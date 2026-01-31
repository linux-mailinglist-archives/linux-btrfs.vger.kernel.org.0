Return-Path: <linux-btrfs+bounces-21257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG8zKlVcfWnKRgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21257-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 02:35:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0AC006D
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 02:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53F9B3026143
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 01:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5F322C77;
	Sat, 31 Jan 2026 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWcZYq+o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746B2BDC0E
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823302; cv=none; b=ZlSuMAz/P4vPGqUogKK8U9StGV4CUfa+VBKKokYNS01aFP/93Cg78H/OvlHEkodaMxQd/hnshm7p+FACv5HFpHbwmgnqYJ1pZqoMt/vWpMM4xHfucmWDkj8eGwd/KpiuNkRYQT/muYRxQnHU4DVvdozM83wO9frqBLPKkflsrus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823302; c=relaxed/simple;
	bh=GoHql7EaEQvfoO0D2xqCpqDhl0MRna3jHTu4nLqkUyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToflqBHlPFNbxfetTNiA9Nk2km9INNEeSGxKrIbpHqJ+Ju17FUP6srMqojU2VXLvDX3oZ/ALKhAcnCsdtQkPwzhLw1WGltnfsj4ILn3tOPcAksEDB8kATU4DLgbSABc9FYhZBfnGaKg6w7JLzzO81M8Ms90GvaR1R8glxurdLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWcZYq+o; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b7c5db431cso2416426eec.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 17:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769823300; x=1770428100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BryjHVsexNAzF59csTx3vohA2syzy8GP7++lXET7oyI=;
        b=bWcZYq+o/tVpbeu2qRBi7WCdcqpZ+CNKOEL2YSKt4acAUoO7WtGh31UbcG98bkzCZx
         NP36i7HTUjSRWm5gYkmVhimZFQpGCPt1J1aq2aJovTiMYwPOlblAXamYraNV6sUUC7pb
         Shd6EezYpAyzxb+GSqzE7poKADcsY8Uvbvhb3IER2RV4iYQv2YyI2b2a2MQZhr0kmBAK
         hmdUOEIw6JLBprPvXHDl7w2GfRG/IRYLKIzgFEPaHsNRvev3QGFwZK8y/d0nF2l/HDIC
         f06OgN3QHp/pSmixzDYFE3z77GNWyPBAsufTKe2ohm9FPfM6h15h/eQ/haP8oZtDcl7k
         6SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769823300; x=1770428100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BryjHVsexNAzF59csTx3vohA2syzy8GP7++lXET7oyI=;
        b=H4Hd661lXaNCDdMkH4ArvlOAhQh8TQ4mxCBScBd+KslFxCbd2yZVOkXasmZnHIrgFX
         KbBo3otCVmlVKAFxdjV2hKNP2YdPRY/NTI7Pm9dEH4Eo39XjXP8ChaQV6cSVz+ixxh4T
         E9nWqGix/eu+Xey0VEsDbP9tbr1cpXQv82KraNWakUECAAvUnjWQB2ec6gtNaf0+Fog/
         vtNTdP/CPz1rtrbAwyW2wK2gO+hsoEtIxjIMv5rGdwdB6s2GJpnd+gIfWoPqoZnrjT7v
         reWN1ZWLsRnXF1RaedIfcnYLF5Rx2hlozNKkc2fcms6zNMGCtTg0LGnduYnPHWCI17/6
         gfoA==
X-Gm-Message-State: AOJu0YxKCWqVpE6HBj3w3BXkT2QP77bMvhsLx3oJchr6nMerIovVLb1j
	UiAaYUNLUC9SmPOoddqmqFk6/DY3n8c/cu+WMvcwqaE+GA1o4KYaLhGh
X-Gm-Gg: AZuq6aLUq6LAASJrBx+wthWMb0FQSMZre2noiCoofuaZ8SUT4gTuCBqdNan3IpTjHPs
	kn/LXJR+BYPZA6U5pxglNcRADDm/sNPGW3cTCBtIEFTg2dNWpadgZ7Ma/jQn9EYo0PdxqbzWruY
	8TmdHr8orgO/BW8d79K5luPykckWvK+lasYxWhwZEiCy86omp6403OoFE8yWSr0BOFG5iSwHasP
	otK77283iZlKqzlajoxED6qAn1iYFFVVNSd+1ByL5TZPHKVeeM2jB6IUmY5AKk9ODu0RPbYUiDg
	rTX9gllsPbRMbT143QjWoC9zneTQlXBaMiGuH+FRTJmSLpRk1jGgKjsT3F/8hkADgCls6zbz7aG
	bhvREuqnh8voYiy27mVM0lAu+QJWY7SkHP4uhgeSqURMbsRRJkLDD9LIW1BvWaE8QiYV514oaWx
	9dsqSlzSkf5bv/DAqxizZth3akJVgJpwhwfRz8xzTC7U6v8xboeu6rHUwm76T2tQ==
X-Received: by 2002:a05:7301:e22:b0:2b7:265d:9eb3 with SMTP id 5a478bee46e88-2b7c895a399mr2558248eec.41.1769823300516;
        Fri, 30 Jan 2026 17:35:00 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC (90.sub-174-249-150.myvzw.com. [174.249.150.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88dasm14454498eec.32.2026.01.30.17.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 17:35:00 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: boris@bur.io,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] btrfs: guard against missing private state in lock_delalloc_folios()
Date: Fri, 30 Jan 2026 17:34:38 -0800
Message-ID: <20260131013438.286422-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21257-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56A0AC006D
X-Rspamd-Action: no action

Users of filemap_lock_folio() need to guard against the situation where
release_folio() has been invoked during reclaim but the folio was
ultimately not removed from the page cache. This patch covers one location
which may have been overlooked.

After acquiring the folio, use set_folio_extent_mapped() to ensure the
folio private state is valid. This is especially important in the subpage
case, where the private field is an allocated struct containing bitmap and
lock data.

Failing calls (with -ENOMEM) are treated as transient errors and execution
will follow the existing "try again" path.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 fs/btrfs/extent_io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3df399dc8856..573b29f62bc1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -332,6 +332,18 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 				folio_unlock(folio);
 				goto out;
 			}
+
+			/*
+			 * release_folio() could have cleared the folio private data
+			 * while we were not holding the lock.
+			 * Reset the mapping if needed so subpage operations can access
+			 * a valid private folio state.
+			 */
+			if (set_folio_extent_mapped(folio)) {
+				folio_unlock(folio);
+				goto out;
+			}
+
 			range_start = max_t(u64, folio_pos(folio), start);
 			range_len = min_t(u64, folio_next_pos(folio), end + 1) - range_start;
 			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);
-- 
2.52.0


