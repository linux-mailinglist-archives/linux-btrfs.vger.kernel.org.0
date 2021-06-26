Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899203B4BB8
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 02:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFZA4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 20:56:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44488 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZA4g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 20:56:36 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 096421FF5C;
        Sat, 26 Jun 2021 00:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624668854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=If1lGVvTTy1mMve5v/f1OW4gM6c9qmSkqDESDLtyHqs=;
        b=SjiknnsUNVjICytBz3ka48tYcKip5ZAYGJzfWsw5lRr8qdToari5DSlTDHIGgK2v436wU7
        FF8g4kuq+1F45mIQVHmh78vPLPpM9jy+N/vuzJ5iwF7i9J/IQjQeiBDZCBhL17HxJLO8pY
        Ej0X+lFhIFuRhTpY8zWFBqQ3bGc0/Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624668854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=If1lGVvTTy1mMve5v/f1OW4gM6c9qmSkqDESDLtyHqs=;
        b=Ji+R9xh/0FWAFTIbhTteyy15Q8MorWHiY0P6k45YZnS18YBaSyJNJofg/FcZo29NIGuHyY
        ocPxX7L/mbwfItCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id AD26B118DD;
        Sat, 26 Jun 2021 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624668853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=If1lGVvTTy1mMve5v/f1OW4gM6c9qmSkqDESDLtyHqs=;
        b=wh93Y7yvzlU5XQrOfvurCNxUardrc/SUJwYmx98m0qFWvMo1PYz68B1d5x6zdj2aGlUX58
        k7asZPRpXyayB8zeXJoZ6W4dlnZCpcb5Il7E5QusO9anqWFW/Cp81WC78map07xuuIkWLV
        CHksUCyUBWD6q0qaziC5zCIbJMnNHSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624668853;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=If1lGVvTTy1mMve5v/f1OW4gM6c9qmSkqDESDLtyHqs=;
        b=lZ+K9UmSwfe3VfVSk3AByt7eThUiRum0BI4/kpG670gxRxKHM4UUaFwBmrBeDCxKmMLZWx
        Lr5GdFIVFM45VSCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id w/AZF7R61mAWeQAALh3uQQ
        (envelope-from <neilb@suse.de>); Sat, 26 Jun 2021 00:54:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Martin Steigerwald" <martin@lichtvoll.de>
Cc:     linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search Baloo
In-reply-to: <41661070.mPYKQbcTYQ@ananda>
References: <41661070.mPYKQbcTYQ@ananda>
Date:   Sat, 26 Jun 2021 10:54:09 +1000
Message-id: <162466884942.28671.6997551060359774034@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 26 Jun 2021, Martin Steigerwald wrote:
> Hi!
> 
> I found repeatedly that Baloo indexes the same files twice or even more 
> often after a while.
> 
> I reported this upstream in:
> 
> Bug 438434 - Baloo appears to be indexing twice the number of files than 
> are actually in my home directory 
> 
> https://bugs.kde.org/show_bug.cgi?id=438434
> 
> And got back that if the device number changes, Baloo will think it has 
> new files even tough the path is still the same. And found over time that 
> the device number for the single BTRFS filesystem on a NVMe SSD in a 
> ThinkPad T14 Gen1 AMD can change. It is not (maybe yet) RAID 1. I do 
> have BTRFS RAID 1 in another laptop and there I also had this issue 
> already.
> 
> I argued that a desktop application has no business to rely on a device 
> number and got back that search/indexing is in the middle between an 
> application and system software.

NO SOFTWARE can rely on device numbers being stable in Linux.  Not
desktop, not system, not anything.  They are stable while the device is
in use (e.g. while the filesystem is mounted) but can definitely change
on reboot.  This has been the case since about Linux 2.4.

>                                  And that Baloo needs an "invariant" for 
> a file. See comment #11 of that bug report:

That is really hard to provide in general.  Possibly the best approach
is to use the statfs() systemcall to get the "f_fsid" field.  This is
64bits.  It is not supported uniformly well by all filesystems, but I
think it is at least not worse than using the device number.  For a lot
of older filesystems it is just an encoding of the device number.

For btrfs, xfs, ext4 it is much much better.

NeilBrown


> 
> https://bugs.kde.org/show_bug.cgi?id=438434#c11
> 
> I got the suggestion to try to find a way to tell the kernel to use a 
> fixed device number. 
> 
> I still think, an application or an infrastructure service for a desktop 
> environment or even anything else in user space should not rely on a 
> device number to be fixed and never change upon reboots.
> 
> But maybe you have a different idea about that and it is okay for an 
> userspace component to do that. I would like to hear your idea about 
> that.
> 
> Another question would be whether I could somehow make sure that the 
> device number does not change, even if just as a work-around. I know for 
> NFS there is a fsid= mount option, but it does not appear to be 
> something generic, at least the mount man page seems to have nothing 
> related to fsid.
> 
> 
> Best,
> -- 
> Martin
> 
> 
> 
