Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034B710CFA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 22:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1V5n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 16:57:43 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:58050 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbfK1V5n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 16:57:43 -0500
Received: from venice.bhome ([94.37.221.184])
        by smtp-35.iol.local with ESMTPA
        id aRnAiPkEu4KqMaRnAiUfs8; Thu, 28 Nov 2019 22:57:40 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1574978260; bh=3IDzzHR2zWBOv1zIXfJEawFYOafx2No9G2mRmojHIXU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kosvwY/yhiWKRlcgNUfEa2olfvNPD1Mnmu7V6VZeJFVtHrJqGat+PDwfxnkna5NQJ
         k2nlJPdl4z9rjMkXkVjKClfZGDLGVUcaL+U3ArOyIsuXGdpt/bZzToL2uf/oMKdKrE
         HxSNc6Xx3ENdlKkhQAyrSMiWDT0lw4ZYRfVcyCxLgfzNp+beSijSpQezsqB84X4JOC
         eaGz3oEsUoBnfVN6X5wUQRddIhpOmxfI4ylkuombADD3WV+ENh4T3onhOqXQsf8zBq
         EqFmH2DV+8cuOT8jsshBc6QAEQvhOgN2SplMt/2rKhatey13D2wUnAhdZhDgM40bUG
         YV8iOSZK7HPxg==
X-CNFS-Analysis: v=2.3 cv=UdUvt5aN c=1 sm=1 tr=0
 a=effWHHp4iGaMry7csNPTyg==:117 a=effWHHp4iGaMry7csNPTyg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=5CM6zFqFAAAA:20
 a=irWrD2dRAAAA:20 a=6rTV6VZxAAAA:20 a=u2-UTMI_L_NzIkRiChIA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
 <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it>
 <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it>
Date:   Thu, 28 Nov 2019 22:57:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMVEn56DeVN/2faokJQUI2aHnKgqXDXP4ryXUxZRTpenM5iuJscvSjVpco7DvL6ZrS3CiSGwExTSK1XJQhvnULSHMojqC4CzDh97CJFommtXnOpoFxdR
 YUtDXhjaPLk/ewE/+2JpP0dT2X46pGkEvLNDJ1VZP1Gy2FI5b+0pXKcRSqTWKljcD0uhxilxCseQ+w+fFqCnbI+2HvqZDlAJs0w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/11/2019 21.05, Chris Murphy wrote:
> On Thu, Nov 28, 2019 at 10:58 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
>> On 28/11/2019 01.42, Chris Murphy wrote:
>>> On Tue, Nov 26, 2019 at 11:07 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>>>
>> [...]
>>>> Could you enable the debug, doing
>>>>
>>>>           set pager=1
>>>>           set debug=all
>>>
>>> I need to narrow the scope. Adding 'set debug=all', there's just way
>>> too much to video, minutes of pages just holding down space bar full
>>> time which is even too fast to video. There must be over 1000 pages, a
>>> tiny minority contain efidisk.c references, the vast majority are
>>> btrfs.c references. As many pages as there are, I was never able to
>>> stop right on a boundary between efidisk.c and btrfs.c. So I gave up
>>> on that approach.
>>
>> If I remember correctly, in the previous email you reports that even a simple "ls" at the grub prompt raises an error.
>> So you could watch what happens when doing something simpler like "ls" or "ls (hd0)"
> 
> Errors with only ls.
> https://photos.app.goo.gl/BJpsLvwpL6yf19uj6

It seems that my supposition is true: the problem exists independently of btrfs.
It would be useful to see the debug (set debug=all + set pager=1) when doing "ls". It is a not so huge set of information (however it is composed by few pages).

> 
> Errors with ls per device
> https://photos.app.goo.gl/pgxQDdj1JDjq86mZ9

Grub sees hd0..hd3 as disks of ~120GB; to be exactly, the size is 125753602048 bytes. The error is reported as unable to access sector 0xea3bfc8, which is locate at 0xea3bf00*512=125753491456 byte, which is less than the previous value...

It seems that  GRUB is correct in complaining. It is trying to access a valid disk location which return an error.
Why grub is trying to access this location ? My supposition is that grub is trying to probe a filesystem (or a partition type...)

The problem seems to be related to the first 4 disks, which have all the same size and are "phantom" disks...
May be that the problem is that GRUB incorrectly detects disks ?
> 
> But without rebooting, just repeating the ls for the same devices, I
> don't get the error for hd4 again.
> https://photos.app.goo.gl/M6yraHfgfAsMigaP8

My understanding is that GRUB tried to load some external modules (zfs, ufs2, ...) without success. However this tentative was attempted only the first time. This could explain the fact that the error appeared only one time.
> 
>>From the first ls, it shows GPT on hd5, shouldn't 'ls (hd5)' report
> GPT rather than no file system? gdisk finds no problem with the GPT on
> /dev/sda which is hd5.

It seems no
-----------------------------------------------------------------------
                             GNU GRUB  version 2.03

    Minimal BASH-like line editing is supported. For the first word, TAB
    lists possible command completions. Anywhere else TAB lists possible
    device or file completions.


grub> ls
(proc) (hd11) (hd13) (hd14) (hd15) (hd19) (hd20) (hd31) (hd31,msdos1) (hd32) (h
d32,msdos2) (hd32,msdos1) (hd51) (hd52) (hd53) (hd61) (hd62) (hd63) (hd64) (hd7
1) (hd72) (hd73) (hd74) (hd99) (hd99,gpt2) (hd99,gpt1) (host) (md/0)
grub> ls (hd99)
Device hd99: No known filesystem detected - Sector size 512B - Total size
10485760KiB
grub>
-----------------------------------------------------------------------

> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
