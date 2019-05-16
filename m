Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1721085
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 00:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfEPW0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 18:26:11 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:36379 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbfEPW0L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 18:26:11 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 18:26:10 EDT
Received: from mail.bi-co.net (voltaic.bi-co.net [127.0.0.1])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id 849B8209BD
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 00:16:20 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 May 2019 00:16:20 +0200
From:   =?UTF-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
To:     <linux-btrfs@vger.kernel.org>
Subject: Massive filesystem corruption after balance + fstrim on Linux 5.1.2
Message-ID: <297da4cbe20235080205719805b08810@bi-co.net>
X-Sender: bevan@bi-co.net
User-Agent: Roundcube Webmail/0.7.2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.

Today I managed to destroy my btrfs root filesystem using the following 
sequence of commands:

sync
btrfs balance start -dusage 75 -musage 75 /
sync
fstrim -v /

Shortly after, the kernel spew out lots of messages like the following:

BTRFS warning (device dm-5): csum failed root 257 ino 16634085 off 
21504884736 csum 0xd47cc2a2 expected csum 0xcebd791b mirror 1

A btrfs scrub shows roughly 27000 unrecoverable csum errors and lots of 
data on that system is not accessible anymore.

I'm running Linux 5.1.2 on an Arch Linux. Their kernel pretty much 
matches upstream with only one non btrfs-related patch on top: 
https://git.archlinux.org/linux.git/log/?h=v5.1.2-arch1

The btrfs file system was mounted with compress=lzo. The underlying 
storage device is a LUKS volume, on top of an LVM logical volume and the 
underlying physical volume is a Samsung 830 SSD. The LUKS volume is 
opened with the option "discard" so that trim commands are passed to the 
device.

SMART shows no errors on the SSD itself. I never had issues with 
balancing or trimming the btrfs volume before, even the exact same 
sequence of commands as above never caused any issues. Until now.

Does anyone have an idea of what happened here? Could this be a bug in 
btrfs?

I have made a copy of that volume so I can get further information out 
of it if necessary. I already ran btrfs check on it (using the slightly 
outdated version 4.19.1) and it did not show any errors. So it seems 
like only data has been corrupted.

Please tell me if I can provide any more useful information on this.

Cheers,
Michael
