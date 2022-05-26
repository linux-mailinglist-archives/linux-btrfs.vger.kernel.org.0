Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9993534C06
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiEZIyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiEZIyG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 04:54:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7C27FF0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 01:54:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8510568AA6; Thu, 26 May 2022 10:54:02 +0200 (CEST)
Date:   Thu, 26 May 2022 10:54:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
Message-ID: <20220526085402.GA26954@lst.de>
References: <20220526073022.GA25511@lst.de> <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com> <20220526074536.GA25911@lst.de> <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com> <20220526080056.GA26064@lst.de> <0cbbc3aa-a104-3d5e-ad13-a585533c9bcb@suse.com> <20220526081757.GA26392@lst.de> <78c1fb7f-60b7-b8fd-6e3c-c207122863aa@gmx.com> <20220526082851.GA26556@lst.de> <f18c85ef-ff11-8308-4562-d68d4578d6f4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18c85ef-ff11-8308-4562-d68d4578d6f4@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 26, 2022 at 04:49:15PM +0800, Qu Wenruo wrote:
>>>> Because that really sucks for the case where the whole I/O fails.
>>>> Which is the common failure scenario.
>>>
>>> But it's just a performance problem, which is not that critical.
>>
>> I'm officially lost now.
>
> Why? If you care so much about the code simplicity, sector-by-sector is
> the best.
> If you care so much about the performance, the latest bitmap is the
> best, no matter if it's the worst checker patter or not.

Because you tell me that handling the most common and important case
in read repair is just a performance issue, which you keep arguing for
micro-optimizing a corner case.  And not, for the case of failing a
large bio (which arguably can only happen for buffered I/O at the
moment, but that is another thing to look into) the bitmaps will only
help you for up to 64 sectors.  Way better than just doing a single
sector synchronous I/O but not exactly nice while still being a fair
amount of code compared to just doing variable sized synchronous
I/O.
