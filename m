Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6532CD0D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgLCII3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 3 Dec 2020 03:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbgLCII2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 03:08:28 -0500
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E1C061A4D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 00:07:48 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 4340E1937D0
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 09:07:47 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Best practice for encrypted BTRFS: LUKS or something else?
Date:   Thu, 03 Dec 2020 09:07:46 +0100
Message-ID: <3575501.kQq0lBPeGt@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I am plannung to deploy a new (used) laptop.

This time I like to encrypt it all, not just part of it.

Before I already used ecryptfs to encrypt part of the data residing on 
BTRFS, however I have the impression that ecryptfs is in kind of a 
maintenance mode. And to what I read Ubuntu stepped away from it. Before 
that I used encfs but that is out of the question as well.

So what is left? BTRFS on LUKS/dm-crypt? 

I plan about 2 TB of SSD storage without RAID initially and I think I 
would, again, like to use BTRFS on top of LVM – it needed a slight 
change to Debian initramfs-tools built RAM disk in order to boot a BTRFS 
RAID 1 from LVM, but I know what to do there. However I intend to put a 
second SSD in there and use BTRFS RAID 1 for most critical data. I am 
going to boot from Coreboot.

What is the best practice for such a kind of setup these days? I am not 
completely up to date with BTRFS on LUKS, but as far as I understand 
meanwhile it is a setup that can work nicely. Is it?

Are crc32c checksums sufficient or should I select one of the new ones? 
How about free space cache? I am using v2 already and unless I learn 
something else would use v2 again.

Anything else to consider?


I'd love to see native encryption for BTRFS, but AFAIK patches related 
to that are still kind of stalled. Any updates on that?

Best,
-- 
Martin


