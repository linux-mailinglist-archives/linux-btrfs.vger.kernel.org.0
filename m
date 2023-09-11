Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51AE79B1DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356152AbjIKWDE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbjIKKhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 06:37:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC66CDC
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 03:36:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE1EC433C8;
        Mon, 11 Sep 2023 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694428617;
        bh=aNhUZcMgfm6U83IFSp76Zf8PliQDFB2ZRFSUlCFn23Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEmVJ/w6PHqx1NSCahxq+fXuEqYiyziQgOwuTrkl9Y0F1PQaCVPzbwH1Jo+lQj0xG
         Gu9VZnTPFCYm7rsxH23p47AifRU0qSyP/dzRuC0MEZ3S0Ddah78P8X/QzcTtmqW1LV
         Z4X+8rrZFJKvZ9xTkFI0G7G/2hFd4xo9Ld5EFoEzbZIKKtdnZtdqgdXDgQiMdeqg9x
         WYJzXJMeB932mjX++09lmfiXaNvsxMpoz1LudAGE71lig+I6gXfeeXyMYG2ubposp2
         nw5eukwr87z/MOiQmLCy5BEebpJE62DlLNBqbcGlg5zaVzem1nP1Kiv2HeZL5pNDEv
         +qw9n3teSxcVg==
Date:   Mon, 11 Sep 2023 11:36:47 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     linux-btrfs@vger.kernel.org
Cc:     ian@ianjohnson.dev, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] btrfs: refresh dir last index during a rewinddir(3)
 call
Message-ID: <ZP7tv0KyZGKildBq@debian0.Home>
References: <cover.1694260751.git.fdmanana@suse.com>
 <f2ce20268ec99d4d4e1392a200d75309a0b41acc.1694260751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ce20268ec99d4d4e1392a200d75309a0b41acc.1694260751.git.fdmanana@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 01:08:32PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When opening a directory we find what's the index of its last entry and
> then store it in the directory's file handle private data (struct
> btrfs_file_private::last_index), so that in the case new directory entries
> are added to a directory after an opendir(3) call we don't end up in an
> infinite loop (see commit 9b378f6ad48c ("btrfs: fix infinite directory
> reads")) when calling readdir(3).
> 
> However once rewinddir(3) is called, POSIX states [1] that any new
> directory entries added after the previous opendir(3) call, must be
> returned by subsequent calls to readdir(3):
> 
>   "The rewinddir() function shall reset the position of the directory
>    stream to which dirp refers to the beginning of the directory.
>    It shall also cause the directory stream to refer to the current
>    state of the corresponding directory, as a call to opendir() would
>    have done."
> 
> We currently don't refresh the last_index field of the struct
> btrfs_file_private associated to the directory, so after a rewinddir(3)
> we are not returning any new entries added after the opendir(3) call.
> 
> Fix this by finding the current last index of the directory when llseek
> is called agains the directory.
> 
> This can be reproduced by the following C program provided by Ian Johnson:
> 
>    #include <dirent.h>
>    #include <stdio.h>
> 
>    int main(void) {
>      DIR *dir = opendir("test");
> 
>      FILE *file;
>      file = fopen("test/1", "w");
>      fwrite("1", 1, 1, file);
>      fclose(file);
> 
>      file = fopen("test/2", "w");
>      fwrite("2", 1, 1, file);
>      fclose(file);
> 
>      rewinddir(dir);
> 
>      struct dirent *entry;
>      while ((entry = readdir(dir))) {
>         printf("%s\n", entry->d_name);
>      }
>      closedir(dir);
>      return 0;
>    }

Missing the reference [1] here:

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/rewinddir.html

> 
> Reported-by: Ian Johnson <ian@ianjohnson.dev>

Now also (as per the reply in the linked thread):

Tested-by: Ian Johnson <ian@ianjohnson.dev>

> Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/
> Fixes: 9b378f6ad48c ("btrfs: fix infinite directory reads")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/inode.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index df035211bdf0..006ca4cb4788 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5820,6 +5820,19 @@ static int btrfs_opendir(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static loff_t btrfs_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	struct btrfs_file_private *private = file->private_data;
> +	int ret;
> +
> +	ret = btrfs_get_dir_last_index(BTRFS_I(file_inode(file)),
> +				       &private->last_index);
> +	if (ret)
> +		return ret;
> +
> +	return generic_file_llseek(file, offset, whence);
> +}
> +
>  struct dir_entry {
>  	u64 ino;
>  	u64 offset;
> @@ -10893,7 +10906,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
>  };
>  
>  static const struct file_operations btrfs_dir_file_operations = {
> -	.llseek		= generic_file_llseek,
> +	.llseek		= btrfs_dir_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= btrfs_real_readdir,
>  	.open		= btrfs_opendir,
> -- 
> 2.40.1
> 
