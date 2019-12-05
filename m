Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB41138DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 01:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfLEAeQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 4 Dec 2019 19:34:16 -0500
Received: from [185.35.77.55] ([185.35.77.55]:36114 "EHLO mail.megacandy.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfLEAeQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 19:34:16 -0500
Received: from [IPv6:::1] (unknown [185.35.77.55])
        (Authenticated sender: gardv@megacandy.net)
        by mail.megacandy.net (Postfix) with ESMTPSA id 564B342BD04;
        Thu,  5 Dec 2019 00:34:14 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Unrecoverable corruption after loss of cache
From:   Gard Vaaler <gardv@megacandy.net>
In-Reply-To: <CAJCQCtQW+-VyATVzi47vtBvN34Ev8j704tiQDVZKxHqT15qccw@mail.gmail.com>
Date:   Thu, 5 Dec 2019 01:34:13 +0100
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0CE6AC6A-3D42-44E3-AA9F-AF05AF68897C@megacandy.net>
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
 <F7C74BD8-4505-4E74-81F2-EB0D603ABCEC@megacandy.net>
 <CAJCQCtRA2+X-ke4yJ4H8o49ZA9mSOFabLpNeXd=4ULDg99rFgQ@mail.gmail.com>
 <B154F1B0-C80A-4E7E-B105-B0E654279E28@megacandy.net>
 <CAJCQCtQW+-VyATVzi47vtBvN34Ev8j704tiQDVZKxHqT15qccw@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> 4. des. 2019 kl. 22:09 skrev Chris Murphy <lists@colorremedies.com>:
> There's a decent chance this is the cause of the problem. That kernel
> does not have the fix for this bug:
> https://www.spinics.net/lists/stable-commits/msg129532.html
> https://bugzilla.redhat.com/show_bug.cgi?id=1751901
> 
> As far as I'm aware the corruption isn't fixable. You might still be
> able to mount the file system ro to get data out; if not then decent
> chance you can extract data with btrfs restore, which is an offline
> scraping tool, but it is a bit tedious to use.
> https://btrfs.wiki.kernel.org/index.php/Restore

That was my first thought too, but it seems too coincidental that I should happen across this bug at the same instant as my cache device failing. btrfs-restore doesn't like my filesystem either:

> [liveuser@localhost-live btrfs-progs-5.4]$ sudo ./btrfs restore -Divvv /dev/bcache0 /mnt
> This is a dry-run, no files are going to be restored
> parent transid verify failed on 3719816445952 wanted 317513 found 313040
> parent transid verify failed on 3719816445952 wanted 317513 found 308297
> parent transid verify failed on 3719816445952 wanted 317513 found 313040
> Ignoring transid failure
> leaf parent key incorrect 3719816445952
> Error searching -1

-- 
Gard

