Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996DA513EBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353053AbiD1Wza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 18:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiD1Wz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 18:55:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999220BE1
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651186313;
        bh=lsLolTSqX5Bmkixdw0UZRVa+BVIOUAIC/R2QEgFCuQ4=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=jpDRSFaDWOm3vr6G8woLTBeW1dkPr0KJpFrVCH2Gf74Dc/+6ch6OnerPzCTJ3LLv6
         +LNe51dfGnst1BHI4iimf/U/Y9k/D12PKhnPYFiKrmqU0fMK0hwJizVB34aGDVf408
         xt166cfRpVmpJIvM8hNRSNO2RUT1yqNHFCdeu/Fw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1nnDGO0AOb-0086ov; Fri, 29
 Apr 2022 00:51:53 +0200
Message-ID: <b27d0b0f-89de-13a5-013b-323e03d7cc40@gmx.com>
Date:   Fri, 29 Apr 2022 06:51:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <ad61ab273c5f591cb4963f348c4b34302f705705.1651043617.git.wqu@suse.com>
 <YmqYm+iFDSRTbV5W@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC v2 04/12] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
In-Reply-To: <YmqYm+iFDSRTbV5W@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UwOQyqW4AfbBZkkO3Yy0+fesOpPC68XLYdZIi5qIjlVgJG19RVe
 uj5FZl6bgqSqBqLj9ggXMgoGyLbcttwcnsxG9HeTBfqRM5buuUDQOeggifSGZUcZ5dsMh2p
 4esSUJG4E3CX5oLf4asF7+en65DhRTGrdshN1UCYQpEiTn/BSLS5kcWdhp/hB63RFf1CFif
 JOxjIZ9nXfwTqu6K81+AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UtVx7UqGGuU=:U+Xs6nVWUb//20kV4zhMfr
 3Jo2HZB7rgsFVJC02FMMsvE3dMBBbUCsLR7KL7cyNvwfFbGk0R5ksuRZV61uSfOR0AYZIgOss
 m4iCiydWjmeACzTBAUTaCFgpTfprWK4ayIxKtW3ElaRL8OaTauG+B1eECcHeAWf99fOO5jtBE
 n0qn7pzW3HeXmXRJ3PptanIcPAaoOV4yHnQUlr4P6FDidniA/X7PmK0g35wHAd8JWruiMX2Zv
 IzIy1KyeT2dQGR6lA9/yF1DVrIZbK1Ti+8N1lWaMJkL+BeAawLUzkoFdXWxfsaT/r7B3F5Cxi
 ZheFEQtFjtiqNvTV/voGR9Cy3OHH3cwpFjjA64BPjdd8lAEAdzaY5I/izkOtlJuAoEZjeIwlw
 TTbxaEhgYc27DO0ttBZ8KPOBY07zDb4avQB6tTmGSYHurX3Iw2HB/wT7kZjCEIOBbdRSvahvt
 CQqlfaN29Xqr3tDJhpapnXS8YTcfWSPI06L7kiNVz7Zn1l/rdW43Af5PQ5ezSQ3TZqd1ta64v
 jh56XuYe+JlHtS8hMx2RGrD54Qc3qL1IkJ70KDA98eTgOGzOT/cuCJGfxwUzQMUclYiwOhEFj
 OmXcg719mdrQLiTfNkkLrsTVFB7k8jnurK0ACBECWu4Q0BPHd5zdmtKpXOkArhDSuHnVt3PDA
 Rjvi09xHl/Nl9p4iyXVnTxOaCz4XAKBG3dLg32dKoN6HE1zR3lzGOKs6ypf/tZ/6384EanMk8
 L6q73SDrj264iNHwQexdBQI0cgYRwTaB8tXOANrb6t/Af5PAsQKIom2B+L/ZebL5lO0grAPtd
 Ony6yIB0W1IvLmQyH7eFUjlfyQFJ8OflaOpv3pzAt8svtYVIDn0BLOn+4rIRnMurcvV+szffs
 ZSp2yNcIgFGzpA8GtWLoFLKhjzwxCkrl93Gr6LXYeridMEGSmHfwsUuX176qjiAC2lCeDyeJS
 dw3TrD3rNbgVs1brDf4qXHZj2cSrxqJ6d+WlLElFJhhfCbuZ2Y1FEEjuXMXu0QiC3XThgyBQs
 0SfqtPmDxqwtUZK96imYEsgHevjjLtHFiJ4i3zmjSW1ZrMA6bxvwG0RoaaqRa7nKkIaUF5Bsr
 5Yz4I2zdMHeRhY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/28 21:37, Christoph Hellwig wrote:
> On Wed, Apr 27, 2022 at 03:18:50PM +0800, Qu Wenruo wrote:
>> Currently we only allocate two bitmaps and initialize various members,
>> no real work done yet.
>
> I'm rather worried about these allocations.  These are called from
> the I/O completion work queues, which can be rather deadlock heavy.
> Never mind that just failing an I/O repair/recovery when we are out
> of memory seems like a rather bad idea.

That's why there is a btrfs_read_repair_ctrl::error member.

If we failed the memory allocation, then we will not do any repair.

To me, memory allocation is a much bigger problem.


Although we can put the bitmap into btrfs_bio structure, and
pre-allocate it for every bio we're going to submit.

But I'm not sure if the pre-allocation way is a good idea, considering
read-repair should be a relatively code path.

>
>> +	if (!ctrl->initialized) {
>
> I don't think you need the initialize field.  Just check for
> failed_bio being non-NULL to simplify this.

That's indeed simpler.

>
>> +		const u32 sectorsize =3D fs_info->sectorsize;
>> +
>> +		ASSERT(ctrl->cur_bad_bitmap =3D=3D NULL &&
>> +		       ctrl->prev_bad_bitmap =3D=3D NULL);
>> +		/*
>> +		 * failed_bio->bi_iter is not reliable at endio time, thus we
>> +		 * must rely on btrfs_bio::iter to grab the original logical
>> +		 * bytenr.
>> +		 */
>> +		ASSERT(btrfs_bio(failed_bio)->iter.bi_size);
>
> Also things would be lot more readable if the code inside this branch
> just moved into a helper that you call if ->failed_bio is not set.

Indeed.

>
>> +		ctrl->cur_bad_bitmap =3D bitmap_alloc(ctrl->bio_size >>
>> +					fs_info->sectorsize_bits, GFP_NOFS);
>> +		ctrl->prev_bad_bitmap =3D bitmap_alloc(ctrl->bio_size >>
>> +					fs_info->sectorsize_bits, GFP_NOFS);
>> +		/* Just set the error bit, so we will never try repair */
>> +		if (!ctrl->cur_bad_bitmap || !ctrl->prev_bad_bitmap) {
>> +			kfree(ctrl->cur_bad_bitmap);
>> +			kfree(ctrl->prev_bad_bitmap);
>> +			ctrl->cur_bad_bitmap =3D NULL;
>> +			ctrl->prev_bad_bitmap =3D NULL;
>> +			ctrl->error =3D true;
>> +		}
>
> I don't think we need the extra error value either, you can just check
> one of the bitmap pointers for NULL.  That being said, as mentioned
> above I'm really worried about these huge allocations that can fail.
> I think we need a mempool of some fixed size here and use that, and just
> change the algorithm to work in chunks based on this upper bound.
>
>> +/* Strucutre for data read time repair. */
>> +struct btrfs_read_repair_ctrl {
>
> Can we keep that structure private?  Based on the rest of the series
> there actually is a fair amount of code using it, what about isolating
> it in a new read_repair.c instead of in the giant extent_io.c and
> inode.c files?

I was considering putting it into read_repair.c, and since you're also
mentioning that, I guess it's a good idea now.

And if we're going to make that structure private, I guess we have to
pre-allocate it in btrfs_bio as a pointer then.

Thanks,
Qu

