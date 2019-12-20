Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6832128148
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTRUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 12:20:45 -0500
Received: from mail.nethype.de ([5.9.56.24]:43923 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfLTRUp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 12:20:45 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiLxE-003dmV-0r; Fri, 20 Dec 2019 17:20:44 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiLxD-0002zz-SH; Fri, 20 Dec 2019 17:20:43 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiLxD-0001ZF-Rq; Fri, 20 Dec 2019 18:20:43 +0100
Date:   Fri, 20 Dec 2019 18:20:43 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220172043.GA5965@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > Just while I was writing this mail, on 5.4.5, the _newly created_ btrfs
> > filesystem I restored to went into readonly mode with ENOSPC. Another
> > hardware problem?
>
> But mounting with clear_cache,space_cache=v2 didn't help, df still shows 0
> bytes free, "btrfs f us" still shows 3tb unallocated. I'll play around with
> it more...

clear_cache didn't work, but btrfsck --clear-space-cache v1 and .. v2 did
work:

   Filesystem               Size  Used Avail Use% Mounted on
   /dev/mapper/xmnt-cold15   27T   23T  3.6T  87% /cold1

Which is rather insane, as I can't see how this filesystem was ever not
mounted without -o space_cache=v2.

Looking at btrfs f u again...

   Metadata,single: Size:1.22GiB, Used:0.00B (0.00%)
      /dev/mapper/xmnt-cold13         1.22GiB

   Metadata,RAID1: Size:27.92GiB, Used:27.90GiB (99.91%)
      /dev/mapper/xmnt-cold15        25.46GiB
      /dev/mapper/xmnt-cold12        24.46GiB
      /dev/mapper/xmnt-cold13         5.92GiB

   System,RAID1: Size:32.00MiB, Used:2.16MiB (6.74%)
      /dev/mapper/xmnt-cold15        32.00MiB
      /dev/mapper/xmnt-cold12        32.00MiB

   Unallocated:
      /dev/mapper/xmnt-cold15         1.00MiB
      /dev/mapper/xmnt-cold12         1.00MiB
      /dev/mapper/xmnt-cold13         3.24TiB

Did this happen because metadata is raid1 and two of the disks were full,
and for some reason, btrfsck freed up a tiny bit of space somewhere?

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
