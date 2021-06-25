Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B5C3B4919
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYTIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYTIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 15:08:46 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A1C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jun 2021 12:06:25 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a2f:d900:2fc7:e4d:d332:3965])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 05E3127A980;
        Fri, 25 Jun 2021 21:06:20 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-block@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Assumption on fixed device numbers in Plasma's desktop search Baloo
Date:   Fri, 25 Jun 2021 21:06:19 +0200
Message-ID: <41661070.mPYKQbcTYQ@ananda>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I found repeatedly that Baloo indexes the same files twice or even more 
often after a while.

I reported this upstream in:

Bug 438434 - Baloo appears to be indexing twice the number of files than 
are actually in my home directory 

https://bugs.kde.org/show_bug.cgi?id=438434

And got back that if the device number changes, Baloo will think it has 
new files even tough the path is still the same. And found over time that 
the device number for the single BTRFS filesystem on a NVMe SSD in a 
ThinkPad T14 Gen1 AMD can change. It is not (maybe yet) RAID 1. I do 
have BTRFS RAID 1 in another laptop and there I also had this issue 
already.

I argued that a desktop application has no business to rely on a device 
number and got back that search/indexing is in the middle between an 
application and system software. And that Baloo needs an "invariant" for 
a file. See comment #11 of that bug report:

https://bugs.kde.org/show_bug.cgi?id=438434#c11

I got the suggestion to try to find a way to tell the kernel to use a 
fixed device number. 

I still think, an application or an infrastructure service for a desktop 
environment or even anything else in user space should not rely on a 
device number to be fixed and never change upon reboots.

But maybe you have a different idea about that and it is okay for an 
userspace component to do that. I would like to hear your idea about 
that.

Another question would be whether I could somehow make sure that the 
device number does not change, even if just as a work-around. I know for 
NFS there is a fsid= mount option, but it does not appear to be 
something generic, at least the mount man page seems to have nothing 
related to fsid.


Best,
-- 
Martin


