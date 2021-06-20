Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02CA3AE049
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 22:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhFTUdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 16:33:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF5C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 13:31:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c138so25336973qkg.5
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=syt+VC+oe+YkxJyKveY/fh86yz3WpEW8Hmg0PmznLOs=;
        b=JJZ4KJ+6HBxc7zzrqvzXsc5bvKKOch6alrGeT7bwZBAo7M4aA0bRzmmtwh/8f1cMEh
         3j6OKvej/aEkXjrB5J2vdohn3/jjyxi2ygk7Dcc4PM4IcHRBXe4o8qkApEOAtolvEQ4u
         Iln50R26LZEM1IYlo8w8IYf3rE7cai6Lvgn71v9Kj34DY6RHkICtZ1Nfxg15jnvl3lAm
         Vs3JJO1G/Rn3q8ZR4+vi2QISRLGOf6kdKLeIgE9n/3w9HZeqsTHxEUv2BY9EdP5/xQps
         4ak/YzS09FYF74Jj+87sNPh0yDNdaxBawWfmtY1ogfvPw+PA3U7isN66Gx172mOD5al1
         NLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=syt+VC+oe+YkxJyKveY/fh86yz3WpEW8Hmg0PmznLOs=;
        b=OSalaIEG0PGTIpJ/tHYIPmdC/aNlpcgymYiUm1ZKgyjZAccYIZ4rpNLhnqy24rvfYZ
         PnRpwwaGwIoywXm051pp+0aNqm3awNJzdpHuesWobbiXI7zLtO1T/eybXcPEOQx+l/4Q
         9K/r1cDO1DGBmPv0GTVtEpWh+yKyaBDgjShVZ/OvK4XeawDSB+sH3e8THqXQcL+vPZn3
         wlXHAGgF8qBCcb9RDxzY2lK85SMqE9jBBRfJlAvCzLScHMaE4hUeeD8au6Vas4ldfngw
         2kJBjjPriOi0lgo6CwJ/hkWA5GEJvQUqIlTYKhQmavn8GPp8i/ckFHO7tXdR4+2miqA/
         dilg==
X-Gm-Message-State: AOAM530SxgPGrbXIeVxDExP06DojWnISW2Kk8Fpjc2bnAGvpLfEpIJDU
        tZWsfJxH2ktQjdWm/mtQaLsYKZk8lhMvF8R2Hj8XZgLmc7w=
X-Google-Smtp-Source: ABdhPJyeuFhPY1u2TJgc1pHKsBJND7YB2mUj+57UVcHDQsS4XuroV9t7SsbG/yIpaZDq34UYQtMUqqR3L/VlK0O4Hyo=
X-Received: by 2002:a25:2681:: with SMTP id m123mr28381419ybm.121.1624221086783;
 Sun, 20 Jun 2021 13:31:26 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Sun, 20 Jun 2021 20:31:16 +0000
Message-ID: <CAEEhgEuN0mmyGjKi_zZDKE2+XzdfGno2xwhPg3sPQ8vQXDehQw@mail.gmail.com>
Subject: 
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A machine failed to boot, so I tried to mount its root partition from
systemrescuecd, which failed:

[ 5404.240019] BTRFS info (device bcache3): disk space caching is enabled
[ 5404.240022] BTRFS info (device bcache3): has skinny extents
[ 5404.243195] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243279] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243362] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243432] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243435] BTRFS warning (device bcache3): couldn't read tree root
[ 5404.244114] BTRFS error (device bcache3): open_ctree failed

btrfs rescue super-recover -v /dev/bcache0 returned this:

parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
Ignoring transid failure
ERROR: could not setup extent tree
Failed to recover bad superblocks

uname -a:

Linux sysrescue 5.10.34-1-lts #1 SMP Sun, 02 May 2021 12:41:09 +0000
x86_64 GNU/Linux

btrfs --version:

btrfs-progs v5.10.1

btrfs fi show:

Label: none  uuid: 76189222-b60d-4402-a7ff-141f057e8574
        Total devices 10 FS bytes used 1.50TiB
        devid    1 size 931.51GiB used 311.03GiB path /dev/bcache3
        devid    2 size 931.51GiB used 311.00GiB path /dev/bcache2
        devid    3 size 931.51GiB used 311.00GiB path /dev/bcache1
        devid    4 size 931.51GiB used 311.00GiB path /dev/bcache0
        devid    5 size 931.51GiB used 311.00GiB path /dev/bcache4
        devid    6 size 931.51GiB used 311.00GiB path /dev/bcache8
        devid    7 size 931.51GiB used 311.00GiB path /dev/bcache6
        devid    8 size 931.51GiB used 311.03GiB path /dev/bcache9
        devid    9 size 931.51GiB used 311.03GiB path /dev/bcache7
        devid   10 size 931.51GiB used 311.03GiB path /dev/bcache5

Is this filesystem recoverable?
