Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E774F3ACAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 03:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfFJBX0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jun 2019 21:23:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:59689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730007AbfFJBXZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Jun 2019 21:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560129799;
        bh=hmTNzWCGFy/tD23h8XfmQ07RbKxcHWoUK0n/HDVo07k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YTb1WmfXkQyX1c01uLcFCUCONz6pC3pPVfnCXQfhFrvTwHwPBPJDgqwCGGz3uNCCe
         BYSjRldhitg7iad3xh/eMgKHEjkPaoH1c3kFTdIOva8OKKRk8R9eAn2vbFblq0zfG2
         tatsxWqF42lAUOzwhmqvsttD00NkYcU99K3is8Co=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.120] ([34.92.239.241]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LfCX2-1glMtC0UHY-00omEs; Mon, 10
 Jun 2019 03:23:19 +0200
Subject: Re: [PATCH 3/9] btrfs-progs: image: Fix a access-beyond-boundary bug
 when there are 32 online CPUs
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190606110611.27176-1-wqu@suse.com>
 <20190606110611.27176-4-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <d6909877-43e9-b66d-6d77-cf58820e64a9@gmx.com>
Date:   Mon, 10 Jun 2019 09:23:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606110611.27176-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ocWsSPT6IU6WjNeLbhP4ngfpGjX3FWt8dzQWiXeRwhQT8BqhaeE
 utnHoT9+WJKo8QiHUXswT50PKDz7uKpTtd9wfnFe1d0exBpb06+OGGcVC/WbBC9bwK3NGn6
 aiHs7tS+Wh2U5pE3qYJu6+8NFBTTVyOXJhGol5DEVN/+RtBUqliygB9rgQ92cV0VSgvs6lp
 NYNPMkWEd+W5MHVOmwnaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ty3d2cQgPnA=:CtALg9wQZ7qSGx0QfTIxFp
 lGE/YAxF9/k52BzmXz6pS4Mn7OT/J67QIB3UTgKSzA6r+PI2MqlHIboePX3dIQHmO3ppMVu8M
 SGQvDJZDLmVkhoQSaQ+V/WdiqSXQbrBE5hHLHc7/Ek4BTXta4anuJn9g2pPAfvHl/tSTX2rNT
 uSecDTgbzlsO3o4eXYXMcOAXJXqd1YxA1LHR2pgURY+ESQcD6sL4SmRd0XAMN4/uTQYKejXTK
 JlJwHNKiY8Bx+FACZn3ZooEDgCN+JKebwOXyRBBZkn4khBzGVGrrp0etx9KMNPf2BJMsM5iAT
 yQhH/vOwlVQRsIjhGIZKCTNtlTITD98aQpec+rqsgjg7uJSAeozoHhkwDB+vZfeU60HgEiv8z
 ZjZlNoejJoDSVEVmzK4pMlzBleSen3YtNOSlBpsj2VmnW36Ge1pDE/I3bClW4A3m3ICc/e8F/
 JnacWp96c7P9Xy6LRUxC8uf50UQsPf2mLBoTTr6QAPRoqb8cRTxzzRsJerVXLBKIwQdTahSPx
 3r6bjlqcQG3wq5OCBKlD216Ss+iALKXV0dNZjziG9giaQYxJwTFvD8vwUAouKWF8FcZWD7JB2
 LEuUbgm4WeB6gruaLCjr6kLk8vN61kJmfVYrXZFpMCWkq94NR5k6EfVUSxIWAacjLoZbw4Q2+
 Ma3TEuzbM9Vy7LlZZ/HMjo/hKTtIjOOpBrlIdjwtN1bZRI76Puv1rICOa6LhwFCFmGT436Rpb
 JaXvVVpP+wRgL8Gbc6bzcouvcsX9vt4Xkb2Ha6NuChjGOCiBCne/YyF0JpZOd0GW+pPrzKUTR
 gzoNSiltyGpQEAffENS2XJN5TU9Xw0SF7CPmBp0E+di0ikIGge26QE2OLjnmnd4kvH/FiQGDN
 JIvjCy2zMpFCLrN93SaFKwapgFiGdGIMEafrX1Nn/deKA58fES63nnRUqTBjlFOl10+u/UrOy
 CMpTm0VAmN/Re+i1gEoRkPdFJN3Cfk9h79paMpTZdJTNkojSDPehP
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/6 7:06 PM, Qu Wenruo wrote:
> [BUG]
> When there are over 32 (in my example, 35) online CPUs, btrfs-image -c9
> will just hang.
>
> [CAUSE]
> Btrfs-image has a hard coded limit (32) on how many threads we can use.
> For the "-t" option we do the up limit check.
>
> But when we don't specify "-t" option and speicified "-c" option, then
> btrfs-image will try to auto detect the number of online CPUs, and use
> it without checking if it's over the up limit.
>
> And for num_threads larger than the up limit, we will over write the
> adjust members of metadump_struct/mdrestore_struct, corrupting
> pthread_mutex_t and pthread_cond_t, causing synchronising problem.
>
> Nowadays, with SMT/HT and higher cpu core counts, it's not hard to go
> beyond 32 threads, and hit the bug.
>
> [FIX]
> Just do extra num_threads check before using the number from sysconf().
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This does fix an issue.
And as the commit says, why limit the max threads to 32?
Does it still make sense in nowadays multiple cores CPU?
Can we increase the limit?
However, this is another story.

For this patch:
Reviewed-by: Su Yue <Damenly_Su@gmx.com>

> ---
>   image/main.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/image/main.c b/image/main.c
> index fb9fc48c..80f09c21 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -2758,6 +2758,7 @@ int main(int argc, char *argv[])
>
>   			if (tmp <=3D 0)
>   				tmp =3D 1;
> +			tmp =3D min_t(long, tmp, MAX_WORKER_THREADS);
>   			num_threads =3D tmp;
>   		}
>   	} else {
>

