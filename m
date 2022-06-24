Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3E55962F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiFXJLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 05:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiFXJLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 05:11:25 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCB4F9F9
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 02:10:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E20FB3F37D;
        Fri, 24 Jun 2022 11:10:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.703
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id owpCs5yK9i8X; Fri, 24 Jun 2022 11:10:53 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 9A7E63F2A6;
        Fri, 24 Jun 2022 11:10:53 +0200 (CEST)
Received: from [192.168.0.134] (port=53426)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1o4fL1-0009X0-Be; Fri, 24 Jun 2022 11:10:52 +0200
Message-ID: <fab89110-00e1-c344-d321-675bec3e2bc4@tnonline.net>
Date:   Fri, 24 Jun 2022 11:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Criteria for mount messages. (was "Re: [PATCH] btrfs: remove
 skinny extent verbose message")
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
 <56e24cb5-c085-3b17-203e-56007008a8ae@gmx.com>
 <20220623141954.GP20633@twin.jikos.cz>
 <7a42092f-9534-e54c-174e-8aaf17509d4b@gmx.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <7a42092f-9534-e54c-174e-8aaf17509d4b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/24/22 00:46, Qu Wenruo wrote:
> 
> 
> On 2022/6/23 22:19, David Sterba wrote:
>> On Thu, Jun 23, 2022 at 04:22:27PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/6/23 16:08, Nikolay Borisov wrote:
>>>> Skinny extents have been a default mkfs feature since version 3.18 i
>>>> (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
>>>> make skinny-metadata default") ). It really doesn't bring any value to
>>>> users to simply remove it.
>>>>
>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>
>>> Looks fine to me.
>>>
>>> But this means we need to define the level of (in)compat flags we want
>>> to show in the dmesg.
>>
>> Yes and we haven't done that so far so we should have some guidelines.
>>>
>>> By default, we have the following lines:
>>>
>>>    BTRFS info (device loop0): flagging fs with big metadata feature
>>>    BTRFS info (device loop0): using free space tree
>>>    BTRFS info (device loop0): has skinny extents
>>>    BTRFS info (device loop0): enabling ssd optimizations
>>>    BTRFS info (device loop0): checking UUID tree
>>>
>>> For "big metadata" it's even less meaningful, and it doesn't even have
>>> sysfs entry for it.
>>
>> There's an entry in the global features but 'big_metadata' does not
>> appear in the per-filesystem directory.
>>
>>> For "free space tree" it may be helpful, but if one is really concerning
>>> about the cache version we're using, it's better to go sysfs other than
>>> checking the kernel dmesg.
>>
>> The logged messages are a bit different as they could be stored and then
>> used for analysis. For new features it makes more sense to log them, I
>> think eg. the free space tree messages have been useful when debugging
>> the online conversion that took a few patches to get right.
>>
>>> For "SSD", it's a good thing to output.
>>
>> Agreed.
>>
>>> For "UUID" tree, it's definitely not useful, even for developers.
>>
>> Agreed.
>>
>>> For skinny metadata it's the one you're cleaning.
>>
>> Though I've sent patch to make it only debug I agree that this has
>> little value and don't object to removing it completely.
>>
>>> So I guess you can clean up more unnecessary mount messages then?
>>
>> The criteria I'd use for adding/removing the messages are vaguely like
>> that:
>>
>> - does the user want to know a particular feature is in use? this is
>>    namely when we're introducing something and want to verify what's
>>    happening

I think this is a good thought.

> 
> I'd say this is not that important.
> 
> In fact, there is a pretty bad example from the past, BIG_METADATA.
> 
> It's just we're supporting larger nodesize, it doesn't even bother users
> that much, nor really need a incompat flag at all.
> 
> Another example is from recent subpage feature, it doesn't need any
> incompat/compat RO flags at all, the only reason we're outputting
> message for subpage is, it's not tested as much as native page size.
> 
> If we can ensure enough test coverage (already getting better and better
> coverage) that experimental message would definitely go away.
> 
> 
> Thus my idea criteria would be:
> 
> - Would this feature bring bad impact to end users?
>    If the feature is only bringing good impact, it should not be output.
> 
>    Thus in this way, v2 cache nowadays should also be skipped, as it's
>    already well tested, and no real disadvantage at all.
> 
Even if v2 is default, lots of users are on older kernel/progs and would 
still benefit from seeing these messages.

>>
>> - can the option have an impact on the filesystem behaviour?  eg. like
>>    ssd, but we tend to log almost all mount options already
>>
>> - if there's a value for developer, the level should be debug, otherwise
>>    info
> 
> I'd say, considering how hard to enable debug messages, it doesn't
> really make much sense for developers.
> 
> Thus unfortunately such debugging info would still better to be at info
> level, just in case it's something like dying message and/or the user
> can not easily reproduce it.
> 
> But we may want a much shorter (even it means less human readable), less
> noisy output.
> 
> Thus I'd say, we may want to output hex incompat/compat RO/compat flags
> just in one line during mount, instead of current one feature per-line
> behavior.
> 
> By this, it provides more debug info, but still way shorter, and way
> more expandable.
> 

The idea of having a short feature flag code is good. As an end-user I 
do want to have the human readable form too. Especially during 
transition periods where lots of distros still use older kernels that 
may not have the new features enabled. For example a lot of users still 
use Ubuntu with a 5.4 kernel.

Of course, we should teach users to use /sys/ information or use btrfs 
inspect-internal tools, but I think this will take a long time.


> Thanks,
> Qu
>>
>> - remove messages if a feature is on by default for a long time and does
>>    not bring any other value, eg. the mixed_backref, big_metadata or
>>    skinny extents;
>>    the respective sysfs files may need to stay as they could be used for
>>    runtime detection even after a long time, eg. in some testsuite
>>    collecting testcases over time but likely not updating them, removal
>>    should be done on case-by-case basis

The sysfs files could stay always? Is that a problem?

Thanks,
Forza
