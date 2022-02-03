Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354024A8CEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 21:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353922AbiBCUFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 15:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbiBCUFw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 15:05:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE8C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 12:05:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso4039068pjt.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Feb 2022 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:message-id:mime-version;
        bh=+WtD7D0ww08bjvgIgS2ytEZyki5+fmPtCescr7+skwk=;
        b=lb/nsv6mHicVlqvtt/YeXsZoowIwb4wkFJ57cFuEKWVbDBRmg+8siyhPy6gay6mKb8
         DE/ggzztyv8dqRuY32H6+u2PNii0sSI5f2bmPBXrlWB5fM4rwLHj7kM7HcpXZtkBdDRV
         HIG6WzTgs3r8sEjOqfZXFZzTvyvjDpwQ9l4HHnh0FHnab5F782qKsX98UwyIjnqNs1Xc
         LRk9d4FMyNPnIGBKr9j+MsMbz3aXL06Lm8iH3tdaKoSYiglaymywffsFCp2XgFMU/le0
         IDN6rve9fFNHOVm8QBoFikUa35gYukI5p/JzxTxXCgsMKoZPVWzzQj2Cc36aN1/N5UF8
         mmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:message-id:mime-version;
        bh=+WtD7D0ww08bjvgIgS2ytEZyki5+fmPtCescr7+skwk=;
        b=TB/yyNHOHqouFwmx8rWtYfD13ErSQaS32QPEAOuIdODypIcE4cn6AbgmGSWtx+1wwA
         yWxQwJpID5hDCoodjjXZLyNJlpbUh7RslSpw/U05yub7mPuqiCb/iAoxBFO/OHOxngCJ
         ccN0/YRvfel/Fdj3TRq7LY41QkXRuBp2XI7HtkDBicStcN3Xml90B4Eu2NyDiolKK46m
         rzNFo2SirCWPUZjuIz3BwaaPWsOgSBdk3Qi9cFZDXBf70WyYyaE7XDW73Fj6uLBcXqag
         IK3Pb21VFvEKYvE0XUSsUUMbp8IMWB7u/vRYmuYhE7Kc3Nu6PFxiBVOT/85/mXjzDEmK
         jIWA==
X-Gm-Message-State: AOAM533BGvIQkkolcfnkjbttQikODKXEJNuJsBR/nn6CvFTRCZm/5Z7A
        3gp5wiPusxIJMsUBe+8b9nO2t3Pf2EA=
X-Google-Smtp-Source: ABdhPJzEAERonOwahQQgLWeDAoAWmweJDbX4l3zouFr1DIf+VOvkHbHWVec4wMmq1HuLkmhuJjJNpw==
X-Received: by 2002:a17:903:41c1:: with SMTP id u1mr31312483ple.91.1643918751922;
        Thu, 03 Feb 2022 12:05:51 -0800 (PST)
Received: from [192.168.1.223] ([47.151.162.98])
        by smtp.gmail.com with ESMTPSA id y15sm30317755pfi.87.2022.02.03.12.05.50
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:05:51 -0800 (PST)
Date:   Thu, 03 Feb 2022 12:05:44 -0800
From:   Benjamin Xiao <ben.r.xiao@gmail.com>
Subject: Still seeing high autodefrag IO with kernel 5.16.5
To:     linux-btrfs@vger.kernel.org
Message-Id: <KTVQ6R.R75CGDI04ULO2@gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

Even after the defrag patches that landed in 5.16.5, I am still seeing 
lots of cpu usage and disk writes to my SSD when autodefrag is enabled. 
I kinda expected slightly more IO during writes compared to 5.15, but 
what I am actually seeing is massive amounts of btrfs-cleaner i/o even 
when no programs are actively writing to the disk.

I can reproduce it quite reliably on my 2TB Btrfs Steam library 
partition. In my case, I was downloading Strange Brigade, which is a 
roughly 25GB download and 33.65GB on disk. Somewhere during the 
download, iostat will start reporting disk writes around 300 MB/s, even 
though Steam itself reports disk usage of 40-45MB/s. After the download 
finishes and nothing else is being written to disk, I still see around 
90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs 
cleaner and other btrfs processes writing a lot of data.

I left it running for a while to see if it was just some maintenance 
tasks that Btrfs needed to do, but it just kept going. I tried to 
reboot, but it actually prevented me from properly rebooting. After 
systemd timed out, my system finally shutdown.

Here are my mount options:
rw,relatime,compress-force=zstd:2,ssd,autodefrag,space_cache=v2,subvolid=5,subvol=/

I've disabled autodefrag again for now to save my SSD, but just wanted 
to say that there is still an issue. Have the defrag issues been fully 
fixed or are there more patches incoming despite what Reddit and 
Phoronix say? XD

Thanks!
Ben


