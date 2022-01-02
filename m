Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33C482AD9
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiABLc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 06:32:56 -0500
Received: from mail1.arhont.com ([178.248.108.111]:51540 "EHLO
        mail1.arhont.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiABLcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jan 2022 06:32:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id A3F8C400A63
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 11:32:54 +0000 (UTC)
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qvJjDzrltDYO for <linux-btrfs@vger.kernel.org>;
        Sun,  2 Jan 2022 11:32:53 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 703D5400A61
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 11:32:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail1.arhont.com 703D5400A61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arhont.com;
        s=157CE280-B46F-11E5-BB22-6D46E05691A3; t=1641123173;
        bh=4hHlzndUjeRoYofvweWTeTx3kSA+VRKEzlIYrUc2Mco=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=edR+gjlgwpQC9V/2odvTMsi+yp0XYNISL3MsllwJNLlu+UR+ZSMCRQchMtbYWHz1g
         3KdZB0ceGurX3u1iIJe8VQFefRBkCZGjpR8Qr333KqsxX67Be8B1ynqTrfgyXeXnZm
         2R39XpZmvFhFJZhYPPtfKYNWuo66YAZNzMK7YiTo=
X-Virus-Scanned: amavisd-new at arhont.com
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DYDJijYtyr3v for <linux-btrfs@vger.kernel.org>;
        Sun,  2 Jan 2022 11:32:53 +0000 (UTC)
Received: from mail1.arhont.com (mail1.arhont.com [10.1.70.26])
        by mail1.arhont.com (Postfix) with ESMTP id 5A600400A60
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 11:32:53 +0000 (UTC)
Date:   Sun, 2 Jan 2022 11:32:53 +0000 (UTC)
From:   "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1056918704.2047.1641123173265.JavaMail.zimbra@arhont.com>
Subject: CEPH to BTRFS over NFS results in no compression
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - GC96 (Linux)/8.8.15_GA_4177)
Thread-Index: YeVFoe1RHDYQULdLbze2vEb5dGggoQ==
Thread-Topic: CEPH to BTRFS over NFS results in no compression
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,=20

I have noticed an interesting and surprising behaviour of my BTRFS with reg=
ards to compression of the files and NFS.=20

I have BTRFS RAID10 with 8 disks , that is mounted with the " nofail,noatim=
e,space_cache=3Dv2,compress-force=3Dzstd:9,subvol=3D@cloudstack-secondary" =
flags and is exported via NFS.=20

When I create a snapshot of a disk in Cloudstack from CEPH and save it to a=
 secondary storage to this BTRFS RAID10 over NFS, the file does not compres=
s, despite the compress-force mount option being set on FS=20
So in the below example, the file eeceaf0e-9780-408b-a748-1495d517a9b6 was =
copied over NFS and is not compressed. When I copy the same file directly o=
n a host, it does get compressed pretty well, as per example below.=20


root@backup1 : /mnt/backup1/cloudstack-secondary/snapshots/49/5355: compsiz=
e eeceaf0e-9780-408b-a748-1495d517a9b6=20
Type Perc Disk Usage Uncompressed Referenced=20
TOTAL 99% 9.8G 9.8G 9.8G=20
none 100% 9.8G 9.8G 9.8G=20
zstd 3% 4.0K 128K 124K=20

root@backup1 : /mnt/backup1/cloudstack-secondary/snapshots/49/5355: cp eece=
af0e-9780-408b-a748-1495d517a9b6 testfile=20
'eeceaf0e-9780-408b-a748-1495d517a9b6' -> 'testfile'=20


root@backup1 : /mnt/backup1/cloudstack-secondary/snapshots/49/5355: compsiz=
e testfile=20
Type Perc Disk Usage Uncompressed Referenced=20
TOTAL 38% 3.7G 9.8G 9.8G=20
none 100% 1.1G 1.1G 1.1G=20
zstd 30% 2.6G 8.6G 8.6G=20

root@backup1: /mnt/backup1/cloudstack-secondary/snapshots/49/5355 =EE=82=B0=
 btrfs filesystem defrag -v -f -czstd ./eeceaf0e-9780-408b-a748-1495d517a9b=
6=20
./eeceaf0e-9780-408b-a748-1495d517a9b6=20

root@backup1: /mnt/backup1/cloudstack-secondary/snapshots/49/5355 =EE=82=B0=
 compsize eeceaf0e-9780-408b-a748-1495d517a9b6=20
Type Perc Disk Usage Uncompressed Referenced=20
TOTAL 38% 3.7G 9.8G 9.8G=20
none 100% 1.1G 1.1G 1.1G=20
zstd 30% 2.6G 8.6G 8.6G=20



So what I have checked so far what works=20
- after the original files is copied over NFS, the copy of the file using #=
cp gets compressed.=20
- after the original files is copied over NFS, the original file can be com=
pressed using #btrfs defrag -czstd option=20
- If I copy the original file to some other host, and copy it back via NFS =
using cp, it does get compressed.=20

So the problem seems to appear only when the file is exported from Ceph and=
 copied to NFS.=20

Any hints what could be causing such a behaviour?=20



Yours sincerely,=20
Kos

