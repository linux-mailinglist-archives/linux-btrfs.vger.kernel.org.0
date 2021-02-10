Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4826E315B4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 01:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhBJAdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 19:33:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:49403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233724AbhBJAWz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 19:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612916462;
        bh=3WO2zfg3LTQse1t7VIV99QKSNRonzRu5afcAkg/wuEI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OzvwbuBj3CUPwDK9Xfksn0ttRMmu4wpxl7UsJi5yEdcUpZJx4HBh0sp8fLoqYMkmu
         GPCU1VQcHz13mZj24w9BE1jSHFvVZh2T6XYGp6dCRw3R12blSSYcJywKBuo6MNkPqH
         mLr2GCKE78SUVKFtLUtk7V7+NIi8XBk9ccAXqegA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1lgl4Y0mb2-00okE1; Wed, 10
 Feb 2021 01:21:02 +0100
Subject: Re: [PATCH u-boot 1/2] fs: btrfs: skip xattrs in directory listing
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>
References: <20210209180508.22132-1-marek.behun@nic.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2092371f-a0cf-4503-f1f5-75a6404b60de@gmx.com>
Date:   Wed, 10 Feb 2021 08:20:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209180508.22132-1-marek.behun@nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/6IdrrmWJYAZfhdTJRaT/JcDlRvPA4oUK/ODHy+G/3XpRbiRXoF
 feyfj8mVXgvfSJJOlPewh+enaPBnew1QPcHTvWJvMxhAT6ddcvlUWvdeguSbTu9pne6wJEb
 WXrgHmIL12SZxs/wlCNpQKHUt2a23cfFo111wfIbLxs1ax5G4h/KEjvvc7XJkHAOz5hwwcT
 OpSWzMIYEzUhaX5KR9CMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7FjopNytrIg=:zBOdUk8NGyzf1hkWNPvcea
 /y8cX4H1BZWk/i8DAxRcCnIDMgx/zzs5e6PUmtt5DVfIvnEeYdxrZFtqWYiS5qsOzEvi0T1q5
 HCZbYQGvNzpvPrrDP7Z2K9+4KhnLuyi+PVMzwc6aaG+1EtZrpk6G+PUk5mRgZ6lzqnCaeekFG
 CHGmelTWMap2EF/uRlOR4dWXf/kWWwa8U9fsi4PAWeqrsI/uuKrOWR1fsfh3cPGnUewj+Zv4h
 fMIjMPyMjKqJt+7UY/1O5/7V1Bz824Z4t8QJQmWqmi/Lrt2ao5MEckrb5gbhgwrcAFUEwOap5
 2nnJchCBVAls1KEOPe001Gt1H9t3Uakqcg4K9uGpfxv4HbLOjbSj632dF1aXKJUJIKPswz1jR
 MR7xR5DRHDIfiLIlk9W1Bde4BReT4ylSKzEIrz42tpP2ydOUvAKqe68XmeB9peqmoISBKUhVU
 xsgW6o45phMiOZevn12HfDEEPdnEiXvAIuWn9b+oPw+6dOtcYqdhU2lgV+EourSam7W+GBKCB
 ZJhE4GRDH73SoNrOM7t2ihwys8Rvfzag4E55+YTvgNB7N2n6um4HwshKiKmaO+PeGsMx8CG8y
 Rp/vhXOG4nN6Zawch9W6MvEShqtKZCszOnaj+ew2OQve61csKhgNWmBj6FSGoQrLDbBx3FCEy
 r7vAndwpGX7bDAEFsKlvRQo+zF5JdybFCFEY5jho2tv9Jq6XqsmTV4fwTMxxRlEPqykh6kIHM
 3YpQZXWEX8cr+wazsQoVPkkhX2WWKyIxqgpg6u4bcrzMNeWCg7YBkwug+y5C3mGVKVJ+mdKv5
 AN4mNTPlpBmzB8vTpA1vVx6TCsvdO5y0Ywa0SysKOcFi0IyE8CgujaOiV9dJrwEwji4BRBELq
 /CG+Hv9bJhpptxI2YExg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/10 =E4=B8=8A=E5=8D=882:05, Marek Beh=C3=BAn wrote:
> Skip xattrs in directory listing. U-Boot filesystem drivers do not list
> xattrs.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/btrfs.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> index 346b2c4341..6b4c5feb53 100644
> --- a/fs/btrfs/btrfs.c
> +++ b/fs/btrfs/btrfs.c
> @@ -29,7 +29,6 @@ static int show_dir(struct btrfs_root *root, struct ex=
tent_buffer *eb,
>   		[BTRFS_FT_FIFO]		=3D "FIFO",
>   		[BTRFS_FT_SOCK]		=3D "SOCK",
>   		[BTRFS_FT_SYMLINK]	=3D "SYMLINK",
> -		[BTRFS_FT_XATTR]	=3D "XATTR"
>   	};
>   	u8 type =3D btrfs_dir_type(eb, di);
>   	char namebuf[BTRFS_NAME_LEN];
> @@ -38,6 +37,10 @@ static int show_dir(struct btrfs_root *root, struct e=
xtent_buffer *eb,
>   	time_t mtime;
>   	int ret =3D 0;
>
> +	/* skip XATTRs in directory listing */
> +	if (type =3D=3D BTRFS_FT_XATTR)
> +		return 0;
> +
>   	btrfs_dir_item_key_to_cpu(eb, di, &key);
>
>   	if (key.type =3D=3D BTRFS_ROOT_ITEM_KEY) {
>
