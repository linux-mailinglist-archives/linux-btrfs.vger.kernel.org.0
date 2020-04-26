Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF581B8EC8
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDZKTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 06:19:31 -0400
Received: from mail.nethype.de ([5.9.56.24]:40017 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDZKTb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 06:19:31 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2020 06:19:30 EDT
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jSe8r-000JWi-QZ
        for linux-btrfs@vger.kernel.org; Sun, 26 Apr 2020 10:04:05 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jSe8r-0003px-MM
        for linux-btrfs@vger.kernel.org; Sun, 26 Apr 2020 10:04:05 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jSe8r-0001Nt-M7
        for linux-btrfs@vger.kernel.org; Sun, 26 Apr 2020 12:04:05 +0200
Date:   Sun, 26 Apr 2020 12:04:05 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: questoin about Data=single on multi-device fs
Message-ID: <20200426100405.GA5270@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I have a quesion about a possible behaviour change. I have a multi-device
btrfs filesystem with metadatas profile raid1 and data profile single.

With my current kernel (5.4.28), it seems btrfs is balancing writes to the
devices, which is nice for performance (it's kind of a best-effort raid0),
but not so nice for data recovery (files get sepasrated out on all kinds of
disks, which increases data loss on device failure).

I remember (maybe wrongly!) that this behaviour was diferent with older
kernels (4.9, possibly 4.19), in that I feel that btrfs was mostly writing ot
a single disk until it was more or less full before switching to another
disk, which is worse for performance, but much better for data recovery.

The reason I chose data=single was specifically to help in case of device
loss at the cost of performance.

So my question is: did the behaviour change (possibly I misinterpreted
what I saw weith older kernels), and is there a way to get the behaviour
I thought it had before, where it mostly stayed with one disk without
balancing writes?

(I can simulate this for my case using either btrfs resize or incremental
btrfs adds).

Thanks a lot for any insights!

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
