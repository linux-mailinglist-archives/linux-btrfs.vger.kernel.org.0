Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB45324F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 10:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiEXIL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiEXILQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 04:11:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A055B8
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 01:11:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 56FBB68AFE; Tue, 24 May 2022 10:11:10 +0200 (CEST)
Date:   Tue, 24 May 2022 10:11:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/8] btrfs: introduce a pure data checksum checking
 helper
Message-ID: <20220524081110.GA27062@lst.de>
References: <20220522114754.173685-1-hch@lst.de> <20220522114754.173685-3-hch@lst.de> <d459113f-7325-ebe9-77de-6639c646f0df@gmx.com> <20220524072458.GA26145@lst.de> <6423b926-c5b2-612c-ccac-0cb9ee29984f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6423b926-c5b2-612c-ccac-0cb9ee29984f@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 24, 2022 at 04:07:41PM +0800, Qu Wenruo wrote:
>> -			    u32 pgoff, u8 *csum, u8 *csum_expected);
>> +			    u32 pgoff, u8 *csum, u8 * const csum_expected);
>
> Shouldn't it be "const u8 *" instead?

No, that would bind to the pointer.  But we care about the data.
