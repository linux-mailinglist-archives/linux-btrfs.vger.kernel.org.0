Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5794828D0
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 01:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiABAPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 19:15:42 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:33888 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbiABAPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Jan 2022 19:15:42 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 3FB7612FE91; Sat,  1 Jan 2022 19:15:41 -0500 (EST)
Date:   Sat, 1 Jan 2022 19:15:41 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed
Message-ID: <YdDurReZpZQeo+7/@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org>
 <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
 <YdDAGLU7M5mx7rL8@hungrycats.org>
 <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 01, 2022 at 04:58:58PM -0500, Eric Levy wrote:
> Here is the new information:
> 
> 
> 1) Previously, the system log from R/W mount attempt, which failed:
> 
> Dec 31 15:15:48 hostname sudo[1477409]:      user : TTY=pts/0 ; PWD=/home/user ; USER=root ; COMMAND=/usr/bin/mount -o skip_balance /dev/sdc1
> Dec 31 15:15:48 hostname sudo[1477409]: pam_unix(sudo:session): session opened for user root by (uid=0)
> Dec 31 15:15:48 hostname sudo[1477409]: pam_unix(sudo:session): session closed for user root
> Dec 31 15:15:48 hostname kernel: BTRFS info (device sdc1): disk space caching is enabled
> Dec 31 15:15:48 hostname kernel: BTRFS error (device sdc1): Remounting read-write after error is not allowed
> 
> 
> 2) Same, but in RO:
> 
> Dec 31 15:14:50 hostname sudo[1477248]:      user : TTY=pts/0 ; PWD=/home/user ; USER=root ; COMMAND=/usr/bin/mount -o skip_balance,ro /dev/sdc1
> Dec 31 15:14:50 hostname sudo[1477248]: pam_unix(sudo:session): session opened for user root by (uid=0)
> Dec 31 15:14:50 hostname sudo[1477248]: pam_unix(sudo:session): session closed for user root
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (Device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675
> Dec 31 15:14:50 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867434496 wanted 9212 found 8675

There's no log messages from the ctree open and it's complaining about
remounting, so you still have the filesystem mounted somewhere, i.e. you
did not umount it successfully.  This would also lead to assigning new
SCSI device IDs instead of reusing the old ones, and getting duplicate
device complains during device scan.

Maybe you did a lazy umount and there's still an open file on the
filesystem?

> 3) After running iSCSI logout, and login, the devices were assigned new
> names (sdc -> sdf, sdd -> sde). Then checking with readonly flag, using
> admin tools, while unmounted:
> 
> $ sudo btrfs check --readonly /dev/sdf1
> Opening filesystem to check...
> Checking filesystem on /dev/sdf1
> UUID: c6f83d24-1ac3-4417-bdd9-6249c899604d
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 266107584512 bytes used, no error found
> total csum bytes: 259546380
> total tree bytes: 586268672
> total fs tree bytes: 214188032
> total extent tree bytes: 52609024
> btree space waste bytes: 89657360
> file data blocks allocated: 1019677446144
>  referenced 300654301184

That's a good sign that the data on disk is OK.

> 4) However, mount still fails. Here is log output from trying to mount
> /dev/sdf1:
> 
> kernel: BTRFS warning: duplicate device /dev/sdf1 devid 1 generation 9211 scanned by mount (1641108)

Again there are no ctree open messages, so you're adding a new subvol
mount point to a filesystem that is already mounted, which means you
didn't successfully umount earlier.

The old device (/dev/sdc and /dev/sdd1) is still mounted, so btrfs device
scan and/or mount will complain about duplicate devices.

> 5) Same kind of results for /dev/sde:
> 
> kernel: BTRFS warning: duplicate device /dev/sde devid 2 generation 9211 scanned by mount (1642247)

Try rebooting to make sure the old mount is truly gone.

If the filesystem has been lazily umounted with open files it can be
very difficult to find all the processes that are still holding the
files open and force them to close.  Tools like 'fuser' and 'lsof'
don't work after all the mount points have been deleted.
