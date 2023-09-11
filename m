Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607079C066
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355829AbjIKWCI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbjIKKkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 06:40:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B3CDC
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 03:40:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCCFC433C8;
        Mon, 11 Sep 2023 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694428830;
        bh=v6J9w8t4I00gjDRlGBnG8klrchAwwNzQYRkn6s0VJ4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJSdnOsBhpsbluwKATLF54elY6oQjNbMVFEYMVnuJR0ZzzOYoQDgLK24kj1Bhu+X/
         E7WdKz9CE8sGbsmZ/D3FYUQq57ZWdQKqjr9ssQmLVEFPMUu501kSiqI7XWxRROcYPj
         PJyRouIUgfaBA2UhBSrKaZ1tr7J3zuHh5FZ7qYUxNujVDtkBTqSWxohNEr7mM1HK9+
         DbJV0bhnzDDYI54JJn2rRtKcUL90k5mAh9Dfs+I/D44d4Z0L3MD+Zgm5AV6uM5vRrz
         uQSQQ1TFuvjvOezx6/zbHcfJarqOtQt7zyhvPNQiz1MIW5SgcYtL1lKBby2CcYCVjq
         frdN+g3lpUvbg==
Date:   Mon, 11 Sep 2023 11:40:27 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     linux-btrfs@vger.kernel.org
Cc:     ian@ianjohnson.dev, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2] btrfs: set last dir index to the current last index
 when opening dir
Message-ID: <ZP7um+C2VEK3DPrf@debian0.Home>
References: <cover.1694260751.git.fdmanana@suse.com>
 <f6ad7269b879d0ac24f3b051c3ff6530dc0953b4.1694260751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ad7269b879d0ac24f3b051c3ff6530dc0953b4.1694260751.git.fdmanana@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 01:08:31PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When opening a directory for reading it, we set the last index where we
> stop iteration to the value in struct btrfs_inode::index_cnt. That value
> does not match the index of the most recently added directory entry but
> it's instead the index number that will be assigned the next directory
> entry.
> 
> This means that if after the call to opendir(3) new directory entries are
> added, a readdir(3) call will return the first new directory entry. This
> is fine because POSIX says the following [1]:
> 
>   "If a file is removed from or added to the directory after the most
>    recent call to opendir() or rewinddir(), whether a subsequent call to
>    readdir() returns an entry for that file is unspecified."
> 
> For example for the test script from commit 9b378f6ad48c ("btrfs: fix
> infinite directory reads"), where we have 2000 files in a directory, ext4
> doesn't return any new directory entry after opendir(3), while xfs returns
> the first 13 new directory entries added after the opendir(3) call.
> 
> If we move to a shorter example with an empty directory when opendir(3) is
> called, and 2 files added to the directory after the opendir(3) call, then
> readdir(3) on btrfs will return the first file, ext4 and xfs return the 2
> files (but in a different order). A test program for this, reported by
> Ian Johnson, is the following:
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
>      struct dirent *entry;
>      while ((entry = readdir(dir))) {
>         printf("%s\n", entry->d_name);
>      }
>      closedir(dir);
>      return 0;
>    }
> 
> To make this less odd, change the behaviour to never return new entries
> that were added after the opendir(3) call. This is done by setting the
> last_index field of the struct btrfs_file_private attached to the
> directory's file handle with a value matching btrfs_inode::index_cnt
> minus 1, since that value always matches the index of the next new
> directory entry and not the index of the most recently added entry.
> 
> [1] https://pubs.opengroup.org/onlinepubs/007904875/functions/readdir_r.html
> 

Also (see the linked thread):

Reported-by: Ian Johnson <ian@ianjohnson.dev>
Tested-by: Ian Johnson <ian@ianjohnson.dev>

> Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ca0f4781b0e5..df035211bdf0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5782,7 +5782,8 @@ static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
>  		}
>  	}
>  
> -	*index = dir->index_cnt;
> +	/* index_cnt is the index number of next new entry, so decrement it. */
> +	*index = dir->index_cnt - 1;
>  
>  	return 0;
>  }
> -- 
> 2.40.1
> 
