Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEDA4826D8
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 08:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiAAHeE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 02:34:04 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:42948 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiAAHeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 02:34:04 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id CC941405AB
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 01:34:47 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id F0DFF8206660
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 01:34:02 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id E3389820665E
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 01:34:02 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PUsNIhV8xgbl for <linux-btrfs@vger.kernel.org>;
        Sat,  1 Jan 2022 01:34:02 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 8CF2C820665D
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 01:34:02 -0600 (CST)
Message-ID: <7cffc181c0b01a52dfd82128eb656ec2ec44b94d.camel@ericlevy.name>
Subject: Re: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Sat, 01 Jan 2022 02:33:53 -0500
In-Reply-To: <CAJCQCtRxkZ4NjQA9KrOvb_ybDE-sg_BzzMU=91fT_p8gMEKw6Q@mail.gmail.com>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
         <Yc9Wgsint947Tj59@hungrycats.org>
         <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
         <CAJCQCtRxkZ4NjQA9KrOvb_ybDE-sg_BzzMU=91fT_p8gMEKw6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2021-12-31 at 16:09 -0700, Chris Murphy wrote:
> Dec 29 21:01:09 hostname kernel: sd 4:0:0:1: Warning! Received an
> indication that the LUN assignments on this target have changed. The
> Linux SCSI layer does not automatical
> ...
> Dec 30 03:47:10 hostname kernel: sd 4:0:0:1: rejecting I/O to offline
> device
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev
> sdc, sector 523542288 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio
> class 0
> 
> 
> Can you tell us more about /dev/sdc a.k.a. scsi 4:0:0:1? Because this
> device seems to be in a bad state, and is rejecting writes.
> 
> 
> --
> Chris Murphy


The hardware is an appliance with an array of SATA magnetic disks
managed in a RAID6-like volume. The volume is formatted with a top-
level Btrfs file system, on which is installed an OS that manages
services and provides an administrative interface. 

All of these components are presently reported healthy through normal
diagnostics and logging. More intensive diagnostics would include a
S.M.A.R.T. extended test of each media device, and a scrubbing of the
file system. All available indications suggest these operations would
expose no problems.

Above these lower layers runs a logical-unit manager and an iSCSI
service, allowing provisioning of logical volumes. After a volume is
provisioned, it is given appropriate permissions (e.g. R/W), and mapped
to an iSCSI target. Adding it to an existing target allows it be
detected by an initiator (the host using the volume) without any
administrative overhead on the remote side. However, the new mapping is
not broadcast, so the initiator must request a refreshed the list of
items in the target.

The log message you have reproduced shows the iSCSI daemon detecting a
new volume in the target, as a consequence of my instruction from the
administrative tool to refresh the list. The volume labeled 4:0:0:1, or
/dev/sdc already existed. The one that was added was 4:0:0:2, or
/dev/sdd.

In this case, the logical units, one pre-existing and one new, were the
volumes for the failing file system.

Since all of these operations were new to me, I tried a variety of
smaller operations at each step to finally achieve the end result.  I
have no indication that I caused any problems, but it is possible there
were side effects due to my own missteps, or quirks in the design of
the administrative system.

While I think a problem of such kind is unlikely, it seems more likely
than a problem at a lower level.

Possible reasons for the device becoming read only include the
following:

   1. As a side effect of provisioning the new volume, write privileges
      were effectively removed for the existing one.
   2. The LV backend became confused and entered a protective state.
   3. The iSCSI initiator was unable to add a new volume without affecting
      the existing one.

However, the logs show that between the detection of the new volume and
the reversion to the RO state, several add and remove operations were
completed. Without knowing about the mechanics of Btrfs, I would
postulate that these operations depend on successful write access to
all devices in the pool, including any added or removed. It appears to
me as though the volumes were healthy and accessible for at least some
time, which can be calculated from the log timestamps, long enough for
me to issue commands.

Thus, my first thought was a file-system issue, not a device issue.

Is the present indication more strongly that a) the driver refuses to
mount the file system because its state shows as corrupt, or b) the
driver aborts the mount operation because it fails to write at the
block level?

If the problem is device-level, then there is much to try, including
renewing the iSCSI login. I can also restart the daemon, reboot the
host, even restart the iSCSI backend service or appliance. 

Would any operations of such a kind be helpful to try?




