Return-Path: <linux-btrfs+bounces-21974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN/WOG9boGm3igQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21974-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:40:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC281A7C04
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8BA305C4B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C83D349A;
	Thu, 26 Feb 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYExvKRA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CC3AE70B;
	Thu, 26 Feb 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116482; cv=none; b=M6mhiq4rnKejvD55aLcFKCLY1FEKP3+jdAbL7mCN5WKLiFRNWHuOG0BRkOBC/33zo/+CY1iQWRm7RDoRUxLdT1LmW4iPifeWIEuNFSC7gIcTY+7aC0l4OuVUMZ6A+LnVL5OoME0pcjIzriQU/TP5WGC8IP+Den13Ywm5rykb3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116482; c=relaxed/simple;
	bh=3nw3YRu3uJvkoRXJ9kLQefkKsleGkFcH6F7lOzIUJos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ac5nZyqOIX8bG3Ea2c5EaZU2IkUmqG3EUcLHsas2upo16DIqwCEE9UW1P6bSwqoJ8L9QFC3iBzHakLZpOXWaKx9cUSr5iLdbQVeh7jX6S+kx1+BtSxuuSTEGQtES0HPg9kt1BlglgOXXhMUYZEiRB/id/ChSEJQBxiG2PV+9Yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYExvKRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69805C116C6;
	Thu, 26 Feb 2026 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116482;
	bh=3nw3YRu3uJvkoRXJ9kLQefkKsleGkFcH6F7lOzIUJos=;
	h=From:To:Cc:Subject:Date:From;
	b=TYExvKRApfyb4QrglNhzrGXxqDLEQnb8TWOiqEzLnwWCkZ3RRZ8TLBxXZV5hnzDrJ
	 mady8kgiUZC+YvFw+vjeF1lYIZfC03vEFm/gSr5f+zqnf+ou6nfkSRGn9L9VCT6DW2
	 xzbm/FAvHpf0EluhXWmB8j6kylhFOAqhMqJ/7g2SIgnSfsFMmakvdaj1rydf8LG0Md
	 pbAb9wVwbtT99cBQzsu8umPbECBzdK0ckhLpCNh9x/oolrXnCvAEiHqiTn6+OX8PQc
	 KgxkCvhoofIMWFTIMd8ogCAZTew80cOeFCV8dnb9Iqe3mqjF1vn0xQqwTkTQZTLCgy
	 H9xIC94sNwwXw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test create a bunch of files with name hash collision
Date: Thu, 26 Feb 2026 14:34:37 +0000
Message-ID: <a1e2690efeb8570651894567d80511144424fb5e.1772106022.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21974-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EC281A7C04
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Test that if we create a high number of files with a name that results in
a hash collision, the filesystem is not turned to RO due to a transaction
abort. This could be exploited by malicious users to disrupt a system.

This exercies a bug fixed by the following kernel patch:

 "btrfs: fix transaction abort on file creation due to name hash collision"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/346     | 95 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/346.out |  3 ++
 2 files changed, 98 insertions(+)
 create mode 100755 tests/btrfs/346
 create mode 100644 tests/btrfs/346.out

diff --git a/tests/btrfs/346 b/tests/btrfs/346
new file mode 100755
index 00000000..ef301ef7
--- /dev/null
+++ b/tests/btrfs/346
@@ -0,0 +1,95 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 346
+#
+# Test that if we create a high number of files with a name that results in a
+# hash collision, the filesystem is not turned to RO due to a transaction abort.
+# This could be exploited by malicious users to disrupt a system.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol
+
+_require_scratch
+_require_btrfs_support_sectorsize 4096
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix transaction abort on file creation due to name hash collision"
+
+# Use a 4K node/leaf size to make the test faster and require less file names
+# that trigger a crc32c hash collision.
+_scratch_mkfs -n 4K >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# List of names that result in the same crc32c hash for btrfs.
+declare -a names=(
+	'foobar'
+	'%a8tYkxfGMLWRGr55QSeQc4PBNH9PCLIvR6jZnkDtUUru1t@RouaUe_L:@xGkbO3nCwvLNYeK9vhE628gss:T$yZjZ5l-Nbd6CbC$M=hqE-ujhJICXyIxBvYrIU9-TDC'
+	'AQci3EUB%shMsg-N%frgU:02ByLs=IPJU0OpgiWit5nexSyxZDncY6WB:=zKZuk5Zy0DD$Ua78%MelgBuMqaHGyKsJUFf9s=UW80PcJmKctb46KveLSiUtNmqrMiL9-Y0I_l5Fnam04CGIg=8@U:Z'
+	'CvVqJpJzueKcuA$wqwePfyu7VxuWNN3ho$p0zi2H8QFYK$7YlEqOhhb%:hHgjhIjW5vnqWHKNP4'
+	'ET:vk@rFU4tsvMB0$C_p=xQHaYZjvoF%-BTc%wkFW8yaDAPcCYoR%x$FH5O:'
+	'HwTon%v7SGSP4FE08jBwwiu5aot2CFKXHTeEAa@38fUcNGOWvE@Mz6WBeDH_VooaZ6AgsXPkVGwy9l@@ZbNXabUU9csiWrrOp0MWUdfi$EZ3w9GkIqtz7I_eOsByOkBOO'
+	'Ij%2VlFGXSuPvxJGf5UWy6O@1svxGha%b@=%wjkq:CIgE6u7eJOjmQY5qTtxE2Rjbis9@us'
+	'KBkjG5%9R8K9sOG8UTnAYjxLNAvBmvV5vz3IiZaPmKuLYO03-6asI9lJ_j4@6Xo$KZicaLWJ3Pv8XEwVeUPMwbHYWwbx0pYvNlGMO9F:ZhHAwyctnGy%_eujl%WPd4U2BI7qooOSr85J-C2V$LfY'
+	'NcRfDfuUQ2=zP8K3CCF5dFcpfiOm6mwenShsAb_F%n6GAGC7fT2JFFn:c35X-3aYwoq7jNX5$ZJ6hI3wnZs$7KgGi7wjulffhHNUxAT0fRRLF39vJ@NvaEMxsMO'
+	'Oj42AQAEzRoTxa5OuSKIr=A_lwGMy132v4g3Pdq1GvUG9874YseIFQ6QU'
+	'Ono7avN5GjC:_6dBJ_'
+	'WHmN2gnmaN-9dVDy4aWo:yNGFzz8qsJyJhWEWcud7$QzN2D9R0efIWWEdu5kwWr73NZm4=@CoCDxrrZnRITr-kGtU_cfW2:%2_am'
+	'WiFnuTEhAG9FEC6zopQmj-A-$LDQ0T3WULz%ox3UZAPybSV6v1Z$b4L_XBi4M4BMBtJZpz93r9xafpB77r:lbwvitWRyo$odnAUYlYMmU4RvgnNd--e=I5hiEjGLETTtaScWlQp8mYsBovZwM2k'
+	'XKyH=OsOAF3p%uziGF_ZVr$ivrvhVgD@1u%5RtrV-gl_vqAwHkK@x7YwlxX3qT6WKKQ%PR56NrUBU2dOAOAdzr2=5nJuKPM-T-$ZpQfCL7phxQbUcb:BZOTPaFExc-qK-gDRCDW2'
+	'd3uUR6OFEwZr%ns1XH_@tbxA@cCPmbBRLdyh7p6V45H$P2$F%w0RqrD3M0g8aGvWpoTFMiBdOTJXjD:JF7=h9a_43xBywYAP%r$SPZi%zDg%ql-KvkdUCtF9OLaQlxmd'
+	'ePTpbnit%hyNm@WELlpKzNZYOzOTf8EQ$sEfkMy1VOfIUu3coyvIr13-Y7Sv5v-Ivax2Go_GQRFMU1b3362nktT9WOJf3SpT%z8sZmM3gvYQBDgmKI%%RM-G7hyrhgYflOw%z::ZRcv5O:lDCFm'
+	'evqk743Y@dvZAiG5J05L_ROFV@$2%rVWJ2%3nxV72-W7$e$-SK3tuSHA2mBt$qloC5jwNx33GmQUjD%akhBPu=VJ5g$xhlZiaFtTrjeeM5x7dt4cHpX0cZkmfImndYzGmvwQG:$euFYmXn$_2rA9mKZ'
+	'gkgUtnihWXsZQTEkrMAWIxir09k3t7jk_IK25t1:cy1XWN0GGqC%FrySdcmU7M8MuPO_ppkLw3=Dfr0UuBAL4%GFk2$Ma10V1jDRGJje%Xx9EV2ERaWKtjpwiZwh0gCSJsj5UL7CR8RtW5opCVFKGGy8Cky'
+	'hNgsG_8lNRik3PvphqPm0yEH3P%%fYG:kQLY=6O-61Wa6nrV_WVGR6TLB09vHOv%g4VQRP8Gzx7VXUY1qvZyS'
+	'isA7JVzN12xCxVPJZ_qoLm-pTBuhjjHMvV7o=F:EaClfYNyFGlsfw-Kf%uxdqW-kwk1sPl2vhbjyHU1A6$hz'
+	'kiJ_fgcdZFDiOptjgH5PN9-PSyLO4fbk_:u5_2tz35lV_iXiJ6cx7pwjTtKy-XGaQ5IefmpJ4N_ZqGsqCsKuqOOBgf9LkUdffHet@Wu'
+	'lvwtxyhE9:%Q3UxeHiViUyNzJsy:fm38pg_b6s25JvdhOAT=1s0$pG25x=LZ2rlHTszj=gN6M4zHZYr_qrB49i=pA--@WqWLIuX7o1S_SfS@2FSiUZN'
+	'rC24cw3UBDZ=5qJBUMs9e$=S4Y94ni%Z8639vnrGp=0Hv4z3dNFL0fBLmQ40=EYIY:Z=SLc@QLMSt2zsss2ZXrP7j4='
+	'uwGl2s-fFrf@GqS=DQqq2I0LJSsOmM%xzTjS:lzXguE3wChdMoHYtLRKPvfaPOZF2fER@j53evbKa7R%A7r4%YEkD=kicJe@SFiGtXHbKe4gCgPAYbnVn'
+	'UG37U6KKua2bgc:IHzRs7BnB6FD:2Mt5Cc5NdlsW%$1tyvnfz7S27FvNkroXwAW:mBZLA1@qa9WnDbHCDmQmfPMC9z-Eq6QT0jhhPpqyymaD:R02ghwYo%yx7SAaaq-:x33LYpei$5g8DMl3C'
+	'y2vjek0FE1PDJC0qpfnN:x8k2wCFZ9xiUF2ege=JnP98R%wxjKkdfEiLWvQzmnW'
+	'8-HCSgH5B%K7P8_jaVtQhBXpBk:pE-$P7ts58U0J@iR9YZntMPl7j$s62yAJO@_9eanFPS54b=UTw$94C-t=HLxT8n6o9P=QnIxq-f1=Ne2dvhe6WbjEQtc'
+	'YPPh:IFt2mtR6XWSmjHptXL_hbSYu8bMw-JP8@PNyaFkdNFsk$M=xfL6LDKCDM-mSyGA_2MBwZ8Dr4=R1D%7-mCaaKGxb990jzaagRktDTyp'
+	'9hD2ApKa_t_7x-a@GCG28kY:7$M@5udI1myQ$x5udtggvagmCQcq9QXWRC5hoB0o-_zHQUqZI5rMcz_kbMgvN5jr63LeYA4Cj-c6F5Ugmx6DgVf@2Jqm%MafecpgooqreJ53P-QTS'
+)
+
+# Now create files with all those names in the same parent directory.
+# It should not fail since a 4K leaf has enough space for them.
+for name in "${names[@]}"; do
+	touch $SCRATCH_MNT/$name
+done
+
+# Now add one more file name that causes a crc32c hash collision.
+# This should fail, but it should not cause a transaction abort and turn the
+# filesystem into RO mode (which could be exploited by malicious users).
+touch $SCRATCH_MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt' \
+      >> $seqres.full 2>&1
+[ $? -eq 0 ] && echo "should not have been able to create file"
+
+# Check that we are able to create another file, with a name that does not cause
+# a crc32c hash collision.
+echo -n "hello world" > $SCRATCH_MNT/baz
+
+# Unmount and mount again, verify file baz exists and with the right content.
+_scratch_cycle_mount
+echo "File baz content: $(cat $SCRATCH_MNT/baz)"
+
+# Now try to create a subvolume with the same name that causes a hash collision.
+# It should fail, but it shouldn't trigger a transaction abort and turns the
+# filesystem to RO mode. Subvolume creation takes a different code path.
+$BTRFS_UTIL_PROG subvolume create \
+	$SCRATCH_MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt' \
+		>> $seqres.full 2>&1
+[ $? -eq 0 ] && echo "should not have been able to subvolume"
+
+# Check that we are able to create another file, with a name that does not cause
+# a crc32c hash collision.
+echo -n "yada yada" > $SCRATCH_MNT/xyz
+
+# Unmount and mount again, verify file xyz exists and with the right content.
+_scratch_cycle_mount
+echo "File xyz content: $(cat $SCRATCH_MNT/xyz)"
+
+_exit 0
diff --git a/tests/btrfs/346.out b/tests/btrfs/346.out
new file mode 100644
index 00000000..e1b82cbd
--- /dev/null
+++ b/tests/btrfs/346.out
@@ -0,0 +1,3 @@
+QA output created by 346
+File baz content: hello world
+File xyz content: yada yada
-- 
2.47.2


