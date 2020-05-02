Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B981C23EF
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgEBHxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 03:53:14 -0400
Received: from aarghimedes.fi ([92.223.105.234]:48636 "EHLO aarghimedes.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgEBHxN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 03:53:13 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 May 2020 03:53:13 EDT
Received: from [192.168.2.148] (77-246-193-133.cust.suomicom.net [77.246.193.133])
        by aarghimedes.fi (Postfix) with ESMTPSA id 786041FF71
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 07:43:15 +0000 (UTC)
Subject: Re: Extremely slow device removals
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org>
 <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
From:   Jukka Larja <roskakori@aarghimedes.fi>
Message-ID: <9b17cb65-1772-52b0-5b30-bfa890fbe83a@aarghimedes.fi>
Date:   Sat, 2 May 2020 10:43:15 +0300
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fi; rv:1.8.1.23)
 Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
In-Reply-To: <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Phil Karn kirjoitti 2.5.2020 klo 10.20:

> So I'm trying to figure out the advantage of including RAID 1 inside
> btrfs instead of just running it over a conventional (fs-agnostic)
> RAID subsystem.
> 
> I was originally really intrigued by the idea of integrating RAID into
> the file system since it seemed like you could do more that way, or at
> least do things more efficiently. For example, when adding or
> replacing a mirror you'd only have to copy those parts of the disk
> that actually contain data. That promised better performance. But if
> those actually-used blocks are copied in small pieces and in random
> order so the operation is far slower than the logical equivalent of
> "dd if=disk1 of=disk2', then what's left?
> 
> Even the ability to use drives of different sizes isn't unique to
> btrfs. You can use LVM to concatenate smaller volumes into larger
> logical ones.

 From the point of view of someone who has set up mdadm just twice and at 
both times needed to start again at some point, due to messing something up, 
I think one great point of Btrfs is ease of setting up. That's especially 
true when adding or deleting disks semi regularly. I don't have any 
experience with LVM, but adding it to the mix will probably complicate 
things more.

There are, of course, lot of more or less "edge cases" that require knowing 
things, or doing sufficient research before proceding. Like using replace 
instead of add+delete. And if add+delete is requires (I recently replaced 
6x4TB disks with 2x16TB in an array that also has 2x10TB and 2x8TB disk), 
it's better to resize deleted disk in small increments instead of just 
deleting (and I think adding some balance would help too, though I came up 
with the idea too late), to avoid lot of unnecessary rewrites during delete, 
and getting stuck with long running operation that can't be cancelled.

-- 
      ...Elämälle vierasta toimintaa...
     Jukka Larja, Roskakori@aarghimedes.fi

<saylan> I just set up port forwards to defense.gov
<saylan> anyone scanning me now will be scanning/attacking the DoD :D
<renderbod> O.o
<bolt> that's... not exactly how port forwarding works
<saylan> ?
- Quote Database, http://www.bash.org/?954232 -
