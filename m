Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E94455F7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 16:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKDPEo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 4 Nov 2021 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhKDPEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 11:04:43 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Nov 2021 08:02:05 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD650C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 08:02:05 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a29:1c00:ddc8:b2c1:df0f:b5bf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 405E02F06B0
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 15:56:29 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Settings compression for a filesystem
Date:   Thu, 04 Nov 2021 15:56:28 +0100
Message-ID: <11237766.pNdQY1Vl8f@ananda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I do have a bunch of BTRFS on LUKS backup disks. Plasma desktop mounts 
them unter /media… however, it does not mount with compression enabled. 
I do have some older backup disks which are in /etc/fstab including 
mount option "compress=zstd".

Is there any way to tell BTRFS to always use a certain compression 
algorithm for all newly written files (and of course existing files which 
use compression) without adding an entry in fstab for each disk?

I thought about

btrfs property set MOUNTPOINT compression zstd

but that sets the property just on the root inode of the mounted 
filesystem. Does it propagate? The manpage does not seem to have any 
information on that.

If not, well then I add the entries to fstab.

Thanks,
-- 
Martin


