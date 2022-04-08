Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9034F8F75
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiDHHYq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDHHYo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 03:24:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0BE2F3D15
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649402554;
        bh=7SdLW4JKTD5FuHd7zZqepE1rkgwdaUguuPzFhNc3YVc=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=J8pt0xBJnJEeD5C/fzWlSJQ6qgE/BYdQx+Yn2YXAuaOLcYcOXEwH7n1YxireC3yWW
         GtrwMu8bt1rUdrwCrxbq7XROiK2G6wK12OV/4cBofz7JH7UbJjs/cTjmiTLg7pIbZm
         iNFRpub/OTWBhSbFNVgEI+zLOdg7IoE9gRlQEkVo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mr9Fs-1oNJlP1Ywg-00oFY8; Fri, 08
 Apr 2022 09:22:34 +0200
Message-ID: <27e9d39c-3546-7be3-31af-2e41ece556a7@gmx.com>
Date:   Fri, 8 Apr 2022 15:22:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220408050839.239113-1-hch@lst.de>
 <20220408050839.239113-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 01/12] btrfs: refactor __btrfsic_submit_bio
In-Reply-To: <20220408050839.239113-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iH1DQc4uH/SZ2l6iX51uhj7L5D/pZiFxHj3XV5rEXrg6yU/1+Qg
 yiOutBGDE1Eb4sJvjY18EpC6xtWJzJXKCYK9xxxdYGkwTgpglg4MVFoqOxUTzI9mopUZiXX
 rN86ftczBwDS594UGFpqe7KKNc3WaPxHZmwHo6Z5OO8q0NBvZkxxz4dVE/0T9pWRr4PElAr
 xBNovqO1sIBs9a2aHr+dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UqLszMr20wQ=:FIiyjgvGoUcT1pCI2D+nig
 LaYHQk3yw0zvg8gTLehOclxM8jbjRGDqLXraxp9VaNyLA0yhUujg3DswjTIBTAVvZn/9Pyfxu
 ssgYuSXAd+ylLIzn9VDZBUT515HInZBFUGLSo/eASHUivAdk1vjNktIGCSmGYqWtzbCTkNrq5
 WO4G2jFTSgarmBLzRmEMP2r9gZncoIPYu8EAeqQEyOAOkb6Svb5m9vBxXtqf3b0An7ETkndIb
 6XDQSfT+k+0ECVYvGMAoSngAGIyu+K4qWn9mZHcd2aGTTw59gWdF6yrsToyUkhXLJRZ5WeXUQ
 shl240uxVSL1Xd4GzyP2dKevA1WZvQy95drmHLbe5795rDo+NmPYSioh5XT77J5NESNfJkjr9
 Xe156TMpVPZEk8jd0RTOUhB7t919hN/jfmTQcn/Z9NiRsabIP22rDYNNXVjmuDOiuyDxi3XaC
 XqQXwxfB7eLtBXL0S0TtzXd3NXtbdCYYUh5vSci9yHG6dY7HVvNURxjBU7Y/fEUwqMshDUAo0
 QKMSlzTG++Gm0pL20duno0r6gLKEY0ZBoUQf8DU+AEPd3A+mIuaJunysv7UJDWQ0qVoEvrbXK
 XJxS6Yrq3ZFRiOH9OLzT7J/Fzw34zpfufNzPjY4g11co23Z+QUAgoPGDlSKSeBPYS5aN+N31L
 KJDyj47og7XByaeH5aifH9RcDpUPUsPsFSyjBkqt/TeGL8Y8ZaHud5sR8oC9l/Zvo5avnf9+0
 fHIUMk+HD5NvAP9JnkQQb344vJU55Kz2UprnDjZqdV1fRFsZXcUZ5E6BfRoeaS5svLFamw24E
 c22FcCukn1U/Q83hFg/LZ9rr4CqlKZDig60yB0e8s+BsOSp/Le4AGF8dWAl+wiZgELFFXLN2n
 qcIdJC8JJwh/UhBtONO6cePqnyhLlAQ3IO4/SL3pnxf4LkAn+szKtQXmJOGEaksMl9Onvg3bJ
 MozFFWqTNWG3SoDzdI4mOLvImUR6TVv8MUWZerPrrQul+F44jiVURsiWU8HIDWPbKAC5UQYab
 jR3rNQiWnfVB0HV/8+DUBlN+xENmgwOWhgGi/EC1ZP9ocPlUb2NiM7C1BgYmI1qWsZ+7/SRra
 u2C9u2kzGqfy1w=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/8 13:08, Christoph Hellwig wrote:
> Split out two helpers to mak __btrfsic_submit_bio more readable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The refactor itself is already pretty good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/check-integrity.c | 150 +++++++++++++++++++------------------
>   1 file changed, 78 insertions(+), 72 deletions(-)
>
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index b8f9dfa326207..ec8a73ff82717 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -2633,6 +2633,74 @@ static struct btrfsic_dev_state *btrfsic_dev_stat=
e_lookup(dev_t dev)
>   						  &btrfsic_dev_state_hashtable);
>   }
>
> +static void btrfsic_check_write_bio(struct bio *bio,
> +		struct btrfsic_dev_state *dev_state)
> +{
> +	unsigned int segs =3D bio_segments(bio);
> +	u64 dev_bytenr =3D 512 * bio->bi_iter.bi_sector;
> +	u64 cur_bytenr =3D dev_bytenr;
> +	struct bvec_iter iter;
> +	struct bio_vec bvec;
> +	char **mapped_datav;
> +	int bio_is_patched =3D 0;
> +	int i =3D 0;
> +
> +	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
> +		pr_info("submit_bio(rw=3D%d,0x%x, bi_vcnt=3D%u, bi_sector=3D%llu (byt=
enr %llu), bi_bdev=3D%p)\n",
> +		       bio_op(bio), bio->bi_opf, segs,
> +		       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_bdev);
> +
> +	mapped_datav =3D kmalloc_array(segs, sizeof(*mapped_datav), GFP_NOFS);
> +	if (!mapped_datav)
> +		return;
> +
> +	bio_for_each_segment(bvec, bio, iter) {
> +		BUG_ON(bvec.bv_len !=3D PAGE_SIZE);
> +		mapped_datav[i] =3D page_address(bvec.bv_page);
> +		i++;
> +
> +		if (dev_state->state->print_mask &
> +		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE)
> +			pr_info("#%u: bytenr=3D%llu, len=3D%u, offset=3D%u\n",
> +			       i, cur_bytenr, bvec.bv_len, bvec.bv_offset);
> +		cur_bytenr +=3D bvec.bv_len;
> +	}
> +
> +	btrfsic_process_written_block(dev_state, dev_bytenr, mapped_datav, seg=
s,
> +				      bio, &bio_is_patched, bio->bi_opf);
> +	kfree(mapped_datav);
> +}
> +
> +static void btrfsic_check_flush_bio(struct bio *bio,
> +		struct btrfsic_dev_state *dev_state)
> +{
> +	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
> +		pr_info("submit_bio(rw=3D%d,0x%x FLUSH, bdev=3D%p)\n",
> +		       bio_op(bio), bio->bi_opf, bio->bi_bdev);
> +
> +	if (dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
> +		struct btrfsic_block *const block =3D
> +			&dev_state->dummy_block_for_bio_bh_flush;
> +
> +		block->is_iodone =3D 0;
> +		block->never_written =3D 0;
> +		block->iodone_w_error =3D 0;
> +		block->flush_gen =3D dev_state->last_flush_gen + 1;
> +		block->submit_bio_bh_rw =3D bio->bi_opf;
> +		block->orig_bio_private =3D bio->bi_private;
> +		block->orig_bio_end_io =3D bio->bi_end_io;
> +		block->next_in_same_bio =3D NULL;
> +		bio->bi_private =3D block;
> +		bio->bi_end_io =3D btrfsic_bio_end_io;
> +	} else if ((dev_state->state->print_mask &
> +		   (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
> +		    BTRFSIC_PRINT_MASK_VERBOSE))) {
> +		pr_info(
> +"btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ign=
ored)!\n",
> +		       dev_state->bdev);
> +	}
> +}
> +
>   static void __btrfsic_submit_bio(struct bio *bio)
>   {
>   	struct btrfsic_dev_state *dev_state;
> @@ -2640,80 +2708,18 @@ static void __btrfsic_submit_bio(struct bio *bio=
)
>   	if (!btrfsic_is_initialized)
>   		return;
>
> -	mutex_lock(&btrfsic_mutex);
> -	/* since btrfsic_submit_bio() is also called before
> -	 * btrfsic_mount(), this might return NULL */
> +	/*
> +	 * We can be called before btrfsic_mount, so there might not be a
> +	 * dev_state.
> +	 */
>   	dev_state =3D btrfsic_dev_state_lookup(bio->bi_bdev->bd_dev);
> -	if (NULL !=3D dev_state &&
> -	    (bio_op(bio) =3D=3D REQ_OP_WRITE) && bio_has_data(bio)) {
> -		int i =3D 0;
> -		u64 dev_bytenr;
> -		u64 cur_bytenr;
> -		struct bio_vec bvec;
> -		struct bvec_iter iter;
> -		int bio_is_patched;
> -		char **mapped_datav;
> -		unsigned int segs =3D bio_segments(bio);
> -
> -		dev_bytenr =3D 512 * bio->bi_iter.bi_sector;
> -		bio_is_patched =3D 0;
> -		if (dev_state->state->print_mask &
> -		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
> -			pr_info("submit_bio(rw=3D%d,0x%x, bi_vcnt=3D%u, bi_sector=3D%llu (by=
tenr %llu), bi_bdev=3D%p)\n",
> -			       bio_op(bio), bio->bi_opf, segs,
> -			       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_bdev);
> -
> -		mapped_datav =3D kmalloc_array(segs,
> -					     sizeof(*mapped_datav), GFP_NOFS);
> -		if (!mapped_datav)
> -			goto leave;
> -		cur_bytenr =3D dev_bytenr;
> -
> -		bio_for_each_segment(bvec, bio, iter) {
> -			BUG_ON(bvec.bv_len !=3D PAGE_SIZE);
> -			mapped_datav[i] =3D page_address(bvec.bv_page);
> -			i++;
> -
> -			if (dev_state->state->print_mask &
> -			    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE)
> -				pr_info("#%u: bytenr=3D%llu, len=3D%u, offset=3D%u\n",
> -				       i, cur_bytenr, bvec.bv_len, bvec.bv_offset);
> -			cur_bytenr +=3D bvec.bv_len;
> -		}
> -		btrfsic_process_written_block(dev_state, dev_bytenr,
> -					      mapped_datav, segs,
> -					      bio, &bio_is_patched,
> -					      bio->bi_opf);
> -		kfree(mapped_datav);
> -	} else if (NULL !=3D dev_state && (bio->bi_opf & REQ_PREFLUSH)) {
> -		if (dev_state->state->print_mask &
> -		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
> -			pr_info("submit_bio(rw=3D%d,0x%x FLUSH, bdev=3D%p)\n",
> -			       bio_op(bio), bio->bi_opf, bio->bi_bdev);
> -		if (!dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
> -			if ((dev_state->state->print_mask &
> -			     (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
> -			      BTRFSIC_PRINT_MASK_VERBOSE)))
> -				pr_info(
> -"btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ign=
ored)!\n",
> -				       dev_state->bdev);
> -		} else {
> -			struct btrfsic_block *const block =3D
> -				&dev_state->dummy_block_for_bio_bh_flush;
> -
> -			block->is_iodone =3D 0;
> -			block->never_written =3D 0;
> -			block->iodone_w_error =3D 0;
> -			block->flush_gen =3D dev_state->last_flush_gen + 1;
> -			block->submit_bio_bh_rw =3D bio->bi_opf;
> -			block->orig_bio_private =3D bio->bi_private;
> -			block->orig_bio_end_io =3D bio->bi_end_io;
> -			block->next_in_same_bio =3D NULL;
> -			bio->bi_private =3D block;
> -			bio->bi_end_io =3D btrfsic_bio_end_io;
> -		}
> +	mutex_lock(&btrfsic_mutex);
> +	if (dev_state) {
> +		if (bio_op(bio) =3D=3D REQ_OP_WRITE && bio_has_data(bio))
> +			btrfsic_check_write_bio(bio, dev_state);
> +		else if (bio->bi_opf & REQ_PREFLUSH)
> +			btrfsic_check_flush_bio(bio, dev_state);
>   	}
> -leave:
>   	mutex_unlock(&btrfsic_mutex);
>   }
>
