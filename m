Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9C4F8F76
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiDHHZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 03:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiDHHZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 03:25:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD59135F1C7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649402625;
        bh=cDEHLpnZXfN3kEtFTJ7/mxgri/HVv/56N4Mjia56nwk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iiSF1ah+vsiIhD1uZetfY4mJZg82XviAtIpA4BK8tKcC1tvah6Z/+/9jJEFJsSvRZ
         Sm7FsGU2PcrlvIzZ1VTwaZ5NesuVhrLV3CiHomAw2caE664mt/YlaaOWawUFKq9pSs
         ursE6CCHIXjIq2FI1+5OxCSzHbo8JguUbdIcI81Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTqg-1nWajG2FHi-00WYJ7; Fri, 08
 Apr 2022 09:23:45 +0200
Message-ID: <de57d0ac-f3b6-e803-3c22-f2d33876398c@gmx.com>
Date:   Fri, 8 Apr 2022 15:23:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/12] btrfs: simplify btrfsic_read_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220408050839.239113-1-hch@lst.de>
 <20220408050839.239113-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220408050839.239113-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xAPXW8yiZXR+pyu8Cozr5CijAt/zcce2tBf/b8eEc6gamEb4W9p
 /1zpYEZ9lFuakcEKn4bLRvhRve0L4rKBG9f5S7Wr2UZ8IGwDfTjmBzb8evucBcIdu4CNj+0
 svIfgK0/tsPI+29DLzh6eaKZ5pfsRocn+6AuGc6Dr99jw44AhP8yVzcLY5mpDL2VTrf2Mwf
 th/UisuVg4OR8fSrVhrLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IC0RTXkA/Xk=:cbKlxqawor2+wB0rumJval
 bHSitVJ8JXY0ntZAPgyQKOs391FVOaACA6NIQXs2TXgquCv5rYP1XixVnSqH3EtQExD7fgB4t
 neHd6OwTBdwdd38Brh0Q+Z2adIedWo92aHGW1aNXZIbsPJem6rvJbByssJtXO36OIoj8dxFsg
 RjaDugpv8taLUQ+RO7+YxDp9Mx+F75425NQq15eMKwydytUAK1GTtgge9JynyLFtng/kl4vGc
 Vyi/OGfYB+RfIQzO1JUT9TKK+wIlVW7jNQ+mdycPCJ7ORjjoNzYD/YMC2w716s+sO+yAPKCHN
 edSAorNRSXEUirxBJe0JGeFljTFWEfTYXSN/QvyoXbsqN/ETRhgwAJKiyymryc+g9bHqx+SJ9
 fXkKrWltmM+9ie/xbUTypg2tuCYrJbg5Y9tDv53xC2ieeGnPK49eGeECaPOrAKEHRe1KGo7XO
 dZ4a5ZNJ/BD/CbJIRXVJ5UoR0Rx3yI26BpN+saPTO4LHLmw8K1Nza4nlff6rzneFTl5J8A00J
 0udwItWl6sBswToQJtXDMKEZStaLZw2Cy0DTJlb3GMRKiksabk16whH8phn2OdWOtHUVhh9j4
 /V5pgP5CfLbfw9iQEPPpF0nn1/2Xpc5VccmDxPE0HaU842+p+GL2+jyz6JTE1p0ZzQrAoODGm
 cgWl+SUu+c4BEPXrIO94dG/JjhtZEL4qBONSFlp4n8AQzEansI3+xYS7n7q/1o3j2I26OIvA5
 WTHfsefK7tr3ksjamWIXNLEs0X2RcHVx8bcVEyTWmTDgkouwHamYi6TeqmDdt6t3J5GzUDW1b
 EalmPAjMabNJsfEQWHNKLSNOaJYVWScXseZrZdnYUphopzzK8cJIe788smgZmK1SL/uFt5EIT
 MrptZmjCWAjdPf+RfYzZBlZ8vEeHwJ+71+CVZQ6SsgX/yFFpRweQq5/iZzVYDM2HJVrnnTA1n
 lFAxzJPs/isOGt4U7x4xbQHDFMcSG4hhyLFsZ4P42FQWtKB9wTZYmQCjYJn1DYSaA9S4TFoAo
 TugxuR4AmHDZ+0rMV0L6B3LDVWpwiBdM1osPN2xVxiCdQYxqok/lNY/6B+PaR9dCbNX8Uc9i9
 tmCH0y1P053wG0=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/8 13:08, Christoph Hellwig wrote:
> btrfsic_read_block does not need the btrfs_bio structure, so switch to
> plain bio_alloc.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/check-integrity.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 9efd33b4e24d7..864a90e825050 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -1561,10 +1561,9 @@ static int btrfsic_read_block(struct btrfsic_stat=
e *state,
>   		struct bio *bio;
>   		unsigned int j;
>
> -		bio =3D btrfs_bio_alloc(num_pages - i);
> -		bio_set_dev(bio, block_ctx->dev->bdev);
> +		bio =3D bio_alloc(block_ctx->dev->bdev, num_pages - i,
> +				REQ_OP_READ, GFP_NOFS);
>   		bio->bi_iter.bi_sector =3D dev_bytenr >> 9;
> -		bio->bi_opf =3D REQ_OP_READ;
>
>   		for (j =3D i; j < num_pages; j++) {
>   			ret =3D bio_add_page(bio, block_ctx->pagev[j],
