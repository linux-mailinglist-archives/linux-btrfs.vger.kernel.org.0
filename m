Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097B6517FA4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiECI0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiECI0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:26:00 -0400
X-Greylist: delayed 144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 01:22:28 PDT
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE629800
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:22:28 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id E308682F50
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 10:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651566002;
        bh=qGK4bHtNd3hTJtxbpra25EyieHhDakB801jBOejshlo=;
        h=Date:From:To:Subject:Reply-To;
        b=jcIZTBT8PQzUqqbr9mgkMRtTS2RqsQcQa2zGUSOcFXeYrZN99wMAkXBTkaHYltCzc
         9bCe8sXU48yu+bNyzeYrLL5xthrQGUDu0w4cOEEO9ju1HylQNVuNB9TdtyQGnoIA8e
         eCDEcLTTgjtUOgO/ghiXds3TGdMi2+KbOyKeKpB07wOKCLTh/NDFn4qqMt82UC8UAQ
         i4ubMbzb1xtVk6xO+O3WIp3sZzaH+Y4cZBogKkaei/JPaIN5R4LYN5g689LX84XDoL
         aSdbHuXCweLhETb0XRFggVfM7/TPS/Xq656HiaGymsGcM3a5fJUK+0QiQLexE+fkPc
         XgUDCRL5jLjVg==
Date:   Tue, 3 May 2022 10:20:01 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: cannot mount btrfs root partition
Message-Id: <20220503102001.271842da4933a043ba106d92@lucassen.org>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello list,

New to btrfs, I try to load a btrfs / filesystem WITHOUT initrd but it
ends up in a kernel panic. I run lilo, boot from /dev/md0.
md1: swap,
md2: / filesystem
sda6/sdb6: btrfs raid1

When booting the system on the old md2 root fs, the btrfs raid1 mounts
in /mnt/data/ without problems. Everyting seems to be ok:

# btrfs filesystem show
Label: 'data'  uuid: 3173a224-830f-41d7-8870-3db0e8c986c9
        Total devices 2 FS bytes used 1020.38MiB
        devid    1 size 187.32GiB used 2.01GiB path /dev/sda6
        devid    2 size 187.32GiB used 2.01GiB path /dev/sdb6

It works like a charm. But when I tell lilo to use
either /dev/sda6, /dev/sdb6 or the UUID, it ends up in a kernel panic.

Here's some config:

Vanilla kernel 5.10.113

$ grep BTRFS .config
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set

lilo stanza:

image=/boot/vmlinuz-5.10.113-apu1
        label=btrfs
        read-only
        root=/dev/sdb6
        append="console=ttyS0,115200n8"

BTRFS: device label data devid 1 transid 19 /dev/root scanned \
  by swapper/0 (1)
BTRFS info (device sda6): flagging fs with big metadata feature
BTRFS info (device sda6): disk space caching is enabled
BTRFS info (device sda6): has skinny extents
BTRFS error (device sdb6): devid 1 uuid \
 d201a08f-84ab-42e1-a411-83caadd1df2d is missing
BTRFS error (device sdb6): failed to read the system array: -2 
BTRFS error (device sdb6): open_ctree failed

# blkid /dev/sda6
/dev/sda6: LABEL="data" UUID="3173a224-830f-41d7-8870-3db0e8c986c9"
UUID_SUB="d201a08f-84ab-42e1-a411-83caadd1df2d" BLOCK_SIZE="4096"
TYPE="btrfs" PARTUUID="e0829fd9-06"

# blkid /dev/sdb6
/dev/sdb6: LABEL="data" UUID="3173a224-830f-41d7-8870-3db0e8c986c9"
UUID_SUB="e660257e-740b-4d92-8996-97ba86cbb812" BLOCK_SIZE="4096"
TYPE="btrfs" PARTUUID="748c2646-06"

Finally, I see this:

No filesystem could mount root,
tried:
ext3
ext4
ext2
vfat
msdos
btrfs

So, btrfs is a built-in fs, the boot process tries the btrfs fs, but is
not able to read it.

As said before, I'm new to btrfs and I'm a bit puzzeled now. I'd rather
do not use an initrd. It smells a bit like what's happening in the 7
year old bug: https://bugs.archlinux.org/task/42884

I also tried to boot from a single btrfs partition (no raid1 config) on
a separate disk, but no way.

Can anyone shine a light on this?

R.

-- 
richard lucassen
https://contact.xaq.nl/
