Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6A3C9AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbfFKLDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 07:03:17 -0400
Received: from atlantic.aurorasky.eu ([80.241.214.27]:50646 "EHLO
        atlantic.aurorasky.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387899AbfFKLDR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 07:03:17 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 07:03:16 EDT
X-BitDefender-CF-Stamp: none
X-BitDefender-SpamStamp: Build: [Engines: 2.15.8.1169, Dats: 588906, Stamp: 3], Multi: [Enabled, t: (0.000059,0.008053)], BW: [Enabled, t: (0.000042), whitelisted: *@winca.de], total: 0(675)
X-Junk-Score: 0 []
X-BitDefender-Spam: No (0)
Received: from localhost (localhost [127.0.0.1])
        by atlantic.aurorasky.eu (Postfix) with ESMTP id 167AD8C0C30
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2019 12:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=winca.de; h=
        message-id:subject:subject:from:from:date:date
        :content-transfer-encoding:content-type:content-type
        :mime-version; s=default; t=1560250401; x=1562064802; bh=rSlhpF7
        MiHiWQKLdWjCldOBSKL1h6XuAY/yk43wU1Pc=; b=KbJtmDxgAowkmHrGEYzrK7x
        s/qLDtV81T4Tymh5nqfOCbFIUXFR8GwvZDSFSYaub9BIUU2jQG76hJnv7LsuVjQa
        blg0PF483lz9gYSNAYI0ryKgiNUwT3azZ7+UXMssrq57ugX5bhjyHdsyp8V/z2hG
        j7+CoIUhLaegLXzsD/1Q=
X-Virus-Scanned: Debian amavisd-new at aurorasky.eu
Received: from atlantic.aurorasky.eu ([127.0.0.1])
        by localhost (vmd14184.contabo.host [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XUC_9JnmWgrq for <linux-btrfs@vger.kernel.org>;
        Tue, 11 Jun 2019 12:53:21 +0200 (CEST)
Received: from aurorasky.eu (localhost [IPv6:::1])
        (Authenticated sender: claudius@winca.de)
        by atlantic.aurorasky.eu (Postfix) with ESMTPSA id 2F6D28C0B9A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2019 12:53:21 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Jun 2019 12:53:21 +0200
From:   claudius@winca.de
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS recovery not possible
Message-ID: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
X-Sender: claudius@winca.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

HI Guys,

you are my last try. I was so happy to use BTRFS but now i really hate 
it....


Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2019 
x86_64 x86_64 x86_64 GNU/Linux
btrfs-progs v4.15.1

btrfs fi show
Label: none  uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
         Total devices 1 FS bytes used 4.58TiB
         devid    1 size 7.28TiB used 4.59TiB path /dev/mapper/volume1


dmesg

[57501.267526] BTRFS info (device dm-5): trying to use backup root at 
mount time
[57501.267528] BTRFS info (device dm-5): disk space caching is enabled
[57501.267529] BTRFS info (device dm-5): has skinny extents
[57507.511830] BTRFS error (device dm-5): parent transid verify failed 
on 2069131051008 wanted 4240 found 5115
[57507.518764] BTRFS error (device dm-5): parent transid verify failed 
on 2069131051008 wanted 4240 found 5115
[57507.519265] BTRFS error (device dm-5): failed to read block groups: 
-5
[57507.605939] BTRFS error (device dm-5): open_ctree failed


btrfs check /dev/mapper/volume1
parent transid verify failed on 2069131051008 wanted 4240 found 5115
parent transid verify failed on 2069131051008 wanted 4240 found 5115
parent transid verify failed on 2069131051008 wanted 4240 found 5115
parent transid verify failed on 2069131051008 wanted 4240 found 5115
Ignoring transid failure
extent buffer leak: start 2024985772032 len 16384
ERROR: cannot open file system



im not able to mount it anymore.


I found the drive in RO the other day and realized somthing was wrong 
... i did a reboot and now i cant mount anmyore


any help
