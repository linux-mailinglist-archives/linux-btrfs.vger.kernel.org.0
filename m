Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995D9115368
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfLFOpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:43 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:32865 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:43 -0500
Received: by mail-qk1-f170.google.com with SMTP id c124so6704272qkg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XZDvI/SLUyFd8HDkTFKUfnjAhySVk6cN+3Lx1+r8gc=;
        b=ut3WNTncNEEj7Mpi3JQ3u1F8A8Twio4bWUee9McW4g+3Dde5yL0ETODVF9ytEY5ssB
         +/TMyETvkgTl3CzGs6df5AVn/D9Y1V3y0IqMbUq+R3q4r8cWOPIrD8Lt1soRgjbZI0iQ
         7AlwPOtIG8OK1c5E9fGJovJk35nH7rCvRvCjpaZqN9V4tHPOhgNoU34GKu0t+X6o0FIj
         g+aOyfEVC5Ye+PhCsvq9ORKm5TjJayW83LQuI3otupnF5aOWRJQ0x99rfP2ge0Mu9orU
         L+LPnkYcFQ8VpBGRguoGR3Wq6Q3hY+eTuiM8ozZ7A6TDal8a8j9Kt0wjjfbL9LuAp7bX
         +c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XZDvI/SLUyFd8HDkTFKUfnjAhySVk6cN+3Lx1+r8gc=;
        b=b1lKcqBcyxyZGvGLHjnOHdZPO4edg+S0JCuRTCRtS+jVxpoGo/Pthl2N/j9o5/Mzhm
         4McOMnMk0MtoOneXZ/f4ps+EVMabEITaStGmpxSmtBQiv27H5o/rvvCaYQlrdQ8Pn5ca
         sDzR+xBewgNnEuuywCDzqv6Tl5FDhO4a5gosgxZEaaf0On4rgnC27LNfCNhfM+HI/dUx
         sunY0p+7EGEvIQncm6mO+zhIqWoOYW2HexzP1lJLGI76kmIes/TjhFvXTIui9SPytVrO
         bAs18Xzxs/RjXCypdv3tcctPbIm3aPULkyPavKmM1wZlEIfgZwQ7gAlPS8TMKZCPdL5h
         6pZQ==
X-Gm-Message-State: APjAAAVBiRjgq5JOXQkHvER/dH4v5gj9JYeCxJbtSSaJ7PId7KpvfApp
        a3tMCdCb90Qb1oD6wfRTXh1aqjXgHgp4YA==
X-Google-Smtp-Source: APXvYqxCLRVRWGt05HLO7ZgMNV6OpzO1GWaz1jQCifezbdx+M+y45j3a6MV/BEdnX+a6wYlU8aSw+w==
X-Received: by 2002:ae9:e714:: with SMTP id m20mr14021939qka.403.1575643541770;
        Fri, 06 Dec 2019 06:45:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z64sm6315376qtc.4.2019.12.06.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/44] Cleanup how we handle root refs, part 1
Date:   Fri,  6 Dec 2019 09:44:54 -0500
Message-Id: <20191206144538.168112-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In testing with the recent fsstress I stumbled upon a deadlock in how we deal
with disappearing subvolumes.  We sort of half-ass a srcu lock to protect us,
but it's used inconsistently so doesn't really provide us with actual
protection, mostly it just makes us feel good.

In order to do away with this srcu thing we need to have proper ref counting for
our roots.  We currently refcount them, but only to handle the actual kfree, it
doesn't really control the lifetime of the root.  And again, this is not done in
any sort of consistent manner so it doesn't actually protect us.

This is the first set of patches, and yes I realize there are a lot of them.
Most of them are just "hold a ref on the root" in all of the call sites that
called btrfs_read_fs_root*() variations.  Now that we're going to actually hold
references to roots we need to make sure we put the reference when we're done
with them, so these patches go through each callsite and make sure we drop the
references appropriately.

Then there's a variety of cleanups and consolidations to make things clearer and
make it so we only have 1 place to get roots.

Finally there's the root leak detection patch.  I used this with a bunch of
testing to make sure I was never leaking roots with these patches.  I've been
testing these for several weeks cleaning up all the corners, so they should be
in relatively good shape.  Most of the patches are small so straightforward to
review.

This is just part 1, this is the prep work we need to make the root lifetime a
little saner, and will allow us to drop the subvol srcu, as well as the inode
rbtree.  It doesn't really fundamentally change how roots are handled other than
making the refcounting actually protect us from freeing the root while we're
using it.  That work will come later.  Thanks,

Josef

