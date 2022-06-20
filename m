Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656AD551219
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiFTIDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiFTIDj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 04:03:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E9213
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655712213;
        bh=yeEVWVSZ02lO+12VVyXmuTyE5PDSQLzJ/4SDujQ6GJA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=aeYYdB3AN19zFAxgwbd+GuA6ZEBCY4n5t+6pMkY8LN2lT8ZSwWNGno3XM8tK8O332
         Ud7QmBtm8kpWib8iaiC++18c/VyZk0Gr7GVegbpxbBS82JnSUbR+lol1FYxeiybcrk
         Uv4kRrqkb9wRSFG9UXUfiP/emudtwDAbrc4U09oI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPXd2-1oH2Gc3MXK-00MYse; Mon, 20
 Jun 2022 10:03:33 +0200
Message-ID: <5a344cb5-ced9-ebd5-b871-6fa6cf031e20@gmx.com>
Date:   Mon, 20 Jun 2022 16:03:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-7-hch@lst.de>
 <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com>
 <1b21e3e9-cdd9-baa6-bd39-e9489de883ff@gmx.com>
 <20220620074742.GB11832@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
In-Reply-To: <20220620074742.GB11832@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BqbXlxGqFYkztGKSOwwu6w7aFKeTQ7VtIxSn6ZFjazoC8P3TFQe
 kg2HxUMKos3/YVZk1nWkOF2JYv2eOh5G/0ME2cnbdk6YqfvygQYOavGH3zKU2bZmRDYIO+Q
 5VYBuIZuLfV1rCkbpTTQCm+elI772Su/gX7HfrYSOLhNzABuF1pXePBILdTPbSsUPlyw+kS
 CQX0Zq23ngKnYfjjct/pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q4WWqQ69Cj0=:+5BN3faRLs0vwb3hNv9JpN
 SOwKcBblIDIVBkeEu4T8YTGD3oYFaCP1O6OFPOkeW3yvsbFNbJEnSag1xfdVlf3G2joQVoGZS
 sBmGr1Gd08YqJKte1qx6e6KhKD3jPFWigX4A0YFTahIQQzMJXQMa/i3DlBpe/O3/uchi5jFoi
 1uMLNjUIXJSZoU1VrRagTcUVhhp8syGo/XLY+79eWaqLbjry23uZriSFWpiL+k+eNNcQ+ssGK
 JlPNC/1o3ivPYp8ran69sDxFvd6Cqn5q6FhWKXD3EHvDGHEylMVJ14tuOjhTS9s0mV49zKwRq
 pznUDwFbl3WnMDbKvQ8O3FR35Kg2E6VAyBUX4wS1ES2EghYZn99XT4HoxgTBeBzJ05U8Uqe+D
 ktNQ+YaTvKXQlY74GedOtgD6bW85VU6dpwRW+bpC7r4mtCNoeA+pIaZPqacZtTsFbGwQhoNYm
 X1zz1x56gDuFZSFQMFtjkYmtswPxK9MudSulnLYhksYwB7DibrGSec5lyxlNHPoiihBBs+WGm
 3hxB9WKncpuxjA9ChT3yOvFELcGCKner6mjXBLkPk4iTeFSGK4el3emRKEWpz4kgNehu5E3Op
 MAZWutRDxI5fyOzOCs8RQXleTdQmV18vat1dhqObynu1r/rHaNCS7AaQ6v3yCYGcQzIdeSBsi
 SmhqbBbXSDoVloX4DR+ERFhD8sI4HDT0vbWt2X4egbOhoucpbZuriza+GXdx6/vXV5u9qOsxW
 iDMWRge2dU7hlVatzXo1zrTOYoMj25QnN/5EkgncJBs5sEXWBL5x5dNY/9Lyt4LC+QO2fxa7E
 l9JkWD4W5Q53Jx0wh551grxliAeBw6O8yduPm9zvfvkPFpRMlYbkIEe37s8Unweb++BYSYuW6
 y5lVq8KRsaN14uUBE7NgQdzGYh5ZHbPxG5E8WWb8lqZt1MJpOfoeGQGnsvVTyB0mCFEQuGOuc
 hW3vW1tdO5nAkZT4XJT1h3C6cqU99uy46S04ABltg8TBM+JDeG7ukoKWAQeeNJk4w/8RRZ0JL
 GjOoQh/qS9xiw3CFG8hrbSU+CshViecCP4WqrzxvPM/VxO+4rRlUkhYRf8cYeD1nh7/cXKdNw
 zqBvcZmWCg8DoIgzmEDTNebL0WybZ0DCQtDqGzIK+LmME90aVnA/gS3zQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/20 15:47, Christoph Hellwig wrote:
> On Mon, Jun 20, 2022 at 05:50:53AM +0800, Qu Wenruo wrote:
>> In fact, the bio counter for btrfs_map_bio() is just increased and to
>> allow the real bios (either the RAID56 code, or submit_stripe_bio()) to
>> grab extra counter to cover the full lifespan of the real bio.
>>
>> Thus I don't think there is any bio counter to be "transferred" here.

Well, your reply already make it very clear that that question is incorrec=
t.

>
> What is the real bio?

At least to me, it is more like a meta bio representing the write for
logical address.

E.g. if we have a write for a logical address, and the underlying chunk
is RAID1, then when both copies finished their endio, the bio counter
should be 0.
(For current code base, during the bio assemble/submission, the counter
can easily go beyond 1, which can be cleaned up in the future).

>
> In the parity raid case there is:
>
>   1) the upper level btrfs_bio, which is handed off to
>      raid56_parity_write / raid56_parity_recover.
>      It then to the bios list of the rbio and is eventually completed
>   2) lower-level RAID bios, which have no direct connection to the
>      btrfs_bio, as they are all driven off the rbio-based state
>      machine
>
> For the non-parity case we have
>
>   1) the upper level btrfs_bio, which is submitted to the actual devic
>      as the last mirror (write case) or the only bio (read case)
>   2) the clones for the non-last mirror writes
>
> btrfs_submit_bio calls btrfs_bio_counter_inc_blocked before
> __btrfs_map_block to protect against device replace operations,
> and that protection needs to last until the last bio using the
> mapping returned from __btrfs_map_block has completed.
>
> So we don't need an extra count for the parity case.

Yep, I can totally agree now.

>  In fact we
> don't really need an extra count either for the non-parity case
> except for additional mirror writes.  So maybe things are cleaned
> up if we also add this patch (which relies on the previous ones in
> this series):

Sure, the series is already a little large, we can definitely do more
cleanup later.

But in that case, mind to put this patch into the series do all the bio
counter cleanups?

AFAIK there is no dependency in the patchset on this patch, it would be
much better to be in a series doing bio counters.

Thanks,
Qu
>
> ---
>  From 6351835b133ce00e2d65a6b2a398678b45426947 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 20 Jun 2022 09:43:48 +0200
> Subject: btrfs: don't take a bio_counter reference for cloned bios
>
> There is no need for multiple bio_counter references for a single I/O.
> Just release the reference when completing the bio and avoid additional
> counter roundtrips.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/ctree.h       | 1 -
>   fs/btrfs/dev-replace.c | 5 -----
>   fs/btrfs/volumes.c     | 7 ++-----
>   3 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1347c92234a56..6857897c77108 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3972,7 +3972,6 @@ static inline void btrfs_init_full_stripe_locks_tr=
ee(
>
>   /* dev-replace.c */
>   void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
> -void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info);
>   void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
>
>   static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info=
)
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index a7dd6ba25e990..aa435d04e8ef3 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -1288,11 +1288,6 @@ int __pure btrfs_dev_replace_is_ongoing(struct bt=
rfs_dev_replace *dev_replace)
>   	return 1;
>   }
>
> -void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info)
> -{
> -	percpu_counter_inc(&fs_info->dev_replace.bio_counter);
> -}
> -
>   void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount)
>   {
>   	percpu_counter_sub(&fs_info->dev_replace.bio_counter, amount);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 33a232c897d14..86e200d2000f9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6647,14 +6647,14 @@ static void btrfs_end_bio(struct bio *bio)
>   		}
>   	}
>
> -	btrfs_bio_counter_dec(bioc->fs_info);
> -
>   	if (bio !=3D orig_bio) {
>   		bio_endio(orig_bio);
>   		bio_put(bio);
>   		return;
>   	}
>
> +	btrfs_bio_counter_dec(bioc->fs_info);
> +
>   	/*
>   	 * Only send an error to the higher layers if it is beyond the tolera=
nce
>   	 * threshold.
> @@ -6698,8 +6698,6 @@ static void submit_stripe_bio(struct btrfs_io_cont=
ext *bioc,
>   	bio->bi_end_io =3D btrfs_end_bio;
>   	bio->bi_iter.bi_sector =3D physical >> 9;
>
> -	btrfs_bio_counter_inc_noblocked(fs_info);
> -
>   	if (!dev || !dev->bdev ||
>   	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
>   	    (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE &&
> @@ -6781,7 +6779,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_inf=
o, struct bio *bio,
>
>   		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
>   	}
> -	btrfs_bio_counter_dec(fs_info);
>   }
>
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_ar=
gs *args,
