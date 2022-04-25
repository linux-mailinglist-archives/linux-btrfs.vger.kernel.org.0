Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A550DC4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiDYJWZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiDYJWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:22:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA322BE7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:18:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0878968D17; Mon, 25 Apr 2022 11:18:39 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:18:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: do not allocate a btrfs_bio for low-level
 bios
Message-ID: <20220425091836.GB16446@lst.de>
References: <20220425075418.2192130-1-hch@lst.de> <20220425075418.2192130-11-hch@lst.de> <cc0cbe5c-ee50-9cd9-c718-6dc5c773a2b9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc0cbe5c-ee50-9cd9-c718-6dc5c773a2b9@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 05:01:11PM +0800, Qu Wenruo wrote:
>>   struct btrfs_io_stripe {
>>   	struct btrfs_device *dev;
>> -	u64 physical;
>> +	union {
>> +		u64 physical;			/* block mapping */
>> +		struct btrfs_io_context *bioc;	/* for the endio handler */
>> +	};
>>   	u64 length; /* only used for discard mappings */
>
> Isn't @length a better candidate?
>
> Since it's only used for discard.

I have anoter patch to be sumitted that removes length entirely
by not using btrfs_io_stripe for discards.
