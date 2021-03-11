Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF17337F29
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 21:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCKUj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 15:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCKUjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 15:39:31 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857EC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 12:39:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id g4so14417784pgj.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=dRk3Kx9qktDh5zPUMLZuWPj/dwqREEOtFiOdbp0qHVo=;
        b=hBaOQKQeZs366Bws/mFU4oCQozIinBKrVp/pl8v8fMvWSnMBQEQFFCyMGeM9pNWBgq
         JpbftdzSKpCc7/EXO1kYkOiiwH7olXi7aqpW+BLtBkMj/dBz+YFJ5V0fN6+a1/6wk2vp
         nHK2i4a4510b9/BaIwFTYBOLGKOCiLoC0uDBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dRk3Kx9qktDh5zPUMLZuWPj/dwqREEOtFiOdbp0qHVo=;
        b=JOpQD708JECt5Jyv5IwRFfyJOKZ9l08tqz5jBsJCGvU6z/pqsuLF788dnKuDafI8tj
         Z1znyI5+RkEGseDwkUMW16ABCzl1Yslc/4LzJ+A/Noz8rBZkNxDmG3g4NZRmvDoGJIiA
         a5BW/mK5oExd0YHhgkmefjQoIEbTLOf/sHjlJgp0MjTF9REYdDwc51rjzGhLWyPjr3WX
         WeqSVV6V1IOW1nUou7vPk/icdJr7Q2WlQDRoSfbwObAfGfm1YlqQobtUH1EaFIpmKDpy
         dT079QMG1BV7sSNP4v9/eLPqYQwb/TvXVBL/u9ccU3hRpN3DQ4EeD84Ze9PwYPZUL32Y
         RfZg==
X-Gm-Message-State: AOAM5317PxxTAW8Ll7JVZ/z+Utpi3LKzyafihjV9Bs0tmo2WydXdFP5O
        wUn2XLipRcsZnH7jRO7/6yHTK++F7/G0Ox+ZJHVnaiHk6aRa6g==
X-Google-Smtp-Source: ABdhPJw9bihQNEKiyIYrkmvXcypOyh+4hQauqjsbzT1TnD/jE4Zg1GNv+hDPoCLDhAzhWOQ3PNT5h13m1xfWr1I3KcM=
X-Received: by 2002:aa7:8d8a:0:b029:1f8:aa27:7203 with SMTP id
 i10-20020aa78d8a0000b02901f8aa277203mr9171115pfr.64.1615495170536; Thu, 11
 Mar 2021 12:39:30 -0800 (PST)
MIME-Version: 1.0
From:   Tavian Barnes <tavianator@tavianator.com>
Date:   Thu, 11 Mar 2021 15:39:19 -0500
Message-ID: <CABg4E-kT0x_uKf-j2fdjqh-8H==Op_xbraaf=jLvNKOoF2n--A@mail.gmail.com>
Subject: balance convert to raid0 makes low-utilization block groups
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm in the process of converting my "single" data to "raid0" for the
performance benefits of striping.  However, watching the output of
btrfs fi usage, I'm seeing something odd.  Here's the current usage:

Data,single: Size:4.47TiB, Used:4.47TiB (99.98%)
  /dev/mapper/neutrino3         300.00GiB
  /dev/mapper/neutrino4         300.00GiB
  /dev/mapper/neutrino5           1.29TiB
  /dev/mapper/neutrino6           1.29TiB
  /dev/mapper/neutrino7           1.29TiB

Data,RAID0: Size:1.62TiB, Used:1.62TiB (99.78%)
  /dev/mapper/neutrino3         332.00GiB
  /dev/mapper/neutrino4         332.00GiB
  /dev/mapper/neutrino5         332.00GiB
  /dev/mapper/neutrino6         332.00GiB
  /dev/mapper/neutrino7         332.00GiB

Now I convert 50G of data from single to raid0 with btrfs balance
start -dconvert=raid0,soft,devid=3,limit=50 /mnt/neutrino.  The usage
now looks like this:

Data,single: Size:4.42TiB, Used:4.42TiB (99.98%)
  /dev/mapper/neutrino3         250.00GiB
  /dev/mapper/neutrino4         300.00GiB
  /dev/mapper/neutrino5           1.29TiB
  /dev/mapper/neutrino6           1.29TiB
  /dev/mapper/neutrino7           1.29TiB

Data,RAID0: Size:1.87TiB, Used:1.67TiB (89.34%)
  /dev/mapper/neutrino3         382.00GiB
  /dev/mapper/neutrino4         382.00GiB
  /dev/mapper/neutrino5         382.00GiB
  /dev/mapper/neutrino6         382.00GiB
  /dev/mapper/neutrino7         382.00GiB

IOW it allocated 250G of raid0 block groups but only filled them with
50G of data.  It's back to normal after I rebalance those block groups
with btrfs balance start -dconvert=raid0,profiles=raid0,usage=80
/mnt/neutrino:

Data,RAID0: Size:1.67TiB, Used:1.67TiB (99.79%)
  /dev/mapper/neutrino3         342.00GiB
  /dev/mapper/neutrino4         342.00GiB
  /dev/mapper/neutrino5         342.00GiB
  /dev/mapper/neutrino6         342.00GiB
  /dev/mapper/neutrino7         342.00GiB

Any idea why?

-- 
Tavian Barnes
