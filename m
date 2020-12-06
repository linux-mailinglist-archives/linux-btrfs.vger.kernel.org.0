Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0E2D05C9
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Dec 2020 17:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLFQAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Dec 2020 11:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLFQA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Dec 2020 11:00:29 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447FDC0613D0
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Dec 2020 07:59:49 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g25so7966613wmh.1
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Dec 2020 07:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z1r30gDwz8BDumgNdRNhDSnIsdG4eC7qoxuoKJEh1I=;
        b=vHHKJL9dlrzu3yK+bNTjTupx9g2axl+vGjFo5+pFZ5Dp9bsf5DMeKnrAvNGXu7Q6zI
         zVoF8s2oshYiewfAdIHYDWJ/IPR/M8hbIixZhNqBogkb5IQja+3QieoCPU3AFUPPS6pP
         VZH3A7Iqx+s8IDm5GetUosCVzX0EYpS0ZsN81L90DbPTTSj8jEF75HLdbtQs3AmKsM2B
         lEaF9phJ+NcuV+M6HxaX4Qc8UkAI2Dfw+JXqIKhO7VzKKO/Aer0HNNJj3/uhS1jxpO1x
         LQdUSN4qSMjwDUwwrmeBECl+NWzxhO49+Fw9Q4zITJMgXu8DTcr3h71nOKcjhWNo8lcQ
         13ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z1r30gDwz8BDumgNdRNhDSnIsdG4eC7qoxuoKJEh1I=;
        b=kMw0l15WAvXrmcUtFEQCbYSHl5zV9RqiLwMtgdALFs6AxnMpknd5Rb4bmH056sY7Q/
         mBS/2LaEUnkJLOjCCS64jeeANHLoS1RI8hozchS78MjDl3jnwDuMiHQyhtCDIVlUHEsk
         U7APDD0AS0U0NIw5DTWC2A7LS4KT7a9Ynw5E5PpGKkthKRje8po7ap+Oq3mZXgWsEg0l
         v0TJdpcgonOtUde84rqn2bOaiYnLG0yYY3HhY/xusILSApqe6TBh3ZLDF91tlVM+fle+
         F5OXdAJYVLchjZYs1m4EaTRny6gEEOizNOjm0LDLMuZlCwIb2PPEKRLOWw8iKdpkptUY
         Qhfg==
X-Gm-Message-State: AOAM531iHz7meZoq9vEu7KJs2u9TGJSmKN9/vZYNT7rHZqc3c4OVjJNl
        jp4zC9WtYbwF87WGArCi2XY=
X-Google-Smtp-Source: ABdhPJzDcd4cyUTzrj3l0/dceQ4JbuQjBQA9DwzsvxgLopY6z/PC/4FemA0e0aPKzWkZQXOJShLsZg==
X-Received: by 2002:a1c:ba07:: with SMTP id k7mr14409615wmf.34.1607270388062;
        Sun, 06 Dec 2020 07:59:48 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.92])
        by smtp.gmail.com with ESMTPSA id h14sm9933355wrx.37.2020.12.06.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 07:59:47 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v3 for-next 0/3] btrfs async discard fixes & improvements
Date:   Sun,  6 Dec 2020 15:56:19 +0000
Message-Id: <cover.1607269878.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix async discard stalls with the first patch, and address other minor
things.

v2: fix async discard stalls, see patch [1/3]
v3: if now == bg->discard_eligible_time it fails to init discard state,
    and index. Always init it if peek return !=NULL bg, it's more
    resilient.

Pavel Begunkov (3):
  btrfs: fix async discard stall
  btrfs: fix racy access to discard_ctl data
  btrfs: don't overabuse discard lock

 fs/btrfs/discard.c | 70 ++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

-- 
2.24.0

