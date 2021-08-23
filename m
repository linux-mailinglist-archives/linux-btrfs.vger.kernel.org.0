Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300093F46CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhHWIrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 04:47:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:44509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhHWIrd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 04:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629708405;
        bh=s2q+Gj9yfvV0F9Iv8x3z73MYcBS2/0ylu6auR56TklM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gOEAukQqOLG5oDT4N++1tP9B5gYCXU2235iAdXR2PENNtmpvueZq9zJVwHuIVj3NE
         EcFwJ8zgSeBZkCfoQtAhJWwuqq3izsuQsu1uyZ75vPDZiCZK8BxV98fG1ZjGOT6y4m
         L97QQ0EECTLgmYf74rqA2BP5ofrjPAlxfQ8RWqZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1mL80X3KWL-003bBS; Mon, 23
 Aug 2021 10:46:45 +0200
Subject: Re: [PATCH 4/9] btrfs-progs: set nritems based on root items written
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <82a9fe493d3f785f30aecff22067d88eb08d4dc0.1629486429.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3e018b48-e6dc-29bd-9ea9-ba5af830ff7e@gmx.com>
Date:   Mon, 23 Aug 2021 16:46:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <82a9fe493d3f785f30aecff22067d88eb08d4dc0.1629486429.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kNmccGwADe92reIwxNjJ1PCzEDEhGsSY75q/mcEwb6bkZXpbmRd
 Kx7n1p8twfkhe0YoG3KREpPmO68e1IXKAy3QDb+bFtE2UnMam03vRSK65eUcT3GOl6957rS
 KAs9pYCSbvUSYE7f5E7k3ZtQs6M146RQvUHIealFpCbiDOYjaQ/m13PAgBhkKacayfi5mGO
 krhtI0TyI7OGTXZIs4Oyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tj8Irioml4g=:owEQodpE1MbKn8CYASUErc
 xDuznlm3xRmmgbBAHI+bMEsEtOjLMnOgb4snvSs+pEAWPb5pI1PpfCSTDS/1Wdt/adFYHjJp6
 wRUNcC6MBFitJsiyxO1Y52SYgozFsabrfeBCOvzItPho6f2vJ//BITngDq+b8SoAOMPYfW8uO
 Sn3JFrbcOmXIJCKJ1VIsUmgpdDYDS85LpDcuGYzKcQ7anOTqtQl2MGUxdwhnCtTDmLBghfmRX
 u6MUH6o4WQWA3v1e6jz8sq2LAkM71ZAJJ9EV8wAK646x7ukBfOwiHqEVi0EmCCvLijpm2vhTL
 5IsDdYp5n88ZDENpsVgCVYygsxm3GnlrXsRGtWMxMfLYf44TcjM+Ps1SMUqIFKCjAPEupxw6G
 70R3+aXa6q2sF39qY8NJEM6vPIvEiDl9PGM4KvIpySKRtwnXY0/RkLqjlaIpxTtO6i18h7EfT
 vQ2wFN40sedGwjE8BeBvHfuhBA8q8bavZoPDMUZGy+doIJIlTVQDgYEh/xBxMsnhwwoRZxj3g
 wmVXywRDfTE5bGLs/8mdmwSQRPunstiPbshtN6U5Xq+ruO7+DUtZm2CdUt1zflQuCSaGDj2rD
 hBPa4k/7efBlnUOUVZlwm6k1JTDAAF+zbgKsMFfKZPKEWB9pGf9dK2jRDMRO70eIuGBwv+92i
 VxxXckb8EjOueBMaAG7C/gI+QqEYeFPwwYSmbQEwtac4t0xp0+ZbAnF9vK4ItnBktMS8ZJiWS
 IwV3xZZRYke54+56JY6SA0DOF16ICXu0cX+x5+GiOprdMvY54Xdr1feR53pa4sFquP5WtvrL+
 t3fJTkucfVeT3l0QsKtEofJk0e5WUi0mH+9wWV4DpHdL87+mo3nPMd73deITp6p4P09zPsixL
 v41tKHRpwJbVcuZ7Q+JPdbHKeNMC5LK2BCMhhpY8DzibJXrE1gwUKX9soiHqXqhxzUA/JEEZv
 95UqfdFqWT566Tjv8lskCSCukZZ/ck3iiv7+0/anyUPkc4Joor0TzLE9O2FPEOrO1ASXaKpnp
 4XaFfYG/32plG0wgKjtfIb6hxuhIpZ9k4w+g4Mjemd19ajI65YFoWIUt/mFCO/V8/Nez9WRsX
 GU4E8CLUWO7Oxz5sBjDZ33Jm5dI67lI5BPphAclsQMjEnBcRfszh6BcAg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
> For the root tree we were just hard setting the nritems to 4, which will
> change when we move to extent tree v2.  Instead set the nritems after
> we've added all the root items we need to the root tree.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   mkfs/common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 0e747301..29fc8f12 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -107,6 +107,8 @@ static int btrfs_create_tree_root(int fd, struct btr=
fs_mkfs_config *cfg,
>   		itemoff -=3D sizeof(root_item);
>   	}
>
> +	btrfs_set_header_nritems(buf, nritems);
> +
>   	/* generate checksum */
>   	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
>   			     cfg->csum_type);
> @@ -238,7 +240,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   	memset(buf->data, 0, cfg->nodesize);
>   	buf->len =3D cfg->nodesize;
>   	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_ROOT_TREE]);
> -	btrfs_set_header_nritems(buf, 4);
>   	btrfs_set_header_generation(buf, 1);
>   	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
>   	btrfs_set_header_owner(buf, BTRFS_ROOT_TREE_OBJECTID);
>
