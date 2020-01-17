Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3006D140BB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAQNwm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:52:42 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:35638 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQNwm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:52:42 -0500
Received: by mail-qk1-f180.google.com with SMTP id z76so22715998qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qp5l/3F45OgeVp84pjDeDFWuZJkLsRyUoDHqdrWlIeQ=;
        b=F8tqgbq3EaTKtXU0TaRFIwTbYy71ZGt2Vx/E2SGu7WftNclLZP/V44kBBc2moApeyx
         PDEqyXkINHw2c7s1AFtTSnZQ5qwJd0gd4PeR3s2Vi2BRj9uV/flGDjqT0worlFxaAShe
         w5p6v4vOSQT+jyXQ242tmTbWDIcFjowGqM5cKoxP6oO6xSwoLOBWcU2XJqjrD9IWUXGk
         9iIenyvXSlj6QNIKSI7XAZsP4iRY326Fes/FCf+1kAb8Yz71z5E0aZ3Ew9+G2NvmB5q0
         EQkwsDXhDEotDqoE/iF6WgIA1Fsp76JSuOvBSY7dAvd8AnRZH6n+rhTLu6F7OXDfX1Lq
         N7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qp5l/3F45OgeVp84pjDeDFWuZJkLsRyUoDHqdrWlIeQ=;
        b=uHiNvTG7FRdLGpV1+E30FjiQcqC97cwfINd7muBOX4cWh6rbUhVpkVvcItCKO+4mh8
         OfiO7KBbHVtnus08/6RJeOlISVxsT5Iu7MqCqVnBh1olDahYebum95rl5dyUv+E6tG5g
         zNcbraqk9ZKOxZ7ng4ITEEGJ4Epf1XmBubaFmFenOiZnKkJS7M2nUq7FLmWJCjrI19Ay
         r05rOuF+3KS2IP1a8d3RQmPFElogW0z9SRbHf+O+fXajQHzHlkuxHBlSCKGNjh34+7nO
         Zps0TfteFLTxMZlL8IfQLXjEtlNuu8EzO7LCIJnVVGF2lvdTqdgmEpzOEVlJEKhZIpGz
         82PA==
X-Gm-Message-State: APjAAAXJbJCcLrYa6FlhsozRQTMmDkBnHP7vC1tR/YbCPqKQWlBN7PBt
        OZ4FF6zo0YacCQJLsWm6VN6gqtRMjfdbrQ==
X-Google-Smtp-Source: APXvYqyI9VDc6nzr+XR0/gEtb1AsF/h3OysfmdUL0JQjqJvzLSaX3wt8Ri+rIdWAIl1az/7Zd9QjhQ==
X-Received: by 2002:a05:620a:210a:: with SMTP id l10mr37438266qkl.382.1579269160478;
        Fri, 17 Jan 2020 05:52:40 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r6sm12714651qtm.63.2020.01.17.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:52:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8][v2] Cleanup how we handle root refs, part 2
Date:   Fri, 17 Jan 2020 08:52:30 -0500
Message-Id: <20200117135238.41601-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rebased onto latest misc-next.
- Fixed a problem where we were dropping the ino_cache_inode in the final put of
  the root, which is braindead since it was holding a ref on that root.

--------------- Original email -------------------
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


