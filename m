Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1622145DF5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 18:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhKYRKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 12:10:34 -0500
Received: from mail-4325.protonmail.ch ([185.70.43.25]:41819 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347725AbhKYRIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 12:08:34 -0500
Date:   Thu, 25 Nov 2021 17:05:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1637859921;
        bh=mOhXLqogjGbU+qWa7AzSjHX6cw+MW8S6Tmc/tkUIydQ=;
        h=Date:To:From:Reply-To:Subject:From;
        b=ghUDaU0+tO50EYQ9/UbKVXDAQRmTbHbJPAuDhi7lV/YoClOhtZBSBN8AHDe+LnKDo
         /iZ5SsQUeRvqv+RtwoXUzuuHM8b8Dtju5m3L7jCHP3JGq836AblEDsemD0otsLp2HY
         miPqkVEianDRC+YVOXkBNXiatZV+tZTWeB1Fl8Oo=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   mcq909 <mcq909@protonmail.com>
Reply-To: mcq909 <mcq909@protonmail.com>
Subject: Scraping data from broken raid0 btrfs
Message-ID: <ggvg1Extbl_pBXtcXLwaIJ3J_sdgHx9XfGbMN0NA_SaJNdqC4GsNCPTgPxTNyzxpxot9UC6j-PQL1WOFAVhojpn5nC9x0gkJHhGh1QV8K5k=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I have a btrfs raid0 array (2 drives) that is broken after the power of one=
 of the drives was
unplugged for a few seconds. The hardware and superblocks are fine but the =
chunk-root seems to be destroyed.
I am desperate enough to try to recover some of the not yet backed up files=
 by finding file signatures within a
dd written binary blob. However i am not sure how to proceed since the file=
system was using zstd and
the files should be split between the drives in raid0. Am i out of luck or =
is there anything i can do to get at
least a raw binary blob of all the files?
Many thanks for any suggestion!
M. Webber

Below is a summary of all rescue attempts so far (both drives, sdb and sdc,=
 are online and fdisk readable):

System:
Linux 5.15.2
btrfs-progs v5.15


mount -o ro /dev/sdb /mnt
=09BTRFS warning: checksum verify failed on 22036480 wanted 0x00000000 foun=
d 0x7b064cd2 level 1
=09BTRFS error: failed to read chunk root
=09BTRFS error: open_ctree failed
=09mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb, miss=
ing codepage or helper =09program, or other error


mount -o ro,rescue=3Dusebackuproot /dev/sdb /mnt
=09BTRFS warning: checksum verify failed on 22036480 wanted 0x00000000 foun=
d 0x7b064cd2 level 1
=09BTRFS error: failed to read chunk root
=09BTRFS error: open_ctree failed
=09mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb, miss=
ing codepage or helper =09program, or other error


btrfs rescue super-recover /dev/sdb
=09All supers are valid, no need to recover


btrfs check /dev/sdb
=09Opening filesystem to check...
=09checksum verify failed on 22036480 wanted 0x00000000 found 0x7b064cd2
=09Csum didn't match
=09ERROR: cannot read chunk root
=09ERROR: cannot open file system


btrfs restore /dev/sdb /tmp
=09checksum verify failed on 22036480 wanted 0x00000000 found 0x7b064cd2
=09Csum didn't match
=09ERROR: cannot read chunk root
=09Could not open root, trying backup super
=09warning, device 1 is missing
=09checksum verify failed on 22036480 wanted 0x00000000 found 0x7b064cd2
=09Csum didn't match
=09ERROR: cannot read chunk root
=09Could not open root, trying backup super
=09warning, device 1 is missing
=09checksum verify failed on 22036480 wanted 0x00000000 found 0x7b064cd2
=09Csum didn't match
=09ERROR: cannot read chunk root
=09Could not open root, trying backup super


btrfs rescue zero-log /dev/sdb
=09checksum verify failed on 22036480 wanted 0x00000000 found 0x7b064cd2
=09ERROR: cannot read chunk root
=09ERROR: could not open ctree


btrfs rescue chunk-recover /dev/sdb
=09runs for a long time and then crashes with BUG_ON(!ce) from volumes.c tr=
iggered,
=09replacing BUG_ON(!ce) with if(!ce) return 0; does not help, core dumped


btrfs inspect-internal dump-super -f -a /dev/sdb
=09generation              26935
=09chunk_root_generation   26935
=09root_level              1
=09chunk_root              22036480
=09chunk_root_level        1
=09cache_generation        26934
=09uuid_tree_generation    26934
=09sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
=09length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
        io_align 65536 io_width 65536 sector_size 4096
        num_stripes 2 sub_stripes 1
        stripe 0 devid 1 offset 22020096
        stripe 1 devid 2 offset 1048576

=09backup_roots[4]:
        backup 0:
                backup_tree_root:       4811447648256   gen: 26933      lev=
el: 1
                backup_chunk_root:      22134784        gen: 26933      lev=
el: 1
                backup_extent_root:     4811320770560   gen: 26933      lev=
el: 2
        backup 1:
                backup_tree_root:       4811056234496   gen: 26934      lev=
el: 1
                backup_chunk_root:      22134784        gen: 26933      lev=
el: 1
                backup_extent_root:     4811055906816   gen: 26934      lev=
el: 2
        backup 2:
                backup_tree_root:       4811009376256   gen: 26935      lev=
el: 1
                backup_chunk_root:      22036480        gen: 26935      lev=
el: 1
                backup_extent_root:     4810999791616   gen: 26935      lev=
el: 2
        backup 3:
                backup_tree_root:       4811296555008   gen: 26932      lev=
el: 1
                backup_chunk_root:      22020096        gen: 26932      lev=
el: 1
                backup_extent_root:     4811259297792   gen: 26932      lev=
el: 2

For "btrfs check" it also does not matter if -s 0,1,2 or --chunk-root 22020=
096, 22036480 and so on is used.

