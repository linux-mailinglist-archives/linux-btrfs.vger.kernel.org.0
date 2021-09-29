Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE66741C6BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245595AbhI2OgL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 10:36:11 -0400
Received: from relay.wolfram.com ([140.177.205.37]:51296 "EHLO
        relay-ext.wolfram.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbhI2OgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 10:36:10 -0400
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
        by relay-ext.wolfram.com (Postfix) with ESMTPS id AE8544D9;
        Wed, 29 Sep 2021 09:34:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com AE8544D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
        t=1632926066; bh=Ku8ub4p55HKl4YNEZ1tDqwQx/yEqo11HWDmVNy5en+Q=;
        h=Date:From:Reply-To:To:Cc:In-Reply-To:References:From;
        b=BMdiP3xXCfRdJreLyO9Fd4av+f3DdpUabz+xJdvG+lRobiMQPiuWRaLNob7ie8h0N
         0j9VZWa4uNzmEGsZoIt9Xn0ugM/iE23juNmnOx3cQeAOOTINp1mW/b4qJgIc9NFyhP
         /vgaKsCTHqU6y+iWciaf7Dbc/mnw1QN/XExRkmKg=
Received: from wrimail05.wolfram.com (wrimail05.wolfram.com [10.128.1.216])
        by relay-10-128.wolfram.com (Postfix) with ESMTPS id AA50430004E;
        Wed, 29 Sep 2021 09:34:26 -0500 (CDT)
Received: from wrimail05.wolfram.com (localhost [127.0.0.1])
        by wrimail05.wolfram.com (Postfix) with ESMTPS id A5DCD1A0B06;
        Wed, 29 Sep 2021 09:34:26 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by wrimail05.wolfram.com (Postfix) with ESMTP id 859FB1A0B0E;
        Wed, 29 Sep 2021 09:34:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail05.wolfram.com 859FB1A0B0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
        s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1632926066;
        bh=93taStzkQFr33zpneygAofbIR8J8KVzhFXc1gnwwYE4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=d/mrC9sZWWZUigI/JwKL9ba8PyoPCF00py2RTy7RX1B+yNR1OuvypteibJMoeYGFK
         MS8b5R1t3z/4lqiK2UypgA6NCgeqyFtNpTOHbU3oopnXX8AFsf5RDAgqNCvqPaohYp
         ZvtFpF3slhE0PILWp1K0VizFcGhCTFYe9cZ3OI5o9FeK5hRJcu3WIAC49/yM3dvuVP
         n3cvm/jmY2lViIiPgs9F7l2qDCduq9iMLTUy0QHS1XM+muZ0A2v2J0c546+ZcjBUT+
         46ONc7qY30GO8PHoT4FfMReoGoNnwznTwBQ9DnP5SjFxUkG9g1HGr5TmqTTKNndTki
         mZGS9rBKG390Q==
Received: from wrimail05.wolfram.com ([127.0.0.1])
        by localhost (wrimail05.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8PbAht0Uu4WL; Wed, 29 Sep 2021 09:34:26 -0500 (CDT)
Received: from wrimail05.wolfram.com (wrimail05.wolfram.com [10.128.1.216])
        by wrimail05.wolfram.com (Postfix) with ESMTP id 746641A0B06;
        Wed, 29 Sep 2021 09:34:26 -0500 (CDT)
Date:   Wed, 29 Sep 2021 09:34:26 -0500 (CDT)
From:   Brandon Heisner <brandonh@wolfram.com>
Reply-To: brandonh@wolfram.com
To:     Forza <forza@tnonline.net>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <2117366261.1733598.1632926066120.JavaMail.zimbra@wolfram.com>
In-Reply-To: <ce9f317.4dc05cb0.17c3070258f@tnonline.net>
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com> <ce9f317.4dc05cb0.17c3070258f@tnonline.net>
Subject: Re: btrfs metadata has reserved 1T of extra space and balances
 don't reclaim it
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.99.92.75]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4059)
Thread-Topic: btrfs metadata has reserved 1T of extra space and balances don't reclaim it
Thread-Index: PBSqSArqsmg4p7J3awQ8tr7S4duJjQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No I do not use that option.  Also, because of btrfs not mounting individual subvolume options, I have the compression and nodatacow set with filesystem attributes on the directories that are btrfs subvolumes.

UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra           btrfs   subvol=zimbra,defaults,discard,compress=lzo 0 0
UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /var/log              btrfs   subvol=root-var-log,defaults,discard,compress=lzo 0 0
UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/db        btrfs   subvol=db,defaults,discard,nodatacow 0 0
UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/index     btrfs   subvol=index,defaults,discard,compress=lzo 0 0
UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/store     btrfs   subvol=store,defaults,discard,compress=lzo 0 0
UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/log       btrfs   subvol=log,defaults,discard,compress=lzo 0 0
UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/snapshots btrfs   subvol=snapshots,defaults,discard,compress=lzo 0 0




----- On Sep 29, 2021, at 2:23 AM, Forza forza@tnonline.net wrote:

> ---- From: Brandon Heisner <brandonh@wolfram.com> -- Sent: 2021-09-29 - 04:23
> ----
> 
>> I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP Fri Jan 20
>> 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is version locked to that
>> kernel.  The metadata has reserved a full 1T of disk space, while only using
>> ~38G.  I've tried to balance the metadata to reclaim that so it can be used for
>> data, but it doesn't work and gives no errors.  It just says it balanced the
>> chunks but the size doesn't change.  The metadata total is still growing as
>> well, as it used to be 1.04 and now it is 1.08 with only about 10G more of
>> metadata used.  I've tried doing balances up to 70 or 80 musage I think, and
>> the total metadata does not decrease.  I've done so many attempts at balancing,
>> I've probably tried to move 300 chunks or more.  None have resulted in any
>> change to the metadata total like they do on other servers running btrfs.  I
>> first started with very low musage, like 10 and then increased it by 10 to try
>> to see if that would balance any chunks out, but with no success.
>> 
>> # /sbin/btrfs balance start -musage=60 -mlimit=30 /opt/zimbra
>> Done, had to relocate 30 out of 2127 chunks
>> 
>> I can do that command over and over again, or increase the mlimit, and it
>> doesn't change the metadata total ever.
>> 
>> 
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
>> Wolfram Research
> 
> 
> What are you mount options? Do you by any chance use metadata_ratio mount
> option?
> 
> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)#MOUNT_OPTIONS
