Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B74913BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 02:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiARBqC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 20:46:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:49395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbiARBqB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 20:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642470356;
        bh=HUtTTQUUDYUbZmBSr66fkmTby/hr7N3YWOA1PN+pltE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=YMubddqHm7ayvHqtLey0ZfrkfitXE7HUXxTM/7/COqheHMz6oTaIusgJ2E/wHY3NC
         OwZTQMIaXTUR+nKHl8vqzFbkDHnJM8DKlzav+jhVfqSYDJl7vYttGEdMVJcevE+Fjz
         9CDR+9bfpnZiYdkXeUrGwd40+r7vRpHWnWHAdBKc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZktZ-1mmLnI0Kfv-00Wn7n; Tue, 18
 Jan 2022 02:45:55 +0100
Message-ID: <efe15874-fdd1-3d60-c01c-26450ba0dce5@gmx.com>
Date:   Tue, 18 Jan 2022 09:45:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: allow defrag to be interruptible
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <0b7b9259d4e0a874aedbabe74d3719a4aaace586.1642437610.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <0b7b9259d4e0a874aedbabe74d3719a4aaace586.1642437610.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o19kmBouPcRVUWbWi5QRW3eDhnK5NvdhXfQYWtg8GG8NKYpxwsZ
 nnSHrqJ56jIrHDf3wrr3z1mHLqkNqfq64PicbvwwrraQYL/tr9WXlpH1PHXLnZOkAUYneGS
 YUtlF7W3PmNDxlGRKL2vCk8r0XSDkm5+hviAg0LT5bB3DWA1kcy9KMzyr0AIaPD9iLtclCI
 V/uHC9yXY2Ahil5CVaSXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8lGDDYgedug=:LW0dYHdtiF5OGSeoSpBhlP
 eucL0ZAcpZL+SQEqwuRNuYbWWBmPa6xBhfMTWZz938bNAM4tERTt0MJMgtN3Cw+ziJhGZ5A7W
 rZX73EWHiYDO2CxrjwQp6/KpYge8dlokxLIt5uSbWxC2jVZpn0UxhTCK9eJWIinox+stvT2L7
 c2p9cN1lyrPVLl2v6wDLvRZa2ikpolwE46c3vHZryxuGaPbRRI7lbs2FeFPzVGI1u++S2WgBp
 y6E5TuLdka1CkKudXi69TzNlKsWIRAKa7G6BsrJE1/YSKiQ58HzgwRi6hfRzv2C49t83lTU90
 OmAc89+/KOQ2DSOG8QbqjTofXZWdvy5zRj/Jod71cteqcas5RrW+AYVMaRvMEJQ4ei23Q9Cb4
 hh7aVv4CJ+gj0Sf0w9Lerjrv+7FdaU46fbAGd7j6tC2rpKF3t7t016DfwkBxxksj10hRAK/ok
 of7seBUpaLplN3Vz00O3CFobcqW2hCBlu52luw5U/mnErjYA/KtRs3h7Q3CzrAfgGNTDjAksp
 lJ2dLyx5RkTXywhyN5Xpt/goP+av2iKwcUXNB2UwiNXL5AOb1BTRXEswLRbD/+uOq2CcVmQwI
 xjJXYH989xZHrt4CVOpXPIQlBuVtoSi/gL7GmOUW5qmoTA3wc32UqrItOpye3jAIxzKz5h/G1
 4i8FZ7MRBiY9DlnwhxOqlRK0T1z+XXIa7yfHR9VZBI5VFWbBqnhvWADNkT+Un3G9qdJwLDZKz
 lCmZ/0CWOdkkv+gB7zll7aPt54fVpnBoi5RQuSsgaeV9M0wIJg1X5RP/BSiMoMCRadabJrzoV
 D1B+EejDKkHB69Jn9FiEPkVt2zN5qD9SUXcC40+uHgyiD9YOa2iJk1IH9x6jL9F6EEUbXhWsh
 4h/z3icdv/32Jtcn8c76oEOBQtpaptlPxc8RtGi+3TyIDoDNxGQpwCP4eEejrvzVkoh5AZx/v
 aJ9QJBZRkvFxOGVEtd6iolOYY2bMUsJ7YH86I4LliwNyrPyyEt1h0EV77l7YVMTW2jCzcW+XU
 u34F/j4lxwuDRyhrn2chq21Hbg5nvdYT2uTjkYPRgNWw9ipWff7hTYZ/d8fL2aulDBz+xTn0x
 GKcKfae8UScjSg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/18 00:41, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> During defrag, at btrfs_defrag_file(), we have this loop that iterates
> over a file range in steps no larger than 256K subranges. If the range
> is too long, there's no way to interrupt it. So make the loop check in
> each iteration if there's a fatal signal pending, and if there is, break
> and return -EINTR to userspace.
>
> This is motivated by a recent bug on 5.16 where defragging a 1 byte file
> resulted in iterating from file range 0 to (u64)-1, as hitting the bug
> triggered a too long loop, basically requiring one to reboot the machine=
.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ioctl.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6ad2bc2e5af3..954dc8259b1b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1546,6 +1546,11 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
>   		/* The cluster size 256K should always be page aligned */
>   		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
>
> +		if (fatal_signal_pending(current)) {
> +			ret =3D -EINTR;
> +			break;
> +		}
> +

We already have a inlined helper doing something similar:
btrfs_defrag_cancelled().

Although it checks more signals, not only the fatal ones.

And this behavior is changed by commit 7b508037d4ca ("btrfs: defrag: use
defrag_one_cluster() to implement btrfs_defrag_file()"), thus fixes tag
may be helpful.

Thanks,
Qu
>   		/* We want the cluster end at page boundary when possible */
>   		cluster_end =3D (((cur >> PAGE_SHIFT) +
>   			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
