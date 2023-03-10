Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E766B3852
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCJIPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCJIPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:15:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0B166EB
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:14:57 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1pwli71IGn-00MOKQ; Fri, 10
 Mar 2023 09:14:50 +0100
Message-ID: <dcc3f350-bfee-4813-ff9c-65c835c7af57@gmx.com>
Date:   Fri, 10 Mar 2023 16:14:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 07/20] btrfs: simplify the read_extent_buffer end_io
 handler
In-Reply-To: <20230309090526.332550-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zvFoSly/s2sAkvCOlKe8WAa9l4MHCCej9QuWCPvsO0n1ovL61Qf
 QuooqeL7mqxvhmhIMa+IaCtglfJE9j1fy1W1roDQ/2pRZSwn/xxAjRlRfhEt5VM7Zh2p0op
 PhNxfdwM+cSVUGEcCFhD4uJwKq2fdI/53VCqoCV3+gKWXpz6IqFYKQZAMJXiwZmNvbH8/NB
 8ON7zIFakWVgGLSXw2fLw==
UI-OutboundReport: notjunk:1;M01:P0:Ayx028qTwLU=;XoZZjBcaukRs/OEIUNpUV5qRSdk
 E202yfzbTL3MYB/3F9zgVuJqUNbAwSk9zbhKrneAWcy5Q7S0dCjiK+vNOI6LJbESFIE4tG2As
 bInnlNaZsBPCBhNvOS3TW9pYoDQwrvwb1M9cCfDLEHzpIAryyrNWbf7kKc+wJmjSfq23dKG6D
 QSBfeGFd5Bp+BIR2HPEiW231WunRpWZHIj84XdAjHQ4bBK0w1kiXcB37Fcua9+M7ISFtYaFl/
 WEZB1isL/RXKExhs1HITztoCovdgl9Z9ZO2H9wSrHm3gH57YOD6XwoQH2gCy4sT1qlcPvETeW
 tv/rVTq3xv0Qd5GAdk46sKgEbKBYaNU8lfg/6dYtDrihgOYjiYlKmviM+zxwv/FvrgeG4hSl/
 YD1YZemYPGuXSB5L96JHBe3C4iVzLo7z1h0QwqlssKbvN7zwcUrBvqy/H+TXY0KcvsKPTqhLP
 UfXr6xuSDparGKp2fyBFnfHCe9hdcYAjTvk8qThigZ7RfFI/bAxBwlRMI4ghuU4aKnRp7sjdi
 dwfnJcjh6/73mWoMyoUzyN1cXHkygrgBYPDD2MCBrJriMkRRiF8qL97GQFXfauvC5FTyJ3FuZ
 hOxwYQrqChaaemvOPJhKSbQWHgcex7Ojm2cnskdkckmFXbs1EPLvfQF/r4EypQCYyL2/ZVcpN
 RHtuEIQec0Co5evJQs5y2QP1u6HdltqVgtfmzev7TE4Q3CLW2Hh5QmK/O/SB8AQ98BDXbPk8f
 qxaj5772ci3DxIKbz7qvyMulT12ZwfEU5e/UYSy8F6kDWt4VH2RGF/MdBk3rGhDTo5K1qTjfO
 jEVPRlHTkNM6nK3uwomxHJnnLPamZnYqgd/uzyUdWr9DozXSfdCup/zokBzRndYAd8phH85aZ
 UjWIFDBMZtuGyxf3pV8oWHkpu11a8rckr2iwWO/h+r0eJaIWsDjkSE2gOZ/T6Pmtg50kCnRPX
 zNKdWkKET63m5RAKl0BFX4DtzJM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> Now that we always use a single bio to read an extent_buffer, the buffer
> can be passed to the end_io handler as private data.  This allows
> implementing a much simplified dedicated end I/O handler for metadata
> reads.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This greatly simplify the subpage routine.

Although we no longer share data and metadata read endio function, it's 
still a net reduce of codes.

But there is a problem related to how we handle the validation.

>   
> +static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
> +{
> +	struct extent_buffer *eb = bbio->private;
> +	bool uptodate = !bbio->bio.bi_status;
> +	struct bvec_iter_all iter_all;
> +	struct bio_vec *bvec;
> +	u32 bio_offset = 0;
> +
> +	atomic_inc(&eb->refs);
> +	eb->read_mirror = bbio->mirror_num;
> +
> +	if (uptodate &&
> +	    btrfs_validate_extent_buffer(eb, &bbio->parent_check) < 0)

Here we call btrfs_validate_extent_buffer() directly.

But in the case that a metadata bio is split, the endio function would 
be called on each split part.

Thus for the first half, we may fail on checking the eb, as the second 
half may not yet finished.

I'm afraid here in the endio function, we still need to call 
btrfs_validate_metadata_buffer(), which will only do the validation 
after all parts of the metadata is properly read.

Thanks,
Qu
> +		uptodate = false;
> +
> +	if (uptodate) {
> +		set_extent_buffer_uptodate(eb);
> +	} else {
> +		clear_extent_buffer_uptodate(eb);
> +		set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> +	}
> +
> +	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
> +		atomic_dec(&eb->io_pages);
> +		end_page_read(bvec->bv_page, uptodate, eb->start + bio_offset,
> +			      bvec->bv_len);
> +		bio_offset += bvec->bv_len;
> +	}
> +
> +	unlock_extent(&bbio->inode->io_tree, eb->start,
> +		      eb->start + bio_offset - 1, NULL);
> +	free_extent_buffer(eb);
> +
> +	bio_put(&bbio->bio);
> +}
> +
>   static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
>   				       struct btrfs_tree_parent_check *check)
>   {
> @@ -4233,7 +4227,7 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
>   	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
>   			       REQ_OP_READ | REQ_META,
>   			       BTRFS_I(eb->fs_info->btree_inode),
> -			       end_bio_extent_readpage, NULL);
> +			       extent_buffer_read_end_io, eb);
>   	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
>   	bbio->file_offset = eb->start;
>   	memcpy(&bbio->parent_check, check, sizeof(*check));
