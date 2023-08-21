Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4686778242D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 09:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjHUHMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjHUHMX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 03:12:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C029AC;
        Mon, 21 Aug 2023 00:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692601942; x=1724137942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnTjaY+E1OSfXer5guoJ/ik72fi46/PHsD2GP1WHBbI=;
  b=I+XcJkJ2JAm6IQgffxA0mBRKTBD0LQMxLPs6AePIVNGdNXC5nHvrWwUR
   dfGLPrvA2ymwSv45BrgeEekycAk9GauWssAnSg/cAlR0iouXdbhd+0Xvd
   7od7XnCPvZVeD/t+ETjFHAV+pgFAMeJSTgcII3Cmp+10L/u1QUsAVuLMG
   gy8QI9nqvzykIdLw43Tnpnf5MbVj7JZB0rdTsSKDKrY/WHi6Gl7bKq2Kc
   rmNxWQ5QiOtVchVvIimyebqCYyQHjItvdZDQAsTBn6cxCsG6x9umcBnuu
   nq76BQN8VrhOTepEC/fst+y25Ar9vnfNY2VT6WnXT4xSeak5vS8u0SCX3
   w==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="246252746"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 15:12:21 +0800
IronPort-SDR: 2XFIbqwndEwGxgmUsbvUa8t0+Wyfhlse8ZHkH0l84zhokg5l5rLryIaTNGRqR4dvSW1c8k/KfS
 PyySsMVbUcjRfUyf/s4EVwkgVS55gSucgzDbeyXPJfIjLoXkSvraMkWgTD+4AshdJqyV852IpQ
 ZIknrpOqb8MNuxOZUzz7Qj5jRF77lmDEWLaksuJuPYDd3d7ZRrTvEHb2kPKsUW3GJOPRK7cqKE
 uHTmXUSUzgjdoLOqOoJKr4NO3n1WtBa9q0QBBLPCibzDp/yYW6I7sbeYFpuEBkmaW4zs/cJy8n
 OZg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 23:25:32 -0700
IronPort-SDR: cQ1jgYUJQP2IiSC85gb2aEgLTBonkpH/p9OzFBSVbghMbrHfJRQL23nq/GXsV3wSDGOztGl4oW
 eHhBRdxP/aOt5HJq0H2wD0k1w255BP5+iCoGxmyoejXb96K07NErTfclZM8QXF86YpDqN3R+i7
 uLKMeHp8kpZInAO9EsW+1KIx2h2NgJlAVdVjS/OVoe+qTadUmv1shcmkzh8pdH0QZBJ1RsuN72
 gFp615fjKuCxGjt1HXAg8r8WLDUmy4smOtEdTApp6Hi31QQGT2ffVIenFzayR7anGcQa/xYn7L
 g/A=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2023 00:12:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 1/3] common/rc: introduce _random_file() helper
Date:   Mon, 21 Aug 2023 16:12:11 +0900
Message-ID: <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692600259.git.naohiro.aota@wdc.com>
References: <cover.1692600259.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
random file in a directory.It sorts the files with "ls", sort it randomly
and pick the first line, which wastes the "ls" sort.

Also, using "sort -R | head -n1" is inefficient. For example, in a
directory with 1000000 files, it takes more than 15 seconds to pick a file.

  $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
  bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total

  $ time bash -c "ls -U | shuf -n 1 >/dev/null"
  bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total

So, we should just use "ls -U" and "shuf -n 1" to choose a random file.
Introduce _random_file() helper to do it properly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/rc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/rc b/common/rc
index 5c4429ed0425..4d414955f6d9 100644
--- a/common/rc
+++ b/common/rc
@@ -5224,6 +5224,13 @@ _soak_loop_running() {
 	return 0
 }
 
+# Return a random file in a directory. A directory is *not* followed
+# recursively.
+_random_file() {
+	local basedir=$1
+	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
+}
+
 init_rc
 
 ################################################################################
-- 
2.41.0

