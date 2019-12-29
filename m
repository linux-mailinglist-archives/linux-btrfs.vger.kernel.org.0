Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588DE12C03A
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 04:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfL2DFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 22:05:04 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42626 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfL2DFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 22:05:03 -0500
Received: by mail-wr1-f54.google.com with SMTP id q6so29725154wro.9
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Dec 2019 19:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=bG/7wPAT4XGHyLMfm86E7UWePI6kswW4HnyrI6ZyAQE=;
        b=WYYaaYAqIL+cGxA34Lmve8Ar1E+lErU3oCZXEvKFw+JKJhT6YCap4UcAapsBs9RESW
         jMWpyk085CG3lguLT/gV60rVkBgx0IkSfO+WGHCc/cTsKqqBAKvlDh1XyrRq6YXpYW4A
         PzVGwneOyPRi3c1mfzvYMuw0vvrZjC0VbCiLXpoc0x/xY2Erir7vlnTasQR4C/DcwaTM
         DNXXmIA6uDC2kI601bMhvbOM4C3XrS+5EbPXC46gEuKFI5oHKJsvUC2EVr5M/BB6yea3
         tpY2sug1QjZZ/BPj9X50/pYBvTDYCCZmwtoKmRZPXDZBiIHIG0mWbJmoxDg/+KT1fIvA
         EFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bG/7wPAT4XGHyLMfm86E7UWePI6kswW4HnyrI6ZyAQE=;
        b=pLGLF1D3MbXs19/0kPX4x0+rDEM21wQicPKacbd/Y9llCwtXDjGvt3H8q/JUUhffa3
         CFAMiwXz58F62t/C2MVAUOfVKDAmDg8evebC5VBfsThG2FXLxDP+DD+036t8Bwess7FM
         WfYCoBbg2HAI4KMd8fKkHreiSZvsSZXcI3BSXNyZ5g2R/JBvEmbTKkH5lRfykdoCsXtk
         Y0pgAnl0j6SDrjsbYs5Y6P3cbdSyRD9RrVy+uH9nuxCFtlS4u6WI1whng+5T3jom4v5K
         Ea3/03UelS+sJR5QKiCaPGUsF9YMi5/KdLELFysYrhtDwg1biddkZp2VDcX7qd7FPDk6
         g+WA==
X-Gm-Message-State: APjAAAUH72PZ0v5MFGAyJl3UUhjIwbos5As5+7PRDH0x8qKCAucrb1aA
        JQ5pn2Ar6wRO2iYvnN9nWHvc8lLTTTmJDQ7+gI7IkyO9iYP+bg==
X-Google-Smtp-Source: APXvYqwgRYtE0ha9+25ZxPpmz+Ap+I8tHrcAZRurux3MbcszUsPha3gPPXM5a45lsSYM/1xE2FApJSmAjFAYDbCrDBw=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr59001568wre.390.1577588701372;
 Sat, 28 Dec 2019 19:05:01 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 28 Dec 2019 20:04:45 -0700
Message-ID: <CAJCQCtR90w=RMb8xM8a8HJXke4tAiJri3TH_Z874waa7tgNpoA@mail.gmail.com>
Subject: seed/sprout resets generation?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a bunch of read-only snapshots that have an identical
generation per the default output from 'btrfs sub list -t
/mountpoint/' even though the snapshots were created years apart, and
many are unrelated to each other.

My best guess is the original volume was at generation 27709, at the
time it was made into a seed device, and then replicated into a
sprout. The original file system is gone, and what I have now is this
sprout, now at generation 33935.

I wonder if a similar effect happens with btrfs replace or btrfs dev add/rem?

The leaf containing the ROOT_ITEM for an example snapshot from 2016

generation 27709 root_dirid 256 bytenr 1471499272192 level 2 efs 1
lastsnap 27697 byte_limit 0 bytes_used 92422144 flags 0x1(RDOLY)
uuid d5d492f6-7421-c74b-a383-287caaac9a6c
parent_uuid 305449bb-3580-614e-8f7e-e30c8385e0e6
ctransid 1004 otransid 1007 stransid 0 rtransid 0

That's a bit confusing. I guess otransid=ogen and ctransid is
something else. And transid=generation. And also something else called
lastsnap. All different values.

The fs_tree show the transid for this snapshot is 27709, which matches
the generation found in the ROOT_ITEM.


-- 
Chris Murphy
