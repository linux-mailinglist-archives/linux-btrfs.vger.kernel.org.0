Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A776CF796
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjC2XkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjC2XkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:40:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A64200
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:39:58 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1pwDBX39Yr-00YUfa; Thu, 30
 Mar 2023 01:39:47 +0200
Message-ID: <3289eba8-8492-3c14-6e3c-f6ef7df7cbb1@gmx.com>
Date:   Thu, 30 Mar 2023 07:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1680047473.git.wqu@suse.com>
 <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1680047473.git.wqu@suse.com>
 <ZCTKola6a+tbtyrL@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v7 02/13] btrfs: introduce a new allocator for scrub
 specific btrfs_bio
In-Reply-To: <ZCTKola6a+tbtyrL@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DHSVhDFaqzSYMsrQnd24amB4oLFRyBrMvbj2qNrX8c8aISFX1A8
 cgEux+6yKJR/wZqjrcfY2mjdR/RzE8smAIqJjnXSVDovqM4+/aaTbs+lhAxj44mAxNK3Eon
 WXOwS9ZgF2e5KbDHenlH8B/de/3XxC2gsC4KA9WrKZyqG1J9JWOgqKunzz/K5Mw8Rgmrz1L
 Vl55vDS5Hx5p81+ub0pAw==
UI-OutboundReport: notjunk:1;M01:P0:GZZxqYp04Dw=;PnBnhFWyC5epZaShDizQEE70/Ta
 9gpWNF2sdQySUFGEO9ln3vM3USnfprC4xo9osIpXos4VlXF5vjMEhFk4rILOC0g6pD/Ggocpl
 V1Rxz0tLl9FImXU7pXVlooPaVfacekik1RN249YynfQW4zoYi/Gbz63mAAw6BvCYOQNhHisZW
 Xp+Z9Ko+CgmYlwL8Qx7WI3cnwSiCWoiVWn+kCbKoKO15vRT0tFH0awnWpoVz6Qu3URm9tVDkO
 j706+OmQcVCdc/qprcAD2zhQtFKAqn9qZJqXZlFcJ0xHtP5tCjpCzDG/tO+CTwk1CCp5UqlCV
 tAhgELFwJtlKlVQOwDsUulJLb9EKGgE7KbBJimyI91lZFSg/BOEanKNrBp3CEAp9UVXwFQ4fS
 pH7tUzjrjuRXEvyxshVeN64QW0F7bDApIuhGvI3NCokx6rkIea7PYi/UzxTLJGBc4NNbd/4iN
 pOQQIx1SMkeXyoMpZ/ffYGZ1saPC9lr9AIE11jKLtYn3qefBmQ4Eb+Djb0i9kesdAy0w1ROhN
 H70zks/IvzMVkJ8ENekVlzH08e1anGQApz92W77rJf9rh6CvJtUhfIy6zSl/RhAgwxPgGOPwq
 b79h4oIcioXOqPXx0iWkboUQKJWptIESdA3GdPaR/DgiT2veQ3kpyvZSpcxVC6ri0hn6qH+/R
 kaAaHD+qenmvbOHfOA4Ag3BtclGu+dUnn4gGNupz9+DC7RXbM8IV0BkK29HOS6nmMmL6DsZgw
 AYdFh2g+RICZxG3q0RBzQ+MQWLY/AjD9VIIFHdwT0jD500Lfg4i5n+b2c5vQFzxS5b1t1GjoT
 2G+Q6cthIXg5ziMmAy3WSuq1R4yYsLDunMCBbRJrompVEzKzda9hPRORxNk3W2Qczy7h26yyQ
 Pz3Q4nXz/7TDp3ZitPX/VM++6wjNJis5WGovnrua6z9XFYk6wNkrDYiWhGSGJEbXupjRwX5pi
 HnatBx+lCpzjZ5zVXYPUVwANZo0=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/30 07:32, Christoph Hellwig wrote:
>> +struct btrfs_bio *btrfs_scrub_bio_alloc(blk_opf_t opf,
>> +					struct btrfs_fs_info *fs_info,
>> +					btrfs_bio_end_io_t end_io, void *private)
>> +{
>> +	struct btrfs_bio *bbio;
>> +	struct bio *bio;
>> +
>> +	bio = bio_alloc_bioset(NULL, BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits,
>> +			       opf, GFP_NOFS, &btrfs_bioset);
>> +	bbio = btrfs_bio(bio);
>> +	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
>> +	bbio->fs_info = fs_info;
>> +	bbio->end_io = end_io;
>> +	bbio->private = private;
>> +	atomic_set(&bbio->pending_ios, 1);
>> +	return bbio;
> 
> As mentioned in the last round, I'm not too happy with this.  With
> the inode and file_offset being optional now we might as well drop them
> as arguments from btrfs_bio_alloc/btrfs_bio_init and just pass a nr_vecs
> instead and make this new allocator obsolete, and it would be a much
> better result.

I would be happier if we drop @inode and @file_offset from 
btrfs_bio_alloc().

In that case, I'm completely fine to drop the new allocator.

A quick glance into the code base, and it shows 
btrfs_bio_alloc/btrfs_bio_init() are not called that frequently, thus 
the change may be small enough to be done in the series.


But as my usual tendency, it would still be better to have some 
ASSERT()s to make sure we're properly populating @inode for needed call 
sites.

Or we can easily pass some bbio, which should go through csum 
verification, without a valid @inode pointer, and to be treated as 
NODATACSUM.
Such problem can be very hard to detect.

Any good suggestions?

> 
> I'd prefer to just do it now rather than doing another series changing
> it a little later.
> 
>> +	/*
>> +	 * Inode and offset into it that this I/O operates on.
>> +	 *
>> +	 * @inode can be NULL for callers who don't want any advanced features
>> +	 * like read-time repair.
>> +	 */
>>   	struct btrfs_inode *inode;
>>   	u64 file_offset;
> 
> I don't think these negative comments are nice for the reader.  I'd do:
> 
> 	/*
> 	 * Inode and offset into it that this I/O operates on.
> 	 * Only set for data I/O.
> 	 */
> 
>> +	/*
>> +	 * For cases where callers only want to read/write from a logical
>> +	 * bytenr, in that case @inode can be NULL, and we need such
>> +	 * @fs_info pointer to grab the corresponding fs_info.
>> +	 *
>> +	 * Should always be populated.
>> +	 */
>> +	struct btrfs_fs_info *fs_info;
> 
> Again here, this comment only makes sense for people following the
> development history of this particular patch series.  Once that is in
> the reason why people use an inode before is irrelevant.  The only
> useful bit left here is that it must always be populated, but I'm not
> even sure I'd add that.  So all we might need is:
> 
> 	/* File system that this I/O operates on. */
> 
> What would be good in this patch is to replace the
> existing bbio->inode->root->fs_info dereferences with bbio->fs_info
> ASAP, though.
Indeed, the comments and extra @fs_info chain would be updated in the 
next version.

Thanks,
Qu
