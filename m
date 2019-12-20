Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5600D1281C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLTSAV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 13:00:21 -0500
Received: from mail.nethype.de ([5.9.56.24]:44769 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfLTSAU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 13:00:20 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiMZX-003fCM-AA; Fri, 20 Dec 2019 18:00:19 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiMZX-0001tq-4a; Fri, 20 Dec 2019 18:00:19 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiMZX-0001pu-3V; Fri, 20 Dec 2019 19:00:19 +0100
Date:   Fri, 20 Dec 2019 19:00:19 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220180018.GA6802@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
 <45b11982-0847-8e2c-b40f-0c22ed21de2b@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b11982-0847-8e2c-b40f-0c22ed21de2b@georgianit.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 12:24:05PM -0500, Remi Gauvin <remi@georgianit.com> wrote:
> You don't need hints, the problem is right here.
> Your Metadata is Raid 1, (which requires minimum of 2 devices,) Your

Guess I found another bug - three disks with >>3tb free space, but df
still shows 0 available bytes. Sure I can probably work around it somehow,
but no, I refuse to accept that this is supposedly a user problem - surely
btrfs could create more raid1 metadata with _three disks with lots of free
space_.

doom ~# df /cold1
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/xmnt-cold15   43T   23T     0 100% /cold1
doom ~# btrfs dev us /cold1
/dev/mapper/xmnt-cold15, ID: 1
   Device size:             9.09TiB
   Device slack:              0.00B
   Data,single:             9.07TiB
   Metadata,RAID1:         25.46GiB
   System,RAID1:           32.00MiB
   Unallocated:             1.00MiB

/dev/mapper/xmnt-cold12, ID: 2
   Device size:             7.28TiB
   Device slack:              0.00B
   Data,single:             7.25TiB
   Metadata,RAID1:         24.46GiB
   System,RAID1:           32.00MiB
   Unallocated:             1.00MiB

/dev/mapper/xmnt-cold13, ID: 3
   Device size:             7.28TiB
   Device slack:              0.00B
   Data,single:             4.03TiB
   Metadata,RAID1:          5.92GiB
   Unallocated:             3.24TiB

/dev/mapper/xmnt-cold14, ID: 4
   Device size:             7.28TiB
   Device slack:              0.00B
   Unallocated:             7.28TiB

/dev/mapper/xmnt-cold11, ID: 5
   Device size:             7.28TiB
   Device slack:              0.00B
   Unallocated:             7.28TiB

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
