Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF74F470F1C
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Dec 2021 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbhLKAEf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 19:04:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:43861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhLKAEf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 19:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639180854;
        bh=ohEPsRGSCQZ6+gPtRulJccM6yWZQc0koCfOl2q61kxc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DlRLB2JSQ4dYBJI8CNfMy0xu0dBrdqKOb56f56AiSa+S4CMCucIKhIhQzdm549fzk
         44x/L6J7+81nKOUgLW1CWWPur9+wS9RWTEdZbSNjJu1/RjRKdx4ntzIyS4+fzkMsZT
         m6DC42gBdrNF9gMXuLyOXymvz3m6AZKrCPm5L4CY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1mCIyu3sb7-00qBEx; Sat, 11
 Dec 2021 01:00:54 +0100
Message-ID: <b9f09724-6455-037c-ffb8-c70b0b7430ab@gmx.com>
Date:   Sat, 11 Dec 2021 08:00:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] btrfs: fix double free of anon_dev after failure to
 create subvolume
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b6c30d9569d56552e38dc6bd305c6eb6578f3782.1639162814.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b6c30d9569d56552e38dc6bd305c6eb6578f3782.1639162814.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OA4xIhQFh1QZ9oXOycUT7EeGa9SzscHCRDyRTSsFcggHdGubkxS
 gjLGVFtuWvGuWzqPW1mc8XAZIETTkjv2Mc7Wm7JdWIKZTQrrYc6i+/O/dBIZJuP27U+1VZr
 0XMFFiTGy7tKOWTR04t54VLrqc6TghY/0OY2mZPZY/JFworXbWCY6nr8Vrn0Uj3fueeF4YC
 ueg9uOeRTZIkLjIggZSVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P2hrO9neVbI=:QwtnCJ/HOtIessopYB30SY
 6/m044raB9faSVAKGDRCAhxtJ8rE3AHGASWKSuNno2rR+zxrQMSLoRqfk8ZLYAbb99NTWCAIZ
 zkET9E4CHoNXzON3YbgGj46BzJka5saisbRUVTGQgIaEUsjOmPdBx0ll0UAJH3nYgSpTEo4q0
 SFTio0e7M+/WAF59EnjL9lrWkbj/4ma8DjVK/X92aIXgI7duTL0/t2Dh9AsTQwc9tjA8M/TBa
 y4/wybMJHn1qRPkHOaHWowR3WpUBXTWyae2bFOYiYlrWcGv4ybatYZ0OusdF+7Zsrtfw08mJJ
 8XqjfZmg/8jbEBZaYTjwva7YM27m0Or2lvpkstdqk8qxxEnih/x6QUUwO71ldIEp03NIan3hI
 gl7mVuIs1HumWGrnUM52yz5XWAUHpAc4l65e30KTssuldsnGKQtGh+JjHuw8dSDziEaoFwtpQ
 +DayNvf1SsSCb7etpgEb4Qm6Pd04p/spDHcqbipx1CUZqfBgFu6qRggRYXnXBTLyQYOF7PlPF
 07nl44wPU0yZV53FJ5Pdnla+E+yM1Z7sS89C4g21Iil3yOaO7Hjeu0PAzWP5j6btAbgt7r4jh
 YhfSDDlrryz8APiPFM6O09aepCIb31uV63xv7/0BqFQMhY/QGq4JeQ0I9nBUjBQRVdziueLVz
 5uN5aDUH8ZSgWhR6/cyPFgsMtxCMwUG1ImMotXUQFo66ORkeRc7wmTCW92iJmQRze4Gcj1SHr
 oaCn8ohaxYKa/VDJAL1NHgbXBhifYzqsBUbua/3JJbCaC6TUMG1DpaT8FTqzFGAH7oH3SAdbq
 gFYzR6qU4NJnWfrhWNS+lBfMuOqLaM18vhL0KRzYmFC0DFvtda+G7HvXrM2ch8gWPaRbDHAWl
 9Id3CL+XckWSpSOkarL0y5W+/b4A/nsrA0xYbr1hYy++rVb+GoyFvb/MPOCEEMqsFeBQxrUgU
 XxWgYOyS9xQJnh/aTY10+S/6bropXwIohSABEKXmBwit10Fsftp+XPrxjJjKMVM+Tz6P0Bd8d
 ZxQJhL9apOCp9ndJGSrCzHkEqIcREHmH73l0vMfUkqTSBQhI1CLOYUkFNzwb7xx+3nFnExOs/
 IyazXS5gW7p9nM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/11 03:02, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When creating a subvolume, at create_subvol(), we allocate an anonymous
> device and later call btrfs_get_new_fs_root(), which in turn just calls
> btrfs_get_root_ref(). There we call btrfs_init_fs_root() which assigns
> the anonymous device to the root, but if after that call there's an erro=
r,
> when we jump to 'fail' label, we call btrfs_put_root(), which frees the
> anonymous device and then returns an error that is propagated back to
> create_subvol(). Than create_subvol() frees the anonymous device again.
>
> When this happens, if the anonymous device was not reallocated after
> the first time it was freed with btrfs_put_root(), we get a kernel
> message like the following:
>
>    (...)
>    [13950.282466] BTRFS: error (device dm-0) in create_subvol:663: errno=
=3D-5 IO failure
>    [13950.283027] ida_free called for id=3D65 which is not allocated.
>    [13950.285974] BTRFS info (device dm-0): forced readonly
>    (...)
>
> If the anonymous device gets reallocated by another btrfs filesystem
> or any other kernel subsystem, then bad things can happen.
>
> So fix this by setting the root's anonymous device to 0 at
> btrfs_get_root_ref(), before we call btrfs_put_root(), if an error
> happened.
>
> Fixes: 2dfb1e43f57dd3 ("btrfs: preallocate anon block device at first ph=
ase of snapshot creation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5c598e124c25..fc7dd5109806 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1826,6 +1826,14 @@ static struct btrfs_root *btrfs_get_root_ref(stru=
ct btrfs_fs_info *fs_info,
>   	}
>   	return root;
>   fail:
> +	/*
> +	 * If our caller provided us an anonymous device, then it's his
> +	 * responsability to free it in case we fail. So we have to set our
> +	 * root's anon_dev to 0 to avoid a double free, once by btrfs_put_root=
()
> +	 * and once again by our caller.
> +	 */
> +	if (anon_dev)
> +		root->anon_dev =3D 0;
>   	btrfs_put_root(root);
>   	return ERR_PTR(ret);
>   }
