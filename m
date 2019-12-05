Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53A113A41
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 04:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfLEDPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 22:15:34 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46946 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfLEDPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 22:15:34 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id 685DB50D7EE;
        Wed,  4 Dec 2019 22:15:33 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1ichc5-0007qj-8Q; Wed, 04 Dec 2019 22:15:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH v2] btrfs-progs: scrub: add start/end position for scrub
Date:   Wed,  4 Dec 2019 22:15:22 -0500
Message-Id: <20191205031523.11593-1-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2 changes:

So far this patch has had one user, who reported a bug:  the manual
page for btrfs scrub said the start/end position arguments were extent
bytenr aka logical addresses, when they are in fact device offset aka
physical addresses.

Removed the sanity question at the top of the cover text as this patch
has now seen real use.  Made some minor changes to the example procedure.

Summary:

This patch adds start (-s) and end (-e) position arguments to 'btrfs
scrub start', to enable focusing a scrub on specific areas of a device.
The positions are offsets from the start of the device.

The idea is that if you have a disk with a lot of errors, you do a
loop of:

        - start a scrub at the beginning of the disk
        - get some read/uncorrectable errors in dmesg
        - cancel scrub, or use -e to scrub in 1G increments
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



