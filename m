Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959023DDAC5
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhHBOVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 10:21:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:58929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234486AbhHBOUy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Aug 2021 10:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627914043;
        bh=xkmHkfdrMIWRgnPujhS7fBjhPu5H1xQq4xGMunOK8lo=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=FeRtCkvRLCNM9qSEVmnlTXZk0gBpSfijccLfhkSnJGtM5WFx/i2IUADv4xICFeeum
         8ZZ9+7qUBuO+EK7Ewz0HJGsdrqfJ5CfWkfM24yQj7cwOZGLuDGeCRgl3QnSseRbPCL
         A8Lin+PpL65W/AqMO8i2m8NmSzNGQAWkdJwWdKKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [89.14.188.180] ([89.14.188.180]) by web-mail.gmx.net
 (3c-app-gmx-bap64.server.lan [172.19.172.134]) (via HTTP); Mon, 2 Aug 2021
 16:20:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-59843172-879e-4efd-9b35-bbfed0ed52c6-1627914043406@3c-app-gmx-bap64>
From:   telsch <telsch@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Random csum errors
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 2 Aug 2021 16:20:43 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:6YVVqS73JxhmUreFnkVWR1Vbiqvtx95S3WGt5wpzAWKxpebCbSWQatF153vyuOfCioci4
 n79bzdVWK7V+8HOnY4pXBdBOVkBGtowlkjdQqu0meQRFxc1UxNuvNHkxpmHzfNquP5/Bf1fE8pAT
 tPLl8SAGcRS4/AC/tsyM3DiXSHgP688k5Cy+heHviW6WxhfTZHhlpdW0hyPDTcdcF26njZDNIQWW
 0q0LrZ89UTixiHRIeHJsOo5w4oYk1ZPA4aZlOySJC9lGd/I/exiw6hGPFzwWJ3y3pv/YsZoyuFao
 i8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A8wrOngqUfo=:7C1MaBL5ehO6ygXU+VVcbB
 6Xif817J5HSGjgjlgAXe5A91KI3NHarCSQZs2qaNpsHLvHJhAdm3G6BcIJz12wkosVDO3yn6N
 /wzk7eod9Maj3Fu8eoRoTLCtahGclLNPtf7yVlNjYAXd4+l9O87lEYHO9q6RjaubvGueZgR1q
 nGiCejCqcAH4/vyL6PNo/epd51H04HXWP6wh7r36LKFySc/9LSnVOhQ+MFZSQdQ8Nh9j2IF4E
 3Y+3sdYSFrDGiiVjgoiBiiTaCXjJ9U6cDmG7eyF+/79mG1uba7L7u/VPJIl6h821MZ9T0cpBy
 orxr12JCU/46HlbUER36tO3KA5g166s+yvS+Tw1h36ApHxiBrN9QgfTm6tKfDYTxCr/z4suuD
 y7d2FaF4qNAkH4cZ2T0C4XN6LPXMq6l8UqHKVuYHTaCEzcHlctdztErdh0/6FJCXSRI6PwBRL
 FV85HkRSN2vQUwNBaph+4D8pkiyguhlX1WYKUMo3ZXo102Bw20AzME9R/P1LZmLd4PCua8K5+
 Gbe1pR+iOIJWUL+U8A1YWnwn3ezVTEi3a3X+PNggqKnBgOktCZ2npy1L6XxmmC7AZpI+fAjU7
 dWFRCn+OI9OYPl3XqiCbhoRSJFrky09yEgt+xN23VVpCrHuGu0WqxgErIvne3CSJvINTOUaJ5
 7Tn1SM2Gdlkhliaq0heJfbd+UHj4Mr6S/10HJZ4+lVqRNDCKqUC66xGpvq/qu+2u93ox+OBjo
 liZNP4tkDdoUyM75pEjnGTYQ6Yu394PRgNuoK6v09JPI53UBXybLv7Ok8kampXVtGLrLVaxwJ
 geORQKdxrN+FxsQqpKSX/cSvPuLtA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear devs,

since 26.07. scrub keeps reporting csum errors with random files.
I replaced these files from backups. Then deleted the snapshots that still contained the
the corrupt files. Snapshot with corrupt files I have determined with md5sum, here I get an input/output error.
Following new scrub, still finds new csum errors that did not exist before.

Beginning with Kernel 5.10.52, current 5.10.55
btrfs-progs 5.13

Disk layout with problems:

mdadm raid10 4xhdd => bcache => luks
mdadm raid6  4xhdd => bcache => luks

Already replaced 2 old hdds with high Raw_Read_Error_Rate values.

Aug 02 15:43:18 server kernel: BTRFS info (device dm-0): scrub: started on devid 1
Aug 02 15:46:06 server kernel: BTRFS warning (device dm-0): checksum error at logical 462380818432 on dev /dev/mapper/root, physical 31640150016, root 29539, inode 27412268, offset 131072, length 4096, links 1 (path: docker-volumes/mayan-edms/media/document_cache/804391c5-e3fe-4941-96dc-ecc0a1d5d8c9-23-1815-92bcac02c4a72586e21044c0b244b052f5747c7d2c25e6086ca89ca64098e3f3)
Aug 02 15:46:06 server kernel: BTRFS error (device dm-0): bdev /dev/mapper/root errs: wr 0, rd 0, flush 0, corrupt 414, gen 0
Aug 02 15:46:06 server kernel: BTRFS error (device dm-0): unable to fixup (regular) error at logical 462380818432 on dev /dev/mapper/root
Aug 02 15:47:25 server kernel: BTRFS info (device dm-0): scrub: finished on devid 1 with status: 0
