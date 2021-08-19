Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5663F3F12DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 07:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHSFn4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 01:43:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:44345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhHSFnz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 01:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629351796;
        bh=cWLqvi7slIhlQxPzqnge/heIOCzYUh1ripDut7bh5i4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ir3MauYRJ9zhrvdwuaZMUcERdQugOIwvsCdOHXHTVDdbwvaQTU1rwRvyXrzz2o3/L
         rpD3CrrDhogJd6u+0QQMHonI4io5kOr3B22vL6X1vuXE9db7jRN5mI+729GQGa0QGN
         ztbFXlEzylIYYKVZGNlOPZyRGL1MSThjK5+cZ+ww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwfai-1n18m12gHa-00yDA7; Thu, 19
 Aug 2021 07:43:16 +0200
Subject: Re: [PATCH v2 03/12] btrfs-progs: propagate fs root errors in lowmem
 mode
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <8a8235462677d3a7c1cf21a8bd3244d929f1466e.1629322156.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <66a6e051-982a-905e-b891-66d9ec0f7a30@gmx.com>
Date:   Thu, 19 Aug 2021 13:43:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8a8235462677d3a7c1cf21a8bd3244d929f1466e.1629322156.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tSUr5XFjQdqtXjsB7h2O9tiJisfBR288TIB5M9uSAUROwUKYYXP
 VXF30umXFpLS4OU5gSDNmz2Omjj2ya3ojP9K+W5iBkOzmK/7bpQ0XV6uAwn2Cf0CRxFYU47
 15nFYc1TDcoatjd9dOk0uYAo/V/xeZYAUZ1fyVgIgWyVDjbyOUR9YV82Eve+rZkrcE1mQFv
 lrM3JQz25Yv76xcNL6WUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:44QtpvOtahA=:ZIwJ+wK2FAkpzP7fgAa+Ah
 k7Se/0c6Hi/s0L65Hk3ywGoC25glKgtAnE68P2q/ExjBh3/ZN9VCmBmozNmQpSPHfRCYMDnXk
 H02U9svKnKttZJ3Xd4GdMnM3mNs6Wa5oviYYe5Pzg+VA9NeG9AszInl+E07pGdWuDjAW6dtk0
 5IigHPdu2d2t3Xm/7nHLT6YebcKh7s2Bbl1+rXDNo3jmsnX83f3rEyPO4KahiRblEs2wq4UXl
 QIvwgP/w3Aknwqyp1MGuSG02JtnKir3UPPTx7xjY+hitl3JcjUTQ2ayWHZOh1GLFqUc4AbnuW
 BjBxI9gW4KjaNjfLtkRbc3DwnYnSCzkK+yqLdnPyx4fHZX1QQP14mt3OYwJl/Ah2n4BCt2ptN
 LuBIOpzLpwOulGEJLPHQ0KuEzMCv1j452MhBO+VgSzzbeocfsb5M6qTJN8zCJo+b0LGzTBEhf
 X6pT+49RedLNoe4qhug7cNAn7eST8CvQZvp/tz9RNm/F9ym9UuxwRvzLkW067qRMlAl1OiDw5
 SmV0QJve9wCAHkmm5yc4qbr0kJmtX+jdbQWfeyQ+z/D33NWhkNxo/sIz3VeaAeY2+wq+r+GaW
 vnAQrlSipRhdDdU8Ip0Js4vmb8bJ6dcIgzrT5XPEtCnCy+LwZusqFcaUOHzc+pOu/kbYypnBd
 j5zttk8ySwJYXhdfyzxUU9/4ftXqUUFfL15tvGEErf3J1rEW3z5RQ7HJ/E/3TwMnaOkI/Tcab
 6p+FUdQUlUy8K3XeI/NsjqbQ6LPCxLwhmiNpycHmgYc1JgWQgklfV1Dnh3oB3dyLZjt5ZWvYE
 3xugV5EzXOOWweCXQTzFQh0ZKsqTEJ3bFurxUO+g0T0yN8wAWptDH4bYElFnsX77arFgU87tt
 sGA6GJXOnQi03vLofURxBifGgUxbfFYGMjSCwJC7PMhG8EgbWXjB9tXWYDZ8aFR6JQdlXxRoK
 L59mEKd88QPpHiIv5d0Hz6vjYBw+NN49gMc7olkqvADAiKs7E3fql8CnoZ31H67ap+W2l8Y6z
 ZR035zG5krHmIhEe3cuXyu8EcitF9LCRNKZcI2J8tc88xNdTBBqshT0UIgdguQedOUYohZkPN
 et0CNAu0+/O/ZA39g/VmTwANbtCBjVJS6rH85ED4VVKOcJ42uPFpegIkA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
> We have a check that will return an error only if ret < 0, but we return
> the lowmem specific errors which are all > 0.  Fix this by simply
> checking if (ret).  This allows test 010 to pass with lowmem properly.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   check/mode-lowmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 7fc7d467..d278c927 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -5204,7 +5204,7 @@ static int check_btrfs_root(struct btrfs_root *roo=
t, int check_all)
>   		 * missing we will skip it forever.
>   		 */
>   		ret =3D check_fs_first_inode(root);
> -		if (ret < 0)
> +		if (ret)
>   			return FATAL_ERROR;
>   	}
>
>
