Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648D540692F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhIJJj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhIJJjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 05:39:55 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A0BC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 02:38:44 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id E3CE69B8C1; Fri, 10 Sep 2021 10:38:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631266720;
        bh=eEbZBSPYDrZZoEtEoID0yXLm3CFrsD3WdkWD8FyZ3Eo=;
        h=From:Subject:To:References:Date:In-Reply-To:From;
        b=aZODZ6NL0Q1pQJmJ5yXnc7kvKHiYls2gmvZRehA7cuHkISMmAST9A+dT5e/frpvA/
         zHy6XaXcIPe+qGNXArTHdWVQ1AidFJiglnzpoAG3NbICbesmdVthBMTsOQE3giz4r/
         buHgkgd6aDIEY/N+qrsZvwObktZZ/ruoJa+KKkivAUX68uvjqVW0tHqs2AIHXkXdtC
         ClckP1S3fhQHDoqmNEizq8yNSUL8EC3F8CfWwW2zpvrzQ8ELrrGXPJfHCNzN+LLyG4
         G3YsNOBF326GfiPjS14Rbkl47JzELhVnLLP+o2wtGi3JBKAr8NOaIf7Ec8hmF68dDh
         vkS1pIVZHKTng==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-7.2 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 47EC09B871;
        Fri, 10 Sep 2021 10:38:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631266690;
        bh=eEbZBSPYDrZZoEtEoID0yXLm3CFrsD3WdkWD8FyZ3Eo=;
        h=From:Subject:To:References:Date:In-Reply-To:From;
        b=AiFq7qIrD+ljjOyLZqW4Sw8ZtRtQNLg6vHHKv/doO4LLwjBGpwOaMy5d1+CUFpKIy
         ta6sEfHSQSn0l9qni5gTd6Fxl+xIvS2XJwjTNKJ241N4qnhw2BOhXfxvABe0ES5Pyu
         Brp5nE7kK0SGg6LCRGj9MJdG1nYfykQ2craBQQ1Oc2Vo4LqQmYoaJ0QCHy3+c6izcT
         1huYONAUptDEOD5QiMyAXpEMabUzVREziiRWX1Mdv74Xk35+2p3Oh88ISiazzEkVhW
         JIN0bPKykjc/dnqrZfrgt6bPFTXHsSWS+pI7aY1GARuTRk7frJ/AyDitlLU2BpmI5v
         nxk7gyuqqMetg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 0A000295384;
        Fri, 10 Sep 2021 10:38:10 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH 1/2] btrfs-progs: do extra warning when setting ro false
 on received subvolume
To:     Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-2-wqu@suse.com>
 <e1dbfdc6-d1d8-12d4-cbcf-1dd02c935df4@suse.com>
 <81a72912-1e90-205f-c875-bfac50e80a0e@suse.com>
Message-ID: <85e10118-0cbb-8283-1c12-e9e876763b8d@cobb.uk.net>
Date:   Fri, 10 Sep 2021 10:38:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <81a72912-1e90-205f-c875-bfac50e80a0e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/09/2021 08:28, Qu Wenruo wrote:
> 
> 
> On 2021/9/10 下午2:36, Nikolay Borisov wrote:
>>
>>
>> On 10.09.21 г. 9:03, Qu Wenruo wrote:
>>> When flipping received subvolume from RO to RW, any new write to the
>>> subvolume could cause later incremental receive to fail or corrupt data.
>>>
>>> Thus we're trying to clear received UUID when doing such RO->RW flip, to
>>> prevent data corruption.
>>>
>>> But unfortunately the old (and wrong) behavior has been there for a
>>> while, and changing the kernel behavior will make existing users
>>> confused.
>>>
>>> Thus here we enhance subvolume read-only prop to do extra warning on
>>> users to educate them about both the new behavior and the problems of
>>> old behaviors.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   props.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/props.c b/props.c
>>> index 81509e48cd16..b86ecc61b5b3 100644
>>> --- a/props.c
>>> +++ b/props.c
>>> @@ -39,6 +39,15 @@
>>>   #define ENOATTR ENODATA
>>>   #endif
>>>   +static void do_warn_about_rorw_flip(const char *path)
>>> +{
>>> +    warning("Flipping subvolume %s from RO to RW will cause
>>> either:", path);
>>> +    warning("- No more incremental receive based on this subvolume");
>>> +    warning("  Newer kernels will remove the recevied UUID to
>>> prevent corruption");
>>> +    warning("- Data corruption or receive corruption doing
>>> incremental receive");
>>> +    warning("  Older kernels can't detect the modification, and
>>> cause corruption or receive failure");
>>
>> This is a bad format for a warning, let's keep it simple - just state
>> that flipping ro->rw would break incremental send and that's that.
> 
> But won't this on older kernels cause more confusion?
> 
> The old kernels will still allow incremental send using that flipped
> subvolume without problem, just corrupting the data..
> 
> (Well, that's definitely "broken", but still a different behavior)

Exactly. I agree with Nikolay - keep the warning simple. Let the man
page explain in more detail.
