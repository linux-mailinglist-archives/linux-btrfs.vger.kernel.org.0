Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5192148670B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbiAFPs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 10:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiAFPs5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 10:48:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340BC061245
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 07:48:57 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g80so8785069ybf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jan 2022 07:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=T4t331y5UUNxT80t/8le8tklJUXwFG4E+TGhF/gzQG8=;
        b=Mz7L9zX8Dk1dKbn2p/aDXWK4bEA2Lsaw5cj5yLjvQWycpEB7uvt6TW3oNpLeBzah14
         U9XIz7Bs4Mce8+S7H1HvOEkpNgBp+bpxR3y2KWZWRq+/Z09H8M7Bu0ZMc85te/krv8d+
         bawpwuqYijq5ZJzZFWIYqUODZFFJMgFEQOz/cSTlNavHUvQ95BPlS451itNJ4ss9fXCk
         Oi2XUapn2aqCUVRWKgY/+Ujtr/3rM1ihZXSZpvWsG6O8+q71QuapONPr+4itGhUGjP3X
         aVYI0qYel4wdf9F4XfjVAbVWC+9DkADGqt4UOigtFTxFSJUcqMRrBMQGW2hB2vUnX00z
         o57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=T4t331y5UUNxT80t/8le8tklJUXwFG4E+TGhF/gzQG8=;
        b=xgoop1NqjhxriVVojALYqKjRIrhIUwjm+HeuLif+s4GGi2O15T51CLYaeymUea7QJ8
         oYYB4W0KEWq+z4cD2rPVjYw/RhlhvZ5TVUUTejaLAPKPGIs5P6KK/5bjZ1eeqinvVS00
         KvpqxIIahUDak3L5uq83vFU5W2xHg49ljdnwS+Wu4aooZEwSadf2/Vic4MUQjewBs769
         soTzEsYzSOc+nPqogSiH8+H9VUi1W6XzjxZ1385ut6o33lAlzDl/PMjaTusRhDboxhdh
         Pul4OLW8zz2jG2xy7Pi7YKzumcu4ndc1PRCNsg8Om8WEngtCFjkgN4lGT8O3Crj+PcT1
         ijJw==
X-Gm-Message-State: AOAM5331n+fz+b2hBA5yn7Iy196TSYGe/gONvqTgWwyGWNQ2u2zisfsF
        G/iPcrVAQNRXZX+zpVYIYQvHnZ9Ya9uk3HyOxJzQx+sFCQY=
X-Google-Smtp-Source: ABdhPJwDtmyPfXnGV7xAWalk3ZH7m6QwLECIRkhlb0twYROXPfqMiEJS7jmdz44oCimoe0Fua63nE7bfFIG1nc9iTW8=
X-Received: by 2002:a25:c143:: with SMTP id r64mr62881135ybf.286.1641484136585;
 Thu, 06 Jan 2022 07:48:56 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Juan_Sim=C3=B3n?= <decedion@gmail.com>
Date:   Thu, 6 Jan 2022 16:48:21 +0100
Message-ID: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com>
Subject: 48 seconds to mount a BTRFS hard disk drive seems too long to me
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hard disk: 16TB SEAGATE IRONWOLF PRO 3.5", 7200 RPM 256MB CACHE
Arch Linux
Linux juan-PC 5.15.13-xanmod1-tt-1 #1 SMP Thu, 06 Jan 2022 12:14:06
+0000 x86_64 GNU/Linux
btrfs-progs v5.15.1

$ btrfs fi df /multimedia
Data, single: total=10.89TiB, used=10.72TiB
System, DUP: total=8.00MiB, used=1.58MiB
Metadata, DUP: total=15.00GiB, used=13.19GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

I have formatted it as BTRFS and the mounting options (fstab) are:

/multimedia     btrfs
rw,noatime,autodefrag,compress-force=zstd,nossd,space_cache=v2    0 0

The disk works fine, I have not detected any problems but every time I
reboot the system takes a long time due to the mounting of this drive

$ systemd-analyze blame
48.575s multimedia.mount
....

I find it too long to mount a drive, is this normal, is it because of
one of the mounting options, or because of the size of the hard drive?

Thanks in advance. Regards.
