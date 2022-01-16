Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1574148FCBD
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 13:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiAPM17 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 07:27:59 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:21339 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232133AbiAPM16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 07:27:58 -0500
X-Sender-Id: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B6BB18801F7;
        Sun, 16 Jan 2022 12:27:57 +0000 (UTC)
Received: from kamino.krystal.uk (unknown [127.0.0.6])
        (Authenticated sender: 9wt3zsp42r)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6F3B88810B8;
        Sun, 16 Jan 2022 12:27:56 +0000 (UTC)
X-Sender-Id: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
Received: from kamino.krystal.uk (kamino.krystal.uk [77.72.1.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.92.82 (trex/6.4.3);
        Sun, 16 Jan 2022 12:27:57 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
X-MailChannels-Auth-Id: 9wt3zsp42r
X-Arch-Whispering: 7dbe21116122a71d_1642336077441_4156126097
X-MC-Loop-Signature: 1642336077441:1576325135
X-MC-Ingress-Time: 1642336077440
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UCsM5aemLgr+xz5w+AougxUCG1fj7aCk1QzNTNgsr+c=; b=NkI6nQ1PUs13ksLn2TI4c8OQB1
        ZtwWu82vioEASRlxMdUQTLTcEEgN2kXBQmGYonMapt7ouwMNaoC5yubTJBGqmZiY+hQ9MEDmz3DJD
        kCouqOsEtToktTVkns7DU1eUQnHEwmPIzj8wOT2YovnfIYb7qD3rjRURqpQuOppRc517U8N+sYrxX
        kP+tb1TIfrUkEMaOIbD9CL0aAgp4Mc8hVRrIF6lBHS/RbD6ZktxuHSznEKE3m7qjrmBriFpn3fueG
        9PArn6XUkKTNO4pQ8lf8uAHuduLZRQ77Hlm3J3YLvU6fKMpT4qCO7QtvWCgnApykqJ6AGA+wqagt4
        f5swXMHg==;
Received: from cpc75872-ando7-2-0-cust919.15-1.cable.virginm.net ([86.13.79.152]:35754 helo=[172.16.100.1])
        by kamino.krystal.uk with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pete@petezilla.co.uk>)
        id 1n94dW-000K0l-Nx; Sun, 16 Jan 2022 12:27:54 +0000
Message-ID: <706262eb-ee79-5dc7-4aae-132e750b2625@petezilla.co.uk>
Date:   Sun, 16 Jan 2022 12:27:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ENOSPC on file system with nearly empty 12TB drive
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b717a01c-c152-97e9-5485-2f0a95a5d4f5@petezilla.co.uk>
 <CAJCQCtTexbZf0TTPsW1Rd-nmooNvsT+MbT1AYZX66WeDeB-5SA@mail.gmail.com>
 <ed95c0e2-3029-45d0-c039-a275037d8bf4@petezilla.co.uk>
 <CAJCQCtS8DDGXOjZdzvkaMSbVyuG-x1Z5o_fO_u8rOGtE2zKSfA@mail.gmail.com>
From:   Pete <pete@petezilla.co.uk>
In-Reply-To: <CAJCQCtS8DDGXOjZdzvkaMSbVyuG-x1Z5o_fO_u8rOGtE2zKSfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AuthUser: pete@petezilla.co.uk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/22 20:38, Chris Murphy wrote:
> On Fri, Jan 14, 2022 at 4:09 PM Pete <pete@petezilla.co.uk> wrote:
> 
>> Any suggestions?  Just be patient, and hope the balance finishes without
>> ENOSPC?  Go for the remove again.  I'd like to remove a 4TB drive if I
>> can without adding a 6th HD to the system.  Still don't understand why I
>> might need more than one practically empty drive for raid1?
> 
> When bg profile is raid1, any time the file system wants to add
> another block group, it must create a chunk on 2 devices at the same
> time for it to succeed or else you get ENOSPC. The question is why two
> chunks can't be created given all the unallocated space you have even
> without the empty drive.

So although in % terms the drives were very full the > 30GB of free 
space on each ought to have been more than sufficient?

A little care is needed as the ENOSPC did not occur at exactly the time 
I ran btrfs fi show and btrfs fi usage.  So perhaps my post is the the 
most rock solid evidence if there is an issue.  However, I had multiple 
instances of ENOSPC at the time, even after it had spent a few hours 
balancing.


> 
> Ordinarily you want to avoid doing metadata balance. Balancing data is
> ok, it amounts to defragmenting free space, and returning excess into
> unallocated space which can then be used to create any type of block
> group.
> 

OK, but various resources show metadata balance being used when trying 
to sort a ENOSPC issue, e.g.
https://www.suse.com/support/kb/doc/?id=000019789
But there are others that I don't seem to be able to find again. I 
should have noted the URLs when I was trying to sort the issue...


> 
> I don't think the large image file is the problem.
> 
> In my opinion, you've hit a bug. There's plenty of unallocated space
> on multiple drives. I think what's going on is an old bug that might
> not be fixed yet where metadata overcommit is allowed to overestimate
> due to the single large empty drive with a ton of space on it. But
> since the overcommit can't be fulfilled on at least two drives, you
> get ENOSPC even though it's not actually trying to create that many
> block groups at once.
> 

My naive but logical expectation was that balance would start 
aggressively moving data to the empty drive.  Most of the guidance I see 
for recovering from an ENOSPC indicates that adding a single device 
would be sufficient, I do note, however, that if you scroll down and 
read it all, some sites do point this out:

https://wiki.tnonline.net/w/Btrfs/ENOSPC

I also note that the various guides / howtos online are not necessarily 
within the control people who are on this mailing list - I'm not 
implying that the active maintainers are/should be responsible about 
everything written about btrfs online.

My strong recollection from reading this mailing list and when I have 
searched on line was that adding one device only was mentioned for 
managing an ENOSPC issue.  However, from a limited amount of searching 
I'm not sure that I can back the up with references.  Perhaps that is 
just my perception?

Adding the new drive plus a loop device allowed me to progressively 
rebalance using dusage and musage filters until I could start a full 
rebalance without the loop device.

Interestingly, though this array had been running, raid1, for a while 
with four drives, without rebalancing, metadata was only stored on two 
of the drives.


> So what I suggest doing is removing the mostly empty device, and only
> add devices in pairs when using raid1.

Should there be a caveat added to this "For very full btrfs raid1 file 
systems only add devices in at least pairs."?  Being able to add devices 
in a fairly ad hoc manner is a great strength for btrfs.

It seems to be that I am past the point of removing the larger device 
now as I have > 500 GB free on the smaller drives now, have removed the 
loop device and am no longer hitting ENOSPC.  I probably would have to 
start deleting some of my backups to remove the new larger device just 
to that the original 4 device array was not so cripplingly full.

Thank you for your help.


