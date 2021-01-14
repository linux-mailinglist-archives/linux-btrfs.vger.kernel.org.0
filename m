Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5BC2F5C41
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 09:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbhANIOs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 03:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbhANIOr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 03:14:47 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDCDC061575
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 00:14:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r4so3834883wmh.5
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 00:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=jxnpXmaI3uf7u3hEK3C5BPdcnRr4hg9q9q4vauoIW3o=;
        b=EBTtF1/unpCiU50burF81DVaegf7b+TgNqmVqyzjvsMUsH2TdWBPob1PEfgcNHhaBq
         1YjCv59GNCzQ9wQkI1Z8HnpXJe3mUvfmiV5vf3YK3CvRrfL+z1hoCMV76Y6BFZrrqBoE
         0zPTrDx4CGmpKfSIFmB9nIpPbDckAUKIuAki5jK20gHRDbqyDzuLVPH6DJDWswJr4xOi
         IX9fYd8wlmfXg48Dl5EawnUfBCo/s6aD/5BJcFP5tMVefZGICNJzTUfj+SgBuXJQUgAW
         hPkwNJT7rDIcUMig+1C2fyNBa7RtYKB3iJrh6xgOvhpoWVhnEcpkHJBz4acXwnUfDQYP
         oYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jxnpXmaI3uf7u3hEK3C5BPdcnRr4hg9q9q4vauoIW3o=;
        b=SBicplpMfPlBFAPwXIjPzJTzJuSgdRnbewBz9rcp9/8K/zk8y6gcAZKWZZ89HRTnC7
         cIIy3HLxREa5JbrpCQMutTZzbtV4oFXjLfZ1pgDYvB7/DdiD0+G5U6ymo3qrzOAW6SfZ
         47nxRXwfc01nYP7yDVZC+DC2zn9HK0FILSxc/upYfT8W6VfZjjfkTvocNzTFEPs9ePFs
         JPFPS0yiRKJtr5+d7/yYv6+YM6B3s4hjkYhEfcyeN8sd5cVIpETZZ2CbZ0BCxxaan0Pv
         kH1T5QNC2SfqIUiWRHJ19CgQjpUYUgGe0FmaQGMECg7eW0m+oVvmdkRe2aMfcjz0Hss0
         /NXQ==
X-Gm-Message-State: AOAM532nE65yUsIcmEROFt8cS2DVLytUNvtDlO/m+j4ljlnYVPa4f0hL
        qshq6lAB6G+lrgcdpFisbIUaJBB+X0pDp3WxKO8RSCpp2AlLIyH9
X-Google-Smtp-Source: ABdhPJx7GNJ9k4UAt6iJbAhXQ+/MUY/F3nrVNKUlLDYLaLEaxDgC6jaZL6hNXH9I+QXwCDj+DjE7JyAPhAX/Rsz//uc=
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr2785781wmb.124.1610612045862;
 Thu, 14 Jan 2021 00:14:05 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 14 Jan 2021 01:13:50 -0700
Message-ID: <CAJCQCtRekGcPXk7-bZKxTNapTkM43d5s0rtLJ77rQL4sLiNX1g@mail.gmail.com>
Subject: btrfs: shrink delalloc pages instead of full inodes, for 5.10.8?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

It looks like this didn't make it to 5.10.7. I see the PR for
5.11-rc4. Is it likely it'll make it into 5.10.8?

e076ab2a2ca70a0270232067cd49f76cd92efe64
btrfs: shrink delalloc pages instead of full inodes

Thanks,

-- 
Chris Murphy
