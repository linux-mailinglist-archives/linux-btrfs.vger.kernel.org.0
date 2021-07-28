Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF89C3D8487
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 02:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhG1APK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 20:15:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:47867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232840AbhG1APJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 20:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627431305;
        bh=/Q1pHYjq9f6fntVXnubS6wDn6kbGGg1mIROVHdLgnoE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c/zyUrnsNBO2pWQeJWcYe+50VM3yaSL/jqtFO1oIb4tjTRXNIV+5ed3MBGNqHK9yN
         WjOh/gsRwkNMbL7ftcngse237RNdaIPsMtKgAzhkgJJx6Q8dWe8/8NXHRDsoEfuJgi
         rnKA9lizmwMjWIC4Dn5gkpoetvLfz7jPlWsaG1yE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQEn-1mwhtn0i8N-00oULF; Wed, 28
 Jul 2021 02:15:04 +0200
Subject: Re: [PATCH v2] btrfs/177: Ignore resize output message
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com, wqu@suse.com
References: <20210727182125.29210-1-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cc2005f7-605b-2c22-3a9f-1bbb8177888f@gmx.com>
Date:   Wed, 28 Jul 2021 08:15:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727182125.29210-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jJTYc4DCuqAthzo0KYc/VDt6DSEm5p2pq4vkTQt//huwCJGMKGz
 E8YQ3Mkdzarr5yS+84dR7VeMuOolonbcvijr+1Qk8a7fH4L0VeqSpSkqV+WsC4nK9BSFWip
 RrQSH3VlQ/JAHTeTx+obqAH5I57irbOdvRrSTv55JGr2SzFSBohvBPxokLCME6dQRQW/iMO
 F9M2a9tGwemr+wIvHpH5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v37CBT6UgR0=:CEAsP89acPfggq+CuDx6jj
 z30iifhI0IL14ULeigk4jvQ6KoYqsOid//m3BPyWmYXywnWwhMiPKAIUrFy0kJso8r7gnfA6l
 jKiSWX9vGK9+o9u1/+pKK2s64tXMCRhSkzS1RS5CNNXVFnB0AYaub3sIZ+pQBAoU3p0S0f6+l
 6RkSfmBQ95Kv9DWscmt46rSAgtRtm/8VF/SdmknDDAqB5WCBlr9auOT5cYeunmDpwsnmskEPf
 uXMq+tggJfxOlhj/mdsZwV1uYLC7VQ3EAzJXK3D4jADXYKwZeJhKEnkPla9QJdV5xYKO5TmXM
 Bqy5b/KPIu3c8xVK8rzD2wsqDqT+7BWufFyEQCgqFXgNQutq+qrygR/7f02hCMIrkng0AoTD8
 McIPByCZONY8DWsSgiSau1+DbHzqImYUP/6uqkI8gv2JsDBP/WDQDIV8NtqcGAnLgJyqo2V1m
 JHibeOySy0q/AHesUUuC8XVFvMwBL9sj5v7xymwUy6y5z7cd/Y0UhcC4ylz9pntHm8E9QYo1m
 0R2Ga7IWQx2xzS3oiQT4CGTLCKhl2cIiEeeJZf7QAhc8ny9MyiQ1NOw67J+gsvpr9HENuEkUO
 t8Z/TuRm++AxXPo1odbKeVKDbFOey9g0o1eXOTK2S08kU7k9Rztp8gMSySLdMPmL+4QgLFLjj
 nGtyhPtWPDn8JDDmLBbPG0vxaiAZf2cEiuFS/w/gfhIb51PQt454w5DPiNVDj123Soc1OPi7X
 zuYGjOb9XNj/iKOLZEnWtGOcNIgFY+O60HFnvd8pxsxCldZK9O7wpauhOx288gfVpvnCqeyvH
 5K9xxNPbumCej2dC/ANwpGFROvF2u/Yd/gk7Xp4EFPH+rNyXuniGcrzoKl7IOhAR2GbHozG8U
 5+Uq2uzdYnbkmNhub07E+wZ8OIr1lK5im7a7IE8PrCgcU0o/XyEtqTKqvPYb06WGV9vF00LUq
 xnnxWjZZEmlNUZe9pqMrxeyxzsvHDFQjVxUd+QJU+lC+2m6jtsCCw7EgYcjIwQQTMPVtiIqht
 esj+am2t3wyvlJHkY6Pg12Br5QlMVMBFQcxpG+7UgQLjeNBMcEQs2MJOw00jJCs4LyL6nb5uK
 2Vqb1G+aqA7FAMyua2fgPksWytso5BGFCEzEH84lR7idN9Mf2joSfaQBg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/28 =E4=B8=8A=E5=8D=882:21, Marcos Paulo de Souza wrote:
> Commit 78aa1d95dd99 ("btrfs-progs: fi resize: make output more
> readable") added the device id of the resized fs along with a pretty
> printed size. Remove the resize output message from 117.out.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>
>   Qu, btrfs/217 is also ignoring the resize output, so I believe it woul=
d be
>   easier if we do the same here. We would see other problems if the resi=
ze fail,
>   so I think we are safe here.

But unfortunately, we have hit case where the output of the resize
commands is insane.

One recent regression is, resize will always output the resized size as 0.

Thus I believe we may still want to properly check the output value.
Although I don't think it should be in golden output.

Thanks,
Qu

>
>   tests/btrfs/177     | 5 ++---
>   tests/btrfs/177.out | 2 --
>   2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tests/btrfs/177 b/tests/btrfs/177
> index 966d29d7..f59f54a7 100755
> --- a/tests/btrfs/177
> +++ b/tests/btrfs/177
> @@ -36,8 +36,7 @@ dd if=3D/dev/zero of=3D"$SCRATCH_MNT/refill" bs=3D4096=
 >> $seqres.full 2>&1
>   # Now add more space and create a swap file. We know that the first $f=
ssize
>   # of the filesystem was used, so the swap file must be in the new part=
 of the
>   # filesystem.
> -$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" | \
> -							_filter_scratch
> +$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" >>$se=
qres.full
>   _format_swapfile "$swapfile" $((32 * 1024 * 1024))
>   swapon "$swapfile"
>
> @@ -55,7 +54,7 @@ $BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2=
>&1 | grep -o "Text file b
>   swapoff "$swapfile"
>
>   # It should work again after swapoff.
> -$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" | _filter_scr=
atch
> +$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" >>$seqres.ful=
l
>
>   status=3D0
>   exit
> diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
> index 63aca0e5..0293ee36 100644
> --- a/tests/btrfs/177.out
> +++ b/tests/btrfs/177.out
> @@ -1,4 +1,2 @@
>   QA output created by 177
> -Resize 'SCRATCH_MNT' of '3221225472'
>   Text file busy
> -Resize 'SCRATCH_MNT' of '1073741824'
>
