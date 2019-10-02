Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C3C86F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfJBLH6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 07:07:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:46288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfJBLH6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 07:07:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED7AEB219;
        Wed,  2 Oct 2019 11:07:54 +0000 (UTC)
Subject: Re: [PATCH 2/3] btrfs: add const function attribute
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1569587835.git.dsterba@suse.com>
 <543f96a0b47e4856e6adbf3761a56df96480f358.1569587835.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <625281f3-90fc-56d8-22e9-76557bb3d410@suse.com>
Date:   Wed, 2 Oct 2019 14:07:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <543f96a0b47e4856e6adbf3761a56df96480f358.1569587835.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.10.19 г. 20:57 ч., David Sterba wrote:
> For some reason the attribute is called __attribute_const__ and not
> __const, marks functions that have no observable effects on program
> state, IOW not reading pointers, just the arguments and calculating a
> value. Allows the compiler to do some optimizations, based on
> -Wsuggest-attribute=const . The effects are rather small, though, about
> 60 bytes decrese of btrfs.ko.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h   | 2 +-
>  fs/btrfs/super.c   | 2 +-
>  fs/btrfs/volumes.c | 2 +-
>  fs/btrfs/volumes.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4bf0433b1179..793085770c84 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3146,7 +3146,7 @@ __cold
>  void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
>  		     unsigned int line, int errno, const char *fmt, ...);
>  
> -const char *btrfs_decode_error(int errno);
> +const char * __attribute_const__ btrfs_decode_error(int errno);
>  
>  __cold
>  void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3da35d8b21a3..b3e6d7aa3402 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -66,7 +66,7 @@ static struct file_system_type btrfs_root_fs_type;
>  
>  static int btrfs_remount(struct super_block *sb, int *flags, char *data);
>  
> -const char *btrfs_decode_error(int errno)
> +const char * __attribute_const__ btrfs_decode_error(int errno)
>  {
>  	char *errstr = "unknown";
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3fd89aee539d..c343b7cdfb53 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -297,7 +297,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>  
>  DEFINE_MUTEX(uuid_mutex);
>  static LIST_HEAD(fs_uuids);
> -struct list_head *btrfs_get_fs_uuids(void)
> +struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)

I'm not entirely sure this function is cons. According to the manual:

Calls to functions whose return value is not affected by changes to the
observable state of the program and that have no observable effects on
such state other than to return a value may lend themselves to
optimizations such as common subexpression elimination.

The const attribute prohibits a function from reading objects that
affect its return value between successive invocations. However,
functions declared with the attribute can safely read objects that do
not change their return value, such as non-volatile constants.


My doubt stems from the fact this function actually references outside
memory, namely gets the ptr to fs_uuids. There is a specific remark not
to use const when the function takes a ptr argument but it doesn't say
anything when getting a ptr from a global var.

>  {
>  	return &fs_uuids;
>  }
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index a7da1f3e3627..0ae0677a8d86 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -571,7 +571,7 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
>  
>  void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
>  
> -struct list_head *btrfs_get_fs_uuids(void);
> +struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
>  void btrfs_set_fs_info_ptr(struct btrfs_fs_info *fs_info);
>  void btrfs_reset_fs_info_ptr(struct btrfs_fs_info *fs_info);
>  bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
> 
