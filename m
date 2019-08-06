Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A418836B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfHFQ2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:41 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:34307 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfHFQ2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:41 -0400
Received: by mail-qt1-f174.google.com with SMTP id k10so15999054qtq.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHWEHlS5m3jSZsBxi0LOHpu+8UCMK3FtD8j84r4jHZQ=;
        b=qFXjaF/L8P8gWQxaay4Tt6q/y4KSPinyylw89i7Q6l69YdAC5ORjCabMiTrTuBHpPN
         rHgIJFVsWBELEoO1WTeBn3BdD+tk5waTWRA4JZz2aOJhcD6HD+VLrrFH36TJJ5nD85fe
         YMKsRG6+CvBYWWJ/UwIFKVSbmKG0vhuSXn1OHlpCerWqAdj476AlM/4CUz5aLL5UV/QJ
         TvQB2x1mzhNxt/8jnTq0rqKJQfJCtTnSmhNqb0FEveZq0AoLeliMOw0MvxFSQHHkXCQG
         8HYw+iCGOAV44Ox3JQkxtTtYIMAOhiVDdSttk61FqBz5JdpjV0vLwCnj+7ENV+VKXDJP
         PVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHWEHlS5m3jSZsBxi0LOHpu+8UCMK3FtD8j84r4jHZQ=;
        b=OQlkk8M7f13aXWXzvE3JFOTtYoTY2RcBEjjHIRQjlHpUMf/ncsIIdBrX6VXob93rk4
         2octm46FuSQSyrbsahQoZwdBtsSLRd5SE39R3Jxc8VY0bSg9DfkKVdQ3FFnmcVd3uAzl
         KzePX1Y7EZoc/4KurN1b8/WKfFI082qiww/FMMRWm7qu4/q9OGUBKawCVq8sH0newgkx
         z/FV4T3Kdy5p54Gb7gEOvSEh9y8bHFzUJct/9tECYpQDnXKhY47sL+sguf3LXOEyrOPT
         fvG2BW9CxksQpPZpFWXzKS3NrqzIY1waTZyzcOe2CnTbmPTdSEJV0xT+NUwvAhDojNPx
         GlKw==
X-Gm-Message-State: APjAAAVjpvySCBilzyHeobkLRKTZrAMPX3t15HYINp4kjqqefS+hd2tN
        ShK45SwMAxxnxbEQFo4Z0OTrTA==
X-Google-Smtp-Source: APXvYqyEvJ6+vn9y+U/zkbkt54G+WmvjZIG8ch0umKp3p/SjGX4L0mFeJK4Dbn0gqTr74Q235Z1esg==
X-Received: by 2002:aed:3aaa:: with SMTP id o39mr3967258qte.146.1565108920258;
        Tue, 06 Aug 2019 09:28:40 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b13sm51916847qtk.55.2019.08.06.09.28.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 00/15] Migrate the block group code into it's own file
Date:   Tue,  6 Aug 2019 12:28:22 -0400
Message-Id: <20190806162837.15840-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the rebased set of the much larger group of patches I sent last month.
The first 10 patches are already merged, these just didn't apply cleanly.  I
went through and applied each one, deleted and re-copied anything that didn't
merge cleanly, and compiled between each patch to make sure everything was
kosher.  This series just moves code around with the goal of making
extent-tree.c smaller.  I made no other changes other than moving code around, I
want to keep cleanups a separate thing _after_ we move the code around.  Thanks,

Josef

