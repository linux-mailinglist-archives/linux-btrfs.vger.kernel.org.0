Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268DF7198E0
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjFAKQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjFAKPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 06:15:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261361730
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685614336; i=quwenruo.btrfs@gmx.com;
        bh=2crxW6+clER6VBHp3jJboX5BxrAVKTmy38uZcV9T6Nw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JMDsAmHvMVbLuy9YEgWP2o36LwUanAbeD/eEONvab7+luv50YXzbUPG/muLybpH8q
         5cpV77N7nJ8oBFLhUhx2Gaio1qbV3iFNMJy7ZMYhEkRdTtBKfsjFky6LddpUlgs/mu
         3/eDwXJChgmM61jV7E7x4ZGvOtHVdKpyuchPHiFtKBQBMKGQmJgb/VZRGoYXxfIrFC
         BGKi2RGWyiG4Kw5ukm/8H3basXCCzpmixfDfS79GLvpAFbEBkahMUt679y+0BXg5tf
         EQ5j63qaLFp3kBtNu9EVS0jIcAXHLxGWVNu2Z54PjZXIivD5Z0E5tCFbd/SlbxDQvA
         nZ3WtTXnsDyVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1q4NN231Xb-004EC6; Thu, 01
 Jun 2023 12:12:16 +0200
Message-ID: <bbd57e3d-c61d-cf1e-6f8c-386c24625a69@gmx.com>
Date:   Thu, 1 Jun 2023 18:12:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs: fix dev-replace after the scrub rework
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <0113e9e82b06106940e8ef7323fd4a9c01aa5afc.1685610531.git.wqu@suse.com>
 <20230601093747.GA6652@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230601093747.GA6652@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9+bH1zaxDTk0m7Lj18S37dwkPLbo+01LFoBKOOlXrUdb3OhEu8O
 uhjLXm/FwnJDLTWd6mi/5VW4OfQ8JIjeGHCrFe6I8uCABzJd36DUyhlTrh+7dP84nRdYRBC
 tpVVpZLHXn/mLoEKY0QtCkA549rzNPZaR6hrZ1Vi6BuSgIvsdbO9vBm6aVOIwb4einR5y2S
 RQ4Gcjy7O8yZmjtFFHitQ==
UI-OutboundReport: notjunk:1;M01:P0:Pi5ahbfpMsM=;ZnkHtsuiKVw6Vl3KtRobbU/pQNu
 K272s6mNzibZiP7hPPZH+6sshc2wSsyIrkjJRTUC0jO1Q8bKZ+4tNsFi+tdd7/7qWXf2y/dy+
 1ktOhSODbwCeK/c8gHhPnSzSQ22dwds2aWPDAJeBe7gpy7FZjttt0xL/IlD+jxPfIt3nwTJCE
 c36DizXscDoVnOkYe0h2slMlaYKSQl4ivUD9oghlxD65gNANBeWKIL76E3NuN0SmsZkf41N88
 yEJPpfd0fcthapvjsIPHiYlEgCU7aMPzNtta0S4ow+pORQ9+wog9RWmgOKqwYF26E5/3Qe/vy
 uWdOSqY84nSlvu5yNJlvPd4RPUDYAPDkJxT8Pr4DDKTRThncDA1DJz6QTNrzhmyqML2B6Wzv2
 YAvvfwfEGUpAOHkcGGMRqF5b80OOo379QxwomWSn1gGQ/FUKOVu1j7IdMKVz07PDf5hVmoEkP
 w93u1WPYBIkk49yI6PSsXcSW1VJR4erEYKQLBM0IHEjfBsDKwizZw/PAQLV90LGs/fXBAbya1
 /3/su11RlhRT+WsOjliCwTmJvSi7+9uK5Sk9PpfJ+I8C4No3TEbpUSd/QN37ll7TvSLwY9Wkw
 et7lT+u66a4H6W+f9qe75dlv6rRGRG0ps61nSavQ+5N5I7Izr75OsbFDQYJM5hPRiZEyxa/1T
 yBe0fqk2UdEDZx8tsr2Bjs3ECLu691kccG7ZPs6ecWZBatL+4rmN0jg5zIwnDxjek0fbux3yq
 C6pR1s0oACfAAtGr5DW2Q5m4/W7eyZ2KruFJQawdhGjOTPvlX7TMALhFco9pypzDt32UAOcrj
 BVdPaT4jlU4DLxK4ill0BOwQPiUL0I+xkCh+3Nc+TGfb4jFpizhtYgGoPebnbzlOFLNLTtiNs
 vBPofJ4TnASc8R8g/oMpMzvFCm4Bi4XHuimsF1qwD06yIlyVdiGEqsFSF+XzNWlSgDbf5KzFD
 Xyf3kHu1mkv6IuxRT5T/tV8pQ4U=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/1 17:37, Christoph Hellwig wrote:
> This fixes the tests case for me.  I'd much prefer to not
> duplicate all this logic though, so something like this should
> be folded in:

Yes, the cleanup is also in my mind, but currently I prefer to do the
fix first in-place, then you can do the tide up after the more critical fi=
x.

Thanks,
Qu
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4e74105bc97191..6fbf30bea27ab0 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1102,6 +1102,33 @@ static void scrub_write_endio(struct btrfs_bio *b=
bio)
>   		wake_up(&stripe->io_wait);
>   }
>
> +static void btrfs_submit_scrub_bio(struct scrub_ctx *sctx,
> +				   struct scrub_stripe *stripe,
> +				   struct btrfs_bio *bbio,
> +				   bool dev_replace)
> +{
> +	struct btrfs_fs_info *fs_info =3D stripe->bg->fs_info;
> +	u32 bio_len =3D bbio->bio.bi_iter.bi_size;
> +	u32 bio_off =3D (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
> +		stripe->logical;
> +
> +	fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
> +	atomic_inc(&stripe->pending_io);
> +	btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
> +
> +	/* For zoned writeback, queue depth must be 1. */
> +	if (!btrfs_is_zoned(fs_info))
> +		return;
> +
> +	/*
> +	 * If the write finished without error, forward the write pointer.
> +	 */
> +	wait_scrub_stripe_io(stripe);
> +	if (!test_bit(bio_off >> fs_info->sectorsize_bits,
> +		      &stripe->write_error_bitmap))
> +		sctx->write_pointer +=3D bio_len;
> +}
> +
>   /*
>    * Submit the write bio(s) for the sectors specified by @write_bitmap.
>    *
> @@ -1120,7 +1147,6 @@ static void scrub_write_sectors(struct scrub_ctx *=
sctx, struct scrub_stripe *str
>   {
>   	struct btrfs_fs_info *fs_info =3D stripe->bg->fs_info;
>   	struct btrfs_bio *bbio =3D NULL;
> -	const bool zoned =3D btrfs_is_zoned(fs_info);
>   	int sector_nr;
>
>   	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
> @@ -1133,25 +1159,7 @@ static void scrub_write_sectors(struct scrub_ctx =
*sctx, struct scrub_stripe *str
>
>   		/* Cannot merge with previous sector, submit the current one. */
>   		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
> -			u32 bio_len =3D bbio->bio.bi_iter.bi_size;
> -			u32 bio_off =3D (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
> -				      stripe->logical;
> -
> -			fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
> -			atomic_inc(&stripe->pending_io);
> -			btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
> -			/* For zoned writeback, queue depth must be 1. */
> -			if (zoned) {
> -				wait_scrub_stripe_io(stripe);
> -
> -				/*
> -				 * Write finished without error, forward the
> -				 * write pointer.
> -				 */
> -				if (!test_bit(bio_off >> fs_info->sectorsize_bits,
> -					     &stripe->write_error_bitmap))
> -					sctx->write_pointer +=3D bio_len;
> -			}
> +			btrfs_submit_scrub_bio(sctx, stripe, bbio, dev_replace);
>   			bbio =3D NULL;
>   		}
>   		if (!bbio) {
> @@ -1164,26 +1172,9 @@ static void scrub_write_sectors(struct scrub_ctx =
*sctx, struct scrub_stripe *str
>   		ret =3D bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
>   		ASSERT(ret =3D=3D fs_info->sectorsize);
>   	}
> -	if (bbio) {
> -		u32 bio_len =3D bbio->bio.bi_iter.bi_size;
> -		u32 bio_off =3D (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
> -			      stripe->logical;
>
> -		fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
> -		atomic_inc(&stripe->pending_io);
> -		btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
> -		if (zoned) {
> -			wait_scrub_stripe_io(stripe);
> -
> -			/*
> -			 * Write finished without error, forward the
> -			 * write pointer.
> -			 */
> -			if (!test_bit(bio_off >> fs_info->sectorsize_bits,
> -				     &stripe->write_error_bitmap))
> -				sctx->write_pointer +=3D bio_len;
> -		}
> -	}
> +	if (bbio)
> +		btrfs_submit_scrub_bio(sctx, stripe, bbio, dev_replace);
>   }
>
>   /*
