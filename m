Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A3534B11
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 10:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbiEZIBC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiEZIBB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 04:01:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0CE33342
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 01:01:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC15668AA6; Thu, 26 May 2022 10:00:56 +0200 (CEST)
Date:   Thu, 26 May 2022 10:00:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
Message-ID: <20220526080056.GA26064@lst.de>
References: <cover.1653476251.git.wqu@suse.com> <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com> <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com> <20220526073022.GA25511@lst.de> <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com> <20220526074536.GA25911@lst.de> <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 26, 2022 at 03:52:03PM +0800, Qu Wenruo wrote:
>
>
> On 2022/5/26 15:45, Christoph Hellwig wrote:
>> On Thu, May 26, 2022 at 03:37:47PM +0800, Qu Wenruo wrote:
>>> Rare case doesn't mean it won't happen.
>>>
>>> We still need to address it anyway.
>>
>> address != build overly complicated code to optimize for it
>>
> Well, using seemly simple code, but can lead to read way more loops and way 
> more data to read, is neither a good way.

Again, having checkered corruption is an extremely unlikely event.
I'd rather deal with it by doing more reads than code complexity.
