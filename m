Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E9458BD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 10:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhKVJ5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 04:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbhKVJ5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 04:57:33 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4DAC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 01:54:27 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id E6C939BBB7; Mon, 22 Nov 2021 09:54:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1637574861;
        bh=zPSRkaKLCbn/L+jdfIPQdPZ8UKID4A7m74BlkZN2TVM=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=QM/5xxHHfLHmN9NzF7HAJcUIDD2MqVwt5PRdrMgUNnDztqXyBhz5SwGfoo8Xh+Y01
         gbFfMX0FwzWGqHNgifAPAAj1duKOKtmkP0Zdqo3eaT1pVKBNtZ30Sm/UqX+B43pKhd
         0N/Ml6h2bEVGZY9WcL9VRpZz+09iwKY51Txka/Jp41ujWATbK8SjO0z/bO8NLfL/bj
         d64/qepvI9eFtJMz8ZmF9XFuOWb8RkXwrn4o/Nf0MwrYTJMiviWWVDYDc1M5yCrMpJ
         KPtWZgGbcqSEWwY3zDzc/LvwyCY7ekh+aaR8AhplC0Lwrmc2rwdQXdzmGDluQkPoKl
         vKS9BhHYDVB1Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-5.0 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id B4A369BB09;
        Mon, 22 Nov 2021 09:53:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1637574803;
        bh=zPSRkaKLCbn/L+jdfIPQdPZ8UKID4A7m74BlkZN2TVM=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=lovtHV1rJcY4yqQO62lUOfOUqLy5RVtZmsf8FtZA19jh+OLIr8gv+P7ratXADUxq6
         1667wlNIS1KJW7p40uDt0SdL4prQj+/Z043R7oWD5qGeGpAibsZ0iBQ0LKsCNXyYzp
         c19cN/kWxJ2FaAWkqGO+hAGPPT28qS83aIqfQjsHAwmFUnEwR/CPe6Llxj+YoOrasV
         vpZEFKb7qXXhoMHe0awQMeuTU633yJOy6hSI6J+vR38EmPKfOkhvlFgiQST+vbwgY3
         8X7ScwVzVMTLZnMs8A1R+40qx5mKPTmykYO7cGgjbxJ39HP6earc2oRm396HBDfGN6
         SoiZ+svEpDYCQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 6141E2C5B94;
        Mon, 22 Nov 2021 09:53:23 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Nikolay Borisov <nborisov@suse.com>,
        Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20211121151556.8874-1-realwakka@gmail.com>
 <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
 <20211122083240.GB8836@realwakka>
 <a28e62b7-f1ee-858f-990b-678ab21312d9@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: filesystem: du: skip file that permission
 denied
Message-ID: <a5cd8f64-066e-8791-5de8-a2263d50f597@cobb.uk.net>
Date:   Mon, 22 Nov 2021 09:53:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a28e62b7-f1ee-858f-990b-678ab21312d9@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 22/11/2021 09:32, Nikolay Borisov wrote:
> 
> 
> On 22.11.21 г. 10:32, Sidong Yang wrote:
>> On Mon, Nov 22, 2021 at 09:20:00AM +0200, Nikolay Borisov wrote:
>>>
>>>
>>> On 21.11.21 г. 17:15, Sidong Yang wrote:
>>>> This patch handles issue #421. Filesystem du command fails and exit
>>>> when it access file that has permission denied. But it can continue the
>>>> command except the files. This patch recovers ret value when permission
>>>> denied.
>>>>
>>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>>
>>>
>>> The code itself is fine so :
>>>
>>>
>>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>>>
>>>
>>> OTOH when I looked at the code rather than just the patch I can't help
>>> but wonder shouldn't we actually structure this the way you initially
>>> proposed but also add a debug output along the lines of "skipping
>>> file/dir XXXX due to permission denied", otherwise users might not be
>>> able to account for some space and they can possibly wonder that
>>> something is wrong with btrfs fi du command.
>>
>> You mean that it would be better that print some debug message than
>> skipping silently. I agree. So I would add this code in condition.
>>
>> fprintf(stderr, "skipping file/dir: %s : %m\n", entry->d_name);
>>
>> I think it's okay that it prints when ENOTTY occurs. Is this code what
>> you meant?
> 
> 
> I meant to print only if we have EACCESS, but now that I think about it,
> printing something when we have a non-fatal error and simply skipping
> some dirs/files makes sense. OTOH printing it by default might be too
> verbose so perhaps usuing a pr_verbose call would be more appropriate.
> 
> This is one of those things which don't have a clear-cut answers so it's
> useful to get as many perspective as possible to arrive at some workable
> solution to a wider number of people.

I must admit I just assumed it worked the same way as /bin/du. I have
just created an inaccessible directory and got:

$ du -sh ~
du: cannot read directory '/home/cobb/permtest': Permission denied
61G	/home/cobb

And when the directory was accessible but the file in it was not, I got:

$ du -sh ~
du: cannot access '/home/cobb/permtest/file': Permission denied
61G	/home/cobb

In other words, I think any error should be printed but the error is
then skipped and the du continues. No need to tell people the file is
being skipped - that is obvious. But the error must be printed by
default (if there are really cases where the error should not be printed
but reasons not to redirect stderr to /dev/null then add an option to
suppress printing it).

Just my opinion.

Graham
