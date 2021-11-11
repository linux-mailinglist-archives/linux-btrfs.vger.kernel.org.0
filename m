Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2344D1F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 07:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhKKGkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 01:40:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKGkO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 01:40:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 672491FD39;
        Thu, 11 Nov 2021 06:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636612645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmlRdmjj3HJ0qJRw2kykO6JfY3Lmy8aWiLIiIjcfGSo=;
        b=lGyCCKIPh0GJ38JFdje+KzPj0Yxn45hqqrAsovRSv9hu39w3ShIqm5/Oo/X6bUsug+3Tzs
        cAYm6MI++ZLFOPKlAwx9CO3ho4osuCIx6p87pNgZsQBD9Thp001/TkNaj+gVyMMa2H4CzO
        uwTajB1ko0bKr9h+chCr1rMG/j8gbls=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2416213D4F;
        Thu, 11 Nov 2021 06:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aUXiBSW6jGEdIgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 11 Nov 2021 06:37:25 +0000
Subject: Re: [PATCH] btrfs-progs: rescue: introduce clear-uuid-tree
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     "S ." <sb56637@gmail.com>
References: <20211111024138.41687-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3644e6ea-1756-5fd0-106b-2d130f6a2c2b@suse.com>
Date:   Thu, 11 Nov 2021 08:37:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211111024138.41687-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.11.21 г. 4:41, Qu Wenruo wrote:
> [BUG]
> There is a bug report that a corrupted key type (expected
> UUID_KEY_SUBVOL, has EXTENT_ITEM) causing newer kernel to reject a
> mount.
> 
> Although the root cause is not determined yet, with roll out of v5.11
> kernel to various distros, such problem should be prevented by
> tree-checker, no matter if it's hardware problem or not.
> 
> And older kernel with "-o uuid_rescan" mount option won't help, as
> uuid_rescan will only delete items with
> UUID_KEY_SUBVOL/UUID_KEY_RECEIVED_SUBVOL key types, not deleting such
> corrupted key.
> 
> [FIX]
> To fix such problem we have to rely on offline tool, thus there we
> introduce a new rescue tool, clear-uuid-tree, to empty and then remove
> uuid tree.
> 
> Kernel will re-generate the correct uuid tree at next mount.

SHouldn't this be made part of btrfs repair, why do we need specific
rescue subcom ?

> 
> Reported-by: S. <sb56637@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/rescue.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/cmds/rescue.c b/cmds/rescue.c
> index a98b255ad328..8b5b619da4f6 100644
> --- a/cmds/rescue.c
> +++ b/cmds/rescue.c
> @@ -296,6 +296,109 @@ static int cmd_rescue_create_control_device(const struct cmd_struct *cmd,
>  }
>  static DEFINE_SIMPLE_COMMAND(rescue_create_control_device, "create-control-device");
>  
> +static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *uuid_root = fs_info->uuid_root;
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_path path = {};
> +	struct btrfs_key key = {};
> +	int ret;
> +
> +	if (!uuid_root)
> +		return 0;
> +
> +	fs_info->uuid_root = NULL;
> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	while (1) {
> +		int nr;
> +
> +		ret = btrfs_search_slot(trans, uuid_root, &key, &path, -1, 1);
> +		if (ret < 0)
> +			goto out;
> +		ASSERT(ret > 0);
> +		ASSERT(path.slots[0] == 0);
> +
> +		nr = btrfs_header_nritems(path.nodes[0]);
> +		if (nr == 0) {
> +			btrfs_release_path(&path);
> +			break;
> +		}
> +
> +		ret = btrfs_del_items(trans, uuid_root, &path, 0, nr);
> +		btrfs_release_path(&path);
> +		if (ret < 0)
> +			goto out;
> +	}
> +	ret = btrfs_del_root(trans, fs_info->tree_root, &uuid_root->root_key);
> +	if (ret < 0)
> +		goto out;
> +	list_del(&uuid_root->dirty_list);
> +	ret = clean_tree_block(uuid_root->node);
> +	if (ret < 0)
> +		goto out;
> +	ret = btrfs_free_tree_block(trans, uuid_root, uuid_root->node, 0, 1);
> +	if (ret < 0)
> +		goto out;
> +	free_extent_buffer(uuid_root->node);
> +	free_extent_buffer(uuid_root->commit_root);
> +	kfree(uuid_root);
> +out:
> +	if (ret < 0)
> +		btrfs_abort_transaction(trans, ret);
> +	else
> +		ret = btrfs_commit_transaction(trans, fs_info->tree_root);
> +	return ret;
> +}
> +
> +static const char * const cmd_rescue_clear_uuid_tree_usage[] = {
> +	"btrfs rescue clear-uuid-tree",
> +	"Delete uuid tree so that kernel can rebuild it at mount time",
> +	NULL,
> +};
> +
> +static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
> +				      int argc, char **argv)
> +{
> +	struct btrfs_fs_info *fs_info;
> +	struct open_ctree_flags ocf = {};
> +	char *devname;
> +	int ret;
> +
> +	clean_args_no_options(cmd, argc, argv);
> +	if (check_argc_exact(argc, 2))
> +		return -EINVAL;
> +
> +	devname = argv[optind];
> +	ret = check_mounted(devname);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("could not check mount status: %m");
> +		goto out;
> +	} else if (ret) {
> +		error("%s is currently mounted", devname);
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	ocf.filename = devname;
> +	ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
> +	fs_info = open_ctree_fs_info(&ocf);
> +	if (!fs_info) {
> +		error("could not open btrfs");
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	ret = clear_uuid_tree(fs_info);
> +	close_ctree(fs_info->tree_root);
> +out:
> +	return !!ret;
> +}
> +
> +static DEFINE_SIMPLE_COMMAND(rescue_clear_uuid_tree, "clear-uuid-tree");
> +
>  static const char rescue_cmd_group_info[] =
>  "toolbox for specific rescue operations";
>  
> @@ -306,6 +409,7 @@ static const struct cmd_group rescue_cmd_group = {
>  		&cmd_struct_rescue_zero_log,
>  		&cmd_struct_rescue_fix_device_size,
>  		&cmd_struct_rescue_create_control_device,
> +		&cmd_struct_rescue_clear_uuid_tree,
>  		NULL
>  	}
>  };
> 
