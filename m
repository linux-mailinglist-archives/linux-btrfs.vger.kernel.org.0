Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A26CB4AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 08:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbfJDG7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 02:59:45 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56623 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbfJDG7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 02:59:45 -0400
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8F059100006
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 06:59:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id EB74238037
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 08:59:42 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WG4ah29SCOMD for <linux-btrfs@vger.kernel.org>;
        Fri,  4 Oct 2019 08:59:41 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id 234FA38039
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 08:59:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net 234FA38039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1570172381;
        bh=EvhovooOKmnGxSfbfq99X/7ZWyU1gqfqpWlI7v11ckE=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=yR4EVMKta1iYRjrt3j7Ejic2H0VXikfyaHC7VDICyDXdxZjITC5eY4i7EEblG5fyo
         7v8rJyXGN6djw70JPdX8Ue4F/nJGbLsN/VrWFuhnRHI73AaD6lhhvNKdTzQ9RPuXMx
         IYdIWBhkfmBVGh66nNKDxQw+R/yUhD5uZ2LyNtkTojtJPLFAJWvU6dpDUCGI1fTCpX
         6ZhibcwqdewG/7DXkKy5I/zAXCjAPPdfn9yvuKy1yDOw6dcfdbj7qxYxYA3tXT8ZbJ
         UiWj5GFQdALBbraKIW5q3oTi046zrq5P/FcFuVLugclKs6R7JAn6ChbhqDs2QqeuZm
         AvVFJontUskZw==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HEmxWhsSlTt9 for <linux-btrfs@vger.kernel.org>;
        Fri,  4 Oct 2019 08:59:41 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id B728238037
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 08:59:40 +0200 (CEST)
Message-ID: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
Subject: BTRFS errors, and won't mount
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 08:59:40 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,

During the night, I started getting the following errors and data was
no longer accessible:

[Fri Oct  4 08:04:26 2019] btree_readpage_end_io_hook: 2522 callbacks
suppressed
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 17686343003259060482 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 254095834002432 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 2574563607252646368 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 17873260189421384017 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 9965805624054187110 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 15108378087789580224 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 7914705769619568652 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 16752645757091223687 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 9617669583708276649 7808404996096
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
start 3384408928046898608 7808404996096
[Fri Oct  4 08:04:26 2019] btrfs_dev_stat_print_on_error: 159 callbacks
suppressed
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174280, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174281, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174282, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174283, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174284, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174285, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174286, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174287, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174288, flush 0, corrupt 0, gen 0
[Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
errs: wr 7, rd 174289, flush 0, corrupt 0, gen 0

Decided to reboot (for another reason) and tried to mount afterwards:

[Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): disk space caching
is enabled
[Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): has skinny extents
[Fri Oct  4 08:29:44 2019] BTRFS error (device sde2): parent transid
verify failed on 5483020828672 wanted 470169 found 470108
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286352011705795888 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286318771218040112 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286363934109025584 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286229742125204784 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286353230849918256 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286246155688035632 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286321695890425136 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286384677254874416 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286386365024912688 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
start 2286284400752608560 5483020828672
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): failed to recover
balance: -5
[Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): open_ctree failed

The FS info is shown below. It is a RAID6.

Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
	Total devices 16 FS bytes used 36.73TiB
	devid    1 size 7.28TiB used 2.66TiB path /dev/sde2
	devid    2 size 3.64TiB used 2.66TiB path /dev/sdf2
	devid    3 size 3.64TiB used 2.66TiB path /dev/sdg2
	devid    4 size 7.28TiB used 2.66TiB path /dev/sdh2
	devid    5 size 3.64TiB used 2.66TiB path /dev/sdi2
	devid    6 size 7.28TiB used 2.66TiB path /dev/sdj2
	devid    7 size 3.64TiB used 2.66TiB path /dev/sdk2
	devid    8 size 3.64TiB used 2.66TiB path /dev/sdl2
	devid    9 size 7.28TiB used 2.66TiB path /dev/sdm2
	devid   10 size 3.64TiB used 2.66TiB path /dev/sdn2
	devid   11 size 7.28TiB used 2.66TiB path /dev/sdo2
	devid   12 size 3.64TiB used 2.66TiB path /dev/sdp2
	devid   13 size 7.28TiB used 2.66TiB path /dev/sdq2
	devid   14 size 7.28TiB used 2.66TiB path /dev/sdr2
	devid   15 size 3.64TiB used 2.66TiB path /dev/sds2
	devid   16 size 3.64TiB used 2.66TiB path /dev/sdt2

The initial error refers to sdw, so possibly something happened that
caused one or more disks in the external cabinet to disappear and
reappear.

Kernel is 4.18.16-arch1-1-ARCH. Very hesitant to upgrade it, because
previously I had to downgrade the kernel to get the volume mounted
again.

Question: I know that running checks on BTRFS can be dangerous, what
can you recommend me doing to get the volume back online?

-- 
Groet / Cheers,
Patrick Dijkgraaf




