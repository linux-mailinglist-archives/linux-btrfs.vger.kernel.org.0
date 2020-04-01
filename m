Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89AC19B62D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgDATFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 15:05:06 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:34604 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbgDATFG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 15:05:06 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id Jifdjc1Z2MAUpJifdj5tmt; Wed, 01 Apr 2020 21:05:02 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1585767902; bh=GP1wAkRbrBRxmhSYfWPGg1F3EAqX++UfyYGfWI0/lPM=;
        h=From;
        b=ruln6qnA0IOcab4duCL8nCBglm4G72w7sKiNBLToG/jEAlGpAbaeP7yRdWS2T2wbS
         O9zvQlVDergBKxQAIrOOtSZCqAB9tDxv91HkH0DYufahKBkbYWuZmS1zOjyhSVHhQh
         hMLFPLe8/96eIqgKNdhd+GXYCv5LHi0F+TT3vPFBbLV+dIFwa+5pCY6RZW90PH55Nh
         FVpBWgAooKsBkbw89Dlf9marPxjBR3UEPGwpKa+YQXEln8A4thy44LKdmJDDMtj4Jq
         +40NKbsfzL5L9XaKCZfoduBm6L+cJA8RKEHvU0chGTbz6M/109QVlxsskYGDXhuBUY
         OHIQh+5rvJrNA==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=vaqtwm1CgXVj8Co_9TAA:9
 a=LhkzyjCt_BDEmIgY:21 a=ZJnjWNUJyS9lw0pv:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2] btrfs-progs: add warning for mixed profiles filesystem
To:     dsterba@suse.cz, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>
References: <20200331191045.8991-1-kreijack@libero.it>
 <97ec9f13-8d8d-1df9-f725-44a2a0ecc438@cobb.uk.net>
 <20200331220534.GI2693@hungrycats.org>
 <6bd78420-f630-19af-076f-1a2b4bf89aa2@libero.it>
 <20200401182021.GY5920@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <2255c548-b033-46f4-a85a-cfa1cbc282ba@inwind.it>
Date:   Wed, 1 Apr 2020 21:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401182021.GY5920@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB7wOcZe02QKYt8fnQCcUfWBcbbgEunqWblt7RoXmjXkdC+wjPEeQ8aNjua7K3s2Ku56uhlc8HAlaFyWX/b1/64iSMa3xsAMcK65BNdJv/HCN7Flu7cK
 7Zc8vgbdhRGljN8u0X5Xo81F4CHRt+xliN2JSxRPTURPnkRoq2wWfaCHZ6XLuO4d0C/KvXhiw0SBaw6JImwR92zF6pXNnnqW04RCQGR4WPtSmwibg0Hk9ZNP
 Mg0ETMObmSlTRRLd6EtebSkH/Mj5sBcRfTCCxz9NF+QF0dFTbUtWgFieWLbUizW16zbU/t7RtwA6HvBmu2uJtRau1IjFcEpoChJxd90nOJs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 4/1/20 8:20 PM, David Sterba wrote:
> On Wed, Apr 01, 2020 at 07:15:19PM +0200, Goffredo Baroncelli wrote:
>> On 4/1/20 12:05 AM, Zygo Blaxell wrote:
>>> On Tue, Mar 31, 2020 at 10:46:17PM +0100, Graham Cobb wrote:
>>>> On 31/03/2020 20:10, Goffredo Baroncelli wrote:
>>>>> WARNING: ------------------------------------------------------
>>>>> WARNING: Detection of multiple profiles for a block group type:
>>>>> WARNING:
>>>>> WARNING: * DATA ->          [raid1c3, single]
>>>>> WARNING: * METADATA ->      [raid1, single]
>>>>> WARNING:
>>>>> WARNING: Please consider using 'btrfs balance ...' commands set
>>>>> WARNING: to solve this issue.
>>>>> WARNING: ------------------------------------------------------
>>>>
>>>> The check is a good a idea but I think the warning is too strong. I
>>>> would prefer that the word "Warning" is reserved for cases and
>>>> operations that may actually damage data (such as reformating a
>>>> filesystem). [Note: in a previous job, my employer decided that the word
>>>> Warning was ONLY to be used if there was a risk of harm to a human - for
>>>> example, electrical safety]
>>
>> In some fields, like medical devices, terms "warning", "caution", "notice"
>> are strictly regulated; and your employer is right: warning is
>> required only when an human harm could happen.
>>
>> In btrfs however, the rules are a bit relaxed; so we have only ERROR (fatal)
>> and Warning (which is more like caution).
>>
>> However I think that an unexpected profile is to be considered a severe fault.
> 
> I agree with the 'unexpected' part and as I read the other feedback, but
> the mixed profiles do not emerge out of nowhere. It requires a balance
> operation and that it changes the filesystem layout I consider expected.

If the balance+conversion operation ends without problem AND if it
converts all the filesystem, a "mixed" profile doesn't appear.
However for the other case like:
- an interrupt of balance process for an external reasons (which likely
get the attention of the user, until he forgets to complete the process)
- a balance made with some filter (like -convert=xxx,usage=yyy)

The results is a mixed profile. To avoid that the user has to do a lot
of attention.
Moreover if you watch the output of a "fi us" (or "dev us") you cannot
understand which profile is representative of the filesystem. (see below)


> 
>> I.e. you could have a RAID5 instead of a RAID1, where the former is more
>> fragile than the latter.
>> Moreover I suspect that a lot of problems reported on mailing list born from
>> a mixed profile filesystem...
> 
> Do you have an example? Converting between some priofiles is tricky, eg.
> when the striped ones need enough space on all devices, unlike mirrored
> that need that on 2/3/4 devices. But that's not something I feel is
> related to lack of the warning.

Read this more as sensation than a true fact.
However what seemed strange to me was the fact that if you have a raid6 profile,
and convert it to a raid1 without completing the process. Then the next chunk will
be a raid6. Other case: you have a raid1 profile, then convert it to a raid6 but not
complete the process. Then the next chunk will be a raid6.
raid6 wins always... [*] This is not what an user expects; I expect that
the latest balance profile wins...

[*] See the thread "Question: how understand the raid profile of a btrfs filesystem".

> 
>>>> Also, btrfs fi usage is something that I routinely run continuously in a
>>>> window (using watch) when a remove/replace/balance operation is in
>>>
>>> I was going to say please put all the new output lines at the bottom,
>>
>> The added lines are the last ones. Do you mean top ?
>>
>>> so that 'watch' windows can be minimally sized without having to write
>>> something like
>>>
>>> 	watch 'btrfs fi usage /foo | sed -e "g/WARNING:/d"'
>>>
>>> People with short terminal windows running btrfs fi usage directly from
>>> the command line would probably complain about extra lines at the bottom...
>>>
>>> Another good idea here would be a --quiet switch, or
>>> '--no-profile-warning'.
>>
>> I think that having a global switch like '--no-profile-warning' is a good thing.
>>
>>>
>>>> progress to monitor at a glance what is happening - I don't want to
>>>> waste all that space on the screen. To say nothing of the annoyance of
>>>> having it shouting at me for weeks on end while **I AM TRYING TO FIX THE
>>>> DAMN PROBLEM!**.
>>>>
>>>> I would suggest a more compact layout and factual tone. Something like:
>>>>
>>>> Caution: This filesystem has multiple profiles for a block group type
>>>> so new block groups will have unpredictable profiles.
>>>>    * DATA ->          [raid1c3, single]
>>>>    * METADATA ->      [raid1, single]
>>>> Use of 'btrfs balance' is recommended as soon as possible to move all
>>>> blocks to a single profile for each of data and metadata.
>>>
>>> How about a one-liner:
>>>
>>> 	NOTE: Multiple profiles detected.  See 'man btrfs-filesystem'.
>>
>>
>> WARNING: Multiple profiles detected.  See 'man btrfs-filesystem'.
>> WARNING: data -> [raid1c3, single], metadata -> [raid1, single]
>>
>> I think that the one above could be a good compromise.
> 
> I agree, though I'd prefer only the reference to manual page with enough
> examples and commandds to see what it means and what to do next.
> 
> The output style of the tools I generally try to maintain is to provide
> building blocks or combining information from various sources together,
> not necessarily a tool that comes with warning everywhere a first time
> user can be surprised.
> 
>> I am thinking also to combine '--no-profile-warning' and '--verbose' to have
>> three different warning level (--no-profile-warning -> no warning at all, nothing
>> -> small warning, --verbose -> "giant" warning).
> 
> That sounds like an overkill to me, the option is too long and I think
> slightly experienced users would have to use it all the time. 

My feeling is that in the 99% of the case the user doesn't see the warning. So
he doesn't need to use --no-profile-warning.
For the other cases something strange is happening. And it is better a warning
than forget a "mixed profile". I thought the switch more for a script than
an "human" user.

May be that we should ensure that the warning doesn't appear when
a balance is in progress. But only when a balance is paused/finished/stopped.
Unfortunately this seems to require root privileges.

> If we
> could find commands where the warning makes most sense, like right
> before or after balance, then it's fine to add it to the output. But for
> 'fi df' or 'fi us' it's IMHO inappropriate.

My feeling is that a mixed profile is the result of not appropriate
use of "btrfs bala". So in a standard condition the warning should not
appear.
In a non standard condition (like a balance to gain some space) the user
should have all the support to avoid any error.
This is the reason of the "WARNING".

> 
> This is all usability tuning, so I'm open to discussion or
> disagreements, we'll find some solution.

Adding or removing a check is simple; so for me it is ok to starts with
the agreed commands and then extend to other if we want.

I will work at the man page. I think that on this point we all agree.


BR
G.Baronelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
