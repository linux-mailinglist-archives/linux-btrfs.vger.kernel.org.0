Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C97139D6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 00:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgAMXiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 18:38:19 -0500
Received: from trent.utfs.org ([94.185.90.103]:39456 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgAMXiT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 18:38:19 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 30E4860055;
        Tue, 14 Jan 2020 00:38:18 +0100 (CET)
Date:   Mon, 13 Jan 2020 15:38:18 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Chris Murphy <lists@colorremedies.com>
cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: file system full on a single disk?
In-Reply-To: <CAJCQCtShpdS81pvc1m26yPmriaE7_3=MZTFkbXknp9+Wehwr5w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.99999.375.2001131532180.21037@trent.utfs.org>
References: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org> <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com> <alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org>
 <CAJCQCtShpdS81pvc1m26yPmriaE7_3=MZTFkbXknp9+Wehwr5w@mail.gmail.com>
User-Agent: Alpine 2.21.99999 (DEB 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 13 Jan 2020, Chris Murphy wrote:
> > Well, I received some ENOSPC notifications from various apps, so it was a
> > real problem.
> 
> Oh it's a real problem and a real bug. But the file system itself is OK.

Ah, OK. Good to know.

> > For now, the balancing "helped", but the fs still shows only 391 GB
> > allocated from the 924 GB device:

The first "balance start --full-balance /" finshed, with the following 
message, of course:

   ERROR: error during balancing '/': No space left on device

But afterwards at least "df" was happy and reported 48% usage again. While 
writing the last email I started another "balance start --full-balance /" 
to balance the extents that could not be balanced before because the file 
system was at 100%. But this failed with the same message and now I'm back 
to square one:

=============================================================
# btrfs filesystem df -h /
Data, single: total=391.00GiB, used=386.38GiB
System, single: total=32.00MiB, used=80.00KiB
Metadata, single: total=2.00GiB, used=1.55GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# df -h /
Filesystem             Size  Used Avail Use% Mounted on
/dev/mapper/luks-root  825G  389G     0 100% /
=============================================================

Sigh. I can't reboot right now, will do later on and will try another 
balance now.

> A less janky option is to use 5.3.18, or grab 5.5.0-rc6 from koji.
> I've been using 5.5.0 for a while for other reasons (i915 gotchas),
> and the one Btrfs bug I ran into related to compression has been fixed
> as of rc5.
> 
> https://koji.fedoraproject.org/koji/buildinfo?buildID=1428886

OK, thanks for the hint, I'll do that in a few hours when I'm able to 
reboot.

Thanks,
Christian.
-- 
BOFH excuse #69:

knot in cables caused data stream to become twisted and kinked
