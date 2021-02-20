Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1A3202CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 03:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhBTCC5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 21:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBTCCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 21:02:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CFAC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 18:01:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a4so9040270wro.8
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 18:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YQkGAV2fegPpVuB36QVanw5bEtOjn8XGo7Yloc0PnOE=;
        b=CrOQmR57Mw0Hnt13t/eUQWLB/61eLN0UQtR4hsQwWd3TjX6/SwiT6xg32MixuTfBEV
         /p0ASwUgcK7Kdyp0NuKZqFJwL5ZavLnbLmOgnAqfHxAB1HBW3MxxGJzQ1hDFWRmWEC3W
         8l0WQBxR7Uxy/+iQkWpGrkLG4ufpH2cipBt8xrH0VP2VP9LuzUXfOy9MHUGcKAPCSpUX
         RgRtZhRBTHhMLao+iO/csylxitASLaAAYIIuvMSUU0iBpPXtFAgl+VVclvHb+/bTnruU
         BCGKDXAgxyk0JnMcZ61wHdBpa6Ac+Owg1DGCraW4Si5FamXYwg3/PjAqDz9qMT7OKkQZ
         rTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YQkGAV2fegPpVuB36QVanw5bEtOjn8XGo7Yloc0PnOE=;
        b=psvZVE85bc5vmioVE5KJH8MMs2miiERIUpI2SNIkC3VM9EuzhSRJCiNudKfSaMHNvl
         VU7KjIpJ8xKzrh3QHIwVGxLtvcykeLfnAX78ivJHMEcIlOH614bFjxIvbr/m/8fCmooO
         NXhSVvcbgcZSzCkvIXAd3TDaHn9FUKRF1BUGdMcaq+I+vOU2sfzYx61NRWxJi/t7LnXe
         cOWr3jB7Gqk8GmYTgVORmEVMaYRV9+Kx0tS2LNa4y/KpkzfrKQD7tWOcx4Pu9CKCEIDh
         EQRilDgYQ8aL8xrri2o8NSBA7Zze1XuDFdCnbsUvYC4RRRc9sAX6lvdxGbnqNI9+9ZJn
         TBAg==
X-Gm-Message-State: AOAM5327fN8q3hmRuK1zVSO8pfuH1TOShe4bdLc0Mwzeq2tSfH6goRD0
        6sOwDlIOdJtyQLNmRfpuzM7RhOK4w7ZT6xmait1GEsa9FhGbEXDp
X-Google-Smtp-Source: ABdhPJxSRVHN3HQODVyykzRs244gziedvrVJujoPaliAervNzsDVs0xaeQTu+zQIiQh/4l5uW4M7vk9ACA5AvI/yQqY=
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr11691373wra.42.1613786517657;
 Fri, 19 Feb 2021 18:01:57 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 19 Feb 2021 19:01:41 -0700
Message-ID: <CAJCQCtTT7djC+FPEeQg3mJuO75JTJUaoKuibBF+KOq0SWKt+zA@mail.gmail.com>
Subject: 5.11 free space tree remount warning
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

systemd does remount ro at reboot/shutdown time, and if free space
tree exists, this is always logged:

[   27.476941] systemd-shutdown[1]: Unmounting file systems.
[   27.479756] [1601]: Remounting '/' read-only in with options
'seclabel,compress=zstd:1,space_cache=v2,subvolid=258,subvol=/root'.
[   27.489196] BTRFS info (device vda3): using free space tree
[   27.492009] BTRFS warning (device vda3): remount supports changing
free space tree only from ro to rw

Is there a way to better detect that this isn't an attempt to change
to v2? If there's no v1 present, it's not a change.

-- 
Chris Murphy
