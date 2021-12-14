Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F228A474B41
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 19:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbhLNSxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 13:53:38 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:51607 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229441AbhLNSxi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 13:53:38 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id xCvem5fPVg9rVxCvemam7L; Tue, 14 Dec 2021 19:53:36 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639508016; bh=BtudPPC1s2AvJBj/ZGIKt6Gs5xhAIcQF+tD6wNZNKdU=;
        h=From;
        b=cg8XOlySO4fYmbrrDjWqlbbmru7MqncWuMopwD8S6ChVBiy22eQ0VsuW6lxyygC+6
         8ZAWK7IRw/oeBam20afR7kMO5w90UvI7KP+xZoEL3AirznuyNE9tdFzzZwiXx5lRUA
         S9yjUqwyGR8BbIZ1OOLBl8gYjNI+/x4rgIQ8EwH/sin3p7qPa9u1qcIpskOQanE+BR
         C5Z3OaCuAXqbemm/9qqWNMHnioj47Q2JV92HY+aT9hm1M2zrxI7EAef2cam+xNNkcb
         W6Me4Hw1GxBe5vfUL6SKfHeZyi3wMkyT4o6do88KyLQCZoMacBCr8yuihWClAVmUNz
         p3opkBZi9w5Jg==
X-CNFS-Analysis: v=2.4 cv=T8hJ89GQ c=1 sm=1 tr=0 ts=61b8e830 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=eT1zTwzpcIPFGerhT4AA:9 a=QEXdDO2ut3YA:10
Message-ID: <97c118df-e7ec-1ef5-8362-e0ecc949db35@libero.it>
Date:   Tue, 14 Dec 2021 19:53:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Ybe34gfrxl8O89PZ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGIY7X8h2v+WvuhDYkVgFTBhPurN7vokEg9Ok75A1o6Wv6jd2WHECXe8syDTCdKBfI6DCJXSanfWNt2KM4VWP9IL0iT/uyBDg5yEgqGxsKZ6fJRVzpOP
 J9sPbHnH3MdIbnP+NxFnVIsRaONqteGB26X+hnrSP3XNEfuokh4jbBHUXjVy/OvlR7rkO/0LpZvG/MfVLNCRpXEowYwEHm0ao+ZEq1popXzZSjjt/eDSZbfN
 0pX3rZSSLuYyktkctUTe8pkKlxmLOGq9hE2rE1ItDlfG4yZ0743M8d5O6ZgPyDzDLiiIFerw4emjZr6hyr9tJuwWX8aJHWE0vtz2E7XgfVg2uVZau1JNRDJ0
 88oF/aC8
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/13/21 22:15, Josef Bacik wrote:
> On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
>> Gentle ping :-)
>>
>> Are there anyone of the mains developer interested in supporting this patch ?
>>
>> I am open to improve it if required.
>>
> 
> Sorry I missed this go by.  I like the interface, we don't have a use for
> device->type yet, so this fits nicely.
> 
> I don't see the btrfs-progs patches in my inbox, and these don't apply, so
> you'll definitely need to refresh for a proper review, but looking at these
> patches they seem sane enough, and I like the interface.  I'd like to hear
> Zygo's opinion as well.
> 
> If we're going to use device->type for this, and since we don't have a user of
> device->type, I'd also like you to go ahead and re-name ->type to
> ->allocation_policy, that way it's clear what we're using it for now.

The allocation policy requires only few bits (3 or 4); instead "type" is 64 bit wide.
We can allocate more bits for future extension, but I don't think that it is necessary
to allocate all the bits to the "allocation_policy".

This to say that renaming the field as allocation_policy is too restrictive if in future
we will use the other bits for another purposes.

I don't like the terms "type". May be flags, is it better ?

> 
> I'd also like some xfstests to validate the behavior so we're sure we're testing
> this.  I'd want 1 test to just test the mechanics, like mkfs with different
> policies and validate they're set right, change policies, add/remove disks with
> different policies.
> 
> Then a second test to do something like fsstress with each set of allocation
> policies to validate that we did actually allocate from the correct disks.  For
> this please also test with compression on to make sure the test validation works
> for both normal allocation and compression (ie it doesn't assume writing 5gib of
> data == 5 gib of data usage, as compression chould give you a different value).
> 
> With that in place I think this is the correct way to implement this feature.
> Thanks,

Ok

> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
