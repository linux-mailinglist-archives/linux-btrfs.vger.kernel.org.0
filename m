Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F334103494
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 07:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKTGuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 01:50:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:49057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfKTGuT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 01:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574232617;
        bh=Q6P2UmF6wU+RV3pJ5RH5j1goUlEOva/Td2Q96VDm/2o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=i027N4EyqNQ61bhgKQYssnTjp70uL9HUdqsxT/VCLvmywx/4c/St7cqq8Jip3bLQL
         s65rzkBWnFz033LwSmum5bTmmsbJI5kt/cgspcraafk5VEKarSkkqaczgPbiDHxBo7
         oRUAVo4OcMJGymXGz4s4MnTFr1Br+hb+MTgQuX/Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [34.92.246.95] ([34.92.246.95]) by
 msvc-mesg-gmx022.server.lan (via HTTP); Wed, 20 Nov 2019 07:50:17 +0100
MIME-Version: 1.0
Message-ID: <trinity-ec49f5ac-9f49-4833-a25e-d4afaa9f0749-1574232617442@msvc-mesg-gmx022>
From:   "Su Yue" <Damenly_Su@gmx.com>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: block group: do not exclude bytenr adjacent to
 block group
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 20 Nov 2019 07:50:17 +0100
In-Reply-To: <20191118055603.10011-1-Damenly_Su@gmx.com>
References: <20191118055603.10011-1-Damenly_Su@gmx.com>
X-Provags-ID: V03:K1:z2OgCr6MGOuwkLZTbhOqvccRFMIzq9JECvzCD/HVoGnv5emqHu7YL7YXVLGvcyDB2nAhE
 eCKBQ7cDUSNfKrjJxYNBiJpB5vUAq9TrhQuGIZZXnEZ7ntg9PgDDzeBuOSlcHkpIDw+w0xxS5+BH
 2AuWWWaP7VlE7nwdEr2OX1GCbUdqlHY3tCWtABYDWfZ5QFswk/sytRHzS16kxu+Rj4krfxo1aB1v
 +ggqpgbf8OU9n8TJ6T/p/BXWqrcrQcAB204akpOaQOqs01UfxMdjTQpBVM00Fys623XCCKPR3qn8
 zpM29/m6cB0aWKL7oShSALD
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DRW9kds14O0=:LueIwrdOYyTSLY8kjdZMtw
 DtV8abXmRR+FttD7OyKtHm4phKDlNCozuJ0b7gcDppxOHyXHOS96i++Sg/ujlRd9/yIoXBocJ
 EYJx6k+aThFHMgOUXNpzhdiKR+6H8itYjhtr0tJGUcOaZtpu0/KsemIUuWZxCuiEUHMy+diRu
 xVN3De1VAYBnr7t0WpoQtvP/mA2vsRXmeL1kvbOa6e+ZMbXrj3uOVHcvhak1cIZSL8OG5rHZ8
 vh+4FXyWW7Xb05nWgwwXQemUqwMapxlA5nx9K12+eskfTGjCgnk0jyCD1abXhzbnlWPLACkTS
 BKk1t2qO5dVhEWJR5dryGDRIotIOm9W8mgAxvT7esDvzHIccf1RRDQTTUSP/6/93+kL+GncCr
 m58j33rwT7B9ufvVdQc/YSR+j8B6WBmn/v7LJujvnfnOFjPcl6rXk2sgy/R1DY4mm+VlnZ2mg
 Mo/wXJAgaz3UsdRwY1o+mkBF9FI3XD1r3Eulr0vadQ7Apvn4XYh2tAWYr4VUwG3CKWlcXtLJ2
 L2GxUWbQ/VfeZh7xHgk0oBzrunmzwjkeigMy82nmFtMt1e18WFoIZmbArTqe/Vltdo3a6xV/a
 BYj4hHkYL7QdkMI6HwFNOoWrRVSzsgsX+Is9FrsjEz5XiaI9IYNkApquKohgkeqAnJFNYQfUy
 fQxGc3TS2ESMTRqb8073taM57HoLb90eXLblvRcobeUdHudGWy+tuAzJq3v15aPTGmwL0FgzC
 h1NvhUGEpvXZnCtH6pZlNNcHtwYZAEhmMOYuPNnPIQGeWTCsShwBwmEn7a7kso4zezCBWrdY0
 DyEEgFR
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Drop those too, will send new version fixed by another method.

On 2019/11/18 at 13:56, damenly.su@gmail.com wrote:

> From: Su Yue <Damenly_Su@gmx.com>
>
> while excluding super stripes from one block group, the logical bytenr
> should not be excluded if the block group's start + length equals the
> bytenr since the bytenr is not belong to the block group.
>
> This is insipred by same bugous code of btrfs-progs.
> The fuzz image is rejected to be mounted by tree-checker, but not
> bad to enhance the check in practice.
>
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>  fs/btrfs/block-group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1e521db3ef56..54f970f459f5 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1539,7 +1539,7 @@ static int exclude_super_stripes(struct btrfs_bloc=
k_group_cache *cache)
>  		while (nr--) {
>  			u64 start, len;
>
> -			if (logical[nr] > cache->start + cache->length)
> +			if (logical[nr] >=3D cache->start + cache->length)
>  				continue;
>
>  			if (logical[nr] + stripe_len <=3D cache->start)
> --
> 2.23.0

