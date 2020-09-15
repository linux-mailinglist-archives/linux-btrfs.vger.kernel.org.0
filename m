Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7E2269A60
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 02:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgIOAWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 20:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgIOAWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 20:22:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B31C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 17:22:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w186so2552131qkd.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7B5+G4uwMRmHs/RTKS5x+bZoePKMB3g169/BIqYaVk=;
        b=fr3UJ7SOb5+TehlCaFDa1QWB8ua+4iCFeftltOhvMitAMpBjjuQNRE9Kgop8eAdvUO
         KFVt0gXo4sToIH80XPBDR4W1RrhPszn/STMBtbrWlIyfAiuzy7NQNnzqxwXDm+ERDeZ4
         Zcn9Yk18I2crD6bVIEOK9cHVhOn0j0RrB7fCqihHCI4BnvIDYOIBAidmao0DAkjLEo+l
         LrnBnOSR1oyhvquAk9JoOA+SvKlNqeV1DLIeFPPKpTZ7iVN6iDq6SenZnWeZWLlnvyHb
         fiG48zwAgMhlJRzgvhGErHHXdNQKczdsvUPdVVIjWLGqMk+TJdJh3W7DEoiuOOiXp6J3
         AqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7B5+G4uwMRmHs/RTKS5x+bZoePKMB3g169/BIqYaVk=;
        b=K4LSdbdJAbR8JIlGntyFhMs8CALuaYj/JioLDX9+hKshrZVmgRjParz5QNDUkpBfir
         CbuVAi7kgmRXNXFqpwv1mPfKW4B8VAlygwJH01UJ3FiPQnm9M+nt2ffios6Vua3cNLdA
         v9L+8002KJeFhOTSIaODug2eBJ/Oi+Ow6/f8D4rCs6e8TMIHoAGHpc6VZ5Dl0NbMbD8n
         m5LQ7LnKvr7HLnpmhwcJd2AHsfzFcbFkGtj2XaY89W8JDsRWLKErMwDdKXgvqrz1ZtSB
         UaGgcg3d/krof7TCf0suINMgpkogXpnGaWnvvOOmHLJQM0E5HtE5AXn9zMyv2bn4Vvl0
         R3dg==
X-Gm-Message-State: AOAM532MC9nvqIE1WZfY8GMQDeaEjTYIN2DXfr9C2rqoCeWO5erlixVe
        okL5OiHtmUUsmcux0xRtbn+dm7ATCgo5kT+l
X-Google-Smtp-Source: ABdhPJxVVmYwuXkmf8MAiJ2/RMcCaGqeynA1A50TXWNiTxxSTFNiSG9hkstgkBAQY+uc1xNTfU7HYg==
X-Received: by 2002:a37:cd5:: with SMTP id 204mr14219818qkm.303.1600129365437;
        Mon, 14 Sep 2020 17:22:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 205sm16338042qki.118.2020.09.14.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:22:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: drop check.log and check.time into section specific results dir
Date:   Mon, 14 Sep 2020 20:22:43 -0400
Message-Id: <20200915002243.57729-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right now we only track check.log and check.time globally, it would be nice
to do it per-section as well.  This makes it easier to parse results from
systems that run a bunch of different configurations at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/check b/check
index 5ffa8777..6a79825d 100755
--- a/check
+++ b/check
@@ -391,6 +391,13 @@ _wipe_counters()
 	unset try notrun bad
 }
 
+_global_log() {
+	echo "$1" >> $check.log
+	if $OPTIONS_HAVE_SECIONS; then
+		echo "$1" >> ${REPORT_DIR}/check.log
+	fi
+}
+
 _wrapup()
 {
 	seq="check"
@@ -415,10 +422,13 @@ _wrapup()
 				}' \
 				| sort -n >$tmp.out
 			mv $tmp.out $check.time
+			if $OPTIONS_HAVE_SECTIONS; then
+				cp $check.time ${REPORT_DIR}/check.time
+			fi
 		fi
 
-		echo "" >>$check.log
-		date >>$check.log
+		_global_log ""
+		_global_log "$(date)"
 
 		echo "SECTION       -- $section" >>$tmp.summary
 		echo "=========================" >>$tmp.summary
@@ -427,29 +437,33 @@ _wrapup()
 				echo "Ran:$try"
 				echo "Ran:$try" >>$tmp.summary
 			fi
-			echo "Ran:$try" >>$check.log
+			_global_log "Ran:$try"
 		fi
 
 		$interrupt && echo "Interrupted!" | tee -a $check.log
+		if $OPTIONS_HAVE_SECIONS; then
+			$interrupt && echo "Interrupted!" | tee -a \
+				${REPORT_DIR}/check.log
+		fi
 
 		if [ ! -z "$notrun" ]; then
 			if [ $brief_test_summary == "false" ]; then
 				echo "Not run:$notrun"
 				echo "Not run:$notrun" >>$tmp.summary
 			fi
-			echo "Not run:$notrun" >>$check.log
+			_global_log "Not run:$notrun"
 		fi
 
 		if [ ! -z "$n_bad" -a $n_bad != 0 ]; then
 			echo "Failures:$bad"
 			echo "Failed $n_bad of $n_try tests"
-			echo "Failures:$bad" >>$check.log
-			echo "Failed $n_bad of $n_try tests" >>$check.log
+			_global_log "Failures:$bad"
+			_global_log "Failed $n_bad of $n_try tests"
 			echo "Failures:$bad" >>$tmp.summary
 			echo "Failed $n_bad of $n_try tests" >>$tmp.summary
 		else
 			echo "Passed all $n_try tests"
-			echo "Passed all $n_try tests" >>$check.log
+			_global_log "Passed all $n_try tests"
 			echo "Passed all $n_try tests" >>$tmp.summary
 		fi
 		echo "" >>$tmp.summary
-- 
2.28.0

