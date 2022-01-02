Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B714828D9
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 01:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiABA4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 19:56:00 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:49245 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiABAz7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 19:55:59 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 21329405B8
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 18:56:44 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id C5C998034D34
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 18:55:58 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id B7AE38034D37
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 18:55:58 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BlVrdkpn9BNy for <linux-btrfs@vger.kernel.org>;
        Sat,  1 Jan 2022 18:55:58 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 710708034D34
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 18:55:58 -0600 (CST)
Message-ID: <109cc618254b1f8d9365bd4ecb7eb435dea91353.camel@ericlevy.name>
Subject: Re: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Sat, 01 Jan 2022 19:55:57 -0500
In-Reply-To: <YdDurReZpZQeo+7/@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
         <Yc9Wgsint947Tj59@hungrycats.org>
         <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
         <YdDAGLU7M5mx7rL8@hungrycats.org>
         <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
         <YdDurReZpZQeo+7/@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 2022-01-01 at 19:15 -0500, Zygo Blaxell wrote:
> Try rebooting to make sure the old mount is truly gone.
> 
> If the filesystem has been lazily umounted with open files it can be
> very difficult to find all the processes that are still holding the
> files open and force them to close.  Tools like 'fuser' and 'lsof'
> don't work after all the mount points have been deleted.

I couldn't find any indication that the file system remained mounted.
The mount point was empty, umount commands failed for all target
devices, as well as the mount point, and the mount table showed no
relevant entries.

I rebooted, and the file system mounted automatically (as normal). I
found no reports of problems in the log (below).

I performed a trivial test (writing "Hello world" to a file, and
reading), and it performed correctly.

Is it likely that data written before the bad events is entirely
intact, that all parts of the file tree not touched afterward have not
been damaged? How confident should I be of not having corruption?

Is it safe to try to continue to write data beyond the capacity of the
first device, into the additional device?

---


Jan 01 19:26:43 hostname kernel: Loading iSCSI transport class v2.0-870.
Jan 01 19:26:43 hostname kernel: iscsi: registered transport (tcp)
Jan 01 19:26:43 hostname kernel: aufs 5.x-rcN-20210809
Jan 01 19:26:43 hostname kernel: scsi host4: iSCSI Initiator over TCP/IP
Jan 01 19:26:43 hostname kernel: scsi host5: iSCSI Initiator over TCP/IP
Jan 01 19:26:43 hostname kernel: scsi 4:0:0:2: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: Attached scsi generic sg4 type 0
Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] 524288000 512-byte logical blocks: (268 GB/250 GiB)
Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Write Protect is off
Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Mode Sense: 43 00 10 08
Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
Jan 01 19:26:43 hostname kernel: scsi 4:0:0:1: Direct-Access     SYNOLOGY iSCSI Storage    4.0  PQ: 0 ANSI: 5
Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: Attached scsi generic sg5 type 0
Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] 524288000 512-byte logical blocks: (268 GB/250 GiB)
Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Write Protect is off
Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Mode Sense: 43 00 10 08
Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
Jan 01 19:26:43 hostname kernel:  sdd: sdd1
Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Attached SCSI disk
Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Attached SCSI disk
Jan 01 19:26:43 hostname kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 2 transid 9211 /dev/sdc scanned by systemd-udevd (386)
Jan 01 19:26:44 hostname kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 1 transid 9211 /dev/sdd1 scanned by systemd-udevd (396)
Jan 01 19:26:44 hostname kernel: kauditd_printk_skb: 13 callbacks suppressed
Jan 01 19:26:44 hostname kernel: audit: type=1400 audit(1641083204.403:25): apparmor="DENIED" operation="capable" profile="/usr/sbin/cups-browsed" pid=670 comm="cups-browsed" capability=23  capname="sys_nice"
Jan 01 19:26:47 hostname kernel: audit: type=1400 audit(1641083207.587:26): apparmor="STATUS" operation="profile_load" profile="unconfined" name="docker-default" pid=993 comm="apparmor_parser"
Jan 01 19:26:49 hostname kernel: bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
Jan 01 19:26:49 hostname kernel: Bridge firewalling registered
Jan 01 19:26:49 hostname kernel: bpfilter: Loaded bpfilter_umh pid 1017
Jan 01 19:26:49 hostname unknown: Started bpfilter
Jan 01 19:26:50 hostname kernel: Initializing XFRM netlink socket
Jan 01 19:28:45 hostname kernel: BTRFS info (device sdd1): flagging fs with big metadata feature
Jan 01 19:28:45 hostname kernel: BTRFS info (device sdd1): disk space caching is enabled
Jan 01 19:28:45 hostname kernel: BTRFS info (device sdd1): has skinny extents
Jan 01 19:28:45 hostname kernel: FS-Cache: Loaded
Jan 01 19:28:45 hostname kernel: FS-Cache: Netfs 'nfs' registered for caching
Jan 01 19:28:45 hostname kernel: NFS: Registering the id_resolver key type
Jan 01 19:28:45 hostname kernel: Key type id_resolver registered
Jan 01 19:28:45 hostname kernel: Key type id_legacy registered
Jan 01 19:28:45 hostname kernel: FS-Cache: Duplicate cookie detected
Jan 01 19:28:45 hostname kernel: FS-Cache: O-cookie c=00000000eab55a10 [p=00000000197b94cc fl=222 nc=0 na=1]
Jan 01 19:28:45 hostname kernel: FS-Cache: O-cookie d=000000007bc6e6c7 n=00000000d6efde4c
Jan 01 19:28:45 hostname kernel: FS-Cache: O-key=[16] '0400000001000000020008010a040102'
Jan 01 19:28:45 hostname kernel: FS-Cache: N-cookie c=00000000d8681119 [p=00000000197b94cc fl=2 nc=0 na=1]
Jan 01 19:28:45 hostname kernel: FS-Cache: N-cookie d=000000007bc6e6c7 n=00000000fd46ace5
Jan 01 19:28:45 hostname kernel: FS-Cache: N-key=[16] '0400000001000000020008010a040102'
Jan 01 19:29:15 hostname kernel: BTRFS info (device sdd1): the free space cache file (274908315648) is invalid, skip it

