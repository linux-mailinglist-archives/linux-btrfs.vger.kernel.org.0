Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B65B032C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiIGLgq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiIGLgb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 07:36:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F46B9419
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 04:35:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B2E667373; Wed,  7 Sep 2022 13:35:17 +0200 (CEST)
Date:   Wed, 7 Sep 2022 13:35:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: code placement for bio / storage layer code
Message-ID: <20220907113517.GA9643@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220907091056.GA32007@lst.de> <382f747b-7ea3-f1a9-805f-0550ae90963e@gmx.com> <20220907111009.GA8131@lst.de> <f1d43420-3fda-1287-5fc2-4035ea988e0c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d43420-3fda-1287-5fc2-4035ea988e0c@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 07, 2022 at 07:27:48PM +0800, Qu Wenruo wrote:
>>   - btrfs_submit_bio
>>   - btrfs_submit_mirrored_bio
>>   - btrfs_submit_dev_bio
>>   - btrfs_clone_write_end_io
>>   - btrfs_orig_write_end_io
>>   - btrfs_raid56_end_io
>
> This is scrub only usage, I guess we may find a better way to determine
> if it should go there.

Nothing of this is scrub only.  All the above are called by
btrfs_submit_bio, or set up as end_io handlers by them.
