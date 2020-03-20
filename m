Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D318D713
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 19:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCTSel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 14:34:41 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:43558 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCTSel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 14:34:41 -0400
Received: by mail-qt1-f175.google.com with SMTP id l13so5782516qtv.10
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZtxYcVBbiSEGwPLAXRpHwl7QnjCdZyo87e0eoYDyvo=;
        b=qQz0u3TzWywvMD7VoKd+9xKuXhT8beGMiKN8jtZOc115DDafCg//OaxESCFWEqRIyI
         eJzzr910tPTEVeLgGBrIGf9guBN+bgBeCc5cksbDT5/1lMOnzHlHD5cUP2sZbRwt38yT
         svYzqKJgTY4PmSnZVa2eT2FomC+5YkX9IvTHaPftvHz6v4aIToZDUHKiplEJEA/LwnvS
         Bj8KipUsHzxMkOMcy5ZOE1dM/0nCHUD0/fiw5JNeP5xglo9nc1XYXRxOCFWngR1ax158
         0u+rZfn9t+DN313Y5PUg2SAcm+YMTYPpfODzbCNZDwF3lJ5y1LVUHLWL3Y+8LpHbxrA7
         dSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZtxYcVBbiSEGwPLAXRpHwl7QnjCdZyo87e0eoYDyvo=;
        b=W438EnloDSaH4c13hz3VAa/15FzdnIYrTv+BRmJIccKJV/iQsSgxYfJR3RL25MoijX
         7Hw5hIo2EXDDfb3A9SZBK+3iyl9THKBUZ5J+D6tsNr8DkQjnhG0JYtXs9Q2Iwxa6wThq
         r3oQVTcxVe29YmDQ85X2FbCyQMXeRSIK8JZc3llal3IPPIC6fHeCr/JcCO8GjsTyZj5o
         WAYOoLD4WpA1pasL5tj0DU8gATqRToiGfdgYPFcShZs3HbhXMCuXDaENcwRIlDj9OE5K
         cm+Ym8t/jX+O8fnH+oJkXfcnZo25KjUPIYeaPOF4u1vJr6Qz49ArPmqbc+4FG6kj880+
         awpw==
X-Gm-Message-State: ANhLgQ2VbXk8KNemDrWtcMQYUZQu/OUwh+IpCqhQq8hhXJayikuUyEnd
        QXA7iXv5uzL2//gnIpJnOaM3o0FHY+quzA==
X-Google-Smtp-Source: ADFU+vvpq2EYtA26k3FKdaq3lYBMcckqIrCZiMb3N91n3qng94Dn3bBNckJ9yo+yHMI8Ywv6iVwfbQ==
X-Received: by 2002:ac8:72d4:: with SMTP id o20mr9960675qtp.23.1584729279769;
        Fri, 20 Mar 2020 11:34:39 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f93sm5151327qtd.26.2020.03.20.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:34:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5][v2] Relocation and backref resolution fixes
Date:   Fri, 20 Mar 2020 14:34:31 -0400
Message-Id: <20200320183436.16908-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- reworded the first patch.
- Added "btrfs: restart snapshot delete if we have to end the transaction".
  Zygo still was able to hit the backref walking+snapshot delete deadlock
  because the original fix is still a little racey.  We can already restart
  snapshot deletes, just drop our path if we have to end the transaction so
  we're not holding locks across trans handles.

===================== Original email =====================================
These are standalone fixes that came out of my debugging Zygo's problems.  The
first two address a problem with how we handle restarting relocation.
Previously this rarely happened, because if it had people would have complained.
The restart logic was broken in a few subtle ways, and these two patches address
those issues.

The third patch just boggles my mind.  We were recording reloc roots based on
their current bytenr.  This worked fine if we never restarted, but broke if we
had to lookup a ref to a reloc root that we found on the tree.  This is because
that would point at the commit root of the reloc root, but if we had modified
the reloc root we'd no longer be able to find it.

And finally the last one was a weird deadlock that Zygo's insane test rig found,
as he runs the dedup thing while balancing and deleting snapshots, which made
this thing fall out.  Thanks,

Josef

