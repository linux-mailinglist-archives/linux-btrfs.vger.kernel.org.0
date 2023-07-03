Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA03745BCF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGCMDs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjGCMDr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 08:03:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE4EE49
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688385819; x=1688990619; i=quwenruo.btrfs@gmx.com;
 bh=b7Ro/ofZNeqVvWBsjpmiA2aos4dvOyHFkfZPKnLkFr4=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=m+KfCXE1xW2j/K3hDB03LJwwrrTqjasepnAL1nHgCgSv9JILMoaFiT3zdCgGUzkdcAY424R
 4sOr1wV1RnLvSyYrPrjGCnLisNunKwLiGTmgDUgi/1/aZg6VlcpBzhK2aHrLarJgWXa8CPdcs
 WkXCYXchkhLx3CeaowqifeMCKvXoJOoJj6klnhWuTvEUiPgjpwpI2SEpvneShtVvr+QPZl4iQ
 ydSi4tnhCK3WaX1Bwm7Zzn8mInrdikb0wDxJ8Z3F3BDib4PuntEd7vnX+lwVVGUI8749Arteb
 pcgXJzy0a5MIxobCwk005XtwNW0gYjMtwsb1PtDWVeK4r2dV9VDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacOQ-1pibQ01fas-00cC2u; Mon, 03
 Jul 2023 14:03:39 +0200
Message-ID: <1449f988-b5f6-3a21-eea0-44298ed7dd42@gmx.com>
Date:   Mon, 3 Jul 2023 20:03:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
References: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
In-Reply-To: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xp/XYXqGrKGshSoX0h7vsnveX1Bdw24qhckz0UqRJ0ay07yWKfR
 6tW712aslr4U7pGsDeyRgLFLj9tnxy0XkfgrZZaZXgRJDiGY0y+526oGvIjTe4KD/HRoIo3
 K1nu2yjmdchra1I/WBWJWd++RHTcGIjrnbYBBNQ3+t3DNu5AiR1uAFRWrbJij70UVvq+kM+
 Lh4oFcTatdDM7O070I4Sw==
UI-OutboundReport: notjunk:1;M01:P0:RXp+VuGhhkQ=;2+0M74wAZAnREIfHknrY+rUHrCE
 xUJAf9uM59CBKMUS5q1CbzVE7yMmDzkEhcECauUG74V+ki6wpsVoKMlrsKSptFucZlKpU7039
 /VtRlLu77RyBGzOVjLD1u/J3XIIDWLE0/T0kSVCfhTpljmeYVoGdBSyyJu6byZYhYOIbvVje1
 CZ/OSo/Grjl0MWa4tvpnsrA0Dqs8+AH5H1Dg6oS8ZRtB8GvdPMNs3VkHNOmUN24yRWr7uXkDi
 Rz6M6NY/RvMte5ZwUcg/T+aj++j+TRWhF67A4sshiUjjMHnHAkjEZZsqM+Cevi4Lj6ZttRGXu
 CwMwZ994HiqK2fgAyBAHMtrwzAXmonAmXnUU3zkqkgGH5ldvB75bBmKvkJNIA2xqZP0cr+U81
 Pa+xCyRg/63qIvqK0QNEUv9MiraFdeXlpUszA+Y1Fp6vHXp+xKvdH8L7jm1uvL7aN8Klog/0H
 jGS2HHDlsjE9cnF5vn4Qf9toXu5GRDtulwmmq5uR3kxM32yUechY0bp7gtxJvqLqjxHe3fVKx
 hW83EA5dHy/4PA+jX/w0EoFjaRtbDKDqKM92SGIzkEVXDB/d4Sr53vnKWS51IxNmmyxTWzVOD
 TyiaWsAmf/FcP4IG/EpmYrEbHGdHbOjGFQBUiVuuGNl7ShrcJt65CpCo3/eeCcJJ0aGqqV1td
 7VfjLdX7pkIi817VTGjBHgHKaq7Qv0ziPpAk53loo+z3o9UxPd8c9DKoCi6PlCf0qmsF3o1oX
 9EdXLdUeAFGoPN3g4f+sByHwloNe+oVJBnU8VLUSZQELl3xciY5IJKm3FrjWsz+U69egI+OO+
 1h14C/imWKqnrb4dUZH+u7Vkal2nqsKHD1+1cfdSbvcDweLGQDCoZlvLiVvzRz9U2uZPgAo2y
 3rgys7RmnnnYLeA+fWVNqvb0slLK64fneYxp1ObIJAIR6oUJf146EU7Kjeg9j/F5O9l87cVUr
 KvcHfr21rxbX+CCpz7UeUMWehYY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/3 19:47, Johannes Thumshirn wrote:
> As an optimization scrub_simple_mirror() performs reads in 64k chunks, i=
f
> at least one block of this chunk is has an extent allocated to it.
>
> For zoned devices, this can lead to a read beyond the zone's write
> pointer. But as there can't be any data beyond the write pointer, there'=
s
> no point in reading from it.
>
> Cc: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> ---
> While this is only a marginal optimization for the current code, it will
> become necessary for RAID on zoned drives using the RAID strip tree.
> ---

Personally speaking, I'd prefer RST code to change
scrub_submit_initial_read() to only submit the read with set bits of
extent_sector_bitmap.
(Change it to something like scrub_stripe_submit_repair_read()).

The current change is a little too ad-hoc, and not that worthy by itself.
Especially considering that reading garbage (to reduce IOPS) is a
feature (if not a selling point of lower IOPS) of the new scrub code.

I totally understand RST would hate to read any garbage, as that would
make btrfs_map_block() complain heavily.

Thus in that case, I'd prefer the initial read for RST (regular zoned
are still free to read the garbage) to only submit the sectors covered
by extents.

Thanks,
Qu

>   fs/btrfs/scrub.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 38c103f13fd5..250317da1730 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2060,13 +2060,19 @@ static int scrub_simple_stripe(struct scrub_ctx =
*sctx,
>   	int ret =3D 0;
>
>   	while (cur_logical < bg->start + bg->length) {
> +		u64 length =3D BTRFS_STRIPE_LEN;
> +
> +		if (btrfs_is_zoned(bg->fs_info) &&
> +		    cur_logical + BTRFS_STRIPE_LEN > bg->alloc_offset) {
> +			length =3D bg->alloc_offset - cur_logical;
> +		}
>   		/*
>   		 * Inside each stripe, RAID0 is just SINGLE, and RAID10 is
>   		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
>   		 * this stripe.
>   		 */
>   		ret =3D scrub_simple_mirror(sctx, bg, map, cur_logical,
> -					  BTRFS_STRIPE_LEN, device, cur_physical,
> +					  length, device, cur_physical,
>   					  mirror_num);
>   		if (ret)
>   			return ret;
