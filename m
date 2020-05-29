Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE271E83DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgE2Qkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 12:40:32 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:36556 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbgE2Qkb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 12:40:31 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id ei3Yjw096trlwei3YjTOfN; Fri, 29 May 2020 18:40:28 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590770429; bh=BOo80PcWm5DSBdox6ZzYYi/IT5OpTIRVJi4va4NiaPg=;
        h=From;
        b=Tb53lC4tAStnKQiP/1J1ORwIZs8pVPKJMxny+gErgDsfiVSFub5ZnyVKbzDDwdVJY
         1aKVxAuHM7JfiyqGAYa1maomizgcxctepqldam4SBKVmWhcUGIFCvQOaOo0J9pnwC1
         /SmNqUvhr3if+d3Pycm+EOWg38d77/8trS7p73dnEBQ1CIkHQak6T9UvXPf8DWQnMK
         VRUBHhzWdt3IwXYF15S2U7q+DbiA9YWRyVXF3Rh8hwtjULnV8hCsYtdh5zTImMJoYb
         07IwFHWcXggJMIAaej11+lDxJVjwpVe7FII7VIqj04tMJtgW2KjE3sOxuRcBUMCb7+
         Hoa2ZtBxFCHqA==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=9JHKcJSvL7YlFLJJR0QA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>
References: <20200405082636.18016-1-kreijack@libero.it>
 <a84d7342-47ed-e162-3047-f7ccdc77fdf1@knorrie.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <218577c2-ef0d-3bc8-fa7a-52fcac143c6d@libero.it>
Date:   Fri, 29 May 2020 18:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <a84d7342-47ed-e162-3047-f7ccdc77fdf1@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB2wZ6o4ge6kfx31HXJqwKtnNRj+l0aRLcCUSOof+elOsF67cG9QAQ4ANiEH7DbHylJigak7E2q5Sk3YG/7SKZamr+1xrVf28ZRPoFdYZlRLMnAyh7Cj
 19xi7xYrvsoHcT5EvGVBj5ra7HLMncebkNHpzKBGBB5nmv5o9epxPl71r/EhP0NipVtseDmhsKCF2fu6laEpHTtQq3kzFyFsm/qxHktjbqpPNVPXnrUXrSXq
 fiMm9GcG2sO+EJK2QtMqGm7QW6kORnQqTNFeRngWV/nZo/NOUMciVHt0om+58zaknQdU7Afe/OHzC08Q/mlejxzTbGKg69EvUslXSIpW7Jk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/29/20 6:06 PM, Hans van Kranenburg wrote:
> Hi Goffredo,
> 
> On 4/5/20 10:26 AM, Goffredo Baroncelli wrote:
>>
>> This is an RFC; I wrote this patch because I find the idea interesting
>> even though it adds more complication to the chunk allocator.
>>
>> The core idea is to store the metadata on the ssd and to leave the data
>> on the rotational disks. BTRFS looks at the rotational flags to
>> understand the kind of disks.
> 
> Like I said yesterday, thanks for working on these kind of proof of
> concepts. :)
> 
> Even while this can't be a final solution, it's still very useful in the
> meantime for users for which this is sufficient right now.
> 
> I simply did not realize before that it was possible to just set that
> rotational flag myself using an udev rule... How convenient.
> 
> -# cat /etc/udev/rules.d/99-yolo.rules
> ACTION=="add|change",
> ENV{ID_FS_UUID_SUB_ENC}=="4139fb4c-e7c4-49c7-a4ce-5c86f683ffdc",
> ATTR{queue/rotational}="1"
> ACTION=="add|change",
> ENV{ID_FS_UUID_SUB_ENC}=="192139f4-1618-4089-95fd-4a863db9416b",
> ATTR{queue/rotational}="0"

Yes but of course this should be an exception than the default

> 
>> This new mode is enabled passing the option ssd_metadata at mount time.
>> This policy of allocation is the "preferred" one. If this doesn't permit
>> a chunk allocation, the "classic" one is used.
>>
>> Some examples: (/dev/sd[abc] are ssd, and /dev/sd[ef] are rotational)
>>
>> Non striped profile: metadata->raid1, data->raid1
>> The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
>> When /dev/sd[ef] are full, then the data chunk is allocated also on
>> /dev/sd[abc].
>>
>> Striped profile: metadata->raid6, data->raid6
>> raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
>> data profile raid6. To allow a data chunk allocation, the data profile raid6
>> will be stored on all the disks /dev/sd[abcdef].
>> Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
>> because these are enough to host this chunk.
> 
> Yes, and while the explanation above focuses on multi-disk profiles, it
> might be useful (for the similar section in later versions) to
> explicitly mention that for single profile, the same algorithm will just
> cause it to overflow to a less preferred disk if the preferred one is
> completely full. Neat!
> 
> I've been testing this change on top of my 4.19 kernel, and also tried
> to come up with some edge cases, doing ridiculous things to generate
> metadata usage en do stuff like btrfs fi resize to push metadata away
> from the prefered device etc... No weird things happened.
> 
> I guess there will be no further work on this V3, the only comment I
> would have now is that an Opt_no_ssd_metadata would be nice for testing,
> but I can hack that in myself.

Because ssd_metadata is not a default, what would be the purpouse of
Opt_no_ssd_metadata ?

> 
> Thanks,
> Hans
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
