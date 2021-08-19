Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3FB3F12D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 07:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhHSFlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 01:41:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:48029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHSFlX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 01:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629351642;
        bh=7ZKs5HncNqy+1J4Mxw4oWJErdKuCoYdmg13s2Bi8xOo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=X/XoFUsdut/FkkPTtk/a9MliHdTW4CqYWdaiDSRu0ZJebiHTkpewB7wB0i4kkPseq
         vlnEoVX1T8TR9zmGdjgjQ5vyoGeqlNaBpgiLRm+DNr4iWLe4UvQW8BZbxYQpXp7Mi8
         o3ye3Ho7ckkBaf8CldGyIX1cPginsMChYbn3nP10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvmO-1mp5zz1daw-00b2Ts; Thu, 19
 Aug 2021 07:40:42 +0200
Subject: Re: [PATCH v2 01/12] btrfs-progs: fix running lowmem check tests
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <45ba3fd15ba81f18136d9f6a7e10e7d6bc2422d5.1629322156.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b278ec67-3774-829d-8a0c-c49e25fd9be7@gmx.com>
Date:   Thu, 19 Aug 2021 13:40:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <45ba3fd15ba81f18136d9f6a7e10e7d6bc2422d5.1629322156.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:731mwuTLQz+fBPVJ8PeWc2USaQLndLzFCmaRwfB5nkLquGP4ZZZ
 y/ug+jZ+mviCa5zrZNxHU00JRPYxYfLgG2UOHvesZkFtLOdjOnM6nEZxIH86gMpNILpmIFC
 T0JoNiStq63f1/h5EDfJ1SnzfaqT8uzvnz1yveUdV5H+wI3LAaqeCcIVzk28DboPXn7JZYI
 KyYktkse/OI1xreVImIdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZBWNYsYlEFs=:VY+RpErmZL9ji8/pUd5bwP
 DXRztrHPy6Yt+y0LKMWKmRHLCo9rxhpf7FirbiVrM7cCLVAdbjON9bSvnJk82K7Z16gmkMGhd
 GN696SU6Xhp9lqvIMoB8ateJFPS3ZfmaRQLUinc3jBxG/7t2KRiqAhWGxV2sBYwq+1McdzNfr
 ABfzW2zr7sT7KnDNTdHwoMKb0MkV3qC6qlJ3mYckzLLpB1uh4glb7We676la90yIrwYb9pDzU
 l25eX/E+7852jVsnkp2yNcgvWbUgNhWv4Q+SY1XUJGJ2MQ8fLucuy1fCf3AZUKtHsMrkuHRuM
 q1jQc4dKflQQgXlh8pBf5k8V3rzkBNxSgC9+BxShmGwDc8NQ70Qwy4E8hKsOzoH5XvMsmy1N4
 QIdKZIiQeoXwvLN8K2TD2ohtCCbplZWHTqFNly652J8Fo31erDwZPx6um8bPQen9VIYTwPpMu
 0tdb8enWXSR907tC40c8tXK0o8okt53bIe7oEkinTYBquwzXmNqM5Z6FuR1ve3yB79CX0QQGV
 DrnDCOjqctYXe+euEkIjb0GuZljdvL8Ycz0R3GYD3uKrD1HoNqoEhTBeiVZdE8LhmIOsjfOYu
 VIMzSU7g4m4aeXamjNGOwsFORClVDSfEE5Fagj7q6nn6m150I3uJEi/zfDoNB3BmG6Y9HJ2lS
 NFCotAIdRMBXnb2YrWau3NRR9OkB51qXiiLG3tBuESsiLqVavmK2OX02GcXCsz0LiuoiUl0o2
 GzO1jW+EWi8iekTjSgGhRjIPOp1f219OeOX/LGpe1SSO1CYFxf/fZ/ZICFFC2qzYU5rlpMnPn
 1iQkP7D+NNh6K4l5RepxkGuyGMNSUko1QveaP8BwBv7gPUDf/sarwPTAhdmGLgwM5z5TQZYvh
 pAH8b7gm81k23diKcqR1XSzcope0lRmi6uSyfEyndYJjVq+YK2GtkVmGNCjrv4u53c2CxhUjO
 u4Ix4SldS8RCiNZwO7F9/CtJEfP1v4FBzqkH8CLFGFWi8uBDh3In3zBZlMKau/yFrmY4Lmq5d
 y7A+zKKkp/f7foMuF5DX7RfMXcJGFxW4p2ayoil2769Dfy6umMDMVLe9rJyYQiimDiyEZrGYe
 L/UqdxsA50UovTl3DIw/8EsE+jbf+P2oREWO89r7uayQF13j9KQkdHFOw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
> When I added the invalid super image I saw that the lowmem tests were
> passing, despite not having the detection code yet.  Turns out this is
> because we weren't using a run command helper which does the proper
> expansion and adds the --mode=3Dlowmem option.  Fix this to use the prop=
er
> handler, and now the lowmem test fails properly without my patch to add
> this support to the lowmem mode.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/common | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tests/common b/tests/common
> index 805a447c..5b255689 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -425,9 +425,8 @@ check_image()
>
>   	image=3D$1
>   	echo "testing image $(basename $image)" >> "$RESULTS"
> -	"$TOP/btrfs" check "$image" >> "$RESULTS" 2>&1
> -	[ $? -eq 0 ] && _fail "btrfs check should have detected corruption"
> -
> +	run_mustfail "btrfs check should have detected corruption" \
> +		"$TOP/btrfs" check "$image"
>   	run_check "$TOP/btrfs" check --repair --force "$image"
>   	run_check "$TOP/btrfs" check "$image"
>   }
>
