Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7413A4364
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFKN4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKN4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1EC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:54:03 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i68so27404231qke.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JOdcMWdXVsJoaWI8HwpgkBnP5c3NGfsOlpQk4HkjqKg=;
        b=vyC4212LvMC0gEPwcWr0Fo74Wl6dfJK80+7jYwL7I7x+5GXTmfXgszeEthsQ0WFfzJ
         uD/6vs9fzbySNDRc0EAt9m5b8DCs9XFZqzEtwJy0JJ1TiX35UvSNBj5r8kmDSEQHcVeP
         fW+PV65iHoUuSQfcT9SeD9F8ZJYVC3fLlGzw7yLSkwS7ww28ZqZ5Qz5okyCKGJ/W3Qxw
         GWgQBvSI0ixy7ZYRk7JTLK7NoGUyNFJC3g02wS8j9B0YLMqoWOuR05+LvR5TvvvAtq42
         7IaQaDe6Z/vScjuXkIUcQqlTDVCfY/6DE/CMwJqV32ha6rDdDNspOtDwmSDLK5tGz7vx
         RA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JOdcMWdXVsJoaWI8HwpgkBnP5c3NGfsOlpQk4HkjqKg=;
        b=fdsJybqVJC5iXDEZ0KJdUV+PdrZt82f0vwl6gBDi0Rp2cMlmIvN+krB0cpnOM5RMtE
         jRMGunBg+eWBGu8NUDaBDxBi4b1eoOvggk3mUiMRSV1bxeCPbxzrQ2nHXSzes/23avPR
         0lm5GAuXvL7uKnT0scLsJL62hluXC+EBKDxucHvvYv2IY/mXgN1u8aJCEkzdu4jcn1jT
         2qjmkQLwFHNojHeEMe/Raq0ZbY1uh/3pJxodrDjjxZVboQI/6Xil9HcEI9P0b+bmPoPM
         EsxgXuK7Prxpk04YRgSchikjSmjokLnK891qPukIi2XAt0V4GRFYpkCK008mBtdgxUKG
         wuZw==
X-Gm-Message-State: AOAM533YYyM1wKlEN9wkY00QW8gp5XeEj3VHRVcwUG5RSaDYcqXj8B4y
        ZD8vsRu3I7otZNxnAqABeZh99OYCmRcjHA==
X-Google-Smtp-Source: ABdhPJwEI2sL/wfYvhAr8WxIxOGCxb+8D5W19d1T5aKPZfP5QeLPerRI2Jn906H1jm6zUVOyMMgNHw==
X-Received: by 2002:a05:620a:1485:: with SMTP id w5mr3939024qkj.66.1623419642093;
        Fri, 11 Jun 2021 06:54:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 64sm4155902qtc.95.2021.06.11.06.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:54:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] btrfs: shrink delalloc fixes
Date:   Fri, 11 Jun 2021 09:53:56 -0400
Message-Id: <cover.1623419155.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I backported the patch to switch us to using sync_inode() to our kernel inside
Facebook to fix a deadlock when using the async delalloc shrinker threads.  This
uncovered a bunch of problems with how we shrink delalloc, as we use -o
compress-force, and thus everything goes through the async compression threads.

I ripped out the async pages stuff because originally I had switched us to just
writing the whole inode.  This caused a performance regression, and so I
switched us to calling sync_inode() twice to handle the async extent case.  The
problem is that sync_inode() can skip writing inodes sometimes, and thus we
weren't properly waiting on the async helpers.  We really do need to wait for
the async delalloc pages to go down before continuing to shrink delalloc.  There
was also a race in how we woke up the async delalloc pages waiter which could be
problematic.

And then finally there is our use of sync_inode().  It tries to be too clever
for us, when in reality we want to make sure all pages are under writeback
before we come back to the shrinking loop.  I've added a small helper to give us
this flexibilty and have switched us to that helper.

With these patches, and others that will be sent separately, the early ENOSPC
problems we were experiencing have been eliminated.  Thanks,

Josef Bacik (4):
  btrfs: wait on async extents when flushing delalloc
  btrfs: wake up async_delalloc_pages waiters after submit
  fs: add a filemap_fdatawrite_wbc helper
  btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking

 fs/btrfs/inode.c      | 16 ++++++----------
 fs/btrfs/space-info.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/fs.h    |  2 ++
 mm/filemap.c          | 29 ++++++++++++++++++++++++-----
 4 files changed, 65 insertions(+), 15 deletions(-)

-- 
2.26.3

