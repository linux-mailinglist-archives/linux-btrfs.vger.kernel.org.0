Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADE44F143
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Nov 2021 05:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhKMEss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 23:48:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:42379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhKMEsr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 23:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636778747;
        bh=dIsaoqzaxfxPhaQdYKCEe0U8SuYukfRQpdyAxq8GCsg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=M6WU4tJj/3gEiekwI+1cxqIZBpTYs3Q5n+k+Cat/3FgFbh/xL5Fe+rs7bafBJwO7v
         RkIxf2eJw/ALxqZGJmPH/LmzQbMpIAgsZltDZuWw1zvATbOZyADd2ic+7ACWXGTlGr
         9HhCT5FaOU+bVheFv2IiBDlHIU0kiPNCdee0ctPw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdeX-1mxdXj3Djp-00EgGi; Sat, 13
 Nov 2021 05:45:47 +0100
Message-ID: <19cde2a1-d17d-d8cf-2539-c1d79b32e376@gmx.com>
Date:   Sat, 13 Nov 2021 12:45:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs-progs: fix discard support check
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20211113031408.17521-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211113031408.17521-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJ7SRC4mL9SN2f6i6kW5cINEVmalDRB/Ru6++fnDCBg4Tz44/A1
 H2YtN75GInrk+NIkQaVLeh0sE924PlW4t5qHKh0UYnpzsteEKgkAOGoQpbKHHRugA9XF/Kh
 vUZ1+DIYYOlKRkzrH0TmTjxCDr6t9yLniJ4RfhQTeD0X0KOsS862ADq4qI3zsfohPw7qYj+
 JWWNkLdd21ZKzE7ewUTDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2HiZV6iHJUg=:ztSf3hIgQIKc1dCS9Ab4go
 05FG47RMVqXS6DMdueXwibQLzN5x2+1l5+AUHJ5RTwO6kf1qIlqldGmsOB9Cg7OZT8ZJM6yR5
 O8Mrz9E4FUprETL2Q8XUtylCLf7197HJ8mV9boid+ngXRIhLnF/xFC/UjcKSc4LvhYLRj3kaj
 IoVgwPk7U0CNtm1wMM/cyMTsDe/54rmL+V+/Tpb2eNcg/5c5G4tTciG+R+BNbXenCZgeXAdKI
 flWgJBgknm0FAw2+s/ervH0NHFbyv3qCTinl8r6BNQ7T5ZAm2Z1BkOCCd2XiqmplrYHLM1SkM
 NSIj43FY9NTDdPbz6IjzZymDpxgKC0rndG88B6SyU7IJk+xLs+eH5dDKigO8/jISG0/cmkFDp
 1dpGRoW27t0oTb4O0BWcSH8hIE1zL9x7MTYjS0GPxv2D4VYF7V2flR0wf2hlMLVeVodaqMld7
 /hRshSZBn0gnVxoFsjXdbjzEkfKz4CwhuKcqBxOrxDRd5WPIRGjN9YnYBfso51J+75+Hyr6wY
 MieoW1c/Ib9LA+1zt6CO8lDQAFAQjJjRCzeDS8wGGxKrFkF/sOUxg2GLHXs/j5ka1Wm7Hek6G
 tHDHPQWWSgnaLrpECrD5Xeg0OBuaixq5bGXRblOcSL5pxuYs/xzNkNcEOl3fKCORzps6SROCP
 EK2yLQQd0qu5HjE1xMITHC5tXsQEV7h1Fs3ng7B5N4pUJ8X7NOdLbG8dnV2GQRI/mS6Z6cSUZ
 VvrpHaY0sCHRDPUMsqTKFkaAeZC85Xt3wC/arjFSGibHJkc4dqYqC2pEryDeL+d3GwUa3mbZu
 Qi6KmwsmMtVfxk50cLkD8NDfDMlyFy6qTy+E96Fgkwvp6Rvs3qsGINvyxiQVNdBLdvseAEykL
 XisBBzhRs+635zqTAyKNR5RaLwhJrGZjCJDfgnMo7ZzWe9Vh3Jbgi+kQMafnU3CXXEABuamGv
 uiaQmqNLC75ibjHzA7souiU8dtHwqN1K8iiqxTL1Kufxx987KwtN2iTzOwcobpCSBE95JJ5FQ
 aFnjcvSNUjFQebO6GEl+E4ZeSwB6CFGks3XwwpbMd6Np8HGlg/UlqHD177acH2iLhWfXWcqNd
 FviHBRcEBQouD0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/13 11:14, Wang Yugui wrote:
> [BUG]
> mkfs.btrfs(v5.15) output a message even if the disk is a HDD without
> TRIM/DISCARD support.
>    Performing full device TRIM /dev/sdc2 (326.03GiB) ...
>
> [CAUSE]
> mkfs.btrfs check TRIM/DISCARD support through the content of
> queue/discard_granularity, but compare it against a wrong value.
>
> When hdd without TRIM/DISCARD support, the content of
> queue/discard_granularity is '0' '\n' '\0', rather than '0' '\0'.

Can we get rid of such bad comparison and just go strtoll() and compare
the value?

Thanks,
Qu

>
> [FIX]
> compare it against the right value.
>
> Fixes: c50c448518bb ("btrfs-progs: do sysfs detection of device discard =
capability")
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>   common/device-utils.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 74a25879..76d5c584 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -64,7 +64,7 @@ static int discard_supported(const char *device)
>   		pr_verbose(3, "cannot read discard_granularity for %s\n", device);
>   		return 0;
>   	} else {
> -		if (buf[0] =3D=3D '0' && buf[1] =3D=3D 0) {
> +		if (buf[0] =3D=3D '0' && buf[1] =3D=3D '\n') {
>   			pr_verbose(3, "%s: discard_granularity %s\n", device, buf);
>   			return 0;
>   		}
>
