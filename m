Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE61ECF30
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgFCMBC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 08:01:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:43647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCMBB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 08:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591185660;
        bh=Iqzoi6HuUo57XbcgDQ7JkRprhiEB7dt6hbVTU42NJWE=;
        h=X-UI-Sender-Class:From:To:Subject:Date:Reply-To;
        b=VCJWCaj7X7D1wNIGIbMXK46N/L9TGSrofZBqEO9LhG8i0cJLEzEI6OlSCMyhb7iSB
         Pd+F4hzNQxFdwrtTCIIDeZl4jvMAo8Rd+g9L/pf6OenO0wCw04Es8p96phE3jYoXiK
         nbgWpbP2p3T89coVL1meC6CEjShUUDH6mvEGfpmg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.63.0.34] ([194.99.106.9]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1itjEA28rB-014TIr for
 <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 14:01:00 +0200
From:   "Adam Gold" <awg1@gmx.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs raid1 encryption alternatives
Date:   Wed, 03 Jun 2020 12:00:58 +0000
Message-Id: <em0da60a8d-9abc-4bc5-a91e-ebe48a4503f6@desktop-31mlcgh>
Reply-To: "Adam Gold" <awg1@gmx.com>
User-Agent: eM_Client/7.2.38732.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VLVZy0fF357RlwBZVBHp0PvG3Fiz+NMVHOumWk59/C3IAp4x2w0
 Jrxo5EEYGWwIXGjGQpQGwHZy1ICr4yz6YBOwBCaVmlDFLV5DQK2BJloHUwKnsUZGyN+P787
 A9PIh2wlDNrL8vAKiVDwsmJCoXWOwbb6qZuRGq4jVSaZr6p8YM3l10ih5L4CnzCLRzpQl/9
 8Xwuk3N0XZda4W5jvaFEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F0/gd2Lho4A=:Q+K23O0SR3+jJ6IkY147uz
 t+z0w27E1veJ6jHx5Q/iMF+OgeVXDlnAeXnlzof9KREFIk86Bt4qDEVDRR7wNiVVSuNviDY0O
 F/XZTxHaXhG8DNSJfwb66Wgn2eL90zUcKSVcwMAo7tw51SUeEPju6GhpLst/h151/R2v018X9
 H1IFEU4umcK07g+ZA66ruSer/QYCQVpP+Noml4nqKagANotktMPwGEgLeD1zRAnyWHQ3IXPYT
 rn8mLtCvTSpYhXtxGsHFrvdoFS7mlJFS9Xtou3E3fPwiylgzGwh0goDKxdoEAsJkdAq83smE9
 OYt+lWXuXlP5FPOlbuVceLaa0kueQiqEBXJfPLsEf5HSzuPweGQ6EQA0w378zF97EsIAwgCe2
 Jf/krXgyL1lQBvBRxvKv8qRBlp4cyX3Dl582xOvXefxLg1SY+Nh5Dqw6xEchLrruEzTaHmjxc
 zCMuOV5wuyeQRV80jEButOb5eccwEC5vOMO3fQunuI+pcbadcppwjryzHtC2asC9qQ5QoQyKk
 OI/8/p5VPLQFk8M6PfIoRNVtfpGytkt5p6YA5sjGKuuo3nvhF2VPlBAU3GfQzym9KuIHvcKEu
 ShqKwd2QBvul9FdDX1F0weXunq+EFpqp+PV3Uqp/KOfFDY0jyX/AlvJyDGEN4dE0wojOYVMUU
 YCUp8EYFvdBAJ/C5rXKoSlTAXfr5PolEGB7wCz5db9OcDIi6yVcWPWJDUOV45A7SjoXCcuuPC
 Z3Gj3yfxlxNYDTMauyhlCFd6lp0ohalHJaujaIJr6OXWVre28De50+2pIH+l0Nu1CYT2OW8x4
 3pxlTzKyaDYSK8j2W917GN3i0SgtXG0Ws2O7umM2IYROnBw5r3MzJKRo3vGE0cmrG5DDhUqHI
 UnCyA05OhzFfLm7a/6TFkiSKZGooVH4NU6dn5BSLI/vRZXDI6qRi1/tVMH4/AfqbfYm+SnkNS
 kRnuBPh8fhcgWrdZfplxtrSeQK10k+t0VZjGOKJlRMTwJJSslCu6jlZNkQmkrVtxe2MDGWi+b
 n+AJj56uhHgpAOPoy1sBa72jkY4vz+xhi6/pdQSRnJ8rsrpPfyHoRvccAq8EpvwveP0DVCEqy
 BK/PCenJZ0WrMgymOyIX6Tejao7r2/4TswJPonhURdMRgqbazeiQGRPgNgYC9/5FXs/XGwual
 yT5isnmkVZl5ysK0u938b7R5FRc3L8SyoI3+xuJ8XzKiOLgMfCx05L3jyTOl+AaGAbY98U5rX
 qOAt0CP8meJiAvxK8
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

