Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FEA34F890
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 08:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhCaGOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 02:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhCaGOQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 02:14:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C7C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 23:14:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so18393132wrt.6
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VunFfdenocrHVJKnlewYGRbjLxyx4WlauhwRsxFATBA=;
        b=AOKSDX2ULUXOtcGju1Iem9ipbyFDFhpGmdjl1Pi99PnmxJg4RK3HWsebjiz4e8O/cU
         H0l9b+0kg/x1rB+BJBDZei983kwb3wCyfpoSNiTQgTRI8XDEPgSHg+lHUCM1qSnLf9Cb
         YBPbbl0Qr7JLCqQkcymPS6JXMgBNqyJauG1mz8WOmCgHb5S7nioOy1G0R9IR7KeLq8wz
         qbP6vJPe8u6MnNW5hUD9i/cXe1cq7dwq/fICowveFRRntKcB1eLCGBp98QhklYjGy35D
         45Q5JfIPjtpbIeL4mlIq4bQsWboDtLqFDseqY8jILitrhUw7K4gT9vINYCqioBKJuuwY
         vI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VunFfdenocrHVJKnlewYGRbjLxyx4WlauhwRsxFATBA=;
        b=GdSZObM4cSd4u7sFzXSxb9k3Ht16EEpT/mq5or1rOYdh9W/C7VracaqxuM3YNH6V1C
         BoxFFzDBS46E7XNnORMvIzXg83WV/L94ANmiNk8lPobolf3HtRJP3W5EJM2Ix4Xl2RZC
         858oBOBBywjEL1IudJSNJGwbqDXaMyz4sIZsnKeLXASjwALnlKPHwSD0rk9of7o6XCmm
         GzYiVK6ARi99NPHgxG+iNNTQh36kUmn+WBkpdRHRRWHCxZTV3es5xGvPY7fON6Wva8sL
         l2d4RDOwk6GoACksM89m2rqMBPE0AcpkyTThVVlR79NAIzsNN0gMunQgGPI90vCI1Gut
         6MYg==
X-Gm-Message-State: AOAM531jfxv9Zno5PiivrhaDsphhcLx85NYocKSqP3CI0mjrTcGg7D2u
        qVatnrJzp1qTquXCMVooV/6dlHiUUQaViUZ91zTZc3b5vncZRA==
X-Google-Smtp-Source: ABdhPJxvDw5q7fiR7o2IsV1wB8wW6Ve0xhtKMDy+49/tFc+/eLZ94KoPnFEX7p3sskiTjdHtBFJ0e1uwK7lPkRmrN2Y=
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr1681910wrz.42.1617171252876;
 Tue, 30 Mar 2021 23:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
In-Reply-To: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 31 Mar 2021 00:13:56 -0600
Message-ID: <CAJCQCtRM-MUPTBSmXa=PE-MBWBrLFta2Gx1+AY1Hox5AZBSfxQ@mail.gmail.com>
Subject: Re: Support demand on Btrfs crashed fs.
To:     Thierry Testeur <thierry.testeur@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm going to fill in some details from the multiday conversation with
IRC regulars. We couldn't figure out a way forward.

* WDC Red with Firmware Version: 80.00A80, which is highly suspected
to deal with power fail and write caching incorrectly, and at least on
Btrfs apparently pretty much always drops writes for critical
metadata.
* A power fail / reset happened
* No snapshots
* --repair and --init-extent-tree  may not have done anything because
they didn't complete
* Less than 10% needs to be recovered and it's accepted that it can't
be repaired. The focus is just on a limited restore, but we can't get
past the transid failures.


zapan@UBUNTU-SERVER:~$ sudo btrfs check --readonly /dev/md0
Opening filesystem to check...
parent transid verify failed on 23079040831488 wanted 524940 found 524941
parent transid verify failed on 23079040831488 wanted 524940 found 524941
Ignoring transid failure
parent transid verify failed on 23079040319488 wanted 524931 found 524939
Ignoring transid failure
Checking filesystem on /dev/md0
UUID: f4f04e16-ce38-4a57-8434-67562a0790bd
[1/7] checking root items
parent transid verify failed on 23079042863104 wanted 423153 found 524931
parent transid verify failed on 23079042863104 wanted 423153 found 524931
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=23079040999424 item=11 parent
level=2 child bytenr=23079042863104 child level=0
ERROR: failed to repair root items: Input/output error
[2/7] checking extents
parent transid verify failed on 23079042863104 wanted 423153 found 524931
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=23079040999424 item=11 parent
level=2 child bytenr=23079042863104 child level=0
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
root 5 root dir 256 not found
parent transid verify failed on 23079042863104 wanted 423153 found 524931
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=23079040999424 item=11 parent
level=2 child bytenr=23079042863104 child level=0
ERROR: errors found in fs roots
found 0 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 0
total fs tree bytes: 0
total extent tree bytes: 0
btree space waste bytes: 0
file data blocks allocated: 0
referenced 0

btrfs-find-root doesn't find many options to work with, and all of
them fail with 'btrfs restore -t'


zapan@UBUNTU-SERVER:~$ sudo btrfs-find-root /dev/md0
parent transid verify failed on 23079040831488 wanted 524940 found 524941
parent transid verify failed on 23079040831488 wanted 524940 found 524941
Ignoring transid failure
parent transid verify failed on 23079040319488 wanted 524931 found 524939
Ignoring transid failure
Superblock thinks the generation is 524941
Superblock thinks the level is 2
Found tree root at 23079040999424 gen 524941 level 2
Well block 23079040327680(gen: 524940 level: 2) seems good, but
generation/level doesn't match, want gen: 524941 level: 2
Well block 23079040389120(gen: 524939 level: 2) seems good, but
generation/level doesn't match, want gen: 524941 level: 2
zapan@UBUNTU-SERVER:~$ sudo btrfs restore -viD -t 23079040389120
/dev/md0 /mnt/raid1/restore/
parent transid verify failed on 23079040389120 wanted 524941 found 524939
parent transid verify failed on 23079040389120 wanted 524941 found 524939
Ignoring transid failure
parent transid verify failed on 23079040323584 wanted 524939 found 524941
parent transid verify failed on 23079040323584 wanted 524939 found 524941
Ignoring transid failure
parent transid verify failed on 23079040319488 wanted 524931 found 524939
Ignoring transid failure
This is a dry-run, no files are going to be restored
Reached the end of the tree searching the directory
zapan@UBUNTU-SERVER:~$ sudo btrfs restore -viD -t 23079040327680
/dev/md0 /mnt/raid1/restore/
parent transid verify failed on 23079040327680 wanted 524941 found 524940
parent transid verify failed on 23079040327680 wanted 524941 found 524940
Ignoring transid failure
parent transid verify failed on 23079040831488 wanted 524940 found 524941
parent transid verify failed on 23079040831488 wanted 524940 found 524941
Ignoring transid failure
parent transid verify failed on 23079040319488 wanted 524931 found 524939
Ignoring transid failure
This is a dry-run, no files are going to be restored
Reached the end of the tree searching the directory





-- 
Chris Murphy
