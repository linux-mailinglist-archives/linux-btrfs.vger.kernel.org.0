Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAA7B307D
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfIOOS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 10:18:59 -0400
Received: from know-smtprelay-omd-1.server.virginmedia.net ([81.104.62.33]:51474
        "EHLO know-smtprelay-omd-1.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIOOS6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 10:18:58 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id 9VMeirAOoGidz9VMfiLCSR; Sun, 15 Sep 2019 15:18:57 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=NKf7BXyg c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=IkcTkHD0fZMA:10 a=UgpSWtyZgIMHUQXiKg4A:9
 a=QEXdDO2ut3YA:10
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Pete <pete@petezilla.co.uk>
Subject: Backup and send/receive between machines with differing kernel
 versions
Message-ID: <f709150a-a553-a230-a755-5ea26227ff8d@petezilla.co.uk>
Date:   Sun, 15 Sep 2019 15:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB/DyWYnkibJgNO7Wvf/QPGgAeYLgsl9BQV752vUE5MFh0/BXDyVDbMrw0PRFmUWZ/s8gVWF4D60H7tqbBmZlA79PIdAt1ztj7Q8RBF9W4R/J0D1WjU+
 hB5fsy0u/I5oWUe8uPkvTQCE/N0Q6ycmnT4pwhSpQRjsbFhRjuxuuf23xWfOU9ah3Q5ykhV8BQY70w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm looking at turning an old PC into a backup server / NAS.  I could
have been bitten by the recent regression if it had caused issue with my
backup USB drive which is also using btrfs.

If I am running a recent 5.1x or 5.2.x kernel on my main machine and the
backup/NAS machine is running 4.19.72 (or later) I have two questions:

1.	Will the difference in version be likely to cause issues?
	
2.	If there are issues with the file system on the main machine
	can send/receive possibly propagate them to the backup machine
	thus damaging the backup? If so rsync would be safer at the
	expense of speed, I would assume?

My motivation is that if I am using a kernel from an older series on the
backup machine it I'd be less likely to be hit by any regression on the
main machine and the backup machine at the same time.

For context this is home use, so 2 x 6TB drives, RAID1, on the main machine.

thanks,

Pete
