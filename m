Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4065F3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2019 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfGKSA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jul 2019 14:00:29 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:45640 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfGKSA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jul 2019 14:00:29 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 86A48142BC3; Thu, 11 Jul 2019 19:00:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562868026;
        bh=FyJny+JcnyuvnAdqegsGmnJAOwFbp2DvJVJEqbIZyVc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=BmVpiJXn1wBQE86lhTSR7FQhnCAYEbb/8mPDfddS1t4eZ8342ouenGQAb+QAZgBEv
         iCVIjDQUMOS6mDUNE+og3HSA8eoWSYIlsnicdWeNaAg9tVoQJF51XpZs356nqFWaWo
         A/ccClpwPo1b8vTadwulQeXfx7SWa8J1CLmspMGCq5dtO7JI309mn+lsh8Qty7NUR+
         7BO5Ri6j6h3+2uL9eNAdYF8dRp16TlESG08AUcX/rZMzuTXVVHWRjFisjlGaKhH+3L
         Y5kpbReH2Gnyr+Jl1D9hkH+vHVWUzYv2cumSy7qV2kMcOWCaVL7Ju2dxMU6pO+Wthw
         lKw7IF2gRp/VA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 60979142BC1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2019 19:00:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562868025;
        bh=FyJny+JcnyuvnAdqegsGmnJAOwFbp2DvJVJEqbIZyVc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FXFAIwbDwh08KMGjYuyTIJOAQJHC/lQeigFD7QlOEymsTEK3NKuRADLDQPVbF/7Px
         NVDRzdh7eyu6IEfqIFpuxa9mgbg8By7894rrL34u4OZOpS4KP3Vmlp9/CENM5yYPUw
         UQ6eAvuwAotEu5WqOj6IXBxA+1hmZaP7Omtpjo2pnDpMPhXa8/kqu7v0H32TNaSkEV
         HDPf98QqkxQ0+5Zd/3/Hv2VD5LZPPSYWt5nlZAQi+lJ9f5CiC4Q2X2N21meyPJlEu1
         12pvFu/xQ4H4bqfu0B1YA/jx0Hrk39Ydmga0U0RMUWPDyCqKidbKEg/6oQar7Y+Bey
         Lri5wRXfcv2dQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 768D81758D
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2019 19:00:24 +0100 (BST)
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
To:     linux-btrfs@vger.kernel.org
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <a3d6e202-acf4-c02e-430a-aef4a2ee4247@cobb.uk.net>
Date:   Thu, 11 Jul 2019 19:00:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/07/2019 03:46, Anand Jain wrote:
> Now the question I am trying to understand, why same device is being
> scanned every 2 mins, even though its already mount-ed. I am guessing
> its toggling the same device paths trying to mount the device-path
> which is not mounted. So autofs's check for the device mount seems to
> be path based.
> 
> Would you please provide your LVM configs and I believe you are using
> dm-mapping too. What are the device paths used in the fstab and in grub.
> And do you see these messages for all devices of
> 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 or just devid 4? Would you please
> provide more logs at least a complete cycle of the repeating logs.

My setup is quite complex, with three btrfs-over-LVM-over-LUKS
filesystems, so I will explain it fully in a separate message in case it
is important. Let me first answer your questions regarding
4d1ba5af-8b89-4cb5-96c6-55d1f028a202, which was the example I used in my
initial log extract.

4d1b...a202 is a filesystem with a main mount point of /mnt/backup2/:

black:~# btrfs fi show /mnt/backup2/
Label: 'snap12tb'  uuid: 4d1ba5af-8b89-4cb5-96c6-55d1f028a202
        Total devices 2 FS bytes used 10.97TiB
        devid    1 size 10.82TiB used 10.82TiB path /dev/sdc3
        devid    4 size 3.62TiB used 199.00GiB path
/dev/mapper/cryptdata4tb--vg-backup

In this particular filesystem, it has two devices: one is a real disk
partition (/dev/sdc3), the other is an LVM logical volume. It has also
had other LVM devices added and removed at various times, but this is
the current setup.

Note: when I added this LV, I used path /dev/mapper/cryptdata4tb--vg-backup.

black:~# lvdisplay /dev/cryptdata4tb-vg/backup
  --- Logical volume ---
  LV Path                /dev/cryptdata4tb-vg/backup
  LV Name                backup
  VG Name                cryptdata4tb-vg
  LV UUID                TZaWfo-goG1-GsNV-GCZL-rpbz-IW0H-gNmXBf
  LV Write Access        read/write
  LV Creation host, time black, 2019-07-10 10:40:28 +0100
  LV Status              available
  # open                 1
  LV Size                3.62 TiB
  Current LE             949089
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           254:13

The LVM logical volume is exposed as /dev/mapper/cryptdata4tb--vg-backup
which is a symlink (set up by LVM, I believe) to /dev/dm-13.

For the 4d1b...a202 filesystem I currently only see the messages for
devid 4. But I presume that is because devid 1 is a real device, which
only appears in /dev once. I did, for a while, have two LV devices in
this filesystem and, looking at the old logs, I can see that every 2
minutes the swapping between /dev/mapper/whatever and /dev/dm-N was
happening for both LV devids (but not for the physical device devid)

This particular device is not a root device and I do not believe it is
referenced in grub or initramfs. It is mounted in /etc/fstab/:

LABEL=snap12tb  /mnt/backup2    btrfs
defaults,subvolid=0,noatime,nodiratime,compress=lzo,skip_balance,space_cache=v2
       0       3

Note that /dev/disk/by-label/snap12tb is a symlink to the dm-N alias of
the LV device (set up by LVM or udev or something - not by me):

black:~# ls -l /dev/disk/by-label/snap12tb
lrwxrwxrwx 1 root root 11 Jul 11 18:18 /dev/disk/by-label/snap12tb ->
../../dm-13

Here is a log extract of the cycling messages for the 4d1b...a202
filesystem:

Jul 11 18:46:28 black kernel: [116657.825658] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 11 18:46:28 black kernel: [116658.048042] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
Jul 11 18:46:29 black kernel: [116659.157392] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 11 18:46:29 black kernel: [116659.337504] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
Jul 11 18:48:28 black kernel: [116777.727262] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 11 18:48:28 black kernel: [116778.019874] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
Jul 11 18:48:29 black kernel: [116779.157038] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 11 18:48:30 black kernel: [116779.364959] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
Jul 11 18:50:28 black kernel: [116897.705568] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 11 18:50:28 black kernel: [116897.911805] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
Jul 11 18:50:29 black kernel: [116899.053046] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 11 18:50:29 black kernel: [116899.213067] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup


I will, later, provide more detailed configuration information,
including the other filesystems and more logs. As that will be very long
I plan to send it directly to you, Anand, rather than to the list.

Graham
