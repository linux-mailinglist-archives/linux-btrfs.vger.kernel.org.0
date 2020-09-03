Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C320425C15B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgICMxq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 08:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgICMxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 08:53:39 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0842C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I2kAC0Z6m52l6EvbJCbUW49gLW7S0qtnQM+AA6ceWgI=; b=BHa2Q6tP28RKfbmBQo2RITOm6P
        cIXn/+lNbevyR2BoR4XL31V+SHA2gwXlhegt8/z4r1huZMmlp9Zvy9T9wNmfu7IAFsYw2jer63o4m
        l6aTsZJJCjet9jObWVP4PEmsyddWyDeP0wvdldPv+f07eWC8und+U83rWriYakzXdWmU=;
Received: from 2403-5800-3100-142-8170-44fc-ed98-c4e4.ip6.aussiebb.net ([2403:5800:3100:142:8170:44fc:ed98:c4e4])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kDok0-0006pM-4W; Thu, 03 Sep 2020 22:53:24 +1000
Subject: Re: new database files not compressed
To:     Zygo Blaxell <zblaxell@furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <20200831161505.369be693@natsu>
 <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
 <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
 <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
 <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
 <dede53e.d98f7053.1744e402728@lechevalier.se>
 <20200902161621.GA5890@hungrycats.org>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <f32f6fdf-bc20-b1d1-d0ea-08f779723066@moffatt.email>
Date:   Thu, 3 Sep 2020 22:53:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902161621.GA5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 2:16 am, Zygo Blaxell wrote:
>
> fallocate doesn't make a lot of sense on btrfs, except in the special
> case of nodatacow files without snapshots.  fallocate breaks compression,
> and snapshots/reflinks break fallocate.


I recompiled Firebird with fallocate disabled (it has a fallback for 
non-linux OSs), and now I have compressed database files.

It may be that de-duplication suits my application better anyway. Will 
compsize tell me how much space is being saved by de-duplication, or is 
there another way to find out?


Hamish

