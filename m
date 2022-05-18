Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30E52B538
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiERIsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiERIsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 04:48:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8821356AB
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 01:48:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 78E8368AFE; Wed, 18 May 2022 10:48:33 +0200 (CEST)
Date:   Wed, 18 May 2022 10:48:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/15] btrfs: refactor end_bio_extent_readpage
Message-ID: <20220518084833.GF6933@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-9-hch@lst.de> <5dc10aca-29ce-9318-c8f9-9ea83b35dde1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc10aca-29ce-9318-c8f9-9ea83b35dde1@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 06:22:54AM +0800, Qu Wenruo wrote:
>> +		} else if (is_data_inode(inode)) {
>> +			/*
>> +			 * Only try to repair bios that actually made it to a
>> +			 * device.  If the bio failed to be submitted mirror
>> +			 * is 0 and we need to fail it without retrying.
>> +			 */
>> +			if (mirror > 0)
>> +				repair = true;
>
> In fact, you can do it even better, by also checking the number of
> copies the bio has.

That's done first thing in the actual new repair code.
