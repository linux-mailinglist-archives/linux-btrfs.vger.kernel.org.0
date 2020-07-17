Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A5A224401
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGQTMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 15:12:35 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09AEC0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 12:12:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x62so8463061qtd.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBnYv+bBysSX9ADynt3ICiHupViAPODL88r69nJcc9M=;
        b=zReQ5wxjK467suJhdci36oYhfjeqdEbUlj5M7ZUfrtn73QLF3NY6bOsBizJ6ZZOYJb
         UDAJIZwRY3LTw4R/Pn6UI/bnRmLHKKacelE4jmMGNcfApPuUDHWxh3RsAOp3qfqxhnp0
         SxAuGVomF07V7PdRIL9XHSqXeoWkPjTzdcdf4n10E76S4hA90ZxWZbsB0e+n1JCgS3+h
         rDZ0GCuEAR/MFmhlqTcJZ5gVMmbnwnp3KAo9qu5wzsbJaWsBUl64iikA0kzTiSMZ2/R5
         G9rNAh5RaujmbK8OlYwjumPWF7X2vp5/pytKCws7wYQpmaxlM0GkxR3IXxmoty8Cy/SH
         ydPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBnYv+bBysSX9ADynt3ICiHupViAPODL88r69nJcc9M=;
        b=f3+PJB/ICiUAKKMc3xKqP9Mx4vc5u64kIgM2DKQHfodovktrIiK/4YOclpmVifNQy6
         Bzwp4ewiD60Wk2zWba5+waygOcOZZ6FDtqvG68Oyr8cy+nn8E7iqtxHicJ6dgAKAu93m
         7bLZ3szOFsF53UEXsBPr1Op38b4hGjDKqpYRTnjl7yDzIEVg2OEJ2XQ8gezbjfuaHkvf
         BoeQsRueRXDXz20rsOZdAFZtfcznnb5WB5Nnep65JwUf8uSyZ2tGXUHnq2DfvvmiZtED
         nRT4I902RWjrZdZaM64LAnmdgSO/49MUZ1iG0Sj8QgHf1K0G5eFC5BdVyPE27Jpzq8kD
         1/lg==
X-Gm-Message-State: AOAM532B/h5KmM9m1Kipgb71f6J2dboTDAIYCCVtbrleA5Vmi3zZMici
        Kq8eyvYTV+lIvfjzLrIIcP1sCVbOE0oj6A==
X-Google-Smtp-Source: ABdhPJzxRhm2yqVzt6wm7ijyT/33gXGL0CPSm/07wd53nsOzer9sHwJhsh6kZy5ATPNBn1l8WpcZew==
X-Received: by 2002:ac8:1bad:: with SMTP id z42mr12418131qtj.110.1595013153719;
        Fri, 17 Jul 2020 12:12:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r18sm11820590qtf.62.2020.07.17.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:12:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Fix a few lockdep splats
Date:   Fri, 17 Jul 2020 15:12:26 -0400
Message-Id: <20200717191229.2283043-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've had a longstanding lockdep splat in open_fs_devices that we've been
ignoring for some time, since it's not actually a problem.  However this has
been masking all the other lockdep issues that we have, since lockdep takes its
ball and goes home as soon as you hit one problem.

This fixes all the issues I found while running xfstests.  I would like to do
something more sane around fs_devices in the future, but for right now lets just
get these lockdep things gone so we can focus on more important things, as well
as get notifications on any new lockdep issues that show up.  Thanks,

Josef

