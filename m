Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1762258AD2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 10:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgIAIzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 04:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIAIzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 04:55:10 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD57FC061245
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yvwEuZBMf4TT7xZr2LP1XwVB4js/dmsMngL/KiZuXMo=; b=CbhmNSJDsvV/wMUvAwsKcey7H6
        lOB9kMk9WtnBDzEkHpE1rEeZzJG0S+Cp1dze+qafZlSZuzgWcjFIS6afS7hubAx0ALjj0JppLTzVx
        LgMmOtX3yoY1mvbLjILtDnt4arbQEXYA9a78y2Rfo0CXmT6zX+45bHvb8N7EBntTEOTQ=;
Received: from 2403-5800-3100-142-5d22-5e60-9f0d-1cf5.ip6.aussiebb.net ([2403:5800:3100:142:5d22:5e60:9f0d:1cf5])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kD24H-0007cY-Rj; Tue, 01 Sep 2020 18:55:05 +1000
Subject: Re: new database files not compressed
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
 <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <20200831161505.369be693@natsu>
 <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
 <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
Date:   Tue, 1 Sep 2020 18:55:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 3:15 pm, Nikolay Borisov wrote:
>
> On 1.09.20 г. 2:50 ч., Hamish Moffatt wrote:
>> On 31/8/20 10:57 pm, Nikolay Borisov wrote:
>>> This means the data being passed to btrfs is not compressible. I.e after
>>> coompression the data is not smaller than the original, input data.
>> It is though - if I copy it, or run defrag, it compresses very well:
>>
>>
> As Zygo explained - with 16k writes you'd need at least 25% compression
>   in order for btrfs to deem it useful. If firebird's 16k writes are not
> 25% compressible then it won't compress. It also depends on whether it
> issues fsync after every write to ensure consistency meaning it won't
> allow more data to accumulate.


I understand, but I think these conditions are being met.

1. strace shows Firebird is writing sequential 16k blocks. I don't see 
fsync either. Example trace: https://hastebin.com/ecayosilog.pl

2. Copying the file with 'dd if=foo.fdb of=copy bs=16k', even with 
'oflag=sync' or 'flag=direct', results in a compressed copy.

There are no special attributes on the file according to lsattr. What 
else could Firebird be doing that would cause the file not to compress?

Hamish



