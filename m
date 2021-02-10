Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E0315B4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 01:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhBJAd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 19:33:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:34521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233918AbhBJAWP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 19:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612916429;
        bh=psXoyorVFo/TpohBDl5nCv4iaRkmxNi++lvI8Y01A44=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U+YUHd5MKSdTxWHuJvRBNWyn8nwp2aX91JsLxJCGWXdQNlk35kAJrS1GzeHnpnoHL
         RJAp4lpyVzxayfvdgHfZdt4rtz4T8Qlar7H9CQ6szUIXNzdWK/kZdSXqnPv6GYiJ+N
         RgqmdJmGKIaBkckx0VzhnV84x5s+0k90BmqdX2l0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhuU-1l4fB047c2-00DqTP; Wed, 10
 Feb 2021 01:20:29 +0100
Subject: Re: [PATCH u-boot 2/2] fs: btrfs: change directory list output to be
 aligned as before
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>
References: <20210209180508.22132-1-marek.behun@nic.cz>
 <20210209180508.22132-2-marek.behun@nic.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8047e03b-9936-2f5d-8b30-08b6b5ba2015@gmx.com>
Date:   Wed, 10 Feb 2021 08:20:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209180508.22132-2-marek.behun@nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4oIROI/j829fTMij2dJA3G0lvQ0BMEgoLeQx3kk1iB/zyRsi6JI
 My4NPHvdtXJSYvu3tbjzUgmLjRF9wuzFvPKJhx9diapefnXJiymwsrolb5Qf4PyWhonQvmS
 3VwaD3tyH92tFvk3EEGl2G5MrELuZg6DM/Peb27z/2V4//NlngmmWScNNGKHX+xx2x2yZw+
 SaNXashwQdxv5o+hm53ew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EvQ+hLY0kbI=:IsbXdPEbj7YpL7HikM7GSf
 TCvs7kd8pqOBQXg92jvkWGKi5Ofzq6JP2GGjGtJ8EEaoF4HxjfpjPeltvDF9abt3Gey7LmzwY
 UP8eK2yVR2R7s2ldaA/9kQ4j0laMJWnU5SdaMC4lutS7LG6sQDh0Unca6MCtPoPUHlZOUgZfl
 mUR7U3sSyPg9rM0+f9KqhO8wVhWL2vmfSGR6eVMkZXt4iO+rY9iKYKXG/UgR8mql/DAmY+lj8
 bZsFSSbqRAJJYQ367TvSPCsmeYpv66RPRTK6QgMSoN44cx48ASTn3eA1o8rYpWoBPL1qMnJVh
 QjaRvbMFfFjM+KipJDYkIsMkZ77K0WshXWxGton8vTMqH9nsBbN9c5FgcKl9jIrqRYoY80x2B
 wfuTjzslUsYFo7WvJMiq5s9G0AevuvO09HG64JbdBZXf/x+PCD7Jr5xGjpOk43OE+OW34SLsw
 9CUyRVfsqRA/CDAG0M9ZniX1mzwOBbUh/xt4YrBTv5oADHIU8bQexzsyZNZDK7s+owImANP0i
 dwsE3ZFnHARlTV6G8y2KceiTtXQQPM7Zo827Sh2HiZYpX//1SJ4hGXrpgsuJ4YQUmVoOMcTfg
 HyTbaEtD4LLoZ6pC1HFndfkzOyowliP6/BYTxZeNNhjkvpt4dbl1qCes2Z0PCT7nhrwZ279Lx
 dXesjqUaYKVYtyXA6rNT0+zbmw6wboeALplgBzWe47+WgjPwRATqk7hm3ni+wzq2Ngky6/YNH
 /xSzhEm9FemKzc7Oo4LyPyo6xtc8Eml/WRevSZU/TktVAkE0VVHEQ19ABUmrEGXFdvUgDY9Sq
 cy2fKuNHQTexvBpeQEUHSkxQzmlL5KiI5ZDChfLQ+akM5gCWrnJQYHLswZfwHe7hGMSILTJEo
 Ft4gQBGtOfkWfxH6+EVQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/10 =E4=B8=8A=E5=8D=882:05, Marek Beh=C3=BAn wrote:
> Since commit 325dd1f642dd ("fs: btrfs: Use btrfs_iter_dir() to ...")
> when btrfs is listing a directory, the output is not aligned:
>
>    <SYMLINK>         15  Wed Sep 09 13:20:03 2020  boot.scr -> @/boot/bo=
ot.scr
>    <DIR>          0  Tue Feb 02 12:42:09 2021  @
>    <FILE>        108  Tue Feb 02 12:54:04 2021  1.info
>
> Return back to how it was displayed previously, i.e.:
>
>    <SYM>         15  Wed Sep 09 13:20:03 2020  boot.scr -> @/boot/boot.s=
cr
>    <DIR>          0  Tue Feb 02 12:42:09 2021  @
>    <   >        108  Tue Feb 02 12:54:04 2021  1.info
>
> Instead of '<FILE>', print '<   >', as ext4 driver.
>
> If an unknown directory item type is encountered, we will print the type
> number left padded with spaces, enclosed by '?', instead of '<' and '>',
> i.e.:
>
>    ? 30?        .............................  name
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Fixes: 325dd1f642dd ("fs: btrfs: Use btrfs_iter_dir() to replace ...")
> Cc: David Sterba <dsterba@suse.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>


> ---
>   fs/btrfs/btrfs.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> index 6b4c5feb53..52a243a659 100644
> --- a/fs/btrfs/btrfs.c
> +++ b/fs/btrfs/btrfs.c
> @@ -22,13 +22,13 @@ static int show_dir(struct btrfs_root *root, struct =
extent_buffer *eb,
>   	struct btrfs_inode_item ii;
>   	struct btrfs_key key;
>   	static const char* dir_item_str[] =3D {
> -		[BTRFS_FT_REG_FILE]	=3D "FILE",
> +		[BTRFS_FT_REG_FILE]	=3D "   ",
>   		[BTRFS_FT_DIR] 		=3D "DIR",
> -		[BTRFS_FT_CHRDEV]	=3D "CHRDEV",
> -		[BTRFS_FT_BLKDEV]	=3D "BLKDEV",
> -		[BTRFS_FT_FIFO]		=3D "FIFO",
> -		[BTRFS_FT_SOCK]		=3D "SOCK",
> -		[BTRFS_FT_SYMLINK]	=3D "SYMLINK",
> +		[BTRFS_FT_CHRDEV]	=3D "CHR",
> +		[BTRFS_FT_BLKDEV]	=3D "BLK",
> +		[BTRFS_FT_FIFO]		=3D "FIF",
> +		[BTRFS_FT_SOCK]		=3D "SCK",
> +		[BTRFS_FT_SYMLINK]	=3D "SYM",

Since btrfs-progs also use similar output for its dump-tree, I guess
it's also possible to use the similar 3 chars output, except the FILE.

Thanks,
Qu
>   	};
>   	u8 type =3D btrfs_dir_type(eb, di);
>   	char namebuf[BTRFS_NAME_LEN];
> @@ -93,7 +93,7 @@ static int show_dir(struct btrfs_root *root, struct ex=
tent_buffer *eb,
>   	if (type < ARRAY_SIZE(dir_item_str) && dir_item_str[type])
>   		printf("<%s> ", dir_item_str[type]);
>   	else
> -		printf("DIR_ITEM.%u", type);
> +		printf("?%3u? ", type);
>   	if (type =3D=3D BTRFS_FT_CHRDEV || type =3D=3D BTRFS_FT_BLKDEV) {
>   		ASSERT(key.type =3D=3D BTRFS_INODE_ITEM_KEY);
>   		printf("%4llu,%5llu  ", btrfs_stack_inode_rdev(&ii) >> 20,
>
