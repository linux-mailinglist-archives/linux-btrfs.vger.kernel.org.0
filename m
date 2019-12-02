Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9107B10E4E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 04:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLBDoa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 22:44:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40960 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfLBDoa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Dec 2019 22:44:30 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id 75339505D66;
        Sun,  1 Dec 2019 22:44:29 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1ibcdR-0006rR-8c; Sun, 01 Dec 2019 22:44:29 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 0/1] btrfs-progs: scrub: add start/end position for scrub
Date:   Sun,  1 Dec 2019 22:44:19 -0500
Message-Id: <20191202034420.4634-1-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch has some problems that will be a lot of work to fix, and
before doing any of that I thought I would check to see if anyone else
thinks the idea is sane.

This patch just adds start (-s) and end (-e) position arguments to 'btrfs
scrub start', to enable focusing a scrub on specific areas of a device.
The positions are offsets from the start of the device.

The idea is that if you have a disk with a lot of errors, you do a
loop of:

	- start a scrub at the beginning of the disk
	- get some read/uncorrectable errors in dmesg
	- cancel scrub
	- fix the errors (delete/replace files)
	- restart scrub at just before the offset of the first error
	- repeat from step 2

The last steps use the '-s' option to skip over parts of the disk that
have already been scrubbed.  Each pass starts reading just before the
first detected error in the previous pass to confirm that all references
to the offending data blocks have been removed from the filesystem.

Without these options, the process looks like this:

	- start a scrub at the beginning of the disk
	- get a random sample of read/uncorrectable errors in dmesg
	- wait for scrub to end
	- fix the errors (delete/replace files)
	- repeat from step 1

The current approach need a full scrub to be repeated many times, because
only a small percentage of a large number of errors will be sampled on
each pass due to dmesg ratelimiting.

It is possible to cancel the scrub, edit /var/lib/btrfs/scrub.status.*,
change the "last_physical" field to the desired start position, and then
resume the scrub to achieve a similar effect to this patch, but that's
somewhat ugly.

TODO:

This patch does nothing to correct the "Total bytes to scrub" or
"ETA" fields in various outputs, which are very wrong when the new
-s and -e options are used.  Fixing that will require joining the
device tree with block groups to estimate how many bytes will be
scrubbed.  Alternatively, we could just disable the ETA/TBS fields
in the status output when -s or -e are used.




