Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA02D1235
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgLGNfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLGNfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:35:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104DC0613D1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:34:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v1so7353277pjr.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vs7JaEB0sksBSesomQeDabbOigPdkKLpSOm31BqPLfo=;
        b=P6LcbDrtBe05Wt6FDOwOOpjI3nL8W5NXkmRpsQbyOu6urSNt4BAD/yzDU9NGD3+MdY
         mggVDIZl5cDJenIFkz+5Bvs6c/q9owM1uUCc5f04SYXfvH2t0Eel7ucPymhWz1K8oGHa
         nNdgCunXu+8Mv1TKWqQ8BVgJUzkzJw8keiSc9/mfR9BtZlqs+9zmwGqeyyGeQR1DGblZ
         AjslSSGoiEuoGxaH3IRwAygN+zNxQ2nGYFdpLKV+kJ7GJuKTj5rvS+uU/riCTBcez0EZ
         dRzmq94CQC1rUPSsRMYH5pQIBAHUNgeZvdKHvcm7zn0mE59Y60bKvMBIlY7tnCgdXwue
         ijQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vs7JaEB0sksBSesomQeDabbOigPdkKLpSOm31BqPLfo=;
        b=dK9gitiIcyGQsvae7ktB0uxnrDi+o1QDP3iBjjxclcPoYrl7Qm7MqlRYzd8+CDcNiT
         SLIoRwf2yhEVCxMXGid5NIkrVTKPDubNrT7RZoEIDgPqp1azWdBMDDTEZ7hDOfVzMziV
         gKDri5p6CgP8Gt6Ry0PtbaZBYABLLSW91bu9dql9Nr4SQ//fWhqCA48yncbqsU03CQEE
         4pdQrdgxKlxgl1FUSEGvJzZ2bm+BALlSDVU336vL6+DRzoKBurQytpAuEHh3dO/PXVF0
         st7j8H7zqx2qeCNiG7yqXsIvJ07F1KoaVbsda60FDx422ptglp1QwPwx5YEr4l0Wtvti
         /01Q==
X-Gm-Message-State: AOAM530rRTO1Jqu0uCR5bhUkaTxvF4inljnGT2QhZMI8XPzTG5w5S0zb
        phM68bLMBsRODYQIPiqVTpKpDb0QEzR5HBDAbxWBwfXsRpM60Q==
X-Google-Smtp-Source: ABdhPJwRjBtVVQv0A0riDrhZ5Nm/qZLSQECb8TxQX39ACTdKchavGATMs8pWxEmOt/nfRINKuuvS0Us6in2T9z41z60=
X-Received: by 2002:a17:90b:4c41:: with SMTP id np1mr16219120pjb.186.1607348079295;
 Mon, 07 Dec 2020 05:34:39 -0800 (PST)
MIME-Version: 1.0
From:   Marcus Bannerman <m.bannerman@gmail.com>
Date:   Mon, 7 Dec 2020 13:34:28 +0000
Message-ID: <CAAdkh9xzT=wYY3jui3d4xF4kp20tB5EiL-KBJdMK69h1oWO3ig@mail.gmail.com>
Subject: data Raid6 with metadata Raid1c3 appears unrecoverable
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Help!
I have an array of 4x6Tb and 4x3Tb disks on BTRFS. I noticed I was
getting csum errors in dmesg, and found that one of the 3Tb drives was
failing. Smartctl reported a lot of read errors on one device. Short
tests were failing at 90%, but SMART status was still OK(!). I tried
removing the drive with a plan to then rebalance as I don't currently
have a spare drive.

$ btrfs devices remove /dev/sdX /raid
ERROR: error removing device 'missing': Input/output error

A lot of searching doesn't seem to give any advice on how to address
this. Most are comments that you should wipe, but I'm hoping the raid
will allow a partial recovery to save me time.

So I tried running a scrub, to see if it can fix the system to allow
me to remove the drive, maybe the errors are localised as Smartctl
reports the drive is still "OK" despite increasing read errors, then I
can remove the drive. The scrub starts reporting a lot of
uncorrectable errors, dmesg is full of errors from the device that is
failing. The scrub slows considerably and is telling me the scrub will
take at least a week to complete (5.7Tb of data on the array) and the
ETA is moving further away.

So cancel the scrub, I shut the computer down, pull the drive, and try
removing the device using the following command:

$ btrfs devices remove missing /raid
ERROR: error removing device 'missing': Input/output error

Still no luck. Why can't I remove a failing drive from the array?

Performing a scrub at this point gives 100% uncorrectable errors.

I can still mount the drive, and access the data. I get errors like
this on mount:

[13044.573841] BTRFS warning (device sdd): devid 7 uuid
27b4ab26-ac60-4bc7-a8a7-ab1d87394512 is missing
[13044.604734] BTRFS info (device sdd): bdev (efault) errs: wr
15816919, rd 1298069, flush 1, corrupt 4912020, gen 0
[13044.604736] BTRFS info (device sdd): bdev /dev/sde errs: wr 0, rd
14, flush 0, corrupt 0, gen 0
[13053.524470] BTRFS error (device sdd): csum mismatch on free space cache

running "btrfs check /dev/sdd" gives a lot of entries like t

failed to load free space cache for block group 5045543239680
But otherwise it is OK.
I want to try to recover the data, as a lot of this is flacs/rips of
my old media that took a long time to carry out.
I also want to understand the issue, as if I'm to try using BTRFS
again I need to be able to recover from single drive failures, this
seems way more complex than it should be.

My O/S is Fedora 33, kernel is 5.9.11-200.fc33.x86_64, btrfs-progs
v5.9, and any advice/help would be greatly appreciated.
