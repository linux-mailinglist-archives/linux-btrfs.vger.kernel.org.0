Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CEF25C427
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgICPEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:04:43 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:29085
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729006AbgICPEh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 11:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=kMRMhJ7uHKpINWTcjflRbrKF/jHLzW+q7IhaFaDqk4Q=;
        b=b5EpAlx6SMBUAZCfnvZIYqT/njUuPUGIG++WeqpIR8V3ZKr+hWI+Pg8buJ7BfxbBRqAmYup0SPFZC
         QyT5sDAZ1MaFvXYebKPVQBlN4yWcYy26Thch4mdD+/T7l+xJrhDLGKxBh0aZ0YtlZ6KcKrdl4S4v8+
         cslnaVapGVaOaFF9kh8qX4Ry8BevFGp0MD6HMcy2RLSxd5DBLai53gh6etT7eFvPJX6f0sZt7r4lwI
         aVTDSfxx8KYoVVRlfvf9+M71pNXbR6z85tI+X0A6HF8DSxz9G6X3KvkV54i/h9Rwc7+Dd6xANwR8Gj
         Nv9emN29wkvy4QJ/2As6sdKgmM/X19A==
X-HalOne-Cookie: 1c5dce77ad977503a05e479011377a2705fe6a9d
X-HalOne-ID: c6f7b785-edf6-11ea-84a0-d0431ea8a290
Received: from [10.0.88.22] (unknown [98.128.186.78])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c6f7b785-edf6-11ea-84a0-d0431ea8a290;
        Thu, 03 Sep 2020 15:04:34 +0000 (UTC)
Subject: Re: new database files not compressed
To:     Nikolay Borisov <nborisov@suse.com>,
        Hamish Moffatt <hamish-btrfs@moffatt.email>,
        linux-btrfs@vger.kernel.org
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
 <dede53e.d98f7053.1744e402728@lechevalier.se>
 <23ddfe07-9ad0-5651-a77d-de7a9e35818a@suse.com>
From:   A L <mail@lechevalier.se>
Message-ID: <ca8bd012-3e5e-64e4-764a-015d9f270ebb@lechevalier.se>
Date:   Thu, 3 Sep 2020 17:04:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <23ddfe07-9ad0-5651-a77d-de7a9e35818a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020-09-02 12:09, Nikolay Borisov wrote:
>
> On 2.09.20 г. 12:57 ч., A L wrote:
>>
>> ---- From: Nikolay Borisov <nborisov@suse.com> -- Sent: 2020-09-02 - 07:57 ----
>>>> I've been able to reproduce this with a trivial test program which
>>>> mimics the I/O behaviour of Firebird.
>>>>
>>>> It is calling fallocate() to set up a bunch of blocks and then writing
>>>> them with pwrite(). It seems to be the fallocate() step which is
>>>> preventing compression.
>>>>
>>>> Here is my trivial test program which just writes zeroes to a file. The
>>>> output file does not get compressed by btrfs.
>>> Ag yes, this makes sense, because fallocate creates PREALLOC extents
>>> which are NOCOW (since they are essentially empty so it makes no sense
>>> to CoW them) hence they go through a different path which doesn't
>>> perform compression.
>>>
>> Hi,
>>
>> This is interesting. I think that a lot of applications use fallocate in their normal operations. This is probably why we see weird compsize results every now and then.
>>
>> A file that is nocow will also not have checksums. Is this true for these fallocated files (that has data written to them) too?
> No, fallocated files will have checksums. It's just that compression is
> not integrated into it. BTRFS is an open source project so patches are
> welcomed.
>
Is it a very big task to add the compression code path here, since we 
already do checksums?
