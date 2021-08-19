Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5213C3F177F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhHSKtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 06:49:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:58353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237866AbhHSKtk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 06:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629370137;
        bh=25bOCLhw0CW1fu4z7pzP0pxwPLI0fNpdqXb/ffzZgm0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B5NcOHMIkKX9k8Fn6s7+WKyKRzgtXbZA5X0A5Pxynz90LK6SBuIOeBngKI0pBklMa
         Sx/7ij1pVJEQsT6CyhV3djOn1K4/Ee08XEyNbcSejq7Vhpj2FJFt84idcUwuG06S24
         XzCL2Xw1qnn53PpbAYbtHXUVwBrrlvJJVxxZ8Rks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpex-1mvCII00Vj-00mMDQ; Thu, 19
 Aug 2021 12:48:57 +0200
Subject: Re: [PATCH 04/11] btrfs: Suppress the message about missing
 filesystem
To:     Simon Glass <sjg@chromium.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210819034033.1617201-1-sjg@chromium.org>
 <20210818214022.4.I3eb71025472bbb050bcf9a0a192dde1b6c07fa7f@changeid>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <86433c79-cf7f-6575-4405-6941625266d1@gmx.com>
Date:   Thu, 19 Aug 2021 18:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818214022.4.I3eb71025472bbb050bcf9a0a192dde1b6c07fa7f@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uanJZETwaDNJS90WhjZCUv+/g2WVneJvE1e60nrPpbfvCqcnHOH
 YyKsYnCdkvJS0vwmbDnAhXkz3IltLC5d7tFlAPaqMsmr1GFPqxLUxIkAgEXWa+sztJ6oAtk
 /pCZFgWn/u/en5TpQjPYPiC6+qseoOgwG8HIYTd23vVFkuoTmMyQHfG6wSGiwPWNdtbBaJj
 8Bleur/JsNEWwtQgXX+Cg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M1usNcoa4Hc=:WUijVNZ7wFfXntrTbIFMXh
 IR1aRNp3f1wq4Vhj98BR/7lgmC+g5/9uCgncGzyp/9ZEtQGTo6jHrKOT5mjhmH/TlGbHYAKID
 rYBJ3xKKK8PZMcFnXaSwwg6cWjkPYc7X3obYeFwC5ENmvG5SFlmwxZpR4sfUfTxu5So8Cd/9e
 dxmO+9bdYCFGdT4ZH9uv8JyqGWWl61dESt2zNQ7quk08XM0Bh17ESvsps8Lz0SdYB9lXkbVZs
 8m3GeUu/8LrxxeKko/cS/pXiR7MpH8NCqdA5N6zVfa/8eHvX9VLpZM3ghWbHzsSlbLfFv3lEG
 TCRQH46zs6/1TM92ZEWEsp2ocCIGAlVXBhGEPDKbQC2J41RHKfp0rHesRWClGlisvFf33Xx0R
 D0tlsMVBh6kCWND74DfkYMjjehubmxE6maKEswdFwnSymtfm0PL76RzK7RETV/wHUNxbX6Wme
 FFHKDUFDs+6va6TZG5G21RkuM7JeskA2BsUoewTdl+mOuJc5oRnqAjQtn8/ettQw4V3jBtdTe
 LhlxD46cpioEDNHbZFgYWjEh7k9R1DNFcNYN/6LSfPzkFZJygTTjoNo4QTwE6TvAChXXm2I+x
 p3qACIOfcWto1ZlZi2SD+78sC/rsHNhMBu4Gu+iNTgbmSSlGIpeMgTmwS6GOuB/SRu85AHnam
 QrP/1oYyhuQnfhj25uQsUhx/EZf/I2xYcjOicTiEeMKzZsbXLFkMLdaX3rwaJ03y4O9V/Amoj
 ol/DmQEjckjtOA+s1Rj5iJ6I6zTETaUzDQwdA8GcDHP31D8gpqIGxG4seeGMcui0xu6ZGQw27
 cuMQ1VtuQ3eHwhFVA2UzETenMjeEc4XsknBE7VjKrdMXn2xLjzHiVmmLulIMIImr2BoJKk59o
 6K14B6Afks0EP9AwIjXTQ5iqetumIYkOaEw3H6e3Z8EXYhvp2zs7rhv2noNDO+uY8omNaExjy
 Ri5/rBCsDWxmDHF3+i17aSs2Sz0jtmOPwZh3Z3W7fkPsrSURdAPOFCOaPbUzqg+/5kD9kE7q1
 jWa4FJEeiJdSvd4ElbZqeKKHjLGxAyFuF9cPXJnhgRfeEUjof7M5uZAR0QTsuBdd4c2t7Sp/e
 EqblGXn23/lbypMA0tW+2XHUF1+imz4i4vNjkxXZT7iTPxZbupEVWnrHg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=8811:40, Simon Glass wrote:
> This message comes up a lot when scanning filesystems. It suggests to th=
e
> user that there is some sort of error, but in fact there is no reason to
> expect that a particular partition has a btrfs filesystem. Other
> filesystems don't print this error.
>
> Turn it into a debug message.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
>   fs/btrfs/disk-io.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 349411c3ccd..1b69346e231 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -886,7 +886,11 @@ static int btrfs_scan_fs_devices(struct blk_desc *d=
esc,
>
>   	ret =3D btrfs_scan_one_device(desc, part, fs_devices, &total_devs);
>   	if (ret) {
> -		fprintf(stderr, "No valid Btrfs found\n");
> +		/*
> +		 * Avoid showing this when probing for a possible Btrfs
> +		 *
> +		 * fprintf(stderr, "No valid Btrfs found\n");
> +		 */
>   		return ret;
>   	}
>   	return 0;
> @@ -975,7 +979,7 @@ struct btrfs_fs_info *open_ctree_fs_info(struct blk_=
desc *desc,
>   	disk_super =3D fs_info->super_copy;
>   	ret =3D btrfs_read_dev_super(desc, part, disk_super);
>   	if (ret) {
> -		printk("No valid btrfs found\n");
> +		debug("No valid btrfs found\n");
>   		goto out_devices;
>   	}
>
>
