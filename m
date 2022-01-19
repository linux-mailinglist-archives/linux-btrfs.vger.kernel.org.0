Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8B8493235
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 02:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350596AbiASBSQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 20:18:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:35551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238605AbiASBSP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 20:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642555090;
        bh=A/a8Lz2JO7gPsdCEHhFMmjQI7M044+4sE9/aCOz2vE4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=XK32PKUWHtnAXSZhIFf/U+WczbW1ohh+zthiE4PdyeinV1Hj2uyRbVjSnuKO+9/Rk
         ODVvoA3uU6RJkyU5pOh99XCLRssVF/Q6rMnUqoOW52NI5UORJ/QvXT5NEtkBJaPnBj
         ueEIwkQuSnNCzF/fEHXi5oh1nLNWifLmK/7oO1Tw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1mxqVp1BkK-00PNYi; Wed, 19
 Jan 2022 02:18:10 +0100
Message-ID: <0f92730e-15c9-9aa6-4f4f-ad9be3fef149@gmx.com>
Date:   Wed, 19 Jan 2022 09:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] btrfs: allow defrag to be interruptible
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <0b7b9259d4e0a874aedbabe74d3719a4aaace586.1642437610.git.fdmanana@suse.com>
 <9a755aa9a3528e385c6dee47e536cd2fe539ab59.1642513202.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9a755aa9a3528e385c6dee47e536cd2fe539ab59.1642513202.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q1pmj23FSHrb20xtrJ1ntch65wRPOhkkTVKGTUvajfk5JLCZAD8
 yFMOwzxwvCdsOptzZYoOa7/BIBnuYnYkth5taYxqd3bLB/0N+lqjsGDukhnR68u0KK+MYst
 8fgb3kPUB2J9eqZfCWWggb42uLKtelHu6CrkH+pw1IryOzJJ2LcoIOpRq35pCefJvNb7KuM
 jJMNj7sNj9w26CWCvZ1sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GoEweRGhbeE=:YPQztCczmF4Ku58xz1lshH
 IOtADJMY9pEzL2G4DiYcCxTN/jT6KvcMKOwzrh3vVNHoTYyPv4/fn/U5x7P+1AQVcHcKnp2jc
 BEbH3IlzVjdUYEXvLsFM+uPYVlU9XGaXfEchYbkEkIOfIeHa/YEq5O/LKsIzbnzYcyAKMOm3K
 LGZDPhgZpZOrd9ybeLvumPQq0W2vz2+BxzYpiOMnzmsdux9eHucPG9muMquAkcnAJh/ydiIRy
 FrACPIn9SRST/2vmW6aOQ5+C8y5Nzmno8Rg4yj1ZLN6wqY/Vh+GT9/GoErZDfB0tRelhCsGBq
 yKnHfsIkBwAIDGKa6PN2r8Jlv+PJr9zrHJuSfImgFqdlxZONf4obnkUndoCzhG19tcc2s/UQT
 MqBRExxgJOHk4YQJcPgL8UEVi4vznSIfFhOesulOqJw2YVcgvPUcJk51uMry8BOAEMKTDTdaM
 RVCE7ixuRcY3QGXBPxjHSsFmMIb5CIleKrJVzot6odVlsnRaJmxOlIKQ/bc9bAsmcordIYds0
 6tt2kMrciLMhj57+iSiK+ByzhZphMpoLnchUKFGkvX8NV0XNPOD+N8aC9nwOM5DnEPkQJNmcW
 4xrK0LDaZ9EfJrtYN7W+MdQ56WnHCebo4Osp8D/YCStaf0D+3Q6Kr+x33tb792u90wpkZHd69
 GCKg2RySUiNK0WJfvL50QxXZl5fLbO9TFyf4QxQJwtbgP4pVlEuATdHxVCDPm5xQJZf/rzKmc
 ywNiNR7CMgPK6Wfs93Xe+IjGG46ZbZd2wSOYgPCAnCRPBKv/cWn3ReyC4pxcLf0RExG5WPXOJ
 dD1vT9VCIGRHQNdDSMmJY6NpEWibATTmkibhrBQWCdTIm5TfT1ABNL0FIs53gr5QB/mnL2Q6R
 QSMZ7/vkUvFnwTIC1N7iY7y7fvSyCueAZa0EXMfLbWhmEVHv62Ljljo+zPplzrxV5vTQptAKm
 T0qpgD9DeX96T2KkKARkPR4IhRZCbTHDozO+PM/kzpQnZYKPdj4pGZ+ei17Typ1KknFvt0G57
 2jCnGXuC/o3Vj96yDj90EtyQmZ5tJclivIkjdzpB13TQEZTQao3I9d7zoMUz2fXEwu+NgRrQ7
 wMrjjKJHlkRnEQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/18 21:43, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> During defrag, at btrfs_defrag_file(), we have this loop that iterates
> over a file range in steps no larger than 256K subranges. If the range
> is too long, there's no way to interrupt it. So make the loop check in
> each iteration if there's signal pending, and if there is, break and
> return -AGAIN to userspace.
>
> Before kernel 5.16, we used to allow defrag to be cancelled through a
> signal, but that was lost with commit 7b508037d4cac3 ("btrfs: defrag:
> use defrag_one_cluster() to implement btrfs_defrag_file()").
>
> This change adds back the possibility to cancel a defrag with a signal
> and keeps the same semantics, returning -EAGAIN to user space (and not
> the usually more expected -EINTR).
>
> This is also motivated by a recent bug on 5.16 where defragging a 1 byte
> file resulted in iterating from file range 0 to (u64)-1, as hitting the
> bug triggered a too long loop, basically requiring one to reboot the
> machine, as it was not possible to cancel defrag.
>
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to imple=
ment btrfs_defrag_file()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>
> v2: Add Fixes tag, as it's actually a regression introduced in 5.16.
>      Use the helper btrfs_defrag_cancelled() instead of fatal_signal_pen=
ding()
>      and return -EAGAIN instead of -EINTR to userspace, as that is what =
used
>      to be returned before 5.16.
>
>   fs/btrfs/ioctl.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6ad2bc2e5af3..6391be7409d8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1546,6 +1546,11 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
>   		/* The cluster size 256K should always be page aligned */
>   		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
>
> +		if (btrfs_defrag_cancelled(fs_info)) {
> +			ret =3D -EAGAIN;
> +			break;
> +		}
> +
>   		/* We want the cluster end at page boundary when possible */
>   		cluster_end =3D (((cur >> PAGE_SHIFT) +
>   			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
