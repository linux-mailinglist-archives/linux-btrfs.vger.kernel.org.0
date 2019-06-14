Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A80450B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 02:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFNAeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 20:34:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35200 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfFNAd7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 20:33:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so471771pgl.2;
        Thu, 13 Jun 2019 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J+WIIloOg8R89ClRTeMiBEyvJHmr12Pt7f1GOmgErrg=;
        b=YhRTqGTux1UNwJbR9l++EjV3FIfs4oZYe2F/+74GkB28vP13HoaYTz1OOgDbnCwuAn
         7PTQk5aAmp3XVlQFWDwzMZKCoiY2Nt4VrW/UCS4aucRv8Tkl1lSnWF8trTiEPjVnzVEp
         OIyCgZUn+Hq6FjOA/cwjGotXXWat43A8uaMwa139+gx/OkrnHit+w4xLIxpuarPGfWzc
         bg1XsyDLeM5ikjMmd3AVa7DXwf4VE9am6/XJE7BQh14YR5Ax7uZg+EjXhY5OWbISVx2q
         XZuk2A+iD3Oj2Qb+QmOJrWS4CX8tNF1TYSxOGeFNyhjgxD7LPjVSkW9VQoHF7eSwcQzV
         0JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=J+WIIloOg8R89ClRTeMiBEyvJHmr12Pt7f1GOmgErrg=;
        b=qvM4KuI3Rv9cgI926sawFC2XTf7pnW3YfR5IS9b8RSEUvP//r9PnResikaD149+wKh
         7UfjhozhvUt7elezpuC2J3og2O/k1PPurRzf6bqAGrJn5cZArYHs5Ic3gQYdXCltGDzZ
         At4z9+26ZN48h6HLo0cIAhB6WOHDSUYKcSF7Qh5NZZ9OeaX0yJhjRLdaj+g48siQLsk4
         S2F9HN32sbrHIRKHlEZoxvaATdPQ7io7K1whpr0gNpbeflJ/7CKP7xZu/ULc+ZZJ9C6E
         ZOR647C3KTQzTfOyffQR37rKAvFku2+2xtHH1xIUR5SvGFnKkVEaWVsdoX+uYRoHKJRJ
         aBMw==
X-Gm-Message-State: APjAAAUNZc2n1gEdNlzm7O3JtUO/EvbqdC5SAUDKfpJuKaF4V/ZLxNig
        GUZuuwpIecyohqExmn9omVk=
X-Google-Smtp-Source: APXvYqxJXtZl5ddqNJkiz0UB18vPyNmtxAoGE34xxniDb2UxO2ThLJNJOSjuSWiMS9pD4PVo8R7OjQ==
X-Received: by 2002:a17:90a:bb01:: with SMTP id u1mr7185132pjr.92.1560472438757;
        Thu, 13 Jun 2019 17:33:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id p1sm827742pff.74.2019.06.13.17.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 17:33:58 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/8] blkcg, writeback: Implement wbc_blkcg_css()
Date:   Thu, 13 Jun 2019 17:33:44 -0700
Message-Id: <20190614003350.1178444-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614003350.1178444-1-tj@kernel.org>
References: <20190614003350.1178444-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helper to determine the target blkcg from wbc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/writeback.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index b8f5f000cde4..1c85563f035d 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -93,6 +93,16 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
 	return 0;
 }
 
+static inline struct cgroup_subsys_state *
+wbc_blkcg_css(struct writeback_control *wbc)
+{
+#ifdef CONFIG_CGROUP_WRITEBACK
+	if (wbc->wb)
+		return wbc->wb->blkcg_css;
+#endif
+	return blkcg_root_css;
+}
+
 /*
  * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
  * and are measured against each other in.  There always is one global
-- 
2.17.1

