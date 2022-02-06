Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2674AAED8
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 11:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiBFKdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 05:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 05:33:03 -0500
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 02:33:01 PST
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B4C06173B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 02:33:01 -0800 (PST)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 4Js53Y5KQnz4xGY3
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 10:24:09 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (2048-bit key) header.d=spliethoever.de header.i=@spliethoever.de header.b="HYV7rUBd"
Date:   Sun, 06 Feb 2022 10:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliethoever.de;
        s=protonmail3; t=1644143044;
        bh=1zNXhPFjbHG40CjQ8npesPMkWGUACBQFW8sDsW05KEI=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
        b=HYV7rUBdD2f41CPeBwSlya6XfKbXDxl9OZn4rmELlNjMEY7OrYbngbMfWQRSj2aIQ
         lx6f8r1UYOYb+fPE9I/FGWCBj/B8XdTe2VSodo1/yyt/lnIkjrNoxn5nd60tmhu7mT
         Qg4ncaVjKA3+/C+dEGegkaeh4oQ8ZqqyYsqO8KxMyIDpKd60Zfwaa7R1ZqV4z43Hfm
         t/AGgE8eHGnsmCgSApD9mtRS5aXsrKUbJ1MM08dtWjk0tjKrRHLkh2sMf9MVkleo5K
         dkY/fiKUVYGPtjN2O45SdoS/QI5cpvQQwgJthZTDquIi17j+EmWWZHBtj+WxpnoKSd
         8C3RGefunUXlQ==
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Reply-To: =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Subject: btrfs RAID1 upgrade
Message-ID: <bfd8a745-3480-70c8-155a-3ee7f5200647@spliethoever.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey everyone.
As the available space on my BTRFS RAID1 setup with 2x 4TB drives gets a bi=
t low (a little over 10% left), I plan to upgrade my setup. The current ide=
a is to add a single 8TB drive to the RAID1. The RAID is not used as system=
 drive, but is merely mounted as storage. According to [1], I could simply =
add the new drive to get 8TB of raw file storage in total, with the data an=
d metadata ratio remaining at 2.0.

Before I do so, I would like to know whether there are any problems with su=
ch a three-drive setup or I misunderstood something, and it isn't actually =
possible to extend the RAID1 in this way.

Also, I would love to get some feedback on the series of steps I plan to ex=
ecute to extend the RAID with the 8TB drive:


1. Stop all applications depending on the storage.
2. Unmount storage device.
3. Mount storage device degraded at `/btrfsmount`.
     ```
     $ mount -o degraded /dev/sdX /btrfsmount
     ```
4. Add the new drive to the raid.
     ```
     $ btrfs device add -f /dev/sdY /btrfsmount
     ```
5. Run a full balance to fully balance the data including the new device.
     ```shell
     $ btrfs balance start --full-balance /btrfsmount
     ```
6. Unmount the raid and remount it in non-degraded mode.


Lastly, if there are any other "best practices" one should follow when doin=
g such an extension (apart from backups, of course), please let me know.

In case it helps, below is the btrfs filesystem usage output:
$ btrfs filesystem usage /btrfsmount
Overall:
     Device size:                   7.28TiB
     Device allocated:              6.43TiB
     Device unallocated:          871.98GiB
     Device missing:                  0.00B
     Used:                          6.41TiB
     Free (estimated):            442.47GiB      (min: 442.47GiB)
     Free (statfs, df):           442.47GiB
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,RAID1: Size:3.21TiB, Used:3.20TiB (99.80%)
    /dev/sdd1       3.21TiB
    /dev/sde1       3.21TiB

Metadata,RAID1: Size:5.00GiB, Used:4.31GiB (86.19%)
    /dev/sdd1       5.00GiB
    /dev/sde1       5.00GiB

System,RAID1: Size:32.00MiB, Used:480.00KiB (1.46%)
    /dev/sdd1      32.00MiB
    /dev/sde1      32.00MiB

Unallocated:
    /dev/sdd1     435.99GiB
    /dev/sde1     435.99GiB



Thank you very much in advance. :)


-Max


[1]: https://carfax.org.uk/btrfs-usage/

