Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1230241E88D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352589AbhJAHv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 03:51:27 -0400
Received: from relay.wolfram.com ([140.177.205.37]:51368 "EHLO
        relay-ext.wolfram.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352547AbhJAHv0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 03:51:26 -0400
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
        by relay-ext.wolfram.com (Postfix) with ESMTPS id 2495815DD;
        Fri,  1 Oct 2021 02:49:40 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 2495815DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
        t=1633074580; bh=q0eP2Jt/8UMHejRa+ElyXpSRJiT+zCwv9lAEqjecF04=;
        h=Date:From:Reply-To:To:Cc:In-Reply-To:References:From;
        b=lP8DJ4DVoOtmsZXq5G5A5MZyuFUHwSqnVFwfXXgw1TQ8ibbCeywR1Lmwzea/VV9xk
         RqQ39hba7u+FMrkJt1BQ6TcAVcL1hnZUDXnIwxrXQIW9xPk3zdj6Ch4A8LEAp74fmJ
         jo0/3u18lmI8qvF+AtQMf2lp3Smn8GHnTCQIZuoc=
Received: from wrimail05.wolfram.com (wrimail05.wolfram.com [10.128.1.216])
        by relay-10-128.wolfram.com (Postfix) with ESMTPS id 1F90630004E;
        Fri,  1 Oct 2021 02:49:40 -0500 (CDT)
Received: from wrimail05.wolfram.com (localhost [127.0.0.1])
        by wrimail05.wolfram.com (Postfix) with ESMTPS id 1753A1A0AFA;
        Fri,  1 Oct 2021 02:49:40 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by wrimail05.wolfram.com (Postfix) with ESMTP id E993F1A0B0A;
        Fri,  1 Oct 2021 02:49:39 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail05.wolfram.com E993F1A0B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
        s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1633074579;
        bh=zAkgeYMOka1IzmJELqAqkthngeItWg4oEOrik2rQPQM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FzPGVH/xfG1lD1mtxVzpQts8WZj1yifUqre4RsLD8jr0DifZmYPF1jutwTeSoc+RO
         srZf+i+nWWrGVBKzvGBsv/yfZi0YgD+AYFyQlIhRfjb192+zuo8bMLKiyeEvI9WDuP
         99zNCCnajRTVZDD+sMqIJpz6iGk+MJV8AY27L1FY+yYEokvaGzE+j/2w2Q/Wo4L1kh
         psN8KfdnGkb2301rISKjSbQxf6X0stCbFJ6NmBWj5cBgRKCWk+u9PyaEcJNV8FM8SC
         ci1Gn2/wSjyh1mP73hkhByH9sZy1V8Kk2HbaCmdfd2vPcSJDv1QcZxN8Npu/vBP1eW
         fBboWqBmdSxzQ==
Received: from wrimail05.wolfram.com ([127.0.0.1])
        by localhost (wrimail05.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HP7vQfJ_zZ5l; Fri,  1 Oct 2021 02:49:39 -0500 (CDT)
Received: from wrimail05.wolfram.com (wrimail05.wolfram.com [10.128.1.216])
        by wrimail05.wolfram.com (Postfix) with ESMTP id D6B461A0AFA;
        Fri,  1 Oct 2021 02:49:39 -0500 (CDT)
Date:   Fri, 1 Oct 2021 02:49:39 -0500 (CDT)
From:   Brandon Heisner <brandonh@wolfram.com>
Reply-To: brandonh@wolfram.com
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <1185660843.2173930.1633074579864.JavaMail.zimbra@wolfram.com>
In-Reply-To: <20210929173055.GO29026@hungrycats.org>
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com> <20210929173055.GO29026@hungrycats.org>
Subject: Re: btrfs metadata has reserved 1T of extra space and balances
 don't reclaim it
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.42.26.127]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4059)
Thread-Topic: btrfs metadata has reserved 1T of extra space and balances don't reclaim it
Thread-Index: 78WjK6xfYitB36X/QFJ82+AC5oq/Dw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A reboot of the server did help quite a bit with the problem, but still not fixed completely.  I went from having 1.08T reserved for metadata to "only" having 446G reserved.  My free space went from 346G to 1010G.  So at least I have some breathing room again.  I prefer not to do a defrag, as that breaks all the COW links and the disk usage would go up then.  I haven't tried the balance of all the metadata, which might be resource intensive.  

# btrfs fi us /opt/zimbra/ -T
Overall:
    Device size:                   5.82TiB
    Device allocated:              4.36TiB
    Device unallocated:            1.46TiB
    Device missing:                  0.00B
    Used:                          3.05TiB
    Free (estimated):           1010.62GiB      (min: 1010.62GiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

            Data      Metadata  System
Id Path     RAID10    RAID10    RAID10    Unallocated
-- -------- --------- --------- --------- -----------
 1 /dev/sdc 446.25GiB 111.50GiB  32.00MiB   932.63GiB
 2 /dev/sdd 446.25GiB 111.50GiB  32.00MiB   932.63GiB
 3 /dev/sde 446.25GiB 111.50GiB  32.00MiB   932.63GiB
 4 /dev/sdf 446.25GiB 111.50GiB  32.00MiB   932.63GiB
-- -------- --------- --------- --------- -----------
   Total      1.74TiB 446.00GiB 128.00MiB     3.64TiB
   Used       1.49TiB  38.16GiB 464.00KiB
# btrfs fi df /opt/zimbra/
Data, RAID10: total=1.74TiB, used=1.49TiB
System, RAID10: total=128.00MiB, used=464.00KiB
Metadata, RAID10: total=446.00GiB, used=38.19GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


----- On Sep 29, 2021, at 12:31 PM, Zygo Blaxell ce3g8jdj@umail.furryterror.org wrote:

> On Tue, Sep 28, 2021 at 09:23:01PM -0500, Brandon Heisner wrote:
>> I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP
>> Fri Jan 20 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is
> 
> That is a really old kernel.  I recall there were some anomalous
> metadata allocation behaviors with kernels of that age, e.g. running
> scrub and balance at the same time would allocate a lot of metadata
> because scrub would lock a metadata block group immediately after
> it had been allocated, forcing another metadata block group to be
> allocated immediately.  The symptom of that bug is very similar to
> yours--without warning, hundreds of GB of metadata block groups are
> allocated, all empty, during a scrub or balance operation.
> 
> Unfortunately I don't have a better solution than "upgrade to a newer
> kernel", as that particular bug was solved years ago (along with
> hundreds of others).
> 
>> version locked to that kernel.  The metadata has reserved a full
>> 1T of disk space, while only using ~38G.  I've tried to balance the
>> metadata to reclaim that so it can be used for data, but it doesn't
>> work and gives no errors.  It just says it balanced the chunks but the
>> size doesn't change.  The metadata total is still growing as well,
>> as it used to be 1.04 and now it is 1.08 with only about 10G more
>> of metadata used.  I've tried doing balances up to 70 or 80 musage I
>> think, and the total metadata does not decrease.  I've done so many
>> attempts at balancing, I've probably tried to move 300 chunks or more.
>> None have resulted in any change to the metadata total like they do
>> on other servers running btrfs.  I first started with very low musage,
>> like 10 and then increased it by 10 to try to see if that would balance
>> any chunks out, but with no success.
> 
> Have you tried rebooting?  The block groups may be stuck in a locked
> state in memory or pinned by pending discard requests, in which case
> balance won't touch them.  For that matter, try turning off discard
> (it's usually better to run fstrim once a day anyway, and not use
> the discard mount option).
> 
>> # /sbin/btrfs balance start -musage=60 -mlimit=30 /opt/zimbra
>> Done, had to relocate 30 out of 2127 chunks
>> 
>> I can do that command over and over again, or increase the mlimit,
>> and it doesn't change the metadata total ever.
> 
> I would use just -m here (no filters, only metadata).  If it gets the
> allocation under control, run 'btrfs balance cancel'; if it doesn't,
> let it run all the way to the end.  Each balance starts from the last
> block group, so you are effectively restarting balance to process the
> same 30 block groups over and over here.
> 
>> # btrfs fi show /opt/zimbra/
>> Label: 'Data'  uuid: ece150db-5817-4704-9e84-80f7d8a3b1da
>>         Total devices 4 FS bytes used 1.48TiB
>>         devid    1 size 1.46TiB used 1.38TiB path /dev/sde
>>         devid    2 size 1.46TiB used 1.38TiB path /dev/sdf
>>         devid    3 size 1.46TiB used 1.38TiB path /dev/sdg
>>         devid    4 size 1.46TiB used 1.38TiB path /dev/sdh
>> 
>> # btrfs fi df /opt/zimbra/
>> Data, RAID10: total=1.69TiB, used=1.45TiB
>> System, RAID10: total=64.00MiB, used=640.00KiB
>> Metadata, RAID10: total=1.08TiB, used=37.69GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>> 
>> 
>> # btrfs fi us /opt/zimbra/ -T
>> Overall:
>>     Device size:                   5.82TiB
>>     Device allocated:              5.54TiB
>>     Device unallocated:          291.54GiB
>>     Device missing:                  0.00B
>>     Used:                          2.96TiB
>>     Free (estimated):            396.36GiB      (min: 396.36GiB)
>>     Data ratio:                       2.00
>>     Metadata ratio:                   2.00
>>     Global reserve:              512.00MiB      (used: 0.00B)
>> 
>>             Data      Metadata  System
>> Id Path     RAID10    RAID10    RAID10    Unallocated
>> -- -------- --------- --------- --------- -----------
>>  1 /dev/sde 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>>  2 /dev/sdf 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>>  3 /dev/sdg 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>>  4 /dev/sdh 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>> -- -------- --------- --------- --------- -----------
>>    Total      1.69TiB   1.08TiB  64.00MiB     3.05TiB
>>    Used       1.45TiB  37.69GiB 640.00KiB
>> 
>> 
>> 
>> 
>> 
>> 
>> --
>> Brandon Heisner
>> System Administrator
> > Wolfram Research
