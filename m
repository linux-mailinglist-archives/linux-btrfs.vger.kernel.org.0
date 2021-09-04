Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62507400B6C
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhIDNDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Sep 2021 09:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhIDNDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Sep 2021 09:03:19 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0729C061575
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Sep 2021 06:02:17 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a07:2600:4496:b139:ff3b:5dc0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 588672B459D;
        Sat,  4 Sep 2021 15:02:14 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Duncan <1i5t5.duncan@cox.net>
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption errors
Date:   Sat, 04 Sep 2021 15:02:11 +0200
Message-ID: <5034273.TbR5U6c5FD@ananda>
In-Reply-To: <20210831194501.175dadf1@ws>
References: <20210831194501.175dadf1@ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Duncan.

Duncan - 01.09.21, 04:45:01 CEST:
> Martin Steigerwald posted on Sun, 22 Aug 2021 13:14:39 +0200 as
> 
> excerpted:
> > This might be a sequel of:
> > 
> > Corruption errors on Samsung 980 Pro
> > 
> > https://lore.kernel.org/linux-btrfs/2729231.WZja5ltl65@ananda/
> 
> I saw on the previous thread some discussion of trim/discard but lost
> track of whether you're still trying to enable it in the mount options
> or not.

I have it enabled for the Samsung 980 Pro, but still disabled for the 
Samsung 860 SSD. Which it seems makes sense, considering:

Samsung 860/870 SSDs Continue Causing Problems For Linux Users

https://www.phoronix.com/scan.php?page=news_item&px=Samsung-860-870-More-Quirks

I may just avoid those drives for the future.

> I'd suggest *NOT* enabling trim/discard on any samsung SSDs unless you
> are extremely confident that it is well tested and known to work on
> your particular model, because...

Well, after I do not hibernate the ThinkPad T14 AMD Gen 1 anymore, I had 
no issues again.

> Now it's quite possible that your newer 980 pro model handles
> queued-trim properly, but it's also possible that it still doesn't,
> while the kernel blacklist might have been updated assuming it does,
> or that the blacklist isn't applying for some reason. And given that
> you're seeing problems, probably better safe than sorry. I'd leave
> discard disabled.

Well, you could be right there. But since I did have no issues again, 
queued trims may just work with Samsung 980 Pro.

> Another consideration for btrfs is the older root-blocks that are not
> normally immediately overwritten, that thus remain available to use
> for repair/recovery should that be necessary.   Because they're
> technically no longer in use the discard mount option clears these
> along with other unused blocks, so they're no longer an option for
> repair/recover. =:^(

Hmmm, that is an interesting consideration for using fstrim -av with a 
cron job and in case of a corruption hope that it was not just at the 
time the cron job triggered.

However, I do tend to eventually put another 42 mm m2 SSD into the 
laptop and thus skip adding a 4G modem to it. Then I could protect 
critical data with BTRFS RAID1 or BTRFS send/receive or hourly backups. 
Actually BTRFS RAID1 prevented me from data loss with the old ThinkPad 
T520 where there were checksum errors after sudden power loss on Crucial 
m500 mSATA SSD.

> The alternative (beyond possibly deliberately leaving some
> unpartitioned free-space for the ssd wear-leveling algorithm to work
> with, in addition to the unreported space it already reserves for
> that purpose) is fstrim.

I always leave some space for that as long as I still have some left. At 
the moment I have plenty of space left. I think I will remove 300G 
homedefect LV soon enough in case no BTRFS developer wants some other 
debug data from the defective filesystem.

> At least on my systemd-option gentoo, there's a weekly fstrim
> scheduled (see fstrim.service and fstrim.timer, owned by the
> util-linux package), tho I don't recall whether I had to enable it or
> whether it was enabled automatically.

No systemd here, however I can do a cron job.

Well as it works at the moment as long as I avoid hibernate, I think I 
keep it that way. And since with Linux 5.14 the deeper sleep state 
(S0ix), labeled as "Windows 10" mode in firmware settings, seems to work 
well enough. I'd still prefer true hibernation, but it is just not 
stable enough on this machine at the moment.

Best,
-- 
Martin


