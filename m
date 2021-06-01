Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F883396E9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhFAIRt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 04:17:49 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:21141
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233088AbhFAIRt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Jun 2021 04:17:49 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2021 04:17:48 EDT
X-SMTP-MATCH: 1
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtgHTJ6NMi1EZecBcTvCjsMiBIKoaSvp037?=
 =?us-ascii?q?BL7TEWdfUxSKfzqynApoVi6faZslgssVsb+exoQZPwJU80rKQFhrX5Xo3CYO?=
 =?us-ascii?q?CFghrQEGgK1+KL/9SKIUHDH4BmuJuJGMNFeb/N5TAQt7eY3ODBKbkdKS68gc?=
 =?us-ascii?q?WVuds=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BEAQDO6bVg//3b77ZUBh0BAQEBCQE?=
 =?us-ascii?q?SAQUFAUAJgT0FAQsBg3eOOIklAYJngRWZAQsBAQEBAQEBAQFHAQIEAQGESgS?=
 =?us-ascii?q?CAyY3Bg4CBBUBAQEFAQEBAQEGAwGBBIV1hlksHA+BBU2GC6kVgTSBAYgvgWK?=
 =?us-ascii?q?BOgGOLIFJRIQBhSiGCwSCRoEQgW+BFxy7WIMjgSyQDoxZpVgdu1+Bfk0fGYM?=
 =?us-ascii?q?lTxkOjisWjj4yZwIGCgEBAwlXAYsCAQE?=
X-IPAS-Result: =?us-ascii?q?A2BEAQDO6bVg//3b77ZUBh0BAQEBCQESAQUFAUAJgT0FA?=
 =?us-ascii?q?QsBg3eOOIklAYJngRWZAQsBAQEBAQEBAQFHAQIEAQGESgSCAyY3Bg4CBBUBA?=
 =?us-ascii?q?QEFAQEBAQEGAwGBBIV1hlksHA+BBU2GC6kVgTSBAYgvgWKBOgGOLIFJRIQBh?=
 =?us-ascii?q?SiGCwSCRoEQgW+BFxy7WIMjgSyQDoxZpVgdu1+Bfk0fGYMlTxkOjisWjj4yZ?=
 =?us-ascii?q?wIGCgEBAwlXAYsCAQE?=
X-IronPort-AV: E=Sophos;i="5.83,239,1616428800"; 
   d="scan'208";a="362991664"
Received: from 182-239-219-253.ip.adam.com.au (HELO Nostromo.Underworld) ([182.239.219.253])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 01 Jun 2021 16:06:38 +0800
Date:   Tue, 1 Jun 2021 18:06:21 +1000
From:   Dennis Katsonis <dennisk@netspace.net.au>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: BTRFS 2-disk array with data=single slow writes on first disk.
Message-ID: <YLXqfQHkUv1+a1VF@Nostromo.Underworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


-- 
I have a VANTEC NexStar 2-disk raid enclosure with 2x 2T WD Green disk
drives in it. The enclosure is connected via USB3 and is set to
"individual mode", so that each disk presents itself as a separate
disk to the OS (which is GNU/Linux (Fedora)).

On the disks is a BTRFS filesystem with metadata set as RAID1 and data
as SINGLE.  This has worked well for years, but the problem is that I
now get slow write speeds, specifically on one disk.  Write speeds are
typically 5-15MB/s.  The other disk is faster, at about 50-70MB/s but
still not as fast as what the disks can do.  Reads occur at full
speed, about 170MB/s from both disks.

So when writing, when it writes a 1G chunk on one disk, it averages
about 10-15MB/s, on the other disk it averages about 5x that speed,
then it alternates back and forth.  It's always the same disk POSITION
which is slower.  I have even tried swapping them in the enclosure and
the symptoms don't change.  The disk in the first position is slower.
I have also replaced the two disks with 2 x 500G disks, formatted them
with data=single, metadata=raid1, and that BTRFS filesystem in the
same enclosure worked with fast writes.  This seems to eliminate the
enclosure/USB connection.  Also, we can eliminate the fault being one
disk, as slowdown is based on disk order.

At the start when the filesystem was first created writing files was
fast, close to what the disk could theoretically do, but for some
reason the performance dropped to this level.  Suddenly.  Even more
mysterious, the problem resolved itself for no reason for a while
several months ago, then returned again now.

I have tried various mount options, nssd, nobarrier, turning off
checksums, doing a partial balance (not a full), but nothing has made
a difference so far.  I have verified that the disks are OK, and
hdparm -Tt returns 182MB/s for both disks.  Using the eSATA connection
instead of USB3 makes no difference either.

I am using kernel 5.11.7, but this has persisted with previous
kernels, and also persists with using the built in Fedora kernel
version 5.10.20 (I run a custom kernel).

There are no errors on DMESG, and btrfs-fsck reports nothing unusual.
I am wondering how I might start troubleshooting this to find where
the fault lies, or at what point this slowdown is being introduced.

Thank you,
Dennis
