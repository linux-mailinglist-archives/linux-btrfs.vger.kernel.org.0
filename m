Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF499FA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391801AbfHVTOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:14:38 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:37793 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbfHVTOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:14:38 -0400
Received: by mail-yb1-f182.google.com with SMTP id t5so2967206ybt.4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c935jJZ81yMZBFmYOes4DYqH/42dqEjd9rlob8Finv0=;
        b=Ow0D9OQO18DFEuBhCwopCI5Bx6JWDObG73TcVnak6IRq4o4gIu/MgoKTvfcs5jdCVy
         hUnJrP57fpe82v6FsPWb8KYh4VHMZwA/a9EDRAPpBU+tEpGUrzYdswDPMmnDoqnc25Gi
         X+hWa428ShpS6i6Mf8m2ptx86+gg2Edq62HG104OBPic0v1jKyYQoEXYsfLtHaM7lV/e
         ilzuAA06NO0DCresceY52pEqg3jmX9qrVh07Baht44qUzLYsPQLtCLcoMSCVhEdOkjow
         s8l2O/VC8o1ozkSHF1W2x5sMp8nUO6IKjkaqzcCrj71V2/N5BY6QkBNChnhA+wwszktY
         5e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c935jJZ81yMZBFmYOes4DYqH/42dqEjd9rlob8Finv0=;
        b=Xwov3se/hawLRkYKYoWU7upAbnPuXicN1lmm8iHwwbn0PVlUxzePsBD5x6kZXheK4r
         uCK9znIgHzWqAJbsbX419eQTDjglVp7wSK73Ty+6clZ/qkQqVLVAqlPCh6GFm+8yHJj2
         mwAnBMuZ7Eq3vUCOeNNj8lMjacAtHQpZ7wAbdrW0ZlLkEvhjIop/xC7o/ajzh0jSoLAT
         ImUbo0Kuu47DO+ltzwRvJm0Y8jIGWMKZmZueN6cvpd53g6Zy2DSNbad1ow/qIVRYiVGK
         scpcG0ZTXC3ye8VAf7s0S0opn5ir4CgOlTYjdRq4NvIWhnBA4A+UMbdYncj4TXT9l2RX
         B9pw==
X-Gm-Message-State: APjAAAXdx5mJX/r7k2yj27oefbkfylqXT1O7/Q0qQYXkerAHvblUQZyb
        +4hM8x7m44YeUGmb5cbv79bPvjjkEWgTrQ==
X-Google-Smtp-Source: APXvYqyPwloDENa9Iv3xjBIH+axjH0zYauh18stfXSBzTGFS8pAGpQ7PrGm+sY8RQmCuj3u9kLyTuw==
X-Received: by 2002:a25:2d09:: with SMTP id t9mr390474ybt.332.1566501276798;
        Thu, 22 Aug 2019 12:14:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r9sm98484ywl.108.2019.08.22.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:14:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2][v2] Rework the worst case calculations for space reservation
Date:   Thu, 22 Aug 2019 15:14:32 -0400
Message-Id: <20190822191434.13800-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- dropped "btrfs: global reserve fallback should use metadata_size", turns out
  I was testing without my evict changes in place so we don't even need this in
  the first place, but it is also wrong because we need to reserve space for the
  orphan item which is an insert.
- Added the reviewed-by's.

-- Original email --
We have two worst case calculations for space reservation, one that takes into
account splitting at every level when cow'ing down the btree, and another that
doesn't account for splitting at all.  The first is used everywhere, and the
second is used mostly for truncate.

However we also do not split when we're only changing an item, so for example
updating the inode item.  So the name for this helper is wrong, because it can
be used for in-place updates as well as for truncates.  Rename the helpers and
then use the smaller worst-case reservation for inode updates in a few places.

As a rule we still want to use the insert calculation when we can't be sure what
kind of operation is going to end up happening.  But for things like delayed
inode updates and file writes where we know there is going to be an existing
inode item we can use the smaller reservation.  Thanks,

Josef


