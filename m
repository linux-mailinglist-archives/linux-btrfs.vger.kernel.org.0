Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D62424F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 07:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHLFXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 01:23:43 -0400
Received: from p-impout010aa.msg.pkvw.co.charter.net ([47.43.26.141]:49606
        "EHLO p-impout001.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgHLFXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 01:23:42 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 01:23:42 EDT
Received: from static.bllue.org ([66.108.6.151])
        by cmsmtp with ESMTP
        id 5j7okuMZvOQ8h5j7okf2wG; Wed, 12 Aug 2020 05:16:33 +0000
X-Authority-Analysis: v=2.3 cv=SrXuF8G0 c=1 sm=1 tr=0
 a=M990Q3uoC/f4+l9HizUSNg==:117 a=M990Q3uoC/f4+l9HizUSNg==:17
 a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=nn-7OC4BeTXFrQUPhbAA:9 a=CjuIK1q_8ugA:10
Received: from bllue.org (localhost.localdomain [127.0.0.1])
        by static.bllue.org (Postfix) with ESMTP id AF792C14F1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 01:16:30 -0400 (EDT)
MIME-Version: 1.0
Date:   Wed, 12 Aug 2020 01:16:30 -0400
From:   kenneth topp <ken@bllue.org>
To:     linux-btrfs@vger.kernel.org
Subject: filesystem issues after abrupt powerloss.
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <87e7782c5b1a8e6a46e500b2382be421@bllue.org>
X-Sender: ken@bllue.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on static.bllue.org
X-CMAE-Envelope: MS4wfB7s3JVKCKsNLMbvPbhD7mbnBtFrxBL2o5zVBFepqaW/oKWHwGBdMhxuITtB0a9HL5oR/okpBaHsY7d0iMehJBWbEjvjXZbnv3wfLHIQ7TdkAYJbIRMy
 p4F77lD6U3ZZQj3/WGs3ivfHtBUy18LE0DoRPEAi4D2758LeT39dpPre
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

greetings,

my btrfs on luks device is having troubles again.  I believe the system 
abruptly powerdown due to heat.

I believe my backups are in good order.  Does anyone have any 
suggestions how to recover this filesystem by running a check  --repair 
or scrub?    Should I trust such a recovery or just recreate the 
filesystem from backups.

Are there any other debugging commands I can run to provide more 
information?

Are there any known defects in the filesystem that would explain how 
this filesystem got so corrupt?

relevent part of dmesg:

[ 1381.291103] BTRFS warning (device dm-22): 'recovery' is deprecated, 
use 'usebackuproot' instead
[ 1381.291104] BTRFS info (device dm-22): trying to use backup root at 
mount time
[ 1381.291105] BTRFS info (device dm-22): using free space tree
[ 1381.291106] BTRFS info (device dm-22): has skinny extents
[ 1488.716374] BTRFS info (device dm-22): checking UUID tree
[ 1520.983660] BTRFS error (device dm-22): parent transid verify failed 
on 19934974361600 wanted 675675 found 675394
[ 1520.984138] BTRFS error (device dm-22): parent transid verify failed 
on 19934974361600 wanted 675675 found 675394
[ 1520.984151] BTRFS: error (device dm-22) in __btrfs_free_extent:3080: 
errno=-5 IO failure
[ 1520.984157] BTRFS info (device dm-22): forced readonly
[ 1520.984163] BTRFS: error (device dm-22) in 
btrfs_run_delayed_refs:2188: errno=-5 IO failure

rest of diagnostics

#   uname -a
Linux static.myhost 5.4.52-100.fc32.x86_64 #1 SMP Thu Jul 16 12:00:22 
EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
#   btrfs --version
btrfs-progs v5.7
#   btrfs fi show
Label: 't2'  uuid: ce50d21c-7727-4a53-b804-d02480643dfa
         Total devices 2 FS bytes used 640.00KiB
         devid    1 size 447.13GiB used 2.01GiB path /dev/mapper/cprt-30
         devid    2 size 447.13GiB used 2.01GiB path /dev/mapper/cprt-31

Label: 'btm'  uuid: 0a5b42a7-0e39-48fa-be1f-4aa29bc323f2
         Total devices 2 FS bytes used 27.34TiB
         devid    1 size 14.55TiB used 13.70TiB path /dev/mapper/cprt-50
         devid    2 size 14.55TiB used 13.70TiB path /dev/mapper/cprt-53
# btrfs fi df /mnt
Data, single: total=27.31TiB, used=27.30TiB
System, RAID1: total=32.00MiB, used=2.88MiB
Metadata, RAID1: total=47.00GiB, used=46.72GiB
GlobalReserve, single: total=512.00MiB, used=0.00B




thanks,

ken
