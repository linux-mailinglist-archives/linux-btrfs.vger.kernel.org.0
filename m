Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7725D333
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgIDIHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgIDIHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 04:07:48 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D961C061244
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Sep 2020 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=079L23OBHbcbuvblYU11UrcG/TrR0YEpj1cPAboCyKQ=; b=iAEMmIjMLu4Zz+D/6h1hq8B2is
        35rrNf6XALrjCArXsTWVtPhYVG6mVj5Wx389co1yliWFpcXntSeJs/FyEgHNG/pLrzlsyTeLRLAMD
        qK8iqTuxKIdQ9r7zzbfMhHVXVQp95z2L5u41eL6iuPlO0FHgywdHagEfZd1+dty9g/Wc=;
Received: from 2403-5800-3100-142-c9f4-b401-fb77-9109.ip6.aussiebb.net ([2403:5800:3100:142:c9f4:b401:fb77:9109])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kE6ku-0000cx-Ua; Fri, 04 Sep 2020 18:07:32 +1000
Subject: Re: new database files not compressed
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
 <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
 <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
 <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
 <dede53e.d98f7053.1744e402728@lechevalier.se>
 <20200902161621.GA5890@hungrycats.org>
 <f32f6fdf-bc20-b1d1-d0ea-08f779723066@moffatt.email>
 <20200903194437.GA21815@hungrycats.org>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <0c74cc4a-3644-805c-9501-6888c2a03f24@moffatt.email>
Date:   Fri, 4 Sep 2020 18:07:32 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903194437.GA21815@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/9/20 5:44 am, Zygo Blaxell wrote:
> On Thu, Sep 03, 2020 at 10:53:23PM +1000, Hamish Moffatt wrote:
>
>> I recompiled Firebird with fallocate disabled (it has a fallback for
>> non-linux OSs), and now I have compressed database files.
>>
>> It may be that de-duplication suits my application better anyway. Will
>> compsize tell me how much space is being saved by de-duplication, or is
>> there another way to find out?
> Compsize reports "Uncompressed" and "Referenced" columns.  "Uncompressed"
> is the physical size of the uncompressed data (i.e. how many bytes
> you would need to hold all of the extents on disk without compression
> but with dedupe).  "Referenced" is the logical size of the data, after
> counting each reference (i.e. how many bytes you would need to hold all
> of the data without compression or dedupe).
>
> The "none" and "zstd" rows will tell you how much dedupe you're getting
> on uncompressed and compressed extents separately.


Great, I have it bees running and I see the deduplication in compsize as 
you said.

What is the appropriate place to ask question about bees - here, github 
or elsewhere?

I added some files, restarted bees and it ran a deduplication, but then 
I added some more files (8 hours ago) and there's been some regularly 
logging but the new files haven't been deduplicated.


Hamish

