Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A654DAC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359214AbiFPGgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359208AbiFPGgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 02:36:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930056B3B
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 23:36:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A9A2B68AA6; Thu, 16 Jun 2022 08:36:18 +0200 (CEST)
Date:   Thu, 16 Jun 2022 08:36:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: remove the raid56_parity_{write,recover}
 return value
Message-ID: <20220616063618.GB5608@lst.de>
References: <20220615151515.888424-1-hch@lst.de> <20220615151515.888424-5-hch@lst.de> <281a06be-aba0-bcce-5681-dc81b0245124@gmx.com> <e2d5e49f-28da-95de-20b6-b29c0ce00cf9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2d5e49f-28da-95de-20b6-b29c0ce00cf9@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 09:06:50AM +0800, Qu Wenruo wrote:
>> But at this branch, we don't yet have called
>> `btrfs_bio_counter_inc_noblocked()`.
>>
>> Wouldn't this cause underflow?
>>

>>>       rbio->operation = BTRFS_RBIO_WRITE;
>>>       rbio_add_bio(rbio, bio);
>>>
>>> -    btrfs_bio_counter_inc_noblocked(fs_info);
>
> And this line is removed completely, any reason for the removal?

This is all part of making these functions consume the bio counter
as documented in the changelog.  But I guess splitting that from
the pure prototype change should help to able to understand the
changes, so I'll do that for the next version.
