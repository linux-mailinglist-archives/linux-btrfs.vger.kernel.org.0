Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458F52529B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHZJFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 05:05:44 -0400
Received: from mail.dubielvitrum.pl ([91.194.229.150]:52203 "EHLO
        naboo.endor.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgHZJFn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 05:05:43 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2020 05:05:41 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 6F4B61A2193
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 10:58:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BQOQoe6AQC_x for <linux-btrfs@vger.kernel.org>;
        Wed, 26 Aug 2020 10:58:25 +0200 (CEST)
Received: from [192.168.18.34] (91-231-23-50.studiowik.net.pl [91.231.23.50])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 7A6B01A20AE
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 10:58:25 +0200 (CEST)
To:     linux-btrfs@vger.kernel.org
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: btrfs-transacti -- change from be/4 to idle (?)
Message-ID: <806a0681-6a1b-30d0-de28-8f18019913ad@dubiel.pl>
Date:   Wed, 26 Aug 2020 10:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hello!

Process btrfs-transacti takes 100% CPU time and server get very slow.

It runs with priority "best effort be/4".

Is it a good idea to change priority to "idle"?





root@wawel:/var/log# df -h  /

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2        20T   11T  7.7T  58% /



root@wawel:/var/log# btrfs sub list / | wc -l

367



root@wawel:/var/log# btrfs dev usag /

/dev/sda2, ID: 2
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              3.97TiB
    Metadata,RAID1:         79.00GiB
    Unallocated:             1.41TiB

/dev/sdb3, ID: 5
    Device size:             9.06TiB
    Device slack:            3.50KiB
    Data,RAID1:              2.26TiB
    Metadata,RAID1:         18.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             6.79TiB

/dev/sdc2, ID: 3
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              4.00TiB
    Metadata,RAID1:         77.00GiB
    Unallocated:             1.38TiB

/dev/sdd3, ID: 6
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              2.03TiB
    Metadata,RAID1:         18.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             3.38TiB

/dev/sde3, ID: 4
    Device size:            10.90TiB
    Device slack:            3.50KiB
    Data,RAID1:              7.96TiB
    Metadata,RAID1:        146.00GiB
    Unallocated:             2.79TiB

/dev/sdf3, ID: 7
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:            235.00GiB
    Unallocated:             3.38TiB

