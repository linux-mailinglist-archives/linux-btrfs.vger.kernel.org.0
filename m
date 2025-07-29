Return-Path: <linux-btrfs+bounces-15726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B1B14822
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF361AA06A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE824A043;
	Tue, 29 Jul 2025 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7LPYyWu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0912AD2C;
	Tue, 29 Jul 2025 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770223; cv=none; b=kX9Lhyf1UdP6up62mfZtl1X2wH5NZusXJwIXZJZkj73RBg21affNMiv20PHVW+skDBHVIcSZd8QmJpxtyWx5sL33uxUSbfQXtBdqDG8h5r0Cy9WutqT5yHWSlMgsvDLbCc51K66dCnfFHt5g8jUd1jlwqFi/fQXICdLL6Fvu0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770223; c=relaxed/simple;
	bh=uv+R/oNQb6sLjijvZz8Xesc8OYfS7U4Rq/odZ4a+Sog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAyVfz2izhs+6UXe/nDHC2C6LIE7bpFbEbwL2z9YE4m+iz+vCWA92pQyF88yDgrkYqQxpvKeCap4q60h6I37E9lYDhTIqm37FlEvBM3uVHI6iQGvwH0C0Q7W814AHPALHt4hIaq4faMbVncv12rFqeKNE0Fd3ueu8jpuCn50Wi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7LPYyWu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6465367a12.0;
        Mon, 28 Jul 2025 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770220; x=1754375020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIS2B8UYAMprwm/k/baAnaP16jYG6InQg+bghxrlVC4=;
        b=P7LPYyWu+IHYFRBPt9dMsr/XqIwTxoaIUQdOoTbwaMSho3a2tZs0BzIn3GIGsdNHHH
         HBHUdudyGQ2ERtY+YAW10RFx2RI7z9XjnnTbrK+P7F9f7W1weTnlUOnbBlEGW9mios5a
         NGZ3llEsUB9v6BERS5sLCpvKCoB+QYFtBynAqreUQl4ufFcw4Yfpdgx3MhKMH0EsoJLr
         YjfF0MxP/Q6Iyy0/v7fE/lz7gE7gekpBhE3GDlqwpUCNmGBzyqrmSfKH1SQxIHxjPLcN
         FDo0s/sCEIjXKpdbT2Zd07/CEhbSav/RLc9dEaEV9Epyc5AKeMw8wJx7lo2mHw/ri+Gq
         d4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770220; x=1754375020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIS2B8UYAMprwm/k/baAnaP16jYG6InQg+bghxrlVC4=;
        b=CyMwSF3zjjbXFVdXdBxh6o0RYBn5auWDoylkMaTPZup06e/YC3QMBPhgcfm2dynnrP
         fAM+bwu0216PK+ruth1esfOK3E2m5/PF/1MIdTQmg7GGvH4ng0Q5pQjAiQiQXNmrtW7g
         teRPpuvKkmokVFy/slIl14liiItOudUetoXgbaPXUsfxmVkKa8z4McRzoRzqbv9Epyin
         8E9ZKQfeXWTjcD/3mfUn4jZEP44LmGCbFjiL2NZyEeZVGmSJ178sRw8TNo0N1bdFv7wP
         YjXkefTeBNc/uadAONIHhG68G+ymzBQxok9nqaQI9DcaQKU/aDNGrSiUWhOn5IGpOJ2K
         +3bQ==
X-Gm-Message-State: AOJu0YyVaQrl+m2mg1FO9uaBTPMUAimMS2zh1YqBHPI9PinDfBKd5CEh
	dFunORNzXAq1+Jv2UudDga4xadl56PVMmXb1HyG9Eh/i53MwZXQQa38R0pmYhA==
X-Gm-Gg: ASbGnctKJ61GcyM6wZAg5pajJAEHXavfPNZjMzlsGjnYknUpkMsrGUeUi+zrEFDJgnq
	wHm3GFcsdNZF7vwhBAzVdnPXtNNcZ0sDjE04WlaSrV4zhQ4gjyDGCHPfcGpM8uOVeKFsGfiJQcK
	ybNbH0qX86/W87dN+1PQJUSoiWytIXmsDia4WWNiZdqW4jMOZFiBpOvt0P1rbSBKcXGjSt2zYkU
	X+jPMGzxk0BYU/QH0fmYHnZbB7zR4i2hxs5h0vuBTa/yUt+QgiU2IChtUdqU3kGTthGJX2I8CLZ
	a133SamedMivP/4n+SUxLlKVY25OFtfco1FGUTWnIqq3CFb6ERWZ4/wA0fQy11murwtCsKu9vV8
	lhLeEwNO7A9hfmMRcoTcZERU=
X-Google-Smtp-Source: AGHT+IGSrDmXcsNyuPs6c5DwcUx9vL1uYdNsbdyLYRk4dYunzpLk54GbaB3FTUv914cfuVXfkCXdwg==
X-Received: by 2002:a17:902:f114:b0:23f:df69:af50 with SMTP id d9443c01a7336-23fdf69b14bmr103033285ad.34.1753770220586;
        Mon, 28 Jul 2025 23:23:40 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:23:40 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 2/7] common/btrfs: Add a helper function to get the nodesize
Date: Tue, 29 Jul 2025 06:21:45 +0000
Message-Id: <971f876c5b78e5d1eeb71a0e61903c1427358fa7.1753769382.git.nirjhar.roy.lists@gmail.com>
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

Introduce a helper function to get the nodesize of the btrfs
filesystem.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 common/btrfs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 6a1095ff..2922eb8e 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -18,6 +18,15 @@ _btrfs_get_subvolid()
 	$BTRFS_UTIL_PROG subvolume list $mnt | grep -E "\s$name$" | $AWK_PROG '{ print $2 }'
 }
 
+# returns the node size of the filesystem.
+# usage _get_btrfs_node_size <device_name>
+_get_btrfs_node_size()
+{
+        local dev=$1
+        $BTRFS_UTIL_PROG inspect-internal dump-super -f "$dev"\
+                 | awk '/nodesize/ { print $2 }'
+}
+
 # _require_btrfs_command <command> [<subcommand>|<option>]
 # We check for btrfs and (optionally) features of the btrfs command
 # This function support both subfunction like "inspect-internal dump-tree" and
-- 
2.34.1


