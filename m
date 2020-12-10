Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229892D6297
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392076AbgLJQyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 11:54:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:59460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731470AbgLJQyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 11:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A6A2AE95;
        Thu, 10 Dec 2020 16:53:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F4140DA842; Thu, 10 Dec 2020 17:52:03 +0100 (CET)
Date:   Thu, 10 Dec 2020 17:52:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progi: check: Add support for ino cache
 deletion
Message-ID: <20201210165203.GF6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201203081742.3759528-1-nborisov@suse.com>
 <20201203081742.3759528-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203081742.3759528-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 03, 2020 at 10:17:41AM +0200, Nikolay Borisov wrote:
> inode cache feature is going to be removed in kernel 5.11. After this
> kernel version items left by this feature will simply take some extra
> space. Testing showed that the size is actually negligible but for
> completeness' sake give ability to users to remove such left-overs.
> 
> This is achieved by iterating every fs root and removing respective
> items as well as relevant csum extents since the ino cache used the csum
> tree for csums.

Thanks. Please fix all the typos, white space and coding style.

> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  Documentation/btrfs-check.asciidoc |   3 +
>  check/main.c                       | 162 ++++++++++++++++++++++++++++-
>  2 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/btrfs-check.asciidoc b/Documentation/btrfs-check.asciidoc
> index 1dd2c386ad09..960752583f88 100644
> --- a/Documentation/btrfs-check.asciidoc
> +++ b/Documentation/btrfs-check.asciidoc
> @@ -94,6 +94,9 @@ method of clearing the free space cache that doesn't require mounting the
>  filesystem.
>  

one newline between ops
>  
> +--clear-ino-cache ::
> +remove leftover items pertaining to the deprecated inode map feature
> +

two newlines between sections

>  DANGEROUS OPTIONS
>  -----------------
>  
> diff --git a/check/main.c b/check/main.c
> index 69a47b316567..12783396f13a 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9909,6 +9909,152 @@ static int validate_free_space_cache(struct btrfs_root *root)
>  	return ret ? -EINVAL : 0;
>  }
>  
> +int truncate_free_ino_items(struct btrfs_root *root)
> +{
> +	struct btrfs_path path;
> +	struct btrfs_key key = { .objectid = BTRFS_FREE_INO_OBJECTID,
> +		.offset = (u64)-1, .type = (u8)-1};

initialize members in order

> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	trans = btrfs_start_transaction(root, 0);
> +	if (IS_ERR(trans)) {
> +		error("Error starting free ino trans");

the message is already prefixed by 'ERROR:' so it should be phrased like
'unable to start transaction'

> +		return PTR_ERR(trans);
> +	}
> +
> +	while (1) {
> +		struct extent_buffer  *leaf;

just one space between type and name

> +		struct btrfs_file_extent_item *fi;
> +		struct btrfs_key found_key;
> +		u8 found_type;
> +
> +		btrfs_init_path(&path);
> +		ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
> +		if (ret < 0) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
> +		} else if (ret > 0) {
> +			ret = 0;
> +			/* No more items, finished truncating */
> +			if (path.slots[0] == 0) {
> +				btrfs_release_path(&path);
> +				goto out;
> +			}
> +			path.slots[0]--;
> +		}
> +		fi = NULL;
> +		leaf = path.nodes[0];
> +		btrfs_item_key_to_cpu(leaf, &found_key, path.slots[0]);
> +		found_type = found_key.type;
> +
> +		/* ino cache also has free space bitmaps in the fs stree */
> +		if (found_key.objectid != BTRFS_FREE_INO_OBJECTID &&
> +				found_key.objectid != BTRFS_FREE_SPACE_OBJECTID) {

continued conditions should be aligned under the expression of the same
level, so

                if (found_key.objectid != BTRFS_FREE_INO_OBJECTID &&
                    found_key.objectid != BTRFS_FREE_SPACE_OBJECTID) {

> +			btrfs_release_path(&path);
> +			/* Now delete the FREE_SPACE_OBJECTID */
> +			if (key.objectid == BTRFS_FREE_INO_OBJECTID) {
> +				key.objectid = BTRFS_FREE_SPACE_OBJECTID;
> +				continue;
> +			}
> +			break;
> +		}
> +
> +		if (found_type == BTRFS_EXTENT_DATA_KEY) {
> +			int extent_type;

newline between declarations and the rest

> +			fi = btrfs_item_ptr(leaf, path.slots[0],
> +					    struct btrfs_file_extent_item);
> +			extent_type = btrfs_file_extent_type(leaf, fi);
> +			ASSERT(extent_type == BTRFS_FILE_EXTENT_REG);
> +			u64 extent_disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
> +			u64 extent_num_bytes = btrfs_file_extent_disk_num_bytes (leaf, fi);
> +			u64 extent_offset = found_key.offset - btrfs_file_extent_offset(leaf, fi);

no mixing of declarations and statements, we have the same style as
kernel

also the lines are over 80, which still looks ok-ish for
extent_disk_bytenr and extent_num_bytes but for extent_offset it's way
too long, so it should be split

> +			ASSERT(extent_offset == 0);
> +			ret = btrfs_free_extent(trans, root, extent_disk_bytenr,
> +						extent_num_bytes, 0, root->objectid,
> +						BTRFS_FREE_INO_OBJECTID, 0);
> +			BUG_ON(ret);
> +			ret = btrfs_del_csums(trans, extent_disk_bytenr, extent_num_bytes);
> +			BUG_ON(ret);

no BUG_ONs please, there's already transaction abort infrastructure and
you use it in the function already

> +		}
> +
> +		ret = btrfs_del_item(trans, root, &path);
> +		BUG_ON(ret);
> +		btrfs_release_path(&path);
> +	}
> +
> +	btrfs_commit_transaction(trans, root);
> +out:
> +	return ret;
> +}
> +
> +

one newline is enough

> +int clear_ino_cache_items(void)
> +{
> +	int ret;
> +	struct btrfs_path path;
> +	struct btrfs_key key;
> +
> +	key.objectid = BTRFS_FS_TREE_OBJECTID;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = 0;
> +
> +	btrfs_init_path(&path);
> +	ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path,	0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	while(1) {
> +		struct btrfs_key found_key;
> +
> +		btrfs_item_key_to_cpu(path.nodes[0], &found_key, path.slots[0]);
> +		if (found_key.type == BTRFS_ROOT_ITEM_KEY &&
> +			is_fstree(found_key.objectid)) {

align condtions as

                if (found_key.type == BTRFS_ROOT_ITEM_KEY &&
                    is_fstree(found_key.objectid)) {

> +
> +			struct btrfs_root *root;

newline between declarations and statements

> +			found_key.offset = (u64)-1;
> +			root = btrfs_read_fs_root(gfs_info, &found_key);
> +			if (IS_ERR(root))
> +				goto next;
> +			ret = truncate_free_ino_items(root);
> +			if (ret)
> +				goto out;
> +			printf("Successfully cleaned up ino cache for root id: %lld\n",
> +					root->objectid);
> +		} else {
> +			/* If we get a negative tree this means it's the last one */
> +			if ((s64)found_key.objectid < 0 &&
> +					found_key.type == BTRFS_ROOT_ITEM_KEY)

align

> +				goto out;
> +		}
> +
> +		/*
> +		 * Only fs roots contain an ino cache information - either
> +		 * FS_TREE_OBJECTID or subvol id >= BTRFS_FIRST_FREE_OBJECTID
> +		 */
> +next:
> +		if (key.objectid == BTRFS_FS_TREE_OBJECTID) {
> +			key.objectid = BTRFS_FIRST_FREE_OBJECTID;
> +			btrfs_release_path(&path);
> +			ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path,	0, 0);

line too long

> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			ret = btrfs_next_item(gfs_info->tree_root, &path);
> +			if (ret < 0) {
> +				goto out;
> +			} else if (ret > 0) {
> +				ret = 0;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +out:
> +	btrfs_release_path(&path);
> +	return ret;
> +}
> +
>  static const char * const cmd_check_usage[] = {
>  	"btrfs check [options] <device>",
>  	"Check structural integrity of a filesystem (unmounted).",
> @@ -9938,6 +10084,7 @@ static const char * const cmd_check_usage[] = {
>  	"       --init-csum-tree            create a new CRC tree",
>  	"       --init-extent-tree          create a new extent tree",
>  	"       --clear-space-cache v1|v2   clear space cache for v1 or v2",
> +	"       --clear-ino-cache 			clear ino cache leftover items",

help texts should spaces not tabs

>  	"  check and reporting options:",
>  	"       --check-data-csum           verify checksums of data blocks",
>  	"       -Q|--qgroup-report          print a report on qgroup consistency",
> @@ -9962,6 +10109,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  	int init_csum_tree = 0;
>  	int readonly = 0;
>  	int clear_space_cache = 0;
> +	int clear_ino_cache = 0;
>  	int qgroup_report = 0;
>  	int qgroups_repaired = 0;
>  	int qgroup_verify_ret;
> @@ -9974,7 +10122,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
>  			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
>  			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
> -			GETOPT_VAL_FORCE };
> +			GETOPT_VAL_CLEAR_INO_CACHE, GETOPT_VAL_FORCE };
>  		static const struct option long_options[] = {
>  			{ "super", required_argument, NULL, 's' },
>  			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
> @@ -9996,6 +10144,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  				GETOPT_VAL_MODE },
>  			{ "clear-space-cache", required_argument, NULL,
>  				GETOPT_VAL_CLEAR_SPACE_CACHE},
> +			{ "clear-ino-cache", no_argument , NULL,
> +				GETOPT_VAL_CLEAR_INO_CACHE},
>  			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
>  			{ NULL, 0, NULL, 0}
>  		};
> @@ -10081,6 +10231,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  				}
>  				ctree_flags |= OPEN_CTREE_WRITES;
>  				break;
> +			case GETOPT_VAL_CLEAR_INO_CACHE:
> +				clear_ino_cache = 1;
> +				ctree_flags |= OPEN_CTREE_WRITES;
> +				break;
>  			case GETOPT_VAL_FORCE:
>  				force = 1;
>  				break;
> @@ -10196,6 +10350,12 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  		goto close_out;
>  	}
>  
> +	if (clear_ino_cache) {
> +		ret = clear_ino_cache_items();
> +		err = ret;
> +		goto close_out;
> +	}
> +
>  	/*
>  	 * repair mode will force us to commit transaction which
>  	 * will make us fail to load log tree when mounting.
> -- 
> 2.17.1
