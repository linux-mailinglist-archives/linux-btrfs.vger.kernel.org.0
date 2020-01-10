Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256B8137289
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 17:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgAJQLc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 11:11:32 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:37258 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgAJQLc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 11:11:32 -0500
Received: by mail-qv1-f54.google.com with SMTP id f16so964967qvi.4
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67zfynRrgKpJdKx/W4NWqj2uvHbY1AiKwDftPj7f/M8=;
        b=cMCWb/bBf1F6TuXbl7bvS0z4bVcnQRlMDiGL6C/c8yyxPUoQB03NK3qIKtJLnvjrHA
         ZHy+LQpEg9VBj92BaLO8uR+3lfIGmsDja+QTjPy4pxFReTCevQ+HWHiHuS4xqt9jpdxi
         hnMjRnwEnXzLpmPkBQ9U/5T/pxk6BOold3g16Qq7YFs6Ovjy2icY0+ocqTavVQsKLFpc
         r5/n1lKK6FdpG6bHh87OJ3WxbQ0hZ/aGrZOi9BfOyVh0qCDRCyf3DE7b5NGx4+B335H6
         D11LvERBKogM7P16amlGPgSaKZWUqKGS9AibgUchqz2iuF3HiqIPh/JBGFCP+s+SF+GT
         UyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67zfynRrgKpJdKx/W4NWqj2uvHbY1AiKwDftPj7f/M8=;
        b=YkCtjHL6x4tiJ2ZW02iB2qJdugUSWNtV2KUhyrIJpp4/UhZk4PNfbxZJ8gNhTpzgfy
         jl4OdXEou/L1fF0BKApnXK+NoXTo6J/ZfbZkETwVeOfzkaLhOH5AcFq2k2iZjUIufsC1
         Im7jWkpey2GD+909ZpXizm3NlNcy1KxoTTv01hHEl4KLwInFGfqI9XXS/zIj2unG92ly
         1K+LqUlgP6ymfNmoCaOxj4UFa7RYCcZdbR/LUO7PX3hlQOdxlpo8D4CtIlzy+BCdc8Fv
         3SyN4uox3yV7Dk9Rt1Kx6ICd4OCqi5xLod1+Rfijb+SnniyLGIzuluGZyuEjlc/pQeQV
         x9LQ==
X-Gm-Message-State: APjAAAXrHQbJ5EJJCTkKo6yNxLpHkwsd9VcrpaCTC77fEKxZI1JCCH/e
        Qs+fXuRwB8BOA53jU0Dfaa/afcz9CoI7BQ==
X-Google-Smtp-Source: APXvYqzHvPKk+upOQEhn8QOl0gi03+/fKK66hLFr3iBHOtm9iiDz0WAEQkl6N4xlc0cgB/QvgmArGA==
X-Received: by 2002:a05:6214:1272:: with SMTP id r18mr3372405qvv.208.1578672691302;
        Fri, 10 Jan 2020 08:11:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm1057132qkc.65.2020.01.10.08.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:11:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5][v3] clean up how we mark block groups read only
Date:   Fri, 10 Jan 2020 11:11:23 -0500
Message-Id: <20200110161128.21710-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Original message below.

-------------------------------
Qu has been looking into ENOSPC during relocation and noticed some weirdness
with inc_block_group_ro.  The problem is this code hasn't changed to keep up
with the rest of the reservation system.  It still assumes that the amount of
space used will always be less than the total space for the space info, which
hasn't been true for years since I introduced overcommitting.  This logic is
correct for DATA, but not for METADATA or SYSTEM.

The first few patches are just cleanups, and can probably be taken as is.  The
final patch is the real meat of the problem to address Qu's issues.  This is an
RFC because I'm elbow deep in another problem and haven't tested this beyond
compile testing, but I think it'll work.  Once I've gotten a chance to test it
and Qu has tested it I'll update the list if it's good to go as is, or send a V2
with any changes.  Thanks,

Josef

