Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9052B57D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiERIyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 04:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiERIyR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 04:54:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143313C096
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 01:54:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 319EC68AFE; Wed, 18 May 2022 10:54:10 +0200 (CEST)
Date:   Wed, 18 May 2022 10:54:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Message-ID: <20220518085409.GG6933@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-13-hch@lst.de> <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 07:04:22AM +0800, Qu Wenruo wrote:
>> +static struct btrfs_bio *btrfs_repair_bio_clone(struct btrfs_bio *src_bbio,
>> +		u64 offset, u32 size, unsigned int op)
>> +{
>> +	struct btrfs_bio *bbio;
>> +	struct bio *bio;
>> +
>> +	bio = bio_alloc_bioset(NULL, 0, op | REQ_SYNC, GFP_NOFS,
>> +			       &read_repair_bioset);
>> +	bio_set_flag(bio, BIO_CLONED);
>
> Do we need to bother setting the CLONED flag?

The CLONED flag should never be set.  Except for the one bogus check
in btrfs that I have a pending removal for it is only used for debugging
checks.

> Without CLONED flag, we can easily go bio_for_each_segment_all() in the
> endio function without the need of bbio->iter, thus can save some memory.

bio_for_each_segment_all ignores the iter and walks over bi_io_vec
directly.  And that is something we absolutely can't do here, as the
bio reuses the bio_vecs from the failed bio, and depending on what
failed reduces the size.

>> +	/*
>> +	 * Otherwise just clone the whole bio and write it back to the
>> +	 * previously bad mirror.
>> +	 */
>> +	write_bbio = btrfs_repair_bio_clone(read_bbio, 0,
>> +			read_bbio->iter.bi_size, REQ_OP_WRITE);
>
> Do we need to clone the whole bio?
>
> Considering under most cases the read repair is already the cold path,
> have more than one corruption is already rare.

The read bio is trimmed to only cover the bad area, so this already
potentially does not cover the whole failed bbio.  But except for
the case you note below we do need to write back the whole bio.

>> +bool __btrfs_read_repair_end(struct btrfs_read_repair *rr,
>> +		struct btrfs_bio *failed_bbio, struct inode *inode,
>> +		u64 end_offset, repair_endio_t endio)
>
> The reason I don't use "end" in my patchset is, any thing related "end"
> will let people to think it has something related with endio.

That seems like an odd conotation.  Without io in the word end just
conotates the end of a range in most of the Linux I/O stack.

> And in fact when checking the function, I really thought it's something
> related to endio, but it's the equivalent of btrfs_read_repair_finish().

But if there is a strong preference I can use finish instead of end.
