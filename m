Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E767596B2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfHTVKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 17:10:30 -0400
Received: from phi.wiserhosting.co.uk ([77.245.66.218]:36010 "EHLO
        phi.wiserhosting.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTVKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 17:10:30 -0400
X-Greylist: delayed 2009 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 17:10:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vsPKe9pjSfIUu5kNid1tj10Ld/NGc8zYWDctbDPzTgc=; b=IZZYmDWuDavIEVdL/Ml6238YXq
        viCpeXvxF/FiKfMg0C52fyaVW3IflrzOxs+lBxJHeJiI5IwkX80ef0p122CXMpgKtg98WoLemOcta
        Nsj6EZYFWs0cLXl5tp/ddqDCvpz/iXzManLaAbPzU/OZOd8mAy1KAq1HuCZ7/stfQHQADH4XTCL0B
        4mc6MFULN7biwol0bwl9SYn2dUwgHK48u5tBTdTkaRBuEg7XEavnrZl00vLmpLsnSg8XPBQPZRhff
        wfj6K3wgasV1ezd03FEtL7NqQaWZD7Zo3fFonhzraxHDHVTFhwR+oLvjqYyOtgie4XS4J4o2LvYvw
        BbAeZnBQ==;
Received: from cpc75874-ando7-2-0-cust841.15-1.cable.virginm.net ([86.12.75.74]:54094 helo=[172.16.100.1])
        by phi.wiserhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <pete@petezilla.co.uk>)
        id 1i0AsG-007hXJ-3u
        for linux-btrfs@vger.kernel.org; Tue, 20 Aug 2019 21:37:00 +0100
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Peter Chant <pete@petezilla.co.uk>
Subject: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
Message-ID: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
Date:   Tue, 20 Aug 2019 21:36:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - phi.wiserhosting.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - petezilla.co.uk
X-Get-Message-Sender-Via: phi.wiserhosting.co.uk: authenticated_id: pete+petezilla.co.uk/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: phi.wiserhosting.co.uk: pete@petezilla.co.uk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chasing IO errors.  BTRFS: error (device dm-2) in
btrfs_run_delayed_refs:2907: errno=-5 IO failure


I've just had an odd one.

Over the last few days I've noticed a file system blocking, if that is
the correct term, and this morning go read only.  This resulted in a lot
of checksum errors.

Having spotted the file system go read only in the logs and then noted
the error message in the subject shortly after booting I assumed a
hardware error and changed the SATA cable.  That had no effect so I
isolated the disk and mounted the respective file system degraded.
Shortly after mounting the degraded file system I had the same error
again. So I unmounted the file system edited fstab and swapped the disk
which I though originally had the error with the one now showing an error.

The file system is btrfs, kernel 5.2.9, RAID 1 with three WD reds of 3,
3 and 4 TB.  btrfs is on top of luks.

The original 'blocking' behaviour seemed to manifest itself as I
upgraded the kernel to 5.2.5 or 5.2.7 a day or two ago.  So I tried
5.1.21 to see if that made a difference when the error was showing.  It
did not.  Yesterday I had a backup with rsync, started early in the
morning that should take minutes to complete still running 8h later with
two CPU cores maxed.  Up until I had the file system go read only I had
not noticed anything amiss in the logs, but to be honest, I'd not looked
very hard.

smartctl did not show anything amiss with the drives.

Does this sound like a hardware error?  I have ordered a replacement
drive, if it is not needed as a replacement I will put it into a
homebrew NAS.

I've hit the issue again.  Hopefully the system is up long enough to
post this.

I'm a bit worried that trying to track this down disconnecting a disk at
a time I might hit the btrfs split brain issue.



Pete
