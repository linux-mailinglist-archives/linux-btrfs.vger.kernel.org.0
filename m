Return-Path: <linux-btrfs+bounces-16121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62134B29E77
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5651C16EE3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730030FF23;
	Mon, 18 Aug 2025 09:54:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EA30F819;
	Mon, 18 Aug 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510847; cv=none; b=ffPC+kfaHDibzdO+Xwr4C1bVIMBhk7bWkN2b/MpCpQVxcKJD6AOq5GPNpLEDHwe+KJvnwIStZuTnjYK0LvdQPAolC6fOhsHI98ax/I5MwsWJXsiktdJnJTMsAmPoyN/XOR9ZpCL+0V2Q4yI3phrjTgDus2GAbPDAEOXjrsF4eg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510847; c=relaxed/simple;
	bh=4vX9/46N1vvwWSTdgzxSrQioczEs1ddvGvywhiQxUlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hl/C5fse+EYnIB3z9YH6XYSzcd81VFIhHAJTwBtrGAD9i4ospDGF8O7+vCrujMJoGZy1ZVYxN12oVGQl2AN9X5yGlUdS0DtsaFjmXtnwfnSsWnFDH4AcH3m/Y9E7KLIH6+/9+G1PchDnDeG6/1bmRqL8W9pSd572o6/9qnIjS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso18418605e9.1;
        Mon, 18 Aug 2025 02:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510844; x=1756115644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tF5FvZUtb65OzIvJARiRQNgRBiOw2l/1Be6YYyZV/io=;
        b=WEc95sRUEwyhY2CBv6xa/TTDTn6c9TICphe8SC1GnwyeBI1HS2ENgqUBBm2DAOptfD
         x3HYzvLy3UfeHfu5Hv8WYe+ZwU8pon1Dhv5ru5FhgvYqbmz2OSUX9Eij2fWJ0uYSPvRV
         sybYm2PTtr0b0mWL8NCUnOvT60XD9+9wWZnmw6uP+p5UYJzBibaAXpBCDncQf9Pgn/he
         eA1uaKJxdpaNcUaS7Oh6MCUcomNeekU02myR4Vz8W269U7jGom9BTxbQ28tOJlbspWZR
         GJXi4DRbt4CeS9Ee9gWCOe4dFO/+AUD0qpIgQVQoF6E9YAmFyIiypAS5Dv1ztfV08J9Y
         3erA==
X-Forwarded-Encrypted: i=1; AJvYcCUIPjRjjZ4ejR93DSZQL5Cipo4ZdF5jSwZpOmhM6xr6z4elY4Va/e45nYxemrYdXCHtMTqUai5x@vger.kernel.org, AJvYcCW6Wp/tA9XbDNg3d9uLjnmYqlpfGCGrO6EZ5PYYYyyZ61JzVnxrAcXugJlc8GYX0kwqOlRJrjZ5vND+JOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfo8O6zvhMWvi4jKpcC7I+Wp/shz5wFw97+Nrb5aWpkhVZxvTo
	jhLOFkXDpmPxRuD/PKErv+r7cdePrrzScI4TaQ9IsElO2fUGa8UjBDw2D1qpX/Kd
X-Gm-Gg: ASbGncu5dz+Zi69CTOUl5E0iw30PDir4RjqQNN+/B1AQyCKn5kZ+48RapE1TF8hwbJ9
	fbOwT4UVUaOkce97GxYd7yDj0pmF4H4we5pr1NXXN6y7G7LzrQAN8+9zJRy6oEj9otfTtcmmpOA
	K7bFGPuDxra08Rk4e/aEAsiALiOSrnCy6FsJGLyjQhIaGO/1JViGZsPFltLtwMExMDUhgK90FEr
	J3lUe+lon5JXr55Zp01jKBA8lWbPBOLiycQ66GSNhrQx8w7iGiVC0nIXaqG6KWebO7uzyiczBao
	bYPMoDGE4sfAZO61ko90O/+wQ/Ck0pW8e3XSCpGRZxf3r41G74psF7rzshQUBQlx7o8QD3D2Ua+
	eI1qJhsZi8uWSM8/A4Pa3RmIcMogAClLdF7az/WfREZImtUyJ1FBlSLskh/JkuP2H8KwCWlbWyu
	BpUxb/2g==
X-Google-Smtp-Source: AGHT+IHvYL+rJrG1ox18RRMQr7TfXE5g/jK4292lFkXRFY05woj8zZ93PwLRSD2Bgkr0ZEZL/mxRLQ==
X-Received: by 2002:a05:600c:695:b0:458:bbed:a812 with SMTP id 5b1f17b1804b1-45a21ef1329mr67548945e9.17.1755510843611;
        Mon, 18 Aug 2025 02:54:03 -0700 (PDT)
Received: from neo.fritz.box (p200300f6f719c7009cd4f1e1fa3886df.dip0.t-ipconnect.de. [2003:f6:f719:c700:9cd4:f1e1:fa38:86df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22321985sm124302805e9.17.2025.08.18.02.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:54:03 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] tests: btrfs/237: skip test on devices with conventional zones
Date: Mon, 18 Aug 2025 11:53:37 +0200
Message-ID: <20250818095338.66277-1-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Skip btrfs/237 on devices with conventional zones, as we cannot force data
allocation on a sequential zone at the moment and conventional zones
cannot be reset, making the test invalid.

Furthermore limit the output of get_data_bg() and get_data_bg_physical()
to the first address.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes in v2:
- Use 'tail' instead of 'head'
---
 tests/btrfs/237 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 2839f6e4..675f4c42 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -28,7 +28,8 @@ get_data_bg()
 {
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
 		grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
-		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
+		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2 |\
+		tail -n 1
 }
 
 get_data_bg_physical()
@@ -36,9 +37,13 @@ get_data_bg_physical()
 	# Assumes SINGLE data profile
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
 		grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
-	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
+	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2 |\
+		tail -n 1
 }
 
+$BLKZONE_PROG report $SCRATCH_DEV | grep -q -e "nw" && \
+	_notrun "test is unreliable on devices with conventional zones"
+
 sdev="$(_short_dev $SCRATCH_DEV)"
 zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
 fssize=$((zone_size * 16))
-- 
2.50.1


