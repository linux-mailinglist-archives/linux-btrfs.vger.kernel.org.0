Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DCB19B495
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgDARPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 13:15:25 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:50885 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727661AbgDARPY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 13:15:24 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id JgxUjbKZ4MAUpJgxVj5Pct; Wed, 01 Apr 2020 19:15:21 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585761321; bh=crAYVmjOtdaUsx2wuaflLkMFzoSrlb6IQ7CP/06pkLE=;
        h=From;
        b=CQwQ3xtKpJxjrhymZskjZMBY6ksbE03FWzHPYqA//TM93yl/5Hpk7PrYtE0OOvEqi
         EdCvpjDv6PnUDDfSM2kzSA7SZEOSD25i1pt8HIdPOv+qJiN9NPQFDli/Nyuz+U/sMi
         II/XtB3F3KQQUl2H3we2nksn9Be4cuBLYUlkNkK9p7pCQeWx4CN4q5VNwME5VWVSWY
         OCvISgNRNESgs3BE953oMyms5bNa3d6P7qPbho4GHpvrFB/CANlBTRdWPxSS3BEz9H
         zkvLUKxgrH9n62PeRkDg0Tpdmd32zzye0WrKL01TyCMi4OJgBX+9saqAwicsFSf4Kt
         ob9/QCZNM0fLQ==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=OFaUtcoj0NLVmBT5XqUA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2] btrfs-progs: add warning for mixed profiles filesystem
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>
References: <20200331191045.8991-1-kreijack@libero.it>
 <97ec9f13-8d8d-1df9-f725-44a2a0ecc438@cobb.uk.net>
 <20200331220534.GI2693@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <6bd78420-f630-19af-076f-1a2b4bf89aa2@libero.it>
Date:   Wed, 1 Apr 2020 19:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331220534.GI2693@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBqKnn6A+MlguvMz59Rs9AqxoK6jOddOA/69Vk+czJOClCb4lzZ1wz2C4U+8XNVYuDf4pQJbgZ9c8nxjnSxD0ICWRl7SiSwA0AqUUMnlVNC91rkUcXOr
 BDSuhO1R0/HlPM6Kr7CrPphhYM3jl5cKIVS/CTct+9aS90gZgAJoIYEs2Lak3YrcqbCeBi9tsoWpOTIdfLrxdCOaqVcQfgFlm/3rn2ziKwcbxeVh4df1p9TG
 GgOsn7DtWPQgK/jomMKeToVnv/HEPR4VnYqpzSDKQhZtuGa/qTUaZRyz3DVkFRvVR24sv/AhS6wCZWtGr6isPA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/1/20 12:05 AM, Zygo Blaxell wrote:
> On Tue, Mar 31, 2020 at 10:46:17PM +0100, Graham Cobb wrote:
>> On 31/03/2020 20:10, Goffredo Baroncelli wrote:
>>> WARNING: ------------------------------------------------------
>>> WARNING: Detection of multiple profiles for a block group type:
>>> WARNING:
>>> WARNING: * DATA ->          [raid1c3, single]
>>> WARNING: * METADATA ->      [raid1, single]
>>> WARNING:
>>> WARNING: Please consider using 'btrfs balance ...' commands set
>>> WARNING: to solve this issue.
>>> WARNING: ------------------------------------------------------
>>
>> The check is a good a idea but I think the warning is too strong. I
>> would prefer that the word "Warning" is reserved for cases and
>> operations that may actually damage data (such as reformating a
>> filesystem). [Note: in a previous job, my employer decided that the word
>> Warning was ONLY to be used if there was a risk of harm to a human - for
>> example, electrical safety]

In some fields, like medical devices, terms "warning", "caution", "notice"
are strictly regulated; and your employer is right: warning is
required only when an human harm could happen.

In btrfs however, the rules are a bit relaxed; so we have only ERROR (fatal)
and Warning (which is more like caution).

However I think that an unexpected profile is to be considered a severe fault.
I.e. you could have a RAID5 instead of a RAID1, where the former is more
fragile than the latter.
Moreover I suspect that a lot of problems reported on mailing list born from
a mixed profile filesystem...

>>
>> Also, btrfs fi usage is something that I routinely run continuously in a
>> window (using watch) when a remove/replace/balance operation is in
> 
> I was going to say please put all the new output lines at the bottom,

The added lines are the last ones. Do you mean top ?

> so that 'watch' windows can be minimally sized without having to write
> something like
> 
> 	watch 'btrfs fi usage /foo | sed -e "g/WARNING:/d"'
> 
> People with short terminal windows running btrfs fi usage directly from
> the command line would probably complain about extra lines at the bottom...
> 
> Another good idea here would be a --quiet switch, or
> '--no-profile-warning'.

I think that having a global switch like '--no-profile-warning' is a good thing.

> 
>> progress to monitor at a glance what is happening - I don't want to
>> waste all that space on the screen. To say nothing of the annoyance of
>> having it shouting at me for weeks on end while **I AM TRYING TO FIX THE
>> DAMN PROBLEM!**.
>>
>> I would suggest a more compact layout and factual tone. Something like:
>>
>> Caution: This filesystem has multiple profiles for a block group type
>> so new block groups will have unpredictable profiles.
>>   * DATA ->          [raid1c3, single]
>>   * METADATA ->      [raid1, single]
>> Use of 'btrfs balance' is recommended as soon as possible to move all
>> blocks to a single profile for each of data and metadata.
> 
> How about a one-liner:
> 
> 	NOTE: Multiple profiles detected.  See 'man btrfs-filesystem'.


WARNING: Multiple profiles detected.  See 'man btrfs-filesystem'.
WARNING: data -> [raid1c3, single], metadata -> [raid1, single]

I think that the one above could be a good compromise.

I am thinking also to combine '--no-profile-warning' and '--verbose' to have
three different warning level (--no-profile-warning -> no warning at all, nothing
-> small warning, --verbose -> "giant" warning).
However the Anand's patches set for a global --verbose is still pending.
Also these global switches can be sets in an environment variables (like BTRFS_GLOBAL_OPTIONS).

> 
> with a section in the btrfs-filesystem man page giving a detailed
> description of the problem and examples of possible remedies.
> 

I will try, however my English is terrific....

BR
G.Baroncelli
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
