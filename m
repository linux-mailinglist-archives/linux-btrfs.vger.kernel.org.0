Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E576339530B
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 May 2021 23:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhE3Vbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 May 2021 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhE3Vbm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 May 2021 17:31:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A038C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 30 May 2021 14:30:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qq22so5332919ejb.9
        for <linux-btrfs@vger.kernel.org>; Sun, 30 May 2021 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm1CmsmSfuMtHl8mqpBXXSj5m8ScvM6P85YSneLtZLg=;
        b=X3Ea43RWfeEyHqiNLdYKoc+mOAf5uKoYgQJVqR3FgjgDrszxS79qaa7VqCSSJsY/Or
         0TxbS8/73TCEKDA5x1BHyfjZAlilGqOTvzrgHAp1FcR+ko/rsLDeqVvo7ojYQlXXJGGv
         MGBTfKcPXNY3MeiD4z71alXbEKanfemLPlbfrTrPLSskge3wBIJeHdJKqiZ3sCBGTifA
         hsfWR11+Ma7/2eQgkXTJIM21NON+7YYpwpbKQxgJlsJlK6WnsWihV1i9DE4L4Gr7K4vs
         9DRfgyseDy4rg8of5ICb3B92BDmYJUWuQr34r1aUJPkZyNCI9HCn2mmdwjfTvoH4csWR
         CUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm1CmsmSfuMtHl8mqpBXXSj5m8ScvM6P85YSneLtZLg=;
        b=JWNFYKxwq5iKrW2uqS044iIpY8KKQVzAHpBvZa7VU+jOvfBKUOq/Dxb7ZYi33rihas
         ccOu2jl7l+8vSCqMRWDUAlulfS2dijmEJWhQVD3F2JkE95K8hkRfE5nsKvLcK4q3zEz5
         EBzidnNEc4mozGjerxIv8CpBVH9UujdUTmPR4nNhYf1luvsPIE5mPQ4ECRbxXpjU1FQV
         DiwLOwsQ/Lgnw/Wh7G1mTZMD5jLsiNm8togIoJxampp3ylLiyTZVYCMNJbaCp4Vf8rva
         IZpyDLipfAkMY31Nvi2CWhuBIBLJ9xG28btMhArn5lQBwaZ6RWuEd8wyw4q/6QwK3OI3
         nmTw==
X-Gm-Message-State: AOAM533lgJJiVGzJg1NWej7kwuutLgT4Me/ZA3XNRM5LdUj2yf6Uhvg2
        yJ7ehi+Q6MNnd1DqxokW8cFwDYdcuAEUIA==
X-Google-Smtp-Source: ABdhPJw70iw+fkc3uxeMtlive9HY8sTLCP3wOTrlcD1NOsK3WUkAZmSkgJJZe/cBifi95+Chpb3ocA==
X-Received: by 2002:a17:906:3785:: with SMTP id n5mr19900149ejc.127.1622410201611;
        Sun, 30 May 2021 14:30:01 -0700 (PDT)
Received: from localhost.localdomain (ppp141255038110.access.hol.gr. [141.255.38.110])
        by smtp.gmail.com with ESMTPSA id r2sm5069175ejc.78.2021.05.30.14.30.01
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 14:30:01 -0700 (PDT)
From:   auxsvr@gmail.com
To:     linux-btrfs@vger.kernel.org
Subject: Write time tree block corruption detected
Date:   Mon, 31 May 2021 00:30:00 +0300
Message-ID: <1861574.PYKUYFuaPT@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On linux 5.3.18-lp152.75-default (openSUSE 15.2), I got the following error message:

[33573.070335] BTRFS critical (device sda2): corrupt leaf: root=3 block=531135201280 slot=0 devid=1 invalid bytes used: have 64503152640 expect [0, 64424509440]
[33573.070338] BTRFS error (device sda2): block=531135201280 write time tree block corruption detected 
[33573.071909] BTRFS: error (device sda2) in btrfs_commit_transaction:2264: errno=-5 IO failure (Error while writing out transaction) 
[33573.071911] BTRFS info (device sda2): forced readonly 
[33573.071913] BTRFS warning (device sda2): Skipping commit of aborted transaction. 
[33573.071915] BTRFS: error (device sda2) in cleanup_transaction:1823: errno=-5 IO failure 
[33573.071917] BTRFS info (device sda2): delayed_refs has NO entry 
[33577.283856] BTRFS info (device sda2): delayed_refs has NO entry

Probably related is that the filesystem had less than 1 GiB free when this occurred. Rebooting and deleting some files seemed to have resolved it for a while, until:

[ 5201.020901] BTRFS critical (device sda2): corrupt leaf: root=3 block=536671682560 slot=0 devid=1 invalid bytes used: have 64503152640 expect [0, 64424509440]
[ 5201.020904] BTRFS error (device sda2): block=536671682560 write time tree block corruption detected
[ 5201.022983] BTRFS: error (device sda2) in btrfs_commit_transaction:2264: errno=-5 IO failure (Error while writing out transaction)
[ 5201.022985] BTRFS info (device sda2): forced readonly
[ 5201.022987] BTRFS warning (device sda2): Skipping commit of aborted transaction.
[ 5201.022988] BTRFS: error (device sda2) in cleanup_transaction:1823: errno=-5 IO failure
[ 5201.022991] BTRFS info (device sda2): delayed_refs has NO entry
[ 5201.023071] BTRFS info (device sda2): delayed_refs has NO entry

after a successful scrub and balance. This time df reports 8.8GiB free, but:

# btrfs fi df /
Data, single: total=55.98GiB, used=47.18GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=2.00GiB, used=1.01GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# btrfs fi show /
Label: none  uuid: 44c67fa4-e2c4-4da5-9d07-98959ff77bc4
        Total devices 1 FS bytes used 48.19GiB
        devid    1 size 60.00GiB used 60.07GiB path /dev/sda2

60.07GiB used out of 60.00GiB! I recall that this is what I saw the first time too, so it might be related to the cause.
Is there anything I can do to ensure that the filesystem is not further damaged and that the issue is resolved?

Regards,
Petros


