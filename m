Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CDC3E3A21
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Aug 2021 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhHHMIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Aug 2021 08:08:44 -0400
Received: from gateway20.websitewelcome.com ([192.185.53.25]:42097 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhHHMIo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Aug 2021 08:08:44 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Aug 2021 08:08:43 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 2F20B40136DC9
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Aug 2021 06:05:04 -0500 (CDT)
Received: from box2278.bluehost.com ([50.87.176.218])
        by cmsmtp with SMTP
        id Cgs8mgmmvK61iCgs9mhQfl; Sun, 08 Aug 2021 06:21:41 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=casa-di-locascio.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:To:References:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xgGKTSRQ61+0bUfAeqFPmYUAqrSBNPor5S3RQK+Q7cc=; b=bBUHQwkXJXlM4PUGCQeXJumHhH
        YrDtmHs32bKKTZDHykHp7dnWxq7MN2e9Gzpx104Hoa+SSBJ0+bbKq1aroyYhMxyscSXJiTwSjb06x
        74ZRxhC7IagtcY9Zmx5Q8Q6z8;
Received: from host86-181-46-172.range86-181.btcentralplus.com ([86.181.46.172]:28233 helo=[192.168.1.52])
        by box2278.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <devel@roosoft.ltd.uk>)
        id 1mCgs8-002jXI-Fl
        for linux-btrfs@vger.kernel.org; Sun, 08 Aug 2021 05:21:40 -0600
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   devel@roosoft.ltd.uk
Message-ID: <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
Date:   Sun, 8 Aug 2021 12:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box2278.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roosoft.ltd.uk
X-BWhitelist: no
X-Source-IP: 86.181.46.172
X-Source-L: No
X-Exim-ID: 1mCgs8-002jXI-Fl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host86-181-46-172.range86-181.btcentralplus.com ([192.168.1.52]) [86.181.46.172]:28233
X-Source-Auth: fpd_eacct+casa-di-locascio.net
X-Email-Count: 1
X-Source-Cap: Y2FzYWRpbG87Y2FzYWRpbG87Ym94MjI3OC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/08/2021 17:46, Dave T wrote:
> I recently switched from snapper and snapsync to btrbk, which I
> generally prefer. However, I am running into one issue.
>
> Background - from https://digint.ch/btrbk/doc/faq.html
> Btrbk is designed to operate on the subvolumes within a root
> subvolume. The author recommend booting linux from a btrfs subvolume,
> and using the btrfs root only as a container for subvolumes (i.e. NOT
> booting from "subvolid=5").
>
> That's exactly what I'm doing.
>
> The key point is that btrbk requires mounting the toplevel subvolume
> to perform its tasks.
>
> I'm using btrbk via a systemd timer. I have a daily and hourly timer
> set up. Each timer starts by mounting the btrfs root, performing the
> btrbk task, and unmounting the btrfs root.
>
> I create hourly snapshots and on a daily basis I use btrbk to transfer
> those to two different USB HDD's as well as to a remote server via
> SSH.
>
> Here's the problem. I now end up (after some time) with a nested list
> of mounts for one particular mount point as shown below. I don't
> understand why or how this is happening. It does have side effects
> (disk access can hang). The apparent "cure" is to restart the nfs
> server service, but I'm still trying to understand the issue fully.
>
> # cat /etc/fstab
> UUID=28D099A-9D92-487C-8113-A231CAD0EEF2  /     btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvol=/@btrtop/snapshot
> 0 0 #mounts my root filesystem
> UUID=28D099A-9D92-487C-8113-A231CAD0EEF2  /mnt/btrtop/root  btrfs
> noauto,nofail,rw,noatime,nodiratime,compress=lzo,space_cache    0 0
> #mounts the top btrfs volume for btrbk access to all snapshots
> /var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0
>
> # findmnt -t btrfs
> TARGET                                      SOURCE
>                                        FSTYPE OPTIONS
> /
> /dev/mapper/xyz[/@btrtop/snapshot]                     btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> ├─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │ └─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │   └─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │     └─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │       └─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │         └─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │           └─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │             └─/srv/nfs/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> ├─/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │ └─/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │   └─/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │     └─/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │       └─/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │         └─/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot
> │           └─/var/cache/pacman
> /dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvolid=3194,subvol=/@btrtop/snapshot

Try mounting the subvolume with it's subvolume ID. System only generates
unit files from the fstab it does not follow them , so if you are vague
in your fstab the systemd unit files will also be vague.

-- 
==

D Alexander



