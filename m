Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E40406949
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhIJJtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhIJJtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 05:49:40 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189EEC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 02:48:29 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id A708A9B8B9; Fri, 10 Sep 2021 10:48:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631267300;
        bh=V7tiNfZqQYe/EeSB6ReGmDHoH8sNeVQouJc0eoPuFNA=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=iEdd2lGJnO2U0/wnYuVrVquYg5SqogyIdIsCN7zje78zatf73d6z9MmAHhITB3abx
         iL1fvyJIEnJNOfqB4a9jOIuVlgGjvVIyU4PJbWWIQh224zRE9Lr15/L2hYThxRfU6M
         NZvZPr/xblEdTc8S+EXJIBkGov4hsXBJMPkBmWnyN7AmTYn2pxsDqVVzjXA4WaFlqx
         7venkvBk1yIaqM2sjSPi5EXxevHigxCYz/iLq8bkcAKZOs2o3MazCXRSkYpSUVI5j7
         0WZ16Z+NfCYsX89adDpMI/GZtJ8YD7vNdQ7jcXS85JnXSuQWQLJRSIgC52o+bLiATt
         AwYJm1Ov9vP4g==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-7.2 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 58B599B84F;
        Fri, 10 Sep 2021 10:48:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631267281;
        bh=V7tiNfZqQYe/EeSB6ReGmDHoH8sNeVQouJc0eoPuFNA=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=aB/0VYsnNOLXRdO3d0jTpOyDiGmG8cFuY8wOHFcy2dvM8lrNowA7JsrW7t0xQpai+
         orxK5kok25kCnaP5Q3SHCSlmRcqAW9xxdBKJqHWqMD+/spyTI1qvafeTNFr1KrAtbH
         Z3fiPEvKjsUkIfY8CZtfE79Ci8qhbXZxvxsn4vhfRTN2bCPzmX9UcS9QVPr3SAgYll
         Gf4XeAJibmsfTfU3vnxBLwR65/7OBD13kYCZhJxzddHP6Y67X74+BvxNaetgOJHr0E
         yIbeCrimAsMZBuBGMMeyFi6etlMLnCRG3ZDbfY/exGJS98rAi+SjOcZ9o3GxGJldTi
         6h1r+YC3necKg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id E7EFF29538E;
        Fri, 10 Sep 2021 10:48:00 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-3-wqu@suse.com>
 <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
 <2442d845-76fa-ebe6-ec48-e7d0d8ff278f@suse.com>
Subject: Re: [PATCH 2/2] btrfs-progs: doc: add extra note on flipping
 read-only on received subvolumes
Message-ID: <6427b226-51b0-81d2-af47-7a02b712a94c@cobb.uk.net>
Date:   Fri, 10 Sep 2021 10:48:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2442d845-76fa-ebe6-ec48-e7d0d8ff278f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/09/2021 08:30, Qu Wenruo wrote:
> 
> 
> On 2021/9/10 下午2:33, Nikolay Borisov wrote:
>>
>>
>> On 10.09.21 г. 9:03, Qu Wenruo wrote:
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   Documentation/btrfs-property.asciidoc | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/btrfs-property.asciidoc
>>> b/Documentation/btrfs-property.asciidoc
>>> index 4796083378e4..8949ea22edae 100644
>>> --- a/Documentation/btrfs-property.asciidoc
>>> +++ b/Documentation/btrfs-property.asciidoc
>>> @@ -42,6 +42,12 @@ the following:
>>>     ro::::
>>>   read-only flag of subvolume: true or false
>>> ++
>>> +NOTE: For recevied subvolumes, flipping from read-only to read-write
>>> will
>>> +either remove the recevied UUID and prevent future incremental receive
>>> +(on newer kernels), or cause future data corruption and recevie failure
>>> +(on older kernels).
>>
>> Hang on a minute, flipping RO->RW won't cause corruption by itself.
> 
> It looks like the "future" part is not clear enough.
> 
>> So
>> flipping will just break incremental sends which is completely fine.
> 
> The "breaking" part is more straightforward for newer kernel, but not
> older kernels (it's definitely breaking, but not that directly observable)

How about...

NOTE: Changing a subvolume which has been received using btrfs receive
to be writable could silently corrupt future btrfs receive operations
using the subvolume. Recent kernels automatically remove the 'received
UUID' on the subvolume when the read-only flag is set to false in order
to protect against this corruption. This will mean that subsequent btrfs
receive commands which refer to this subvolume will fail. With earlier
kernels, similar btrfs receive commands could cause silent corruption.

> 
> Thanks,
> Qu
> 
>>
>>> +
>>>   label::::
>>>   label of the filesystem. For an unmounted filesystem, provide a
>>> path to a block
>>>   device as object. For a mounted filesystem, specify a mount point.
>>>
>>
> 

