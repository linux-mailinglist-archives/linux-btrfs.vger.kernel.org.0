Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA014229B25
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgGVPSO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 22 Jul 2020 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGVPSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 11:18:14 -0400
X-Greylist: delayed 468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jul 2020 08:18:13 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117CC0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 08:18:13 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 767B812176A
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 17:10:20 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Understanding "Used" in df
Date:   Wed, 22 Jul 2020 17:10:19 +0200
Message-ID: <3225288.0drLW0cIUP@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have:

% LANG=en df -hT /home
Filesystem            Type   Size  Used Avail Use% Mounted on
/dev/mapper/sata-home btrfs  300G  175G  123G  59% /home

And:

merkaba:~> btrfs fi sh /home   
Label: 'home'  uuid: […]
        Total devices 2 FS bytes used 173.91GiB
        devid    1 size 300.00GiB used 223.03GiB path /dev/mapper/sata-home
        devid    2 size 300.00GiB used 223.03GiB path /dev/mapper/msata-home

merkaba:~> btrfs fi df /home
Data, RAID1: total=218.00GiB, used=171.98GiB
System, RAID1: total=32.00MiB, used=64.00KiB
Metadata, RAID1: total=5.00GiB, used=1.94GiB
GlobalReserve, single: total=490.48MiB, used=0.00B

As well as:

merkaba:~> btrfs fi usage -T /home
Overall:
    Device size:                 600.00GiB
    Device allocated:            446.06GiB
    Device unallocated:          153.94GiB
    Device missing:                  0.00B
    Used:                        347.82GiB
    Free (estimated):            123.00GiB      (min: 123.00GiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              490.45MiB      (used: 0.00B)
    Multiple profiles:                  no

                          Data      Metadata System              
Id Path                   RAID1     RAID1    RAID1    Unallocated
-- ---------------------- --------- -------- -------- -----------
 1 /dev/mapper/sata-home  218.00GiB  5.00GiB 32.00MiB    76.97GiB
 2 /dev/mapper/msata-home 218.00GiB  5.00GiB 32.00MiB    76.97GiB
-- ---------------------- --------- -------- -------- -----------
   Total                  218.00GiB  5.00GiB 32.00MiB   153.94GiB
   Used                   171.97GiB  1.94GiB 64.00KiB   


I think I understand all of it, including just 123G instead of
300 - 175 = 125 GiB "Avail" in df -hT.

But why 175 GiB "Used" in 'df -hT' when just 173.91GiB (see 'btrfs fi sh')
is allocated *within* the block group / chunks?

Does this have something to do with that global reserve thing?

Thank you,
-- 
Martin


