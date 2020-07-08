Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7164E2189A1
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgGHOAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D6C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id k18so4199050qtm.10
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsrlyGZJ4bN4vxf0lqPe3QLp8ndgvM5RkdQvGd9XadQ=;
        b=I4vT9WOftq8vXFtm2A6Eb1dCfMKiD6S/KBTSGbNNVRxM/sKvZSyv+dSpRlrECVT8pz
         PbNGxP2CWiUU94BCr0TQfUKXWlrwUn1PHkg6pH0A3qcp/lA4Qr61ivQUTalK2l9V3lKO
         mUi1PdJ3J5bFW1KSFRsmvT+fSB8HOWisG2Toi9820Gll+pFjAPMl2gs6sQ10cO5naqD9
         Ua4eNk3ASEAy1gArTXOM3A4gPWKpwUef2lohYnC//NL+S1VVEgKVjiyUDNkkBh2IetYh
         7HI12IPlWm8V592U+T6gAnxeZJxLoPefJaTkg+oc60l6xg6FS8ZeiPNAYv1+HrnZw8Rd
         9OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsrlyGZJ4bN4vxf0lqPe3QLp8ndgvM5RkdQvGd9XadQ=;
        b=Dd4QZrtANvwqs+oD8WrEO0MwGHsIpYHrxeNTZt/EGsS5cLUyqzYZwTXYH/q1dtulo7
         6aOfNUkFbv1brOzsPtpZAKb7pI6xb2nHz16ngmzNlY9sXHZNpe2mLjCBjirySo5dy17V
         gMV+jrx1Jn1dtfzNeP1LbE2AGLUeAGmX8vuUiCtMK7SHldxCVJ67QzaZkqXh+bhmLkWz
         LHsOp5guWfGs/h9DRlFOQ+so5REJ+Pooi0Wh0xODYS/g4/ViZrGZbN4OTum06+28YS7m
         yIZE58D0eYdQepYvt+BdKfcjK04cMSeAr7eND/XyP4+CnuKQtV49QUB4+IX/CHJuXTlc
         1QRA==
X-Gm-Message-State: AOAM531La80ETiqBrN8sKn+FzVbDxPF4tTX2XaZE9E9p91o7ETf9DmAV
        b2kDQSlFUCm1cUnpbI7CseMRn/RkSbUkVw==
X-Google-Smtp-Source: ABdhPJxQ0fdLTU+vnzxqnLfBxgzw7EXxscvut0xba33tpkgMXBJkOl5uwPI79N9xSWsZNvQS1opiNg==
X-Received: by 2002:ac8:6f7a:: with SMTP id u26mr58810682qtv.33.1594216816909;
        Wed, 08 Jul 2020 07:00:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m4sm32660472qtf.43.2020.07.08.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/23][v3] Change data reservations to use the ticketing infra
Date:   Wed,  8 Jul 2020 09:59:50 -0400
Message-Id: <20200708140013.56994-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Rebased onto a recent misc-next

v1->v2:
- Adjusted a comment in may_commit_transaction.
- Fixed one of the intermediate patches to properly update ->reclaim_size.

We've had two different things in place to reserve data and metadata space,
because generally speaking data is much simpler.  However the data reservations
still suffered from the same issues that plagued metadata reservations, you
could get multiple tasks racing in to get reservations.  This causes problems
with cases like write/delete loops where we should be able to fill up the fs,
delete everything, and go again.  You would sometimes race with a flusher that's
trying to unpin the free space, take it's reservations, and then it would fail.

Fix this by moving the data reservations under the metadata ticketing
infrastructure.  This gets rid of that problem, and simplifies our enospc code
more by consolidating it into a single path.  Thanks,

Josef


