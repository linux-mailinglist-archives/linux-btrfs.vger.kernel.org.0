Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDA2F31DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhALNlj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 08:41:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:37169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbhALNlj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 08:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610458804;
        bh=/uDq4QRKO8SyrrBKUZBPpD6NX0k921ENyOuc3y+vhQo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dpOwZfeuUunKjCE7zcltCAWd/kazoZ7kgDsyG8DasimL/iFZM8QD6L0EARvH/rUkK
         XfXNf7vTN38KjhFI6u2RNNxPpt1pRxSecFnuydVXpJ98I02+ZC6vT6Ma6xsiMZQv5s
         Ocpwsrz6Cq3rtX1UR2I9CzfMzIKR4fdKAQO6l9VE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoRK-1klXym0PWI-00Esxj; Tue, 12
 Jan 2021 14:40:03 +0100
Subject: Re: [PATCH RFC] btrfs: no need to transition to rdonly for ENOSPC
 error
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
References: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <56e1248e-0956-0446-1c45-d280c396d378@gmx.com>
Date:   Tue, 12 Jan 2021 21:39:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BxKBqq0x8ukJ39UJ+yDmS4EukO8rHeWFF1MmlbvywgmyTnbdK5Y
 obviBiJk5dKJGfp6jWb84TSOXoPGh+BhiSgS7nSjXPpRzczyNsyu1KuYuh90Xz+ZazF2c8k
 23mxPTij2Oe8aO6dV9poy8KQnCBfLIIznaijxbcgXecrQhwraIFvcj/cLMvF6Nz4sftfvRH
 wGlVFeRAvkLZ7oGNNNqjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z6T4mMTXtZc=:V8RmsDs9tnbAjbIQnBFOY9
 9bHa+4hgKWwUaqFHY9icUP4unVKxM+7YPvVDzEU9m2xU9J6mddiFfYDYxRMz1rmvw8asNZ4FR
 8MC+YOmtO/gveNo6dTCk6Iq8x4icewdAKyGUU5zGjKT2ppCn36He+5wH1JYgJ3RFQv14Vz9zB
 dm1KkAUCIVWsLgu43fxVqtHSVVWzEtPM8RBe3UtR3xR3afykn+GAHiL3qzOp4aVPfLdX1e0gg
 FCOYdhuBcUNu/0S1cIGBOxJqhNsKkFFXVreBSRTAJwXIY65PjK0t7kg+vXl/ug+bLR3WgJfmd
 zbyn1BvcOSD/jRfYX5XshJiGFcX0QE0baeANi8LtuDTRYudJWytY1ywJr7/613ZagtPqOCPkS
 xEG/XtsLCAMBPQU8PnF7QgwpKMkLnuchiKRMroUrwk+CIC5ljEIjkPUm9hjlj5NOlNaYDZubN
 FMcz3DJDj1I9P3LQ+60cO7+mvhtqyTTcnFZoCjGG4A9afTMmE+adCWiTTR2wnLWeWAJoNwSoa
 L6BMqQ+EjXI14Fbdz6vxCbqnwanphXbKj0uyEgKpCREWs9+rXJ5kQbpkfcbGIuT0phpPpFv8c
 g9pZPICNMbE4eJmEzfOzK5UiMsTOugJD0u+DEgWIbeKHVVjX2NK+3TLBxSEelC8AZoODTR7A+
 1J+2Wk2I/S3sLUP59fODtHjGmXQSDTX5ZIQ0XWOrGNg9s5dH2DFzpydhzEmWwl24QNuBjUOdR
 jP+4QE1ZTj+33/ijHzFcO1uV+Xt4BuAippFTBaEaoE/c2n2lnlMmOU4RXXHDbhk9DoOla58X6
 J9p3z6uwy9j64iG8j+IqVIV0HY1eO9AxFhTum8onE/ynuD3LOzFNsnYS+7LhuGWa+6ibsPsKi
 ZQCe/vlA4mbYzfcyUZCg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/12 =E4=B8=8B=E5=8D=886:34, Anand Jain wrote:
> In the current kernel both scrub and balance fails due to ENOSPC,
> however there is no reason that it should be transitioned to the
> RDONLY and making free spaces difficult.

This just masks the real problem.

 From all your reports, the problem is the same, we exhausted the
metadata space, but the GlobalRSV is only 100+MiB.

It looks like the problem Josef is working on to make GlobalRSV work as
usual.

Definitely not the proper way to fix it.

Thanks,
Qu
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/super.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 12d7d3be7cd4..8c1b858f55c4 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -172,6 +172,9 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *f=
s_info, const char *function
>   	if (sb_rdonly(sb))
>   		return;
>
> +	if (errno =3D=3D -ENOSPC)
> +		return;
> +
>   	btrfs_discard_stop(fs_info);
>
>   	/* btrfs handle error by forcing the filesystem readonly */
>
