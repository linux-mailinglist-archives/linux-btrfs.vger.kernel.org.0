Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C17B0B40
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjI0Rp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Rpz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:45:55 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE010E
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:45:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 547BD32008FC;
        Wed, 27 Sep 2023 13:45:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Sep 2023 13:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1695836750; x=1695923150; bh=FjxlkBjvRQ
        faHRfk9PfVbWNer0i06IauT6UJjiLiG6k=; b=aR083tmRmvfZPs50vSfZVjy3c4
        60b/DvfrawDBqCSzXS1er6nAgeu50HGIj0ZLrJ7+dMMEItbU5JrACVXzF2iz70/6
        iSHfb+g2WeVBPSjtnlIyp/xHWHbdwCCGDcqGBQi1t7/YFZ3dq20LY6+6kWRByZ5Q
        0sY0G2l4GbjC12+3UnRdHmSc5yx5V7bi4QChpY/V6RnczeJ93KcbnZwHigb4EuJu
        c85LULHTo6cUzBKzYDVE07mUuPLP+N4bnIWNf4gWpQCSANRpftw47qCiBLeiS5Ps
        dUi2NCldJuOhh9bLGnqwuAWXpkk/Sjzo362AlMidzlsuKoNiWGgCgSDiPv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1695836750; x=1695923150; bh=FjxlkBjvRQfaHRfk9PfVbWNer0i0
        6IauT6UJjiLiG6k=; b=mYwnDzKgQpRkWTz8DZoj6S/+UpAsFiDmsYGdU+brwUEY
        OeMh4n9oUWt+Z5Wkz/22JclX2obFzy3uS8XhIcUK1q5s4LZ6S+CBlY1gd+IpYD9X
        Tf8NlbaUJ47JYyJ+8zH+WlRxOBHL3saXhACYCzcPxwEB2bVYWmpetkVu2NVuanWd
        cIVXmKQnqYU8W4b011drIpLgewG+UYPdFTjUfkUIPa+6iC6wSCec9HQQM1LRrOAq
        1z3lj0hFWKZalwd9Yb4Tn1bYK6I4Cxwy3JKDWlH1bC1ZmafSBS0Qw9OcLBmfVgED
        b/HPrjTx1X0SCnBKfqJxGjlIoqJnmlBGu/VtNqBbxA==
X-ME-Sender: <xms:TmoUZeJg2LxX952ErvkWmkudl5LRZpJCqagzUexy1VIrKiTpBXaPrg>
    <xme:TmoUZWJoemObDNiodve_uoaS4LPnIoCbFsWPu-iZCBH4uk4QsoRjRUCxBiQehnQzM
    n3SIye_Wf5F-UJiOuY>
X-ME-Received: <xmr:TmoUZevVnoJLYiRNe9kFgW3xOTybfHhHwVW3YluUJBlNx5QwQCvKDDFrIOafMNIn3qMzBHwBzqrsbd5kxF60acWMeWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:TmoUZTajWZWFnqLYEj9-4fh8wb2sNKdsXwqTOlUjKUcCWnZXmHcYvw>
    <xmx:TmoUZVbG2KU0J2_MxOmZZJLVSkvkv8RZnCChWoiai-mt7GGKevoA6g>
    <xmx:TmoUZfBSrEuIDPxUIF03bxnLfvurIFZ7-FqpJy67MK1jgru1_p4bSw>
    <xmx:TmoUZWClmoWmq6lKmLJb61c__3arTiK7f2zR8j6u_XqfdLxu1c-8rA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:45:50 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/8] btrfs-progs: simple quotas
Date:   Wed, 27 Sep 2023 10:46:41 -0700
Message-ID: <cover.1695836680.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs changes for supporting simple quotas. Notably:
btrfs quota can enable squota via ioctl
mkfs can create an fs with squota enabled
btrfstune can enable squota
btrfs inspect commands dump squota fields
btrfs check validates and repairs squota invariants

---
Changelog:
v3:
* rebase
* update enum values to match kernel changes
v2:
* fixed messed up list numbering in doc
* fixed broken formatting
* used new command in enable ioctl instead of status value
* introduced new qgroup status flag to mkfs/tune

Boris Burkov (8):
  btrfs-progs: document squotas
  btrfs-progs: simple quotas kernel definitions
  btrfs-progs: simple quotas dump commands
  btrfs-progs: simple quotas fsck
  btrfs-progs: simple quotas mkfs
  btrfs-progs: simple quotas btrfstune
  btrfs-progs: simple quotas enable cmd
  btrfs-progs: tree-checker: handle owner ref items

 Documentation/btrfs-quota.rst    |   7 +-
 Documentation/ch-quota-intro.rst |  59 +++++++++++
 Documentation/mkfs.btrfs.rst     |   6 ++
 Makefile                         |   2 +-
 check/main.c                     |   2 +
 check/qgroup-verify.c            |  86 +++++++++++++++-
 cmds/quota.c                     |  39 +++++--
 common/fsfeatures.c              |   9 ++
 kernel-shared/accessors.h        |   9 ++
 kernel-shared/ctree.h            |   6 +-
 kernel-shared/print-tree.c       |  27 ++++-
 kernel-shared/tree-checker.c     |   2 +
 kernel-shared/uapi/btrfs.h       |   3 +
 kernel-shared/uapi/btrfs_tree.h  |  16 ++-
 mkfs/main.c                      |  64 ++++++++++--
 tune/main.c                      |  18 +++-
 tune/quota.c                     | 172 +++++++++++++++++++++++++++++++
 tune/tune.h                      |   3 +
 18 files changed, 504 insertions(+), 26 deletions(-)
 create mode 100644 tune/quota.c

-- 
2.42.0

