Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030192E7F2A
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 11:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLaKBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 05:01:11 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:41192 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaKBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 05:01:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 4541F3F713;
        Thu, 31 Dec 2020 11:00:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.728
X-Spam-Level: 
X-Spam-Status: No, score=-2.728 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.829, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7kYnyMGNWRHV; Thu, 31 Dec 2020 11:00:13 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 453913F5D8;
        Thu, 31 Dec 2020 11:00:13 +0100 (CET)
Received: from [192.168.0.10] (port=55566)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1kuuke-0005JF-2e; Thu, 31 Dec 2020 11:00:12 +0100
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        john terragon <jterragon@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
 <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
From:   Forza <forza@tnonline.net>
Message-ID: <4febd23e-94d2-6aa3-8d3f-77731eb83ad0@tnonline.net>
Date:   Thu, 31 Dec 2020 11:00:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020-12-31 08:05, Andrei Borzenkov wrote:
> 30.12.2020 20:39, john terragon пишет:
>> On Wed, Dec 30, 2020 at 6:24 PM sys <system@lechevalier.se> wrote:
>>>
>>>
>>>
>> [...]
>>> You should simply make a 'read-write' snapshot (Y-rw) of the 'read-only'
>>> snapshot (Y) that is part of your backup/send scheme. Do not modify
>>> read-only snapshots to be rw.
>>>
>>
>> OK, but then could I use Y as parent of the rw snapshot, let's call it
>> W, in a send?
> 
> No
> 
>> So I would have this tree where Y is still the root.
>>
>> Y-W
>>   \
>>    Z-X
>>
>> Can I do a send -p Y W ?
> 
> No. All subvolumes used in send/receive must be read-only. And they must
> remain read-only from the moment they are created - we have seen quite a
> lot of reports when users removed read-only property from subvolume used
> in the past as send source, modified it, set as read-only again and
> tried to continue replication. This resulted in complete mess on receive
> side. Also if you try to modify destination snapshots it will break at
> some point.
> 
> The general rule - everything used for replication must remain
> read-only. If you want to use any snapshot that is part of replication
> you clone it and use its clone.
> 
>> Because I thought it was other way around, that is I do a readonly
>> snapshot W of Y and that will be the base for incrementally sending
>> the future modified Y to another  FS (provided of course W is already
>> there).
>>
> 
> If you want to capture changes in W since it was cloned from Y you
> create another read-only snapshot of W and use it.
> 
> btrfs subvolume snapshot -r W V
> btrfs send -p Y V
> 
> It is possible that btrfs implementation is optimized for sequential
> snapshots from the same subvolume so the send stream size will be
> larger. I am not familiar with these low level details. From the naïve
> end-user point of view there should be no difference between
> 
> btrfs subvolume snapshot -r W R1
> btrfs send R1
> modify W
> btrfs subvolume snapshot -r W R2
> btrfs send -p R1 R2
> 
> and
> 
> btrfs send R1
> btrfs subvolume snapshot R1 W
> modify W
> btrfs subvolume snapshot -r W R2
> btrfs send -p R1 R2
> 

I think you are correct. The man page specifies that all snapshots must 
be read-only, but it is rather unclear if you modify some snaps in between.

https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-send

