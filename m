Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED614D3FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgA2Xua (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:30 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:39417 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2Xu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:29 -0500
Received: by mail-qv1-f53.google.com with SMTP id y8so619925qvk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuRTTVTSBlUMzPI72bhlUocL3aw4rTmD+L+dYcx0dcc=;
        b=XpZWscLt6tI2yA3mmLuoY8bOMXFjT8GoXfsVNZR1zPimA8ew5zTg16FG3Q8ymFCEsw
         d51Now6lc3VWPFGj4hA7W+2x1dfDomeRWnkUyTp3MYZUsNre9+SYcCEzsRXs5+gHe29M
         iTvrfuMKFBafS0Y7c1OZjLbPTNv/k0w+NCBKOVWY8E9YR1caB/0CYXHDkKNYet6cq9Cg
         +aUafemAN6b04x42HEfIk146HYXnqHwaOy/ZBy7c4LyJW/KDbLGjtYVHCMsYd+Ed6wHi
         cyVAUKUN7ZoKT6XjfPujKGgR2K8dVB2VTpeTjcVVIUrMGOAoqji8Cz9sxopWtB1gO+fB
         TwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuRTTVTSBlUMzPI72bhlUocL3aw4rTmD+L+dYcx0dcc=;
        b=Po3bYdo3dwYYT+I/q6UukaiK7vdBouZNUXeopNDh301k/peNzMDwGT2KBO6DcN24fM
         G2+/Jlfnyf8hETcrlC7nD9yKS5leyXYBrNvRQckAXgynG//hrAlqs5d1U47iXOKeFaLE
         1DWSFXU2V9wEEjgkK5mMZLhhmsi8/wfUICbIv4Aw4PvYTF9nTmceiT+LbDkRo0lE3Vxw
         yMIFhAsqBzF8k/wWJr/5IivA0QsfZbl9cFQ6yHLndtSWyELf50OiGyh3RTyBsZ60gAFr
         dkInxDtH4pbTELNpEbYGF2o4i03tmke7KuTeXUl19NGfxWJBVxSiR6aGdQoZymgrWKU7
         t1fQ==
X-Gm-Message-State: APjAAAXxchzOCH74WHuYvx87Xcz3h1BuhwWMtYC4IrqYs8UivCLkHZMU
        HrYC40b2gJh0OJ7Equ+W7Kbh9jDVrFdwIA==
X-Google-Smtp-Source: APXvYqyLuA2t6IEGuYHh6hPLabFW5j4Gp6cWoC1yzfCc0f7/wux/rZxe9Kb1xhmtGzRuwgGaaIv/dA==
X-Received: by 2002:a0c:ed32:: with SMTP id u18mr1867428qvq.2.1580341827993;
        Wed, 29 Jan 2020 15:50:27 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v18sm1825992qkg.67.2020.01.29.15.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/20][RFC] Convert data reservations to the ticketing infrastructure
Date:   Wed, 29 Jan 2020 18:50:04 -0500
Message-Id: <20200129235024.24774-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay reported a problem where we'd occasionally fail generic/371.  This test
has two tasks running in a loop, one that fallocate and rm's, and one that
pwrite's and rm's.  There is enough space for both of these files to exist at
one time, but sometimes the pwrite would fail.

It would fail because we do not serialize data reseravtions.  If one task is
stuck doing the reclaim work, and another task comes in and steals it's
reservation enough times, we'll give up and return ENOSPC.  We validated this by
adding a printk to the data reservation path to tell us that it was succeeding
at making a reservation while another task was flushing.

To solve this problem I've converted data reservations over to the ticketing
system that metadata uses.  There are some cleanups and some fixes that have to
come before we could do that.  The following are simply cleanups

  [PATCH 01/20] btrfs: change nr to u64 in btrfs_start_delalloc_roots
  [PATCH 02/20] btrfs: remove orig from shrink_delalloc
  [PATCH 03/20] btrfs: handle U64_MAX for shrink_delalloc

The following are fixes that are needed to handle data space infos properly.

  [PATCH 04/20] btrfs: make shrink_delalloc take space_info as an arg
  [PATCH 05/20] btrfs: make ALLOC_CHUNK use the space info flags
  [PATCH 06/20] btrfs: call btrfs_try_granting_tickets when freeing
  [PATCH 07/20] btrfs: call btrfs_try_granting_tickets when unpinning
  [PATCH 08/20] btrfs: call btrfs_try_granting_tickets when reserving
  [PATCH 09/20] btrfs: use the btrfs_space_info_free_bytes_may_use

I then converted the data reservation path over to the ticketing infrastructure,
but I did it in a way that mirrored exactly what we currently have.  The idea is
that I want to be able to bisect regressions that happen from behavior change,
and doing that would be hard if I just had a single patch doing the whole
conversion at once.  So the following patches are only moving code around
logically, but preserve the same behavior as before

  [PATCH 10/20] btrfs: add flushing states for handling data
  [PATCH 11/20] btrfs: add btrfs_reserve_data_bytes and use it
  [PATCH 12/20] btrfs: use ticketing for data space reservations

And then the following patches were changing the behavior of how we flush space
for data reservations.

  [PATCH 13/20] btrfs: run delayed iputs before committing the
  [PATCH 14/20] btrfs: flush delayed refs when trying to reserve data
  [PATCH 15/20] btrfs: serialize data reservations if we are flushing
  [PATCH 16/20] btrfs: rework chunk allocate for data reservations
  [PATCH 17/20] btrfs: drop the commit_cycles stuff for data

And then a cleanup now that the data reservation code is the same as the
metadata reservation code.

  [PATCH 18/20] btrfs: use the same helper for data and metadata

Finally a patch to change the flushing from direct to asynchronous, mirroring
what we do for metadata for better latency.

  [PATCH 19/20] btrfs: do async reclaim for data reservations

And then a final cleanup now that we're where we want to be with the data
reservation path.

  [PATCH 20/20] btrfs: kill the priority_reclaim_space helper

I've marked this as an RFC because I've only tested this with generic/371.  I'm
starting my overnight runs of xfstests now and will likely find regressions, but
I'd like to get review started so this can get merged ASAP.  Thanks,

Josef

