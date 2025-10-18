Return-Path: <linux-btrfs+bounces-17986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75809BEC771
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21D0235355A
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683B288C2B;
	Sat, 18 Oct 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb23HCS4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B628314B;
	Sat, 18 Oct 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762183; cv=none; b=tJNTkXGxrP2TjS7/oAeqoNh/W22ln8AYm8iYbFPC2wVZzzUWGnd5EkyODOGaDSPdQituxNC1icXOmWZA7b2sEXYWzueDku+D/0ZC3dskCEcgdgmKHOXqScKzeMN3AEoF9xVi8ghPY+9+/laVt2zhP9qZ+uwXGEcz6eMlWXA9phE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762183; c=relaxed/simple;
	bh=X9hF360ZBLNWRhousM988AHVWLEkL48cUoMgTVwucLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts/1pKtmKoaBMg/kWN4diVUAJ8CSj8nNOw5C4DadaRxt6ReZVdwTD/cEthI4hKOtP5h1c41way6EFejVRv6hzlg9Bj7RFWxC7UQacEF9AGYdbi0pexwhlxyb/8NPJQJOqkSD9YIdDHDt+CCgcYspHA7jrIzs05txAbb9d9E9VO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb23HCS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA0DC4CEF8;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762183;
	bh=X9hF360ZBLNWRhousM988AHVWLEkL48cUoMgTVwucLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb23HCS4QCh3TeBOORyo0XcWYXTjnpuh28lZ/FeQFQITTDlXUlSk3qJdx61evPp6N
	 iG0UoPIZoyrf6IcXQf5ZLc2g1liQa4HtYl/o4vtnpjH3ciIkKJeKb0c5nXNTWVPg08
	 U8pH/PHRsrrdid//8CGsNDtqZyZFve8sfaaT1QlMRjQEy0/fMESWF01VP7LsR3ZfWY
	 WwK4tuNwxuRAg64PmYu83eTcjBYWz7k4Em6sQ/Sm3QyldQIf1lR6WcaTMR4CnJoLKF
	 rnGzh2r3TYJYaLyd+NycLYIXaTb8i03BYbXXx5jt291/GrtxgTmASjU/dsMPk9bw+x
	 mxv2Xm083jhvA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 05/10] byteorder: Add le64_to_cpu_array() and cpu_to_le64_array()
Date: Fri, 17 Oct 2025 21:31:01 -0700
Message-ID: <20251018043106.375964-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251018043106.375964-1-ebiggers@kernel.org>
References: <20251018043106.375964-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add le64_to_cpu_array() and cpu_to_le64_array().  These mirror the
corresponding 32-bit functions.

These will be used by the BLAKE2b code.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/byteorder/generic.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index b3705e8bbe2b8..55a44199de872 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -171,10 +171,26 @@ static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
 		__cpu_to_le32s(buf);
 		buf++;
 	}
 }
 
+static inline void le64_to_cpu_array(u64 *buf, unsigned int words)
+{
+	while (words--) {
+		__le64_to_cpus(buf);
+		buf++;
+	}
+}
+
+static inline void cpu_to_le64_array(u64 *buf, unsigned int words)
+{
+	while (words--) {
+		__cpu_to_le64s(buf);
+		buf++;
+	}
+}
+
 static inline void memcpy_from_le32(u32 *dst, const __le32 *src, size_t words)
 {
 	size_t i;
 
 	for (i = 0; i < words; i++)
-- 
2.51.1.dirty


