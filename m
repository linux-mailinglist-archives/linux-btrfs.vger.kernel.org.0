Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F412456514
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 22:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKRVgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 16:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhKRVgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 16:36:20 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F13C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 13:33:19 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id j9so5623087qvm.10
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQ2JTZmj7ZCjZmSfcsjgywIq+RkEBJtveiBzRdnvygM=;
        b=J9wWwZafb8kv1jnw5gl06sxwGm2wu1ilT3KwwZmRwdT0MrvOiJeXXEobWKVJ6eICwN
         88cppdCW3TVTGVWP5s4OvZ94PYp2nC71SClt3TgVzJ7elDJ5WlRvvpmwOIkhl9++wc13
         q3PljKSNIcPxlpGcsvDuNsnmQC4n9vfbq+7qAm9pml9RZffDpzvAx69RYrCGe7URazLM
         5NL8PoPxV1JC65O6et9Fd8knhiMBRvqa+GTIxvuRVS8O7vc+XAJkqMM+eZOr1pJCLrXE
         hALEuC0ZhRgbIK2Ayp2CCGhlRuAgGpj35o+pyFvb0QuKauaI8Wdkiggc70UBHULbH8i4
         zztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQ2JTZmj7ZCjZmSfcsjgywIq+RkEBJtveiBzRdnvygM=;
        b=nphinYjoeGMeX9lfrmA831sireUUaEJWclb78uFiqWQ/H42o+1aVliwrr9skS7/82s
         FF/6LWiqtOwpFfYBRLMVld+DhGWzganukAqfNKExeGlmUD+4cqIjZ7+SrRIalZ66Th21
         0SQnras87ig5XkEtmVXXNVnVLLm6bAf8moOu8QUMa3HO6ZeMcuK8bUkUOo8SXPycL6dm
         byXgIdXvRULkPTIIHwel0lSD9K8dOL/uwfTatZEZA2MQxTFtiBq963JkqA2hLuUWcO/w
         65I5tgGzb09YkVrlq1vChXCmELkLUVCuY4mXnteU3gNhzH0KeRfPjnajrpK/RBUEF97s
         5OSw==
X-Gm-Message-State: AOAM532hO2axjfAI9ZBtyNc23eq3357NyR9rOYl0elFJareOWQLyzUkC
        IuEYPvtcX+QvvH8hSKx7NQzNwBLusZMNPw==
X-Google-Smtp-Source: ABdhPJysMiObHUS4DkL4U8bMAUeSFL0brSCemmrmj/hDUTMpZkBH5fPCpGD+x6gUKNNoweobQzpU+A==
X-Received: by 2002:a05:6214:5002:: with SMTP id jo2mr68385286qvb.54.1637271198561;
        Thu, 18 Nov 2021 13:33:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs16sm611970qkb.45.2021.11.18.13.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:33:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 0/3] Index free space entries on size
Date:   Thu, 18 Nov 2021 16:33:13 -0500
Message-Id: <cover.1637271014.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4->v5:
- Broke out the self tests into their own patch.
- Use the rb_add_cached() helper instead of yet again duplicating the rb tree
  insertion code.

--- Original email ---

Hello,

I noticed while digging into an xfstests hang that the bytes index stuff was a
little wonky when it came to bitmap entries.  If we change the ->bytes at all we
weren't re-arranging the bytes indexed tree for bitmaps, because we don't do the
unlink/link thing that we do with extent entries.

I fixed this particular shortcoming and added a new set of selftests to validate
that everything was working as expected.  This uncovered a weirdness with how we
handle ->max_extent_size, so I've added that as a separate patch to make it
clear why the change is necessary.

Additionally I've updated my original patch to include the fixes necessary to
make bitmaps re-index when they change.  I've added self tests to validate the
changes to make sure everything is acting as we expect.  Thanks,

Josef

Josef Bacik (3):
  btrfs: only use ->max_extent_size if it is set in the bitmap
  btrfs: index free space entries on size
  btrfs: add self test for bytes_index free space cache

 fs/btrfs/free-space-cache.c       | 157 ++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h       |   2 +
 fs/btrfs/tests/free-space-tests.c | 181 ++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+), 20 deletions(-)

-- 
2.26.3

