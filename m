Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2807123F8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 19:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfETRzD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 20 May 2019 13:55:03 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:11992 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfETRzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 13:55:02 -0400
Received: from [94.217.151.102] (helo=[192.168.177.20])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hSmV2-00065V-1P
        for linux-btrfs@vger.kernel.org; Mon, 20 May 2019 19:55:00 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Fw: Re[2]: [Samba] Fw: Btrfs Samba and Quotas
Date:   Mon, 20 May 2019 17:54:58 +0000
Message-Id: <em6f1e2828-e2f1-4aae-8e1b-18a700d198c0@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



------ Weitergeleitete Nachricht ------
Von: "Hendrik Friedel" <hendrik@friedels.name>
An: "Rowland penny" <rpenny@samba.org>; "sambalist" 
<samba@lists.samba.org>; "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Gesendet: 20.05.2019 19:54:13
Betreff: Re[2]: [Samba] Fw: Btrfs Samba and Quotas

Hello,

>Is btrfs becoming more common ?
In my impression: Yes. Also, this problem seems to affect also zfs and 
thus all (?) file systems that support checksums and scrubbing in linux; 
consequently all filesystems that are the choice of users who need this 
for ensuring data consistency.
>You posted this:
>
>I am using Openmediavault (debian based NAS distribution), which is not actively supporting btrfs
>
>It is this that I was referring to.
Ah, yes.
OMV intended to move to btrfs as the only choice with the next version. 
In order to pave the way, I intended to be an early adopter. The problem 
I report here, that there is good reason to.

>> > it just a pain in the a.. Never use it together with quotas or CTDB it
>> > will crash after short time. I only take xfs and have no problem at all.
>> > I don't know wy, but it's not good idea to user brtfs with samba.
>>
>>Well, as long as this is not being reported and being improved, it will remain that way...
>>
>Possibly, but it works great with ext4
Glad to hear that.
>I suggest you sit down with a copy of 'man smb.conf' and remove all the default
My intent is not to solve *my* problem, but to make developers aware of 
this issue and help getting this issue fixed.

I feel a bit helpless though, as I perceive a lack of interest...
I mean... This Bug is now celebrating its 5th aniversary.
https://bugzilla.samba.org/show_bug.cgi?id=10541

Greetings,
Hendrik

