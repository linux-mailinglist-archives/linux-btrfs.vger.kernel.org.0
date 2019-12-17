Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219771230B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLQPoI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:08 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:34398 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfLQPoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:08 -0500
Received: by mail-qv1-f50.google.com with SMTP id o18so4343455qvf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NFgGiVfCNBnblJiGw6VkhEAqL+vMG8FF/P51fz2Q698=;
        b=AN5JZhNsDsmU74p1LOv1L7heQofxoZg31G1DbaFWw16dgnKOoe1j38kXw6eQlfa1+G
         7zb83G0neddcDusRaAoQ9OThAgxGRJSZeqdYszJO8j2O13Kl6KZeVUBov3hYWGQjBu0d
         claq0IGrHYRQmgF4FZVBnlE1jJbdYWhBGHkgLlzhfh2KMexxL2QPEDAX7pXq42c5tNJ6
         2nckLAQudjTM65hy6BkISqc9j4ZrKkEvRwKddo7VosFMWVEr4NS+BDtKSe9lcH0lDgM/
         xKBD5Viq9qS39ZZlc6AVs8rsvI+CELLUG0+icOOuDLGoAJVpgFlbfiu0+cqfsgWGoa/5
         TyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NFgGiVfCNBnblJiGw6VkhEAqL+vMG8FF/P51fz2Q698=;
        b=A+8m+EY0ksugyBQetOazyFyc593+Hphno+zCpxjQsxdQN7ngKKEcCkNnA55s8wzYN8
         ssRhilYoGjTcJnc5s0j/I5rQuG0gIpGrsG+ZPUwZV0xfXv4nZHE7iyqR9QSzy+7hBFPS
         z9MCLyvRm+QmQCgbr5SDI7+LgIkBkXoLkVUA9w8Ytk6dDPalMlSJ63T8BK9+3PkEfAPN
         UD0Q+mi7ExXverOXk58kMfUGstBIsRqfIb0/B4uhtiXCn3a7UxkwZoh2LMmKsPxT9MZx
         G9ndGftopMqKF14Iyiu7bllFlHGZQ74jZ+8LHM32lqT9Pf82pUbp3HN4fxI2mtBV3tbo
         +2rQ==
X-Gm-Message-State: APjAAAWY1eC1Zh+fwIQVJlI2uc95z2I9vh9MB8hOeBHQLw3WcTOmMEN1
        5G3cTIUWu+BHUhLth46youomyqV52amv/Q==
X-Google-Smtp-Source: APXvYqzHQ1fuQm9Cpa3ZpTaLF+WRokWtJ4nQfi/tTiEb3mlE9xZzxQ8JUmdwPcG1DULgGb7WGeTuUQ==
X-Received: by 2002:a05:6214:1090:: with SMTP id o16mr5263843qvr.105.1576597447134;
        Tue, 17 Dec 2019 07:44:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g4sm5322418qtg.35.2019.12.17.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/7] Cleanup how we handle root refs, part 2
Date:   Tue, 17 Dec 2019 10:43:57 -0500
Message-Id: <20191217154404.44831-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series depends on part 1 and is the final bit of cleaning up how we handle
root refs.  Historically the ref counting has been just about kfree'ing the root
itself and not actually cleaning up the root and free'ing it.  This makes it
sort of awkward to handle the lifetime of a root, as we will just free a bunch
of things related to the root, but then not free the actual root until we drop
the last reference.

This patch series brings the actual cleanup of the root inside the ref
accounting for the root.  In addition to that we also now hold refs on the root
for all of the various users of the root in order to make the lifetime more
coherent.  Previously if you looked up a root we just held it in memory until
unmount and then we had to do two put's to clear it out.  Now we hold refs to
the root when we open an inode in the root, so we could get rid of this extra
ref holding.  Now we hold refs for discrete operations, like putting it in the
radix tree, adding to the dead roots list, and of course opening an inode.

This final piece allows us to remove the subvol_srcu, which was the reason for
all of this work.  I fixed the original deadlock, but it's use was sporadic and
inconsistent, which is a recipe for trouble.

Unfortunately I was not able to kill the per-root inode rb tree yet.  We use it
in relocation to drop the extent cache for extents we are relocating, and
there's not a very clear way to accomplish that without the inode rbtree right
now.  However this work means that once I've fixed that problem we can delete
the inode rbtree completely.  Thanks,

Josef

