Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7ECB4E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfJDHR5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:17:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44663 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfJDHR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:17:57 -0400
X-Originating-IP: 163.158.29.153
Received: from katrien.duckstad.net (153-029-158-163.dynamic.caiway.nl [163.158.29.153])
        (Authenticated sender: relay@duckstad.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4FC93FF810
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 07:17:55 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id B2CAE38037
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 09:17:54 +0200 (CEST)
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qa9ofccd4Njm for <linux-btrfs@vger.kernel.org>;
        Fri,  4 Oct 2019 09:17:52 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by katrien.duckstad.net (Postfix) with ESMTP id CE80238039
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 09:17:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 katrien.duckstad.net CE80238039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duckstad.net;
        s=EEE0E95C-ABE4-11E9-AA35-1FC771689572; t=1570173472;
        bh=2WmOocCbzO10SCIWDO3GVo1VuvmYS9IjqOKiGjclnyI=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=jGEVrh558EKcFI2vXE02l4utYuCdm9cDVPki3huGaQDcBO77qi3gdKTNJFfrNcC3D
         0j0qPnKcwsHxS6GOzT94FAtOFFQVBcj58EQjRqGMagi3S961zFGyagU6VMcl+DefGB
         RO9VAbgmMWUxzf3RFgZ28yorBMQQ86fNEiX2GaNcj26zMDUFm0DZp/HzfMHU2hWXEi
         Rc/xCE7Fl/trhMOOt7u+sG5gNWXZESSazp8dTGdYEf4DmGAYpVEaOxE+c6AyvhwJE6
         zsXaEZ8bAuWYvQi3VRP5J4Y4mxPI1fQX0xxwA7u04xGV/ZkGpJOujaA0egD4TdFJIB
         4lAb+sWlYdaYg==
X-Virus-Scanned: amavisd-new at katrien.duckstad.net
Received: from katrien.duckstad.net ([127.0.0.1])
        by localhost (katrien.duckstad.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8zu6ZN904aMp for <linux-btrfs@vger.kernel.org>;
        Fri,  4 Oct 2019 09:17:52 +0200 (CEST)
Received: from bolderbast (unknown [10.4.2.1])
        by katrien.duckstad.net (Postfix) with ESMTPSA id 9B12338037
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 09:17:52 +0200 (CEST)
Message-ID: <632ab4b48128d70cd3a671bfda608a947e221e54.camel@duckstad.net>
Subject: Re: BTRFS errors, and won't mount
From:   Patrick Dijkgraaf <bolderbast@duckstad.net>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:17:52 +0200
In-Reply-To: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
References: <2649522a0283fc35ade2218755063f8ff0dc4aa4.camel@duckstad.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS restore shows the following output:

#btrfs restore -D /dev/sde2 /mnt/data
This is a dry-run, no files are going to be restored
parent transid verify failed on 4314638041088 wanted 470169 found
470107
parent transid verify failed on 4314638041088 wanted 470169 found
470107
checksum verify failed on 4314638041088 found 4D792F65 wanted A99A92D3
checksum verify failed on 4314638041088 found 8D966120 wanted 4C528768
checksum verify failed on 4314638041088 found 8D966120 wanted 4C528768
bad tree block 4314638041088, bytenr mismatch, want=4314638041088,
have=20210165085184
Error reading subvolume /mnt/data/00-live/nextcloud:
18446744073709551611
Error searching /mnt/data/00-live/nextcloud

-- 
Groet / Cheers,
Patrick Dijkgraaf



On Fri, 2019-10-04 at 08:59 +0200, Patrick Dijkgraaf wrote:
> Hi guys,
> 
> During the night, I started getting the following errors and data was
> no longer accessible:
> 
> [Fri Oct  4 08:04:26 2019] btree_readpage_end_io_hook: 2522 callbacks
> suppressed
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 17686343003259060482 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 254095834002432 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 2574563607252646368 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 17873260189421384017 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 9965805624054187110 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 15108378087789580224 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 7914705769619568652 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 16752645757091223687 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 9617669583708276649 7808404996096
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bad tree block
> start 3384408928046898608 7808404996096
> [Fri Oct  4 08:04:26 2019] btrfs_dev_stat_print_on_error: 159
> callbacks
> suppressed
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174280, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174281, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174282, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174283, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174284, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174285, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174286, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174287, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174288, flush 0, corrupt 0, gen 0
> [Fri Oct  4 08:04:26 2019] BTRFS error (device sde2): bdev /dev/sdw2
> errs: wr 7, rd 174289, flush 0, corrupt 0, gen 0
> 
> Decided to reboot (for another reason) and tried to mount afterwards:
> 
> [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): disk space
> caching
> is enabled
> [Fri Oct  4 08:29:42 2019] BTRFS info (device sde2): has skinny
> extents
> [Fri Oct  4 08:29:44 2019] BTRFS error (device sde2): parent transid
> verify failed on 5483020828672 wanted 470169 found 470108
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286352011705795888 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286318771218040112 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286363934109025584 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286229742125204784 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286353230849918256 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286246155688035632 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286321695890425136 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286384677254874416 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286386365024912688 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): bad tree block
> start 2286284400752608560 5483020828672
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): failed to
> recover
> balance: -5
> [Fri Oct  4 08:29:45 2019] BTRFS error (device sde2): open_ctree
> failed
> 
> The FS info is shown below. It is a RAID6.
> 
> Label: 'data'  uuid: 43472491-7bb3-418c-b476-874a52e8b2b0
> 	Total devices 16 FS bytes used 36.73TiB
> 	devid    1 size 7.28TiB used 2.66TiB path /dev/sde2
> 	devid    2 size 3.64TiB used 2.66TiB path /dev/sdf2
> 	devid    3 size 3.64TiB used 2.66TiB path /dev/sdg2
> 	devid    4 size 7.28TiB used 2.66TiB path /dev/sdh2
> 	devid    5 size 3.64TiB used 2.66TiB path /dev/sdi2
> 	devid    6 size 7.28TiB used 2.66TiB path /dev/sdj2
> 	devid    7 size 3.64TiB used 2.66TiB path /dev/sdk2
> 	devid    8 size 3.64TiB used 2.66TiB path /dev/sdl2
> 	devid    9 size 7.28TiB used 2.66TiB path /dev/sdm2
> 	devid   10 size 3.64TiB used 2.66TiB path /dev/sdn2
> 	devid   11 size 7.28TiB used 2.66TiB path /dev/sdo2
> 	devid   12 size 3.64TiB used 2.66TiB path /dev/sdp2
> 	devid   13 size 7.28TiB used 2.66TiB path /dev/sdq2
> 	devid   14 size 7.28TiB used 2.66TiB path /dev/sdr2
> 	devid   15 size 3.64TiB used 2.66TiB path /dev/sds2
> 	devid   16 size 3.64TiB used 2.66TiB path /dev/sdt2
> 
> The initial error refers to sdw, so possibly something happened that
> caused one or more disks in the external cabinet to disappear and
> reappear.
> 
> Kernel is 4.18.16-arch1-1-ARCH. Very hesitant to upgrade it, because
> previously I had to downgrade the kernel to get the volume mounted
> again.
> 
> Question: I know that running checks on BTRFS can be dangerous, what
> can you recommend me doing to get the volume back online?
> 




