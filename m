Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307AD461085
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 09:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhK2Ixz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 03:53:55 -0500
Received: from w1.tutanota.de ([81.3.6.162]:37324 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348915AbhK2Ivy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 03:51:54 -0500
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id C721CFBF58A
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638175713;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=MfENIj8VvX+no02rteqociDsXex4aF5CaNr58Jj2BPU=;
        b=Hdg7GRICfvRRd/rsp4He4mt+W+5PaCRGLBqHwEF5ug2MX2IgjKM8FfrTOHoB8MWt
        futrmks3Xboj721jhZH8Q0g3attBsKZg1FtuLmCRZmB8Qgghbfo2EgvBKTOhZBO0L5+
        zt9SBHHpKHtYf3IMFEzh/hpg3uFL69VT8vfwdhws1wp9sZeedt6ukIGYH1wKaC3KOZx
        R1htw651hyH5Qn8VV1ryID6XGDoLyfK3gQ9Qz9JbWxVClJtCOMp7MFKz+f/gBFXf7Uv
        y9/bCZDIMFgWOLfxeM5l9FjWQSCwAoeJgIDTFREfXJeP5RlV9S4bSFLBqyr6xVT6m4H
        nVMf/2jFCw==
Date:   Mon, 29 Nov 2021 09:48:33 +0100 (CET)
From:   Borden <borden_c@tutanota.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <MpesPIt--3-2@tutanota.com>
Subject: Connection lost during BTRFS move + resize
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good morning,

I couldn't find any definitive guidance on the list archives or Internet, s=
o I want to double-check before giving up.

I tried to left-move and resize a btrfs partition on a USB-attached hard dr=
ive. My intention was to expand the partition from 2 TB to 3 TB on a 4TB dr=
ive. During the move, the USB cable came loose and the process failed.

From what I can tell, the partition was "moved" to its new location and cor=
rectly shows the usage, but the partition is not expanded to its new 3 TB l=
imit. As one would expect, sudo mount -o ro /dev/sdb3 /mnt yields:
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb3, missin=
g codepage or helper program, or other error.

Although I know it's extremely dangerous, I nevertheless ran btrfs check --=
repair /dev/sdb3 and received:
Starting repair.
Opening filesystem to check...
checksum verify failed on 2160397959168 wanted 0x2d75ada8 found 0x55dc86b3
checksum verify failed on 2160397959168 wanted 0x5c57dcfd found 0xe722d853
checksum verify failed on 2160397959168 wanted 0x5c57dcfd found 0xe722d853
bad tree block 2160397959168, bytenr mismatch, want=3D2160397959168, have=
=3D8937084726424501725
Couldn't read tree root
ERROR: cannot open file system

As requested:
uname -a: Linux debian 5.15.0-1-amd64 #1 SMP Debian 5.15.3-1 (2021-11-18) x=
86_64 GNU/Linux
btrfs --version: btrfs-progs v5.15
sudo btrfs fi show: Label: 'Backup'=C2=A0 uuid: <drive UUID, still good>
=C2=A0 Total devices 1 FS bytes used 1.71TiB
=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 1.82TiB used 1.73TiB path /dev/sdb3
dmesg: output at http://paste.debian.net/1221191/, valid until 2021-12-02

From other discussions, it seems like the partition's contents are gone for=
 good, which is OK because it's a backup and I can start over. However, if =
I can recover the data, that would be nice, too, since I might have to dig =
up something from a while back.

With many thanks,
