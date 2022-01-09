Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF84888AE
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jan 2022 11:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiAIKUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jan 2022 05:20:20 -0500
Received: from mx01.maccuish.org.uk ([116.203.49.71]:56592 "EHLO
        mx01.maccuish.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiAIKUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jan 2022 05:20:19 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jan 2022 05:20:18 EST
Received: from [172.16.30.16] (unknown [172.16.30.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx01.maccuish.org.uk (Postfix) with ESMTPSA id A3F783FE71
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jan 2022 10:11:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maccuish.de; s=mail;
        t=1641723101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iSxlShm1cdExHF0Nph6FOXKGMfzmh00/GRhkniZtn+o=;
        b=KYs3P7p1zzzfaGKfDNO6s7suih8Xri59MrgoE1rbb4+xmR8L3l2tbQ3tl8+LzryTj6HZ+I
        yWL8YlALQ6yNw1vyfC069d8mt5x7hvjd2mptTi9LTsll8fQdfuYgRcoropGbF9d1loBY/D
        wC1VhOfltLKvCuCTH33f6t2s0t7yvl8sdnTCKY5w0mQT/VSXBE7GA99gxU1JcdIeDaiY3z
        oLsrpXRMSdxaeVF1/udnba4xAauYXtiB9h9MQHATOW7kg0bSGf0yBXSikMl0p8Gs1rPFiY
        BhpA4X88CGh2gakfaHV2PaHACVvvDCNJgjJaBK6oADje4GH2dXyyaTYHbPNP6Q==
Message-ID: <61b5cb09-8bd4-8b25-fbda-73b866a36fd5@maccuish.de>
Date:   Sun, 9 Jan 2022 11:11:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Alex MacCuish <alex@maccuish.de>
Subject: Adding a UUID to the top level subvol on an existing filesystem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For use of send/receive, I need my subvolume id 5 to have a UUID. I see 
here (https://www.spinics.net/lists/linux-btrfs/msg76016.html) that it 
was discussed to add this feature to say btrfstune, but I can't find any 
option to do it. What's the best way to do this and ensure current 
subvolumes have the correct parent ID?

---

Linux xxx.xxx.xxx 5.15.11-051511-generic #202112220937 SMP Wed Dec 22 
10:04:02 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

btrfs-progs v5.4.1

btrfs fi show

Label: 'storage'  uuid: 61538bc8-fc27-4818-9cc9-133938e252da
         Total devices 4 FS bytes used 2.35TiB
         devid    1 size 1.82TiB used 1.63TiB path /dev/sdd
         devid    2 size 1.82TiB used 1.63TiB path /dev/sdc
         devid    3 size 1.82TiB used 744.03GiB path /dev/sdb
         devid    4 size 931.51GiB used 738.03GiB path /dev/sde

btrfs fi df /mnt/storage
Data, RAID1: total=2.35TiB, used=2.34TiB
System, RAID1: total=32.00MiB, used=368.00KiB
Metadata, RAID1: total=5.00GiB, used=4.32GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

btrfs subvolume show /mnt/storage/
/
         Name:                   <FS_TREE>
         UUID:                   -
         Parent UUID:            -
         Received UUID:          -
         Creation time:          -
         Subvolume ID:           5
         Generation:             4620363
         Gen at creation:        0
         Parent ID:              0
         Top level ID:           0
         Snapshot(s):
                                 CN_IMGS
                                 CN_PKGS
                                 CN_PKGS/.snapshots
                                 CN_SHARE
                                 CN_SHARE/.snapshots
                                 CN_MEDIA
                                 CN_MEDIA/.snapshots
                                 CN_HOMES
                                 CN_HOMES/.snapshots
                                 CN_BACKUPS

