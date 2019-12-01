Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA110E2C6
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2019 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLARdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 12:33:25 -0500
Received: from [185.35.77.55] ([185.35.77.55]:52246 "EHLO mail.megacandy.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfLARdY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Dec 2019 12:33:24 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 12:33:23 EST
Received: from [192.168.10.160] (26.51-174-238.customer.lyse.net [51.174.238.26])
        (Authenticated sender: gardv@megacandy.net)
        by mail.megacandy.net (Postfix) with ESMTPSA id EA9DB42BD04
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Dec 2019 17:27:10 +0000 (GMT)
From:   Gard Vaaler <gardv@megacandy.net>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_DF951A58-A800-421E-91EC-F817A1E9A397"
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Unrecoverable corruption after loss of cache
Message-Id: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
Date:   Sun, 1 Dec 2019 18:27:09 +0100
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Apple-Mail=_DF951A58-A800-421E-91EC-F817A1E9A397
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Trying to recover a filesystem that was corrupted by losing writes due =
to a failing caching device, I get the following error:
> ERROR: child eb corrupted: parent bytenr=3D2529690976256 item=3D0 =
parent level=3D2 child level=3D0

Trying to zero the journal or reinitialising the extent tree yields the =
same error. Is there any way to recover the filesystem? Relevant logs =
attached.


--Apple-Mail=_DF951A58-A800-421E-91EC-F817A1E9A397
Content-Disposition: attachment;
	filename=btrfs
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="btrfs"
Content-Transfer-Encoding: 7bit

[liveuser@localhost-live btrfs-progs-5.3.1]$ ./btrfs --version
btrfs-progs v5.3.1 
[liveuser@localhost-live btrfs-progs-5.3.1]$ sudo ./btrfs check /dev/bcache0
Opening filesystem to check...
parent transid verify failed on 2529691090944 wanted 319147 found 314912
parent transid verify failed on 2529691090944 wanted 319147 found 310171
parent transid verify failed on 2529691090944 wanted 319147 found 314912
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=2529690976256 item=0 parent level=2 child level=0
ERROR: cannot open file system
[liveuser@localhost-live btrfs-progs-5.3.1]$ sudo ./btrfs rescue zero-log /dev/bcache0
parent transid verify failed on 2529691090944 wanted 319147 found 314912
parent transid verify failed on 2529691090944 wanted 319147 found 310171
parent transid verify failed on 2529691090944 wanted 319147 found 314912
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=2529690976256 item=0 parent level=2 child level=0
ERROR: could not open ctree

--Apple-Mail=_DF951A58-A800-421E-91EC-F817A1E9A397
Content-Disposition: attachment;
	filename=dmesg
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg"
Content-Transfer-Encoding: 7bit

[  207.230521] BTRFS info (device bcache1): disk space caching is enabled
[  207.230526] BTRFS info (device bcache1): has skinny extents
[  207.478890] BTRFS error (device bcache1): parent transid verify failed on 2529691090944 wanted 319147 found 310171
[  207.491729] BTRFS error (device bcache1): parent transid verify failed on 2529691090944 wanted 319147 found 314912
[  207.491741] BTRFS error (device bcache1): failed to read block groups: -5
[  207.503087] BTRFS error (device bcache1): open_ctree failed


--Apple-Mail=_DF951A58-A800-421E-91EC-F817A1E9A397
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



-- 
Gard


--Apple-Mail=_DF951A58-A800-421E-91EC-F817A1E9A397--
