Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB3F10AA99
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 07:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0GJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 01:09:33 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:54934 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfK0GJc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 01:09:32 -0500
Received: from venice.bhome ([94.37.221.184])
        by smtp-35.iol.local with ESMTPA
        id ZqW2i7bLv4KqMZqW2iJV2a; Wed, 27 Nov 2019 07:09:30 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1574834970; bh=tmegjrh3JH04mkv2QifkC5biZLDK/U42S8Wb1QhTesI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EpOkURWohOg8L/7j3v9+scUJbQFjd9YkVdsD8RPFU22oUqRPec15/60p7jGx02uPA
         qR3m3k7ibrizOb4xDV1RPaFO+j1Bmw2g/7smBcq85WQ5NRM1313IKnoSxnf8nQ7D8y
         6YuJXdtQh6PvepkfkBPLZLcUAoV2x16xhrP9kOxpYJ6pUxD8uLKnpb+CjX2AEK3wQO
         u1wICRv98CP9HyOneBGmpJ7mY6SfjLAKNsxzL49m7hP6WGT+SorkFv/RuT0Bg6YBie
         BQzOa1zcoRlLA91FPqHEzwxq1aKxqTftgJn/R/wB1+su42sv7awNWRaA+9F4DhRFKa
         wCjcHBF7tKHcg==
X-CNFS-Analysis: v=2.3 cv=UdUvt5aN c=1 sm=1 tr=0
 a=effWHHp4iGaMry7csNPTyg==:117 a=effWHHp4iGaMry7csNPTyg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=doPC0QqkYbtJk2A2XCYA:9
 a=0Jns2jzslF4hp9Ig:21 a=ZFn7A5CI2fFgbM74:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <1853071f-bbe9-da23-8b42-ccf46db995f8@inwind.it>
Date:   Wed, 27 Nov 2019 07:09:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLiPOeMKfR8fKxD5wudJ+qgLTWQQo/2UZAQpLsKa6gXmSTYzWysNmzy3Q68mMcXXmMh2J6/pjy/sTqHjE3unuw4ZcLJREDTfPuItZqJFkAJxi5PtvT/9
 Hf6m5gHcyzi2IRTD3hGA3QYtUd+aRC+wt02UG0rFJZ8z0ZOcZfJovs8Aaax3xOzgEKLVT1kriv2eJfWdGV/HUA41zhgvDuXDBhU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/11/2019 00.53, Chris Murphy wrote:
> On Tue, Nov 26, 2019 at 2:11 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> On 26/11/2019 05.05, Chris Murphy wrote:
>>> grub2-efi-x64-2.02-100.fc31.x86_64
>>> kernel-5.3.13-300.fc31.x86_64
>>>
>>> I've seen this before, so it isn't a regression in either of the above
>>> versions. But I'm also not certain when the regression occurred,
>>> because the last time I tested Btrfs multiple devices (specifically
>>> data single profile), was years ago and I didn't run into this.
>>
>>   From the video, it seems that GRUB complaints about a "failure reading". However GRUB is capable to perform the boot and because the profiles are "single (no redundancy), it seems a "false positive" error.
>>
>> When I added the RADID5/6 support to grub, I remember errors like what you showed. However it happened 1 year ago, so my remember may be wrong.
>> I noticed that GRUB test a lot of disks (hd0 ... hd3) . Could you be so kindly to share the disks layout ? Most error is something like "failure reading sector 0xXX". However I can't read the XX number: could you be so kindly to tell us which number is "XX" ? It seems 0x80... but my eyes are bad and your video is even worse :-)
> 
> It was a dark room and shaky cam was seeking for focus :-D It's 0x80.
> 
> The storage is one CD-ROM drive and one SSD drive. That's it. So I
> don't know why there's hd2 and hd3, it seems like GRUB is confused
> about how many drives there are, but that pre-dates this problem.

If these drives are phantom ones, these could be the root of the problem...

> 
> 
>> I think that the errors is due to the "rescan" logic (see grub commit [1]). Could you try a more recent grub (2.04 instead of 2.02) ?
> 
> Yes Fedora Rawhide has 2.04 in it, so I'll give that a shot next time
> I rebuild this particular laptop, which should be relatively soon; or
> even maybe I can reproduce this problem in a VM with two virtio
> devices.
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
