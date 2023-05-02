Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC56F4301
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 13:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjEBLrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEBLrl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 07:47:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF183
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 04:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01F4621EF8;
        Tue,  2 May 2023 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683028058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ZFIhAqLo7yZ/el6C+6ydm3fnjzMKXyzcsnSTmowDBI=;
        b=LBeTTCDVe/po1+BCa9R68eB0tKV1RqhSQYIFsn+rvfMDvkI/X9JBiTVoXPAjJEMau01RX9
        j0xVe8Aqv9rMLCkYQYxnIyBXEsS3Q61/sBZsLwRjHVj76ZwcSaOuT8Y3hKiOs4xGinJoLJ
        cRG3IwHQ/rC2/B44cHHIUmKkIvIP1AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683028058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ZFIhAqLo7yZ/el6C+6ydm3fnjzMKXyzcsnSTmowDBI=;
        b=KmQ40yHqB/513erwXoJfzVrVkWDMrS50CZAp3dk2nHMJbmP/WyaVCicNkIcZ5tBQwybgww
        jVSzTmBdBMK6IgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCA39139C3;
        Tue,  2 May 2023 11:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yPs/LVn4UGSrIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 11:47:37 +0000
Date:   Tue, 2 May 2023 13:41:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: enable -Wmissing-prototypes for debug builds
Message-ID: <20230502114142.GA8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8cf9b5f14a52067bec9c4bb9f2d2c13821e0d7b6.1682990969.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf9b5f14a52067bec9c4bb9f2d2c13821e0d7b6.1682990969.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 09:29:30AM +0800, Qu Wenruo wrote:
> During development I'm a little surpirsed we don't have
> -Wmissing-prototypes enabled even for debug builds.

The build supports W=levels like kernel and -Wmissing-prototypes is in
level 1. In some cases we may want to add the warnings to be on by
default for debugging builds though.

> Thus quite some obvious problems are not exposed.
> 
> This patch would fix these all.

I'd rather see some of the changes split, and the warning enabled in a
separate patch too. This would be the way in kernel and in progs we
don't need to be that strict about patch separation but eg. the libbtrfs
change is potentially touching the public API and should be explained
separately, same for the function removals.

> Some are questionable, mostly from crypto:

And if you have questions like that then it's IMHO better to split it so
it does not affect the rest of the patch that could be otherwise OK.

> - Add blake2 hardware optimized definitions
> - Add sha hardware optimized definitions
>   I have added such definitions unconditionally. They should still be
>   safe on platforms without such optimization.
> 
> Others are pure safe fixes:
> 
> - Unexport print_path_column()
> - Unexport parse_reflink_range()
> - Unexport btrfs_list_setup_print_column()
> - Unexport device_get_partition_size_sysfs()
> - Unexport read_path()
> - Unexport ulist_release()
> - Unexport max_zone_append_size()
> - Unexport subvol_uuid_search_add()
> - Delete blake2()
> - Delete btrfs_check_allocatable_zones()
> - Delete subvol_uuid_search_finit()
> - Add needed headers
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Makefile              |  2 +-
>  cmds/qgroup.c         |  2 +-
>  cmds/reflink.c        |  2 +-
>  cmds/subvolume-list.c |  2 +-
>  common/device-utils.c |  2 +-
>  common/utils.c        |  2 +-
>  crypto/blake2.h       |  4 +++
>  crypto/blake2b-ref.c  |  4 ---
>  crypto/sha.h          |  2 ++
>  crypto/sha256-x86.c   |  2 ++
>  kernel-shared/ulist.c |  2 +-
>  kernel-shared/zoned.c | 60 +------------------------------------------
>  libbtrfs/send-utils.c | 31 ++--------------------
>  tune/change-csum.c    |  1 +
>  tune/change-uuid.c    |  1 +
>  tune/convert-bgt.c    |  1 +
>  tune/seeding.c        |  1 +
>  tune/tune.h           |  2 ++
>  18 files changed, 24 insertions(+), 99 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b03367f26158..63bb8d4ef2a9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -66,7 +66,7 @@ include Makefile.extrawarn
>  EXTRA_CFLAGS :=
>  EXTRA_LDFLAGS :=
>  
> -DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3
> +DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3 -Wmissing-prototypes
>  DEBUG_CFLAGS_INTERNAL =
>  DEBUG_CFLAGS :=
>  
> diff --git a/cmds/qgroup.c b/cmds/qgroup.c
> index 49014d5702ec..70a749aa4062 100644
> --- a/cmds/qgroup.c
> +++ b/cmds/qgroup.c
> @@ -289,7 +289,7 @@ static void print_qgroup_column_add_blank(enum btrfs_qgroup_column_enum column,
>  		printf(" ");
>  }
>  
> -void print_path_column(struct btrfs_qgroup *qgroup)
> +static void print_path_column(struct btrfs_qgroup *qgroup)

Changes only adding static to functoius could be in one patch.

>  {
>  	struct btrfs_qgroup_list *list = NULL;
>  
> diff --git a/cmds/reflink.c b/cmds/reflink.c
> index 24e562a744ff..14201349fc9f 100644
> --- a/cmds/reflink.c
> +++ b/cmds/reflink.c
> @@ -58,7 +58,7 @@ struct reflink_range {
>  	bool same_file;
>  };
>  
> -void parse_reflink_range(const char *str, u64 *from, u64 *length, u64 *to)
> +static void parse_reflink_range(const char *str, u64 *from, u64 *length, u64 *to)
>  {
>  	char tmp[512];
>  	int i;
> diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
> index 750fc4e6354d..a667290c1585 100644
> --- a/cmds/subvolume-list.c
> +++ b/cmds/subvolume-list.c
> @@ -280,7 +280,7 @@ static struct {
>  static btrfs_list_filter_func all_filter_funcs[];
>  static btrfs_list_comp_func all_comp_funcs[];
>  
> -void btrfs_list_setup_print_column(enum btrfs_list_column_enum column)
> +static void btrfs_list_setup_print_column(enum btrfs_list_column_enum column)
>  {
>  	int i;
>  
> diff --git a/common/device-utils.c b/common/device-utils.c
> index cb1a7a9d328a..70fbee49df1a 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -332,7 +332,7 @@ u64 device_get_partition_size_fd(int fd)
>  	return result;
>  }
>  
> -u64 device_get_partition_size_sysfs(const char *dev)
> +static u64 device_get_partition_size_sysfs(const char *dev)
>  {
>  	int ret;
>  	char path[PATH_MAX] = {};
> diff --git a/common/utils.c b/common/utils.c
> index 2c359dcf220f..3c67e1eb453c 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -498,7 +498,7 @@ static bool valid_escape(const char *str)
>   * - line is advanced to the final separator or nul character
>   * - returned path is a valid string terminated by zero or whitespace separator
>   */
> -char *read_path(char **line)
> +static char *read_path(char **line)
>  {
>  	char *ret = *line;
>  	char *out = *line;
> diff --git a/crypto/blake2.h b/crypto/blake2.h
> index cd89adb65a9b..784b82c5ea63 100644
> --- a/crypto/blake2.h
> +++ b/crypto/blake2.h
> @@ -92,6 +92,10 @@ extern "C" {
>  
>    void blake2_init_accel(void);
>  
> +void blake2b_compress_sse2( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
> +void blake2b_compress_sse41( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );
> +void blake2b_compress_avx2( blake2b_state *S, const uint8_t block[BLAKE2B_BLOCKBYTES] );

Unused prototypes do no harm, so it's probably ok to have it here.

> +
>  #if defined(__cplusplus)
>  }
>  #endif
> diff --git a/crypto/blake2b-ref.c b/crypto/blake2b-ref.c
> index eac4cf0c48da..f28dce3ae2a8 100644
> --- a/crypto/blake2b-ref.c
> +++ b/crypto/blake2b-ref.c
> @@ -326,10 +326,6 @@ int blake2b( void *out, size_t outlen, const void *in, size_t inlen, const void
>    return 0;
>  }
>  
> -int blake2( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen ) {
> -  return blake2b(out, outlen, in, inlen, key, keylen);
> -}

Removing code should be also split to another patch, though in this case
it's quite trivial.

> -
>  #if defined(SUPERCOP)
>  int crypto_hash( unsigned char *out, unsigned char *in, unsigned long long inlen )
>  {
> diff --git a/crypto/sha.h b/crypto/sha.h
> index e65418ccd0d3..4cca17116966 100644
> --- a/crypto/sha.h
> +++ b/crypto/sha.h
> @@ -211,4 +211,6 @@ extern int hmacResult(HMACContext *context,
>  
>  void sha256_init_accel(void);
>  
> +void sha256_process_x86(uint32_t state[8], const uint8_t data[], uint32_t length);
> +
>  #endif /* _SHA_H_ */
> diff --git a/crypto/sha256-x86.c b/crypto/sha256-x86.c
> index 602c53cf4f60..6acf67e07eea 100644
> --- a/crypto/sha256-x86.c
> +++ b/crypto/sha256-x86.c
> @@ -7,6 +7,8 @@
>  
>  #ifdef __SHA__
>  
> +#include "sha.h"

This does not seem necessary, include whole file just for one prototype.

> +
>  /* Include the GCC super header */
>  #if defined(__GNUC__)
>  # include <stdint.h>
> diff --git a/kernel-shared/ulist.c b/kernel-shared/ulist.c
> index e193b02d5f33..6f231a3d9eab 100644
> --- a/kernel-shared/ulist.c
> +++ b/kernel-shared/ulist.c
> @@ -72,7 +72,7 @@ void ulist_init(struct ulist *ulist)
>   * This is useful in cases where the base 'struct ulist' has been statically
>   * allocated.
>   */
> -void ulist_release(struct ulist *ulist)
> +static void ulist_release(struct ulist *ulist)
>  {
>  	struct ulist_node *node;
>  	struct ulist_node *next;
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index 7d2e68d08bcc..d187c5763406 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -92,7 +92,7 @@ u64 zone_size(const char *file)
>  	return strtoull((const char *)chunk, NULL, 10) << SECTOR_SHIFT;
>  }
>  
> -u64 max_zone_append_size(const char *file)
> +static u64 max_zone_append_size(const char *file)
>  {
>  	char chunk[32];
>  	int ret;
> @@ -596,64 +596,6 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
>  	return ret_sz;
>  }
>  
> -/*
> - * Check if spcecifeid region is suitable for allocation
> - *
> - * @device:	the device to allocate a region
> - * @pos:	the position of the region
> - * @num_bytes:	the size of the region
> - *
> - * In non-ZONED device, anywhere is suitable for allocation. In ZONED
> - * device, check if:
> - * 1) the region is not on non-empty sequential zones,
> - * 2) all zones in the region have the same zone type,
> - * 3) it does not contain super block location
> - */
> -bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
> -				   u64 num_bytes)

This should be in a separate patch explaining why it's ok to remove the
function.

> -{
> -	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> -	u64 nzones, begin, end;
> -	u64 sb_pos;
> -	bool is_sequential;
> -	int shift;
> -	int i;
> -
> -	if (!zinfo || zinfo->model == ZONED_NONE)
> -		return true;
> -
> -	nzones = num_bytes / zinfo->zone_size;
> -	begin = pos / zinfo->zone_size;
> -	end = begin + nzones;
> -
> -	ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
> -	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
> -
> -	if (end > zinfo->nr_zones)
> -		return false;
> -
> -	shift = ilog2(zinfo->zone_size);
> -	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -		sb_pos = sb_zone_number(shift, i);
> -		if (!(end < sb_pos || sb_pos + 1 < begin))
> -			return false;
> -	}
> -
> -	is_sequential = btrfs_dev_is_sequential(device, pos);
> -
> -	while (num_bytes) {
> -		if (is_sequential && !btrfs_dev_is_empty_zone(device, pos))
> -			return false;
> -		if (is_sequential != btrfs_dev_is_sequential(device, pos))
> -			return false;
> -
> -		pos += zinfo->zone_size;
> -		num_bytes -= zinfo->zone_size;
> -	}
> -
> -	return true;
> -}
> -
>  /**
>   * btrfs_find_allocatable_zones - find allocatable zones within a given region
>   *
> diff --git a/libbtrfs/send-utils.c b/libbtrfs/send-utils.c
> index 831ec0dc1222..8eb0a4518277 100644
> --- a/libbtrfs/send-utils.c
> +++ b/libbtrfs/send-utils.c
> @@ -377,7 +377,7 @@ static int count_bytes(void *buf, int len, char b)
>  	return cnt;
>  }
>  
> -void subvol_uuid_search_add(struct subvol_uuid_search *s,
> +static void subvol_uuid_search_add(struct subvol_uuid_search *s,
>  			    struct subvol_info *si)

Libbtrfs changes need explanation why it's ok and that it does not break
the userspace API.

>  {
>  	int cnt;
> @@ -462,7 +462,7 @@ static struct subvol_info *subvol_uuid_search_old(struct subvol_uuid_search *s,
>  	return tree_search(root, root_id, uuid, transid, path, type);
>  }
>  #else
> -void subvol_uuid_search_add(struct subvol_uuid_search *s,
> +static void subvol_uuid_search_add(struct subvol_uuid_search *s,
>  			    struct subvol_info *si)
>  {
>  	if (si) {
> @@ -821,29 +821,6 @@ skip:
>  out:
>  	return ret;
>  }
> -
> -void subvol_uuid_search_finit(struct subvol_uuid_search *s)

The function used to be exported in libbtrfs but got disabled in
56e99634749568 ("btrfs-progs: libbtrfs: hide unused symbols, same
version") and removed completely in 751be36f8650aa ("btrfs-progs: delete
commented exports from libbtrfs.sym"). This also needs to be explained
separately with links to the other commits for continuity.

> -{
> -	struct rb_root *root = &s->root_id_subvols;
> -	struct rb_node *node;
> -
> -	if (!s->uuid_tree_existed)
> -		return;
> -
> -	while ((node = rb_first(root))) {
> -		struct subvol_info *entry =
> -			rb_entry(node, struct subvol_info, rb_root_id_node);
> -
> -		free(entry->path);
> -		rb_erase(node, root);
> -		free(entry);
> -	}
> -
> -	s->root_id_subvols = RB_ROOT;
> -	s->local_subvols = RB_ROOT;
> -	s->received_subvols = RB_ROOT;
> -	s->path_subvols = RB_ROOT;
> -}


>  #else
>  int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s)
>  {
> @@ -851,8 +828,4 @@ int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s)
>  
>  	return 0;
>  }
> -
> -void subvol_uuid_search_finit(struct subvol_uuid_search *s)
> -{
> -}
>  #endif
> diff --git a/tune/change-csum.c b/tune/change-csum.c
> index a11316860e3c..4531f2190f06 100644
> --- a/tune/change-csum.c
> +++ b/tune/change-csum.c
> @@ -24,6 +24,7 @@
>  #include "kernel-shared/transaction.h"
>  #include "common/messages.h"
>  #include "common/internal.h"
> +#include "tune/tune.h"
>  
>  static int change_tree_csum(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>  			    int csum_type)
> diff --git a/tune/change-uuid.c b/tune/change-uuid.c
> index f148b9e54915..99ce0b15b2b9 100644
> --- a/tune/change-uuid.c
> +++ b/tune/change-uuid.c
> @@ -25,6 +25,7 @@
>  #include "kernel-shared/volumes.h"
>  #include "common/defs.h"
>  #include "common/messages.h"
> +#include "tune/tune.h"
>  #include "ioctl.h"
>  
>  static int change_fsid_prepare(struct btrfs_fs_info *fs_info, uuid_t new_fsid)
> diff --git a/tune/convert-bgt.c b/tune/convert-bgt.c
> index 27953cb26ada..c6bd4361f8ac 100644
> --- a/tune/convert-bgt.c
> +++ b/tune/convert-bgt.c
> @@ -22,6 +22,7 @@
>  #include "kernel-shared/transaction.h"
>  #include "common/messages.h"
>  #include "common/extent-cache.h"
> +#include "tune/tune.h"
>  
>  /* After this many block groups we need to commit transaction. */
>  #define BLOCK_GROUP_BATCH	64
> diff --git a/tune/seeding.c b/tune/seeding.c
> index 80b075e53baa..99ad455e9468 100644
> --- a/tune/seeding.c
> +++ b/tune/seeding.c
> @@ -18,6 +18,7 @@
>  #include "kernel-shared/ctree.h"
>  #include "kernel-shared/transaction.h"
>  #include "common/messages.h"
> +#include "tune/tune.h"
>  
>  int update_seeding_flag(struct btrfs_root *root, const char *device, int set_flag, int force)
>  {
> diff --git a/tune/tune.h b/tune/tune.h
> index 6beae9fc9ef7..753dc95eb138 100644
> --- a/tune/tune.h
> +++ b/tune/tune.h
> @@ -17,6 +17,8 @@
>  #ifndef __BTRFS_TUNE_H__
>  #define __BTRFS_TUNE_H__
>  
> +#include <uuid/uuid.h>
> +
>  struct btrfs_root;
>  struct btrfs_fs_info;
>  
> -- 
> 2.39.2
