Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFB2F94D9
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 20:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbhAQTX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbhAQTX2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 14:23:28 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A90C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 11:22:48 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1l1DcR-000303-PG; Sun, 17 Jan 2021 19:21:47 +0000
Date:   Sun, 17 Jan 2021 19:21:47 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Anders Halman <anders.halman@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: received uuid not set btrfs send/receive
Message-ID: <20210117192147.GB4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Anders Halman <anders.halman@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 17, 2021 at 10:49:26AM -0800, Anders Halman wrote:
> Hello,
> 
> I try to backup my laptop over an unreliable slow internet connection to a
> even slower Raspberry Pi.
> 
> To bootstrap the backup I used the following:
> 
> # local
> btrfs send root.send.ro | pigz | split --verbose -d -b 1G
> rsync -aHAXxv --numeric-ids --partial --progress -e "ssh -T -o
> Compression=no -x" x* remote-host:/mnt/backup/btrfs-backup/
> 
> # remote
> cat x* > split.gz
> pigz -d split.gz
> btrfs receive -f split

> worked nicely. But I don't understand why the "received uuid" on the remote
> site in blank.

   Are you doing the receive as root?

   Hugo.

> I tried it locally with smaller volumes and it worked.
> 
> The 'split' file contains the correct uuid, but it is not set (remote).
> 
> remote$ btrfs receive --dump -f split | head
> subvol          ./root.send.ro uuid=99a34963-3506-7e4c-a82d-93e337191684
> transid=1232187
> 
> local$ sudo btrfs sub show root.send.ro| grep -i uuid:
>     UUID:             99a34963-3506-7e4c-a82d-93e337191684
> 
> 
> Questions:
> 
> - Is there a way to set the "received uuid"?
> - Is it a matter of btrfs-progs version difference?
> - What whould be a better approach?
> 
> 
> Thank you
> 
> 
> ----
> 
> # local
> 
> root@fos ~$ uname -a
> Linux fos 5.9.16-200.fc33.x86_64 #1 SMP Mon Dec 21 14:08:22 UTC 2020 x86_64
> x86_64 x86_64 GNU/Linux
> 
> root@fos ~$   btrfs --version
> btrfs-progs v5.9
> 
> root@fos ~$   btrfs fi show
> Label: 'DATA'  uuid: b6e675b3-84e3-4869-b858-218c5f0ac5ad
>     Total devices 1 FS bytes used 402.17GiB
>     devid    1 size 464.27GiB used 414.06GiB path
> /dev/mapper/luks-e4e69cfa-faae-4af8-93f5-7b21b25ab4e6
> 
> root@fos ~$   btrfs fi df /btrfs-root/
> Data, single: total=404.00GiB, used=397.80GiB
> System, DUP: total=32.00MiB, used=64.00KiB
> Metadata, DUP: total=5.00GiB, used=4.38GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> # remote
> root@pih:~# uname -a
> Linux pih 5.4.72+ #1356 Thu Oct 22 13:56:00 BST 2020 armv6l GNU/Linux
> 
> root@pih:~#   btrfs --version
> btrfs-progs v4.20.1
> 
> root@pih:~#   btrfs fi show
> Label: 'DATA'  uuid: 6be1e09c-d1a5-469d-932b-a8d1c339afae
>     Total devices 1 FS bytes used 377.57GiB
>     devid    2 size 931.51GiB used 383.06GiB path
> /dev/mapper/luks_open_backup0
> 
> root@pih:~#   btrfs fi df /mnt/backup
> Data, single: total=375.00GiB, used=374.25GiB
> System, DUP: total=32.00MiB, used=64.00KiB
> Metadata, DUP: total=4.00GiB, used=3.32GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> dmesg is empty for the time of import/btrfs receive.

-- 
Hugo Mills             | If it ain't broke, hit it again.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                                  Foon
