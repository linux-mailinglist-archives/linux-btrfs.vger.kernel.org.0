Return-Path: <linux-btrfs+bounces-15725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCCAB14821
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8D17AAEEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5124A043;
	Tue, 29 Jul 2025 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5RmfTsd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25A2AD2C;
	Tue, 29 Jul 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770209; cv=none; b=kFt+BXepugRQ4Mwkg5AzrkJ/25stqpxgvJDqkvXlGhidNBEvPk/9E5ZW/YUcgY4zy9uwZh893JgyObmV1WRpw3tx7z3/HT349+CIijWwU0cRhK+Jm312725UsP4ya5zS3P+sib+4GuUE0FVRmzU+Y2JqVLFTrQWmqH7TdGgikUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770209; c=relaxed/simple;
	bh=Dt76mLFP8WWM8MtnFKlDk1wZcZgR/P6vlDHR7WvwhCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBAKuSBwSFZrZdEVzu0ZgEw097nv0IZa5YPjM+BYLJgl3gPOiSGev00v39axZk9meNkQW2cGa9MS7Ja3G4/fGFAG0fJnSQFMveSINPHYl+/AxgDKJGFzsOCLoZUXg3e6Yednz7RMqR+oB4U7Z/BOazuJrwUpTtOITs7aMa0ZWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5RmfTsd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24009eeb2a7so17468545ad.0;
        Mon, 28 Jul 2025 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770207; x=1754375007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIX/m8jus/vWvhFmdxeyXkIDrtApe4Mq47mHfoiGPlU=;
        b=B5RmfTsd/YRmIKZ+SnZ0UE8Uis/ZE5Wn2lZQ1QE2csQWcZuCSQT4IJt8+5b9XWQ+MG
         Gvo7eeOzPDQxq+wfC545k2ACHsVgOe/1O4DeyB9IwzanwbGcuFf4JlvjSRLzmiG1iVID
         t4Q6uCt0HxvCm3x6wP7czTQEyHNXSK481ud/xhGDzm48nCoaEP2wXWEkoJXYngsylzkk
         kneHBVqxesMVpQaoti17zRSaIkWQVXFb8H6voFTuT7r2EwtW84YF1XtqjIG+gCdB1kCp
         WLdqi6vAyJsIaUqC2YfqFxfeiuyLq7p75jUr0z+7Q+pjDXHmmmXc7cs7DRSdJFYXQbuN
         GCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770207; x=1754375007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIX/m8jus/vWvhFmdxeyXkIDrtApe4Mq47mHfoiGPlU=;
        b=ErYkEJnz4jbYTLqYtc8RJpS/d32n+pTvdcM1VbnUXYLAjbSWs7tYkQUm/clI4a93hR
         yJxVNlrAgdhv5gaFl+1hw5Agqh5pcRhBZs5kDCmQ1RsWr7w/f01ZtB76VxIRsWqZ0yug
         TSxPhpeGDuCQjNgd3qR5pkcj1W978Q8Lq56fPZYtAqyTAPzzl5cmeAXccRzUxwJfUtby
         zRQ8h14NNVkQert8U+x6V/RPjIqsXWih9XI8y1J4v/7mYQr+W4gPbEooMelqvy5Tl/Bn
         BpaO3Vb+s1GzuXmGQWwwttlVhcxiZMkuH8SirrhxA4Ec5ScDsdgErk22GwofBtnWkKmg
         uM9g==
X-Gm-Message-State: AOJu0YzWJ1bfEumBJTZFk2Yh/UEWDH8Tf6+olM55C5+fWXREEleMLLFA
	rP1JFxHbUAmb9pF7pTXPg5hjfMSHIG0lm3fZVBsWriaSUVDESK+xEu8LMDmpLg==
X-Gm-Gg: ASbGncvjg4zvcg0JgEf/jy6/P8PhNkYA3idCMfZhrorDR0rjxZZy9eS3LEMIzYczztu
	yvsAeEYovvsjWLBPxhFDEBzyU1ZVPxsMsGe3TkNPOI0lNnzzIMmt2Tjxt2crzBht9HUrFGYdj3S
	Ta/xdBZ5fxPLfigbpWStH/E8K3yU3oNZx8dj7aY2agONApzfYGNQdLgLmErmPSlKsS1ayPhTOp3
	sR/V9iEYF+OCrBeIU8bDyPKJuyoI3iH7+wvdsb32pw9sehy32OfxVhz1vmY22ltrukQRUraUgmh
	aUcfv9+TDLiWqJWdLLQ7OQq95t46jelDb6WnCGs1d0sUkJZGXKL8HfHwDb4MJ32Usz+9yofGLpQ
	E4mdiMDxC1SwbRUo+Pb1g6UM=
X-Google-Smtp-Source: AGHT+IHuchh8nwsoKf8EuT4Iqt3+dQMpCc/Udasclog5T3wLjBAaJFq5w8QtrtevvtAhVNFnzU0ZPg==
X-Received: by 2002:a17:902:f606:b0:240:2970:65e7 with SMTP id d9443c01a7336-2402970687dmr74313255ad.25.1753770206574;
        Mon, 28 Jul 2025 23:23:26 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:23:26 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 1/7] common/filter: Add a helper function to filter offsets and sizes
Date: Tue, 29 Jul 2025 06:21:44 +0000
Message-Id: <45abeee1d9aa4fbb31fd2cb616c5c9f4c4add6d0.1753769382.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_filter_xfs_io_size_offset() filters out the size and the offset
emitted by various subcommands of xfs_io like pwrite.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 common/filter | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/filter b/common/filter
index bbe13f4c..45188a5a 100644
--- a/common/filter
+++ b/common/filter
@@ -115,6 +115,20 @@ _filter_date()
 	-e 's/[A-Z][a-z][a-z] [A-z][a-z][a-z]  *[0-9][0-9]* [0-9][0-9]:[0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]$/DATE/'
 }
 
+# This filters out the offsets and bytes written with
+# various subcommands of xfs_io. For example
+# wrote 4096/4096 bytes at offset 1052672 will be
+# converted to
+# wrote SIZE/SIZE bytes at offset OFFSET.
+# usage: __filter_xfs_io_size_offset <offset> <size>
+_filter_xfs_io_size_offset()
+{
+	local offset="$1"
+	local size="$2"
+	sed -e "s#${size}/${size}#SIZE/SIZE#g" \
+		-e "s#offset ${offset}#offset OFFSET#g"
+}
+
 # prints filtered output on stdout, values (use eval) on stderr
 # Non XFS filesystems always return a 4k block size and a 256 byte inode.
 _filter_mkfs()
-- 
2.34.1


