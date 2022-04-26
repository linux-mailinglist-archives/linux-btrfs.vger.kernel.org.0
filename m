Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3C50FEF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiDZN11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 09:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiDZN11 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 09:27:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D9E18C2B2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 06:24:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D7B2168BFE; Tue, 26 Apr 2022 15:24:13 +0200 (CEST)
Date:   Tue, 26 Apr 2022 15:24:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/10] btrfs: refactor btrfs_map_bio
Message-ID: <20220426132413.GA14871@lst.de>
References: <20220425075418.2192130-1-hch@lst.de> <20220425075418.2192130-10-hch@lst.de> <9ae89d00-7047-a207-6fd0-3223871576ca@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae89d00-7047-a207-6fd0-3223871576ca@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 04:56:21PM +0800, Qu Wenruo wrote:
>>   -	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
>> -		dev = bioc->stripes[dev_nr].dev;
>> -		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
>> -						   &dev->dev_state) ||
>> -		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
>> -		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
>
> Maybe just make the complex if () condition into a helper?
>
> In fact I see some other locations uses similar complex expressions to 
> check it's a missing device.

So I looked at this a bit, and while there's a fair amount of checks
for BTRFS_DEV_STATE_MISSING, most of the conditions looks slightly
different.  So for now I'd like to skip that cleanup for this series.
