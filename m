Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D02DC717
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgLPT2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 14:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388512AbgLPT2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 14:28:54 -0500
Received: from ravenhurst.kallisti.us (ravenhurst-smtp-tx.kallisti.us [IPv6:2600:3c03:e000:2e0::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7633C0617A6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
        ; s=20180707; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
        Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xwMhIf473iA4IqjHJBaY7YRdm4q30MuaavaneRIC5CA=; b=aCPuNgLZd6X9SETzxODd6Li1yS
        XfPl//kQXLHA0Ou86W5EcfBZs+DFTKxr3eRPRVys/l41HnileqVO6WI1THQW4JF9dVclk0WIGItnF
        USNnESAh3cW5e6xQ1PGM09xOnAvfaBUA8wd6DyH3IuNSMIW8/9b5oXqx4ykWflyFgSGxwOfA4a0t1
        zjNF6PfW+7gYb4/stZHgsS2ME009ZwDAb8OJ3ZBKOonWSfehZju8L6Kl3wuTBiMGD0lDOeH4EzX83
        AkdZqcxeEnWIr7hiQvhb7s3ynaZ8LzJ28bCH+c3ABwslVMaqLFDgR4AMizhMuYH436stOXYZOlpWP
        4HbbPoDw==;
Received: from [2606:6000:4500:1400:98d2:dc3e:a6eb:31df] (helo=vanvanmojo.kallisti.us)
        by ravenhurst.kallisti.us with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ross@kallisti.us>)
        id 1kpcT6-0008Lv-Ht
        for linux-btrfs@vger.kernel.org; Wed, 16 Dec 2020 14:28:12 -0500
Date:   Wed, 16 Dec 2020 11:28:08 -0800
From:   Ross Vandegrift <ross@kallisti.us>
To:     linux-btrfs@vger.kernel.org
Subject: csum errors on negative root id?
Message-ID: <20201216192808.lodnlgbdxefayn2c@vanvanmojo.kallisti.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I recently saw these in my dmesg, on 4.19.160:
  BTRFS warning (device dm-20): csum failed root -9 ino 1303 off 0 csum 0x47abffd5 expected csum 0xd5f0d335 mirror 1
  BTRFS warning (device dm-20): csum failed root -9 ino 1303 off 0 csum 0x47abffd5 expected csum 0xd5f0d335 mirror 1

I'm confused by a few things here:
- does the negative root id mean something, or is this a bug?
- inode 1303 doesn't seem to exist.
- This is a standalone drive, is this about a dup metadata block?

Details on the fs:
$ sudo btrfs fi show /mnt/storage
Label: none  uuid: 6a2038fb-a9b4-4720-a441-c084610e4295
        Total devices 1 FS bytes used 4.66TiB
        devid    1 size 7.28TiB used 5.72TiB path /dev/mapper/storage

$ sudo btrfs fi df /mnt/storage
Data, single: total=4.68TiB, used=4.66TiB
System, DUP: total=32.00MiB, used=768.00KiB
Metadata, DUP: total=536.45GiB, used=4.95GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
$ sudo btrfs inspect-internal subvolid-resolve -- -9 /mnt/storage
ERROR: -9: negative value is invalid.
$ sudo btrfs inspect-internal inode-resolve 1303 /mnt/storage
ERROR: ino paths ioctl: No such file or directory

Please keep me CCed, thanks!

Ross
