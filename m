Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C709BC46
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2019 08:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHXGsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Aug 2019 02:48:10 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36841 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXGsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Aug 2019 02:48:10 -0400
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 88AFC100006
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 06:48:08 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 2BFA23802F
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 08:48:08 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ez8nXWuRmITw for <linux-btrfs@vger.kernel.org>;
        Sat, 24 Aug 2019 08:48:06 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 6AD9738030
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 08:48:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net 6AD9738030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1566629286;
        bh=kCy/fULPq6ZG9GeAbj33TyVK2P/JhCL8qREbW6zHIjI=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=NXK7uRRzhf0z6eQwD6ChoOdaoI3w0S5LDwMZ4brbOHrIHQc6eEPkNc4IHa4fCO4yS
         YUFV0oXga+gBWHmmX953uGEjlpYV5xIPKHYyQMGvHTEFf+2KqdpxgZU5viMdXLxS3V
         6fUp9EpYuvNrFg1Z7Nv5OR77zG8InsxfmjXl3/s1ANQnvu47cgTQq8vPnVqHHFJZyh
         QBOyuHRFaIftE2/yiBCk5Mqb2ISyCyKO7rSf27oyA5fWWUEFmyowprxrqWtn91vBhQ
         3xSDXI8PWq6zFDuTXoMoCgfN16dtJ4/oCupOx7wN7AxEBcwg0d27oRAgXxBZviCwbp
         i0vzsacqnrr1Q==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id og89e5bNPSfZ for <linux-btrfs@vger.kernel.org>;
        Sat, 24 Aug 2019 08:48:06 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id 4A7393802F
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 08:48:06 +0200 (CEST)
Message-ID: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
Subject: Need help: super_total_bytes mismatch with fs_devices total_rw_bytes
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 24 Aug 2019 08:48:05 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

My server hung this morning, and I had to hard-reset is. I did not
apply any updates. After the reboot, my FS won't mount:

[Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): super_total_bytes
92017957797888 mismatch with fs_devices total_rw_bytes 184035915595776
[Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): failed to read
chunk tree: -22
[Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): open_ctree failed

However, running btrfs rescue shows:
root@cornelis ~]# btrfs rescue fix-device-size /dev/sdh2
No device size related problem found

FS config is shown below:
[root@cornelis ~]# btrfs fi show
Label: 'cornelis-btrfs'  uuid: ac643516-670e-40f3-aa4c-f329fc3795fd
Total devices 1 FS bytes used 536.05GiB
devid    1 size 800.00GiB used 630.02GiB path /dev/mapper/cornelis-
cornelis--btrfs

Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
Total devices 16 FS bytes used 36.61TiB
devid    1 size 7.28TiB used 2.65TiB path /dev/sde2
devid    2 size 3.64TiB used 2.65TiB path /dev/sdf2
devid    3 size 3.64TiB used 2.65TiB path /dev/sdg2
devid    4 size 7.28TiB used 2.65TiB path /dev/sdh2
devid    5 size 3.64TiB used 2.65TiB path /dev/sdi2
devid    6 size 7.28TiB used 2.65TiB path /dev/sdj2
devid    7 size 3.64TiB used 2.65TiB path /dev/sdk2
devid    8 size 3.64TiB used 2.65TiB path /dev/sdl2
devid    9 size 7.28TiB used 2.65TiB path /dev/sdm2
devid   10 size 3.64TiB used 2.65TiB path /dev/sdn2
devid   11 size 7.28TiB used 2.65TiB path /dev/sdo2
devid   12 size 3.64TiB used 2.65TiB path /dev/sdp2
devid   13 size 7.28TiB used 2.65TiB path /dev/sdq2
devid   14 size 7.28TiB used 2.65TiB path /dev/sdr2
devid   15 size 3.64TiB used 2.65TiB path /dev/sds2
devid   16 size 3.64TiB used 2.65TiB path /dev/sdt2

Other info:
[root@cornelis ~]# uname -r
4.18.16-arch1-1-ARCH

I was able to mount is using:
[root@cornelis ~]# mount -o usebackuproot,ro /dev/sdh2 /mnt/data

Now updating my backup, but I REALLY hope to get this fixed on the
production server!

-- 
Cheers,
Patrick Dijkgraaf


