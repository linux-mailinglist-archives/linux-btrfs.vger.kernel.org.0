Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24AF455F6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhKRP3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 10:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhKRP3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 10:29:19 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4BC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 07:26:18 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id p19so6332695qtw.12
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vrVWYN1bc5g1UgqTXVIR/rtuf2A8dlWGnkdTWialRU=;
        b=GSpv6pUs5WgkEIbbOGz9rrBrrBgN/LSJwUXwqaUE0Ore+6Lz6lhDUr7wWS/7jhpapz
         vDsYpQumflSNLaKeHsO33M1D51xG22hvUqurudUQU8+w2JLgDy93kxRk8QleQqkuyUzD
         Hkn5r/kofezl876tNXLRoW5vGDmv5mYfiYXCshsTLJ8C7qoz5yJiLznvWq3hymh37NfO
         DKqGhdM9IrvNo6POZZVYcUtLwuRqTnaOdpRi9j9fMcBN76GXKo5CD2sQY95DXveQGI53
         0WnBrtZnyQJN6ksmktWmuZQSYSHkyFHhcaVjaZxQcH/PnXXX9MCrEwflswQ4MV/Kot9K
         eA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vrVWYN1bc5g1UgqTXVIR/rtuf2A8dlWGnkdTWialRU=;
        b=YjukuIjqinCiWcqNkU6DlNJKisyWx2yYqOnO4TytTqK6iT7mYirJOjXH0nyNfPi06H
         Wx+8f1s3AG2TcnXtWLHgbtHlRxjoPaOhgji6JKghowQ27aN+z8ZduLdlifSyE+NE39A0
         JWFSnSUaeguEj/hrkoeVF01ojl6sbkt62CuyR1rsDhb8HV22DmcuTk3528fNNM2nRDYH
         yQDQf3fXOLtApfPixRsyFm9xB6fEgmNUJ8dYuXNdTseMBI2635bXSFcm7GpmIpEgcLE8
         2obcgjjQetNeR9bG+P1zDly7PO+JVYWDehy6JVCbGeLmhPoN9+eKHY4PP4p8hvKrxhLm
         Bz/w==
X-Gm-Message-State: AOAM532BMkogo0Gwx7YS8GWLM07CNZCzbnj5gXIT/svRQs1jzVG8lmGE
        XXUmqyexaoHf3ZLcdejzowTdLDZ075yZ8g==
X-Google-Smtp-Source: ABdhPJzooBPV4hXi1TxH0jSDw3aJlwgkdjE25/uOwna3NE7Sy0RpMw7VXHxP+ZxRikCHGBNZY6PG+A==
X-Received: by 2002:ac8:7f06:: with SMTP id f6mr27191323qtk.258.1637249177763;
        Thu, 18 Nov 2021 07:26:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i23sm66570qkl.101.2021.11.18.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 07:26:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/2] Index free space entries on size
Date:   Thu, 18 Nov 2021 10:26:14 -0500
Message-Id: <cover.1637248994.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (2):
  btrfs: only use ->max_extent_size if it is set in the bitmap
  btrfs: index free space entries on size

 fs/btrfs/free-space-cache.c       | 174 ++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h       |   2 +
 fs/btrfs/tests/free-space-tests.c | 181 ++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+), 20 deletions(-)

-- 
2.26.3

