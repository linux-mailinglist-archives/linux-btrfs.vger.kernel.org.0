Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2441E12D4AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 22:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfL3VbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 16:31:22 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:39696 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3VbW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 16:31:22 -0500
Received: by mail-qt1-f181.google.com with SMTP id e5so30464058qtm.6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 13:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAOjnGwN11o1U0uePbT3Dq7gWqSIStrWySXGj3Mx7tw=;
        b=sCv0Ix1TVN/weSKhp8wPIAexp4YtCzsB4yaKILZuqCU1Jf38twJl74YHIkjNpdB8Fx
         WmTYR7iH0Itbdr8Ytcrdon8qmzI+rMK8/XZ/y/51oTG78EPDkNOe3dABJS+Y2nL42n7P
         u4GtUDjaUjj1pbJV6hwBSSvlPqCcKf8OlTl3wdiuKv/aGU62eifTx7O0g1USlAu46rtc
         9rpa0m8B/P6bj9axzD2uajXzgR0jI4x1lo0TdTDF1bGlWKHqiyLwQmGPbzun18GUBhpk
         1STt32GyN9K4yNkhzbmreP6sbGQ8qtqtT7+8xVTVJ841WnZfOwWSc2mZKI+OCTTdpY7r
         PHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAOjnGwN11o1U0uePbT3Dq7gWqSIStrWySXGj3Mx7tw=;
        b=ny3Fnj30Y1JdFdykJJECla5utHCykX1ZiqIKeHrf9VTSMIvKqlx7YV0HMBzLUhm77s
         USp3bJAE3CIcSO5m7OXYu/iSnWQ41DPXDVceLOf9SmAAwMGFscXlitOk2fkQ8vhn2y3L
         znNJdiw+CJQgUS3hdFajJ9LuP62gr5+eIPRNf6GUuNnYJ6FZcv0um4Xet0csCnA22piD
         fe6uGWLE4bTagdrYaNG5v2DNdchIbxiMzLXe1iMWlu/R35VaS/LroXuAWG5Hm72MP3ag
         k7uDivgGSfxOSLUTPPj76YGfbeohzq7oH0ZAMvhz4VDnwNNYEFBHPkNYBOVKacTkWfCs
         l7Lg==
X-Gm-Message-State: APjAAAVSAtkoG1gMvXw8SbzqglpwCrssIIrcj/c6o0LBX+DyMfpG6UWI
        45niUIFatd+eHC62jvCmtYJsnjVQHpVubw==
X-Google-Smtp-Source: APXvYqw6ZrrkvDYEk5aPqaERh2ayM/S+d3YKgm5BGn1mBGRXCa51vACII2csoYhlkxG6FOxYhAxVxA==
X-Received: by 2002:ac8:330d:: with SMTP id t13mr48987697qta.379.1577741481022;
        Mon, 30 Dec 2019 13:31:21 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c184sm12806129qke.118.2019.12.30.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 13:31:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [RFC][PATCH 0/5] btrfs: fix hole corruption issue with !NO_HOLES
Date:   Mon, 30 Dec 2019 16:31:13 -0500
Message-Id: <20191230213118.7532-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've historically had this problem where you could flush a targeted section of
an inode and end up with a hole between extents without a hole extent item.
This of course makes fsck complain because this is not ok for a file system that
doesn't have NO_HOLES set.  Because this is a well understood problem I and
others have been ignoring fsck failures during certain xfstests (generic/475 for
example) because they would regularly trigger this edge case.

However this isn't a great behavior to have, we should really be taking all fsck
failures seriously, and we could potentially ignore fsck legitimate fsck errors
because we expect it to be this particular failure.

In order to fix this we need to keep track of where we have valid extent items,
and only update i_size to encompass that area.  This unfortunately means we need
a new per-inode extent_io_tree to keep track of the valid ranges.  This is
relatively straightforward in practice, and helpers have been added to manage
this so that in the case of a NO_HOLES file system we just simply skip this work
altogether.

I've been hammering on this for a week now and I'm pretty sure its ok, but I'd
really like Filipe to take a look and I still have some longer running tests
going on the series.  All of our boxes internally are btrfs and the box I was
testing on ended up with a weird RPM db corruption that was likely from an
earlier, broken version of the patch.  However I cannot be 100% sure that was
the case, so I'm giving it a few more days of testing before I'm satisfied
there's not some weird thing that RPM does that xfstests doesn't cover.

This has gone through several iterations of xfstests already, including many
loops of generic/475 for validation to make sure it was no longer failing.  So
far so good, but for something like this wider testing will definitely be
necessary.  Thanks,

Josef

