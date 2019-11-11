Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02186F6CF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 03:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKCol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 21:44:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:56925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfKKCol (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 21:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573440280;
        bh=56NXgwKS7I1h9z8DKwaDvNcwSECYn4USflCDvT/75lI=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=jtrg4CbIbLYrcgTPHuluhGOo9EE0m9ByPS/YhRc4TyNC+i20CEZqx/Zlj0BtpOSva
         ngYSiAhX++3mBcuNPXrw62CFplouvKz3Hr1XTZWnQMHgt0moBSVmlvvvNF3kQDlHhB
         HIPUKLXnT2JhzLyRDiKziIHX9AJ5GofsF4G6EE24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [209.122.194.126] ([209.122.194.126]) by web-mail.gmx.net
 (3c-app-mailcom-bs04.server.lan [172.19.170.170]) (via HTTP); Mon, 11 Nov
 2019 03:44:40 +0100
MIME-Version: 1.0
Message-ID: <trinity-9b5e3549-dd52-48e7-98f1-9f8bfd1a358a-1573440280042@3c-app-mailcom-bs04>
From:   "Paul Monsour" <boulos@gmx.com>
To:     linux-btrfs@vger.kernel.org
Subject: dd does it again!
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Nov 2019 03:44:40 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:C9rqAUECjGIMlp/WF1ugYJ+zXdrxiw2Z/QkFzYGulk9FmOO7vy8zz6B4p/okcaX90r5Ff
 HxAyS9sHW1LuxuB/ZVwJtiKu9okoW1Q1kS0gRO4U/PyBEHdTwwDbzSxEJ5JrsERc0jD1cMoRs2jb
 LTDpVBodnZN07PPetDCsfxLMAJcHUIzjmUB0ZcGidPZn6KL/2Diw9JY65CLqZ3stVBiM54lomxEH
 1mgZMAHUY3TRGEFh9JzGg3Rp+gCH7tykW8+g1mWwe86mxS8QrXLs3mQIkKeJJ2DZJKvhKKaPPtEc
 RY=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Pn/TmMGZYc=:zJjPzRCGhKTj61SO9p0E5Q
 WzCLDFXhr4EjwRpI7Bc2xM4q3QJavYZhlGcTgD2S7vCoHy3xfa562BfYYZvmURUdGBwZ7hlrx
 79SH+iI/mkGO3vkhMsOxti/ZXH8vrXJbGK+YdbOSj4g5n9Z/V8npGEzrYgbUN8dB/OMbgMTko
 S+X0CxSjbjnNmHPd77/Pq+Q/imoqMLvoOeSF6mwh1HKujmCI72xST818JEE7lQSZuSWQ/dRyg
 smd2U+GHIeAXucxVlTlgyC2TYzNiIzXjNCwo6Zc5qNGu8wBCy43VK/NmsdpSSLWmmo+fYA/28
 66b8je6XiKWFjXStvJ5b5sZJQo7xNhd8+32dnJfoWYQJB7H5dHkSX1VYVVgVfUazDTq9gEw+Q
 F7iFtkQ8s9mpBm7TlVS32puoknNebMv61tsJiJPKqPQ2OTdFKbENiCIr9IyOxj860f4ktoL6B
 TLlfkiNcLcGDHheMwGgz2mbrNRYYblc4miT7c3fRjvAGRRwrywH44O5lbmuXinlhN7bKg9wRR
 W0A1rhwcVeXG1TxLt3plNJpN9fDVmzmFtxtoWVpDi5WJ8R+PvDFSLzQt8kejDHTOdyGRJu/xa
 UXlV7XT/abiDd3AjCcAjy5ouZLhStZrxXpKU8PmaWPf6oNC2wRCytQ01ClAUpdTdjD1z8+2bk
 Ic8VCkV5aoQOVP9EXBAiZUn/lLlzp/RxeqppG+DuIYa/Fhg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I did it; I used dd and accidentally zapped all of my personal files, whic=
h were under the /home directory. This was a btrfs raid0 setup with /dev/s=
dc1 and /dev/sdd1. I aborted the command after it had started but before i=
t had completed. Neither directory is now mountable, but btrfs fi show pro=
duced the following output:

[root@sysresccd /]# btrfs fi show
Label: none  uuid: 9819165f-fade-471a-9f93-86f36523e58a
    Total devices 1 FS bytes used 28.81GiB
    devid    1 size 48.82GiB used 32.02GiB path /dev/sdb1
warning, device 2 is missing
Label: none  uuid: 9985ee11-bc6d-4f06-ab15-3156457ba29c
    Total devices 1 FS bytes used 32.75GiB
    devid    1 size 58.59GiB used 45.06GiB path /dev/sdb5
Label: none  uuid: 073f1926-d84d-4150-9498-4239b5383272
    Total devices 2 FS bytes used 629.10GiB
    devid    1 size 2.73TiB used 646.12GiB path /dev/sdc1
    *** Some devices missing

parted -l produced:

Model: ATA ST3000DM008-2DM1 (scsi)
Disk /dev/sdc: 3001GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags:
Number  Start   End     Size    File system  Name  Flags
 1      1049kB  3001GB  3001GB  btrfs        Home

Model: ATA ST3000DM008-2DM1 (scsi)
Disk /dev/sdd: 3001GB
Sector size (logical/physical): 512B/4096B
Partition Table: msdos
Disk Flags:
Number  Start  End     Size    Type     File system  Flags
 2      119kB  1593kB  1475kB  primary               esp

The portion of the dd command that wrecked the files was "of=3D/dev/sdd1"

btrfs restore produced just:

drwxr-xr-x 1 root root   0 Nov 10 12:43 ftp
drwxr-xr-x 1 root root 362 Nov 10 12:51 palsor

However, I was (perhaps optimistically) heartened by what "btrfs-find-root=
 /dev/sdc1" produced:

# btrfs-find-root /dev/sdc1
warning, device 2 is missing
Superblock thinks the generation is 322292
Superblock thinks the level is 1
Found tree root at 649710272512 gen 322292 level 1

How do I use this information? Is there reason to be optimistic?

Thanks in advance for your help.

Paul Monsour




