Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C725A550
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 08:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBGFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBGFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 02:05:33 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F715C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u78hjC3m1lRZzJsp36kSFXo7oGAQEWr7igjr/6VDjWs=; b=J4tbZgtBZTEZRQfnEstt2L6CyD
        5J70fRcmTFVc1r73U2CTCZVm+mpvs3azp9Z9vzbz2bsjElA6pgzKvChGqjuxL4Pq5lmciPPBQ834R
        5121HKZF8IrLRLJJ9qJMXTZ/2s+0KQHVDTRoblNWsCbpCfJMEDyaN9orakLJyzxeJR5A=;
Received: from 2403-5800-3100-142-b906-8ee0-11bc-256c.ip6.aussiebb.net ([2403:5800:3100:142:b906:8ee0:11bc:256c])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kDLth-000459-KR; Wed, 02 Sep 2020 16:05:29 +1000
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
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
 <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
 <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <99c84e4e-0055-1e6d-7e89-ffa708551708@moffatt.email>
Date:   Wed, 2 Sep 2020 16:05:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/9/20 3:57 pm, Nikolay Borisov wrote:
>
> On 2.09.20 г. 3:32 ч., Hamish Moffatt wrote:
>>
>> I've been able to reproduce this with a trivial test program which
>> mimics the I/O behaviour of Firebird.
>>
>> It is calling fallocate() to set up a bunch of blocks and then writing
>> them with pwrite(). It seems to be the fallocate() step which is
>> preventing compression.
>>
>> Here is my trivial test program which just writes zeroes to a file. The
>> output file does not get compressed by btrfs.
> Ag yes, this makes sense, because fallocate creates PREALLOC extents
> which are NOCOW (since they are essentially empty so it makes no sense
> to CoW them) hence they go through a different path which doesn't
> perform compression.

>>      for (int count = 0; count < 256; ++count) {
>>          if (count % 8 == 0)
>>              fallocate(fd, 0, count * BLOCK_SIZE, 8 * BLOCK_SIZE);
>>          pwrite(fd, buf, BLOCK_SIZE, count * BLOCK_SIZE);
>>      }


OK, and they can't be compressed when data is written to those extents 
afterwards?


Thanks, it's good to understand why it's not working for Firebird.


Hamish

