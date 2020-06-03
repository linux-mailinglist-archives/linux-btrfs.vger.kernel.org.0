Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A2E1ECF72
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgFCMIc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 08:08:32 -0400
Received: from mail.adamgold.net ([165.22.16.18]:42672 "EHLO mail.adamgold.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgFCMIb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 08:08:31 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 08:08:31 EDT
From:   "Adam Gold" <adam@adamgold.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamgold.net;
        s=dkim; t=1591185553;
        h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Iqzoi6HuUo57XbcgDQ7JkRprhiEB7dt6hbVTU42NJWE=;
        b=U2QdGTu6+h3R54t3O11Mp0TA1od3+oZsbRazyZrcaG7tlWMDEHBO2kd5FcSCx0k7tQvO7/
        qZ9g6tBPzIb/mNmyAC7/9HFx3MDP1129QYp3zdY2zKd3+U3PFEfgJCSqvHqDPZnXPIMQWJ
        DIhEjjNodHN6OSlKLfUsDqvgmMa6HEUnT/4hpJH8yrKZ1IesRl4uaXOV2u/i3zsG0E3n3E
        1MuYEFQU403uGWwHJ57TWJ2L+AaEHj8oTlGSKE9jU6X8IL0IdM6Upqx+/zVyTT7g0JPVE+
        2GFUVmd2D44mWANJADEGp3LHNtU+QD1cypOn6/nbLlQB5f3LxZMKdH/wZ1NyNQ==
To:     linux-btrfs@vger.kernel.org
Subject: btrfs raid1 encryption alternatives
Date:   Wed, 03 Jun 2020 11:59:12 +0000
Message-Id: <em5570d4e3-0ca2-4d92-91a4-3e9eec9a337b@desktop-31mlcgh>
Reply-To: "Adam Gold" <adam@adamgold.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm intending to create a raid1 mirror using usb3 disks attached to an=20
overclocked Raspberry Pi 4. It might not be going into a data center any=20
time soon but I've done it before and it ran without fault. It will be=20
used for used for general backup and media.

Last time I used btrfs only, but I want an encryption layer this time=20
for which I'm going to use plain-dmcrypt. My understanding is that, like=20
with zfs, btrfs should be proximate to the disk sectors so one can make=20
best use of all its features (compression, scrubbing etc). I'm=20
considering the following two options:

1) sda+sdb --> PV --> VG --> btrfs_pool_LV (100% of VG) -->=20
plain-dmcrypt
2) sda+sdb --> plain-dmcrypt --> /dev/mapper/btrfs_raid1 --> /mnt/btrfs

I look at 1) and wonder whether the lvm layers are redundant but they (I=20
believe transparently) allow btrfs to format sda+sdb directly .

My question is, then, in 2) once /dev/mapper/btrfs_raid1 has been=20
opened, is it de facto identical to /dev/sda+/dev/sdb from scenario 1)=20
and will therefore allow btrfs to use all its capabilities. I believe=20
that in scenario 1) will only have to decrypt the LV whereas in 2) I'll=20
have to decrypt both disks but I'm not too fussed about that.

Thanks in advance for your attention.

