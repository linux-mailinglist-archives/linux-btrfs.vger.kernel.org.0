Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEABA79E434
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbjIMJw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbjIMJwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 05:52:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D312E19A9;
        Wed, 13 Sep 2023 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694598722; x=1695203522; i=quwenruo.btrfs@gmx.com;
 bh=gVnD+g/dG7cHd/ek17XbLYGS5fEVkFLT1gU9AXvzt1E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IkFbaPAW1tHp+rSUGTlIgoN1smEGhKt7/TfIEIEF/kILaKgwxxoj3rjr7+QfbwlbajFITl6ftxM
 z5zDpeZAk2YNu/FRtA86FUGpWmiKxWvQUQfybR7EeZr4RQ5MfvAUi6+cNXLwtP5wTavHGlXU2i4Xs
 rEz9vRt3cqWBZjoB+shH3+sWuGvWu8pn1opPyU5izNnt121eCiAs94MCyma4F+8UNe8+XXc5X4QCM
 p8S+3N1BL8slypJ8BmTb94TKxm6Z9PWPeF6Gaorsf2Q6nLBmGL40vbrq6NvibqdryWDSdsf2AS2RK
 ww41MuHrHHucGobDWSAXJO3IzYYtDi4SH4EA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhyc-1quA3n49D8-00DpUt; Wed, 13
 Sep 2023 11:52:02 +0200
Message-ID: <f00629cc-4409-4ea8-ba6b-1953c60f152b@gmx.com>
Date:   Wed, 13 Sep 2023 19:21:55 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/11] btrfs: implement RST version of scrub
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-6-647676fa852c@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20230911-raid-stripe-tree-v8-6-647676fa852c@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nl41nuFrOEn8y6qkjelG8Vou8UY4adu5QuhYXepH1Gsu7REt58f
 HI4GuWxC08eL8t/WjbLEVK6Qg8/roxJu5vTzwcjnk5L/NM3MJx7BrDYhr///nJAkOneqr4H
 utXv4IZ9ylpNPEnc4KFemaQVEAM06KQnbrpdq5yH0W3RYC8L4IqEf3ac1EybA7zQsGOPGor
 uX0/IMxfLtZeBRsB6AT4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DWrNHLuo6Ts=;cG/3cyINkaZyxwNrz7857lnBAtD
 DWkCIMEeNmCcmqJ522/N0CRojhJuf5+RHQgha5gcozF/1gvJEjmLpIEg6F2L5xtAkMaqLUF8B
 mb75lLesECZH2Un5SOYQMpcuyYU54Q+gm7r+/jvGWxQQvA7l4E2VEczQJjULsgGqtD1FcvZc6
 UNAgRNsBcZZZykHdse0i+QtBI5/T7CKE4w6gxNaAfyzIO02IEtxhZBHtBkKaKJEb4hBwwg737
 eSi1xou/HdbrYCWxe+EdELGRh3RvQfIDHn81D40G7s52RRBRL70V6YMFR0kXHTwNTwe+GV5PO
 krBa6Qo+UKlErzxmy/9KXUh5jR0vAmhS2dNpxEvp46CkvOf/k5Qavw09eKp96dml9OoexBu32
 1yxw2+jXLfxKTxu1i/qCRhCn/YalHdXZe4CtN3kHmpdBb5TFeHKf3Y9ahkcoT7IP6J3Adggbq
 DCL2mahsKMODE0ZqyDUOVjf/UhfGgvuqcxDop+u32UYycL96cSV7yOeFoudV02PNgciosqT2S
 V59gqeHuGThRs53t53XQo0Xj/kwMssuxaxSTTLgU+9FP8Wv1UV9KP2QAmduo01tJVPYf8Ncsp
 exN0W+sNozLUZsR8NjDptTe/JZVNfD7M7CiA0XloJ/1NPopucB3v1aPgnecNTIa2uKdq/xHPI
 b1UjaB+Jq/ZmkyTCFN9SjdCa5M+BT4cI6cIcVZNLDc6zJzP4Z/nAf1rVeQOR386us+NGl14m8
 B3tjZoyXOYURoG0kc0nznA5z6lHQouH2dLZjz7ZqQEuEnvg2fYn5FMgrxa5fUYUUz8JtIARCR
 x2ja2KytW5KeqYEyCRCrupquhf/OY3IBh/uSjuam8cCZcNi7wSwqc786w2kQFE+V3bkwWTHEn
 o3aO2rzpWdgp1Yiw3GqlAJhViN4CBsFVe/u3WDKi3w9CwbNa/Nar8i8hRbrVdeUjZht1a2OrF
 4TZ+/aid1EZ2uv1z4WZFtHKPjI0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/11 22:22, Johannes Thumshirn wrote:
> A filesystem that uses the RAID stripe tree for logical to physical
> address translation can't use the regular scrub path, that reads all
> stripes and then checks if a sector is unused afterwards.
>
> When using the RAID stripe tree, this will result in lookup errors, as t=
he
> stripe tree doesn't know the requested logical addresses.
>
> Instead, look up stripes that are backed by the extent bitmap.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/scrub.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>   1 file changed, 56 insertions(+)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f16220ce5fba..5101e0a3f83e 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -23,6 +23,7 @@
>   #include "accessors.h"
>   #include "file-item.h"
>   #include "scrub.h"
> +#include "raid-stripe-tree.h"
>
>   /*
>    * This is only the first step towards a full-features scrub. It reads=
 all
> @@ -1634,6 +1635,56 @@ static void scrub_reset_stripe(struct scrub_strip=
e *stripe)
>   	}
>   }
>
> +static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
> +					    struct scrub_stripe *stripe)
> +{
> +	struct btrfs_fs_info *fs_info =3D stripe->bg->fs_info;
> +	struct btrfs_bio *bbio =3D NULL;
> +	int mirror =3D stripe->mirror_num;
> +	int i;
> +
> +	atomic_inc(&stripe->pending_io);
> +
> +	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors)=
 {
> +		struct page *page;
> +		int pgoff;
> +
> +		page =3D scrub_stripe_get_page(stripe, i);
> +		pgoff =3D scrub_stripe_get_page_offset(stripe, i);
> +
> +		/* The current sector cannot be merged, submit the bio. */
> +		if (bbio &&
> +		    ((i > 0 && !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
> +		     bbio->bio.bi_iter.bi_size >=3D BTRFS_STRIPE_LEN)) {
> +			ASSERT(bbio->bio.bi_iter.bi_size);
> +			atomic_inc(&stripe->pending_io);
> +			btrfs_submit_bio(bbio, mirror);
> +			bbio =3D NULL;
> +		}
> +
> +		if (!bbio) {
> +			bbio =3D btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
> +				fs_info, scrub_read_endio, stripe);
> +			bbio->bio.bi_iter.bi_sector =3D (stripe->logical +
> +				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
> +		}
> +
> +		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> +	}
> +
> +	if (bbio) {
> +		ASSERT(bbio->bio.bi_iter.bi_size);
> +		atomic_inc(&stripe->pending_io);
> +		btrfs_submit_bio(bbio, mirror);

Since RST is looked up during btrfs_submit_bio() (to be more accurate,
set_io_stripe()), and I just checked there is no special requirement to
make btrfs to lookup using commit root.

This means we can have a problem that extent items and RST are out-of-sync=
.

For scrub, all the extent items are searched using commit root, but
btrfs_get_raid_extent_offset() is only using current root.
Thus you would got some problems during fsstress and scrub.


We need some way to distinguish scrub bbio from regular ones (which is a
completely new requirement).
For now only scrub doesn't initialize bbio->inode, thus it can be used
to do the distinguish (at least for now).

Thanks,
Qu
> +	}
> +
> +	if (atomic_dec_and_test(&stripe->pending_io)) {
> +		wake_up(&stripe->io_wait);
> +		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
> +		queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
> +	}
> +}
> +
>   static void scrub_submit_initial_read(struct scrub_ctx *sctx,
>   				      struct scrub_stripe *stripe)
>   {
> @@ -1645,6 +1696,11 @@ static void scrub_submit_initial_read(struct scru=
b_ctx *sctx,
>   	ASSERT(stripe->mirror_num > 0);
>   	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
>
> +	if (btrfs_need_stripe_tree_update(fs_info, stripe->bg->flags)) {
> +		scrub_submit_extent_sector_read(sctx, stripe);
> +		return;
> +	}
> +
>   	bbio =3D btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
>   			       scrub_read_endio, stripe);
>
>
