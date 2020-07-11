Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC521C19F
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 03:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGKBh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 21:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKBh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 21:37:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B734C08C5DC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 18:37:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 22so7898750wmg.1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=n6UFJ/excSM439dp6N0giI+YVh73oslynMlKHNiB8hk=;
        b=mjdpRy5PEI4IM2yCJ2vwdT/KuwNFKHWWVydLc4io1a3IYA2/UpljjmZV3T65e3Xly9
         jrRX3eL4/Q+F8JluciO1rKiCmr2zfNtxkcjXaC35tfQYVmboFGEJbiaBuz1qTsCxslYm
         dcqVIr+IkRuJPv3ttwy104e+RQKoOTlqvK5k/RlHWhZxwmHf7LTsQvcxcuE3uL777Jlr
         jhwp9pyGNW01h88I4x6VV6nk7WsmQ+FS2arjPWESQEpp0KOeljz8gz+ryPVHJoEHHDQ2
         7ZJn+0VPN5c/bijo03qTVHFLTnCRNlWNlt+WBgRF/U1iuNf+XmwLjq/dUYX0VaCZDKwM
         ZYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n6UFJ/excSM439dp6N0giI+YVh73oslynMlKHNiB8hk=;
        b=Qnb4kEPfm/uofx15QU+JAYkTFrLZfBUheMchBiW26ZRWHyigAkaQvRTRrsd0EFXTHx
         aKXtOv+HWlAkR66fI85xIfZZLvlPBZUWJ/xiqu+LRxsbHmH2BGlh721Wn+coyf1Cvvd0
         5RkAGo7eM/qqCPBOUM6ucMHOKhVrPiyMR4JAK5cvroa2OZG6kx/dnPcBq3BiwWZmNz6D
         HOoqz51NBiVZDANB//DUNrjXcJPXqRVIFz7EkgzuA8fSzT4OjZWswY8Oq5H+48TiTNS4
         GZ72+E+C2LliHDq5BnKhrRr58ROFuEZL1QDiVIPUTV4RcpU9P3ggRyox0k+e6XoByXz1
         QKTA==
X-Gm-Message-State: AOAM5319E8cQ6A8QJBWw378qd+gYjWbFEybJEdPG2X63ObJ6fDvj3KSJ
        yQen7f+eNTYwmnokGJuNK6VJx3RYdmsk1GTLILxKphoVkJY=
X-Google-Smtp-Source: ABdhPJwvpniBgCO3DRX/K33AXBHfUlNYdXKZa8QxpDug88um8ZMC4Qsylhqm6UI65bt5yV0a1EPRu+Q4Gumr9EOc3Uo=
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr7578671wmi.128.1594431473209;
 Fri, 10 Jul 2020 18:37:53 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 10 Jul 2020 19:37:37 -0600
Message-ID: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
Subject: raid0 and different sized devices
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Summary:

df claims this volume is full, which is how it actually behaves. Rsync
fails with an out of space message. But 'btrfs fi us' reports
seemingly misleading/incorrect information:

    Free (estimated):          12.64GiB    (min: 6.33GiB)

If Btrfs can't do single device raid0, and it seems it can't, then
this free space reporting seems wrong twice. (Both values.)

Details:

# uname -r
5.8.0-0.rc3.20200701git7c30b859a947.1.fc33.x86_64
# btrfs --version
btrfs-progs v5.7


# btrfs fi show
Label: 'fedora_localhost-live'  uuid: 1fa3ab85-2dec-46f8-9a35-264c0f412dcc
    Total devices 2 FS bytes used 885.83MiB
    devid    1 size 730.00MiB used 709.00MiB path /dev/vda3
    devid    2 size 13.30GiB used 709.00MiB path /dev/vdb1


# df -h
Filesystem           Size  Used Avail Use% Mounted on
/dev/vda3             15G  905M   60M  94% /mnt/sysroot


# btrfs fi us /mnt/sysroot
Overall:
    Device size:          14.01GiB
    Device allocated:           1.38GiB
    Device unallocated:          12.63GiB
    Device missing:             0.00B
    Used:             901.58MiB
    Free (estimated):          12.64GiB    (min: 6.33GiB)
    Data ratio:                  1.00
    Metadata ratio:              2.00
    Global reserve:           3.25MiB    (used: 0.00B)
    Multiple profiles:                no

Data,RAID0: Size:890.00MiB, Used:870.08MiB (97.76%)
   /dev/vda3     445.00MiB
   /dev/vdb1     445.00MiB

Metadata,RAID1: Size:256.00MiB, Used:15.73MiB (6.15%)
   /dev/vda3     256.00MiB
   /dev/vdb1     256.00MiB

System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
   /dev/vda3       8.00MiB
   /dev/vdb1       8.00MiB

Unallocated:
   /dev/vda3      21.00MiB
   /dev/vdb1      12.61GiB
#


-- 
Chris Murphy
