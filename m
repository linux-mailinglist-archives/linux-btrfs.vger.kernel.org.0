Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D73F5134
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhHWTYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhHWTYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D0C061764
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f22so10753234qkm.5
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OUIAPaPRo28Nh4nvyCNL2l7pZbGalkX0l+sB9/pDFMs=;
        b=VgjAe9HM4akQw1CxDLwW0NEKz3a3RWHbICzUPVbxnvC19NFhUxPPTnhaahRQKV4rIE
         Ej+webvyU6tsMRWSdaLxEofjjJ+6h9V/ySqiLvO+791n0kQvCZ6YLCxdWaFFE3GLu+Mm
         ygen73fMK6iHuEbzOx1WPflnez/3Fsc4aj7RrM6sOf4McvgbsXoYMi0yba5z7f6r2e7D
         XNXkabQ0E4H/AzeYmTbujb3uuFSmKx+JMMFGsgsEOLrGTcQl9r+pmnKNefeFszW5cS+7
         RgOQi8eoYkAYh3tBR5r51AKpHeV/nhD4ToKbNTwtbn/SkXLVFEQ2NAzW/ZiR2jcuwcxI
         WiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUIAPaPRo28Nh4nvyCNL2l7pZbGalkX0l+sB9/pDFMs=;
        b=kEvzvpF75c5VBxZYh9aDlVkhaA32wPAOnpWl5rQ0P3fhc3QVw1eqAym4TVCQM4bANz
         BLGKRDJX6NUDLU8Gp4uossDEgTUvj7p4eZmTjifyDsKuiWJxi/INhWWsNf0Kx7KIfq+l
         ToHH764g4KRwwxaSs56Lv9cime9xf1TFkuWK+8+qzeVaeZ0T92HyB/u7BPSnFXBDCQF0
         mg2cbxaXyWtKkSA2yNr4ufh+rJMYTlAKQgRymDsamxtDCK6Rwhf1sd0PqLGNCypTg+S3
         qek9EQaNlOOAnB6F0cB4zaucRKpL6krsdTnB5o0vGjXYgiyK3ATNAMP+VSzVaxvB/I9F
         W7+Q==
X-Gm-Message-State: AOAM530p1w8yYRzLRP+6Ei21uX3gNbUPZ/LuGbG05Fz/6Uvf3eUf9e5Z
        qVOgXRO4XLN4M+1Mj2L4yhE0kII9LtJTaw==
X-Google-Smtp-Source: ABdhPJy9BLV6v1CSu59e3JBgKNB21CetjeRf9oouFlbF0GTm8YvuUxIJroO+on5KUA7y1cgrphy8Bw==
X-Received: by 2002:a05:620a:4482:: with SMTP id x2mr6585856qkp.474.1629746596730;
        Mon, 23 Aug 2021 12:23:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v10sm873584qkj.79.2021.08.23.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/9] btrfs-progs: tests: fix running lowmem checks
Date:   Mon, 23 Aug 2021 15:23:05 -0400
Message-Id: <d65ac47d0113a814b358b451d789ac0df352e034.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When I added the invalid super image I saw that the lowmem tests were
passing, despite not having the detection code yet.  Turns out this is
because we weren't using a run command helper which does the proper
expansion and adds the --mode=lowmem option.  Fix this to use the proper
handler, and now the lowmem test fails properly without my patch to add
this support to the lowmem mode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/common | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/common b/tests/common
index 94ebf7a6..bcab11f3 100644
--- a/tests/common
+++ b/tests/common
@@ -428,10 +428,8 @@ check_image()
 
 	image=$1
 	echo "testing image $(basename $image)" >> "$RESULTS"
-	"$TOP/btrfs" check "$image" &> "$tmp_output"
-	ret=$?
-	cat "$tmp_output" >> "$RESULTS"
-	[ "$ret" -eq 0 ] && _fail "btrfs check should have detected corruption"
+	run_mustfail_stdout "btrfs check should have detected corruption" \
+		"$TOP/btrfs" check "$image" &> "$tmp_output"
 
 	# Also make sure no subpage related warnings
 	check_test_results "$tmp_output" "$testname"
-- 
2.26.3

