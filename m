Return-Path: <linux-btrfs+bounces-11473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8299A36398
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 17:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6516FFAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD867267B6B;
	Fri, 14 Feb 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaHnxYjm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736381519BF
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551651; cv=none; b=t8JuJzg9lSlvyiKCR8M8O6SlBuprB89Nj2VBjxGpgcIwysdlfALb9bxzKjA1KnbpuFpzsgJcAMsbpqfWhrnwF6gQnN0k9v01guyAMH/F9cPSLRjmg7v40TP75bBcw0XucenuCzsTN0Op0zyzL8caXpZN1qdntIUH7Mguv2Trfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551651; c=relaxed/simple;
	bh=THBy/knhjQkcKTB9FVvJHc5V+krS0aFCG/OZp7ByjnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTcngCViHy2wu3rxOGRxIrFLCrYHFCNnRF/CfGnCzaV7IiXWXHGxX2FSvpdi2oaNWwgMIQeRyFVzgjslM+H9z9QOdEV8diFNwwKmLm5MrZSHQO2R7ud4RqUPEq4HdT/rypJQcxsuehlDWrtycHTFW+Ed6EmTB6VkcM6lb6RpyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaHnxYjm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so4216781a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551648; x=1740156448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhOw+2PFewFDzgiEX/WmuH7JONHbE4qmToURjZcv3Is=;
        b=DaHnxYjmC6w9t/S1TNk+dF4XDTIZP/QUeqWmZdjOBNEVjG0eIfGTCU79PZZK+8G5jG
         WfukiMUML/qDIlTLq5mDu7200Gsq5Eldi1fE1EPVo71ov3rpDun/FOvlj6/AKHFuskyt
         ikckDWUc3JzCJclv1TS5qFNX0ratk4FThGU+4/zHMBqdKawfuZiKDL+tdzVxeTBdUulB
         l/Vgl7xuICiZWwIsRjCGBUwhWg9AHY8lK5/fX/Ec3QiqRypzuqHnRpFfnNNte9Up1uSR
         reYIx6kzqpv+4pfLSzhMulLuS+P+XP3oWaClb6yRddZdzUKolivPMbTY6UU9EybtJylP
         wlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551648; x=1740156448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhOw+2PFewFDzgiEX/WmuH7JONHbE4qmToURjZcv3Is=;
        b=fdYj0U1XhblZBsuwiUfO+EaqECXZzFqSdnT3zSXgOA0Oe/RV9oqfF/jjkcSmAkWJAD
         lJQMF6y6//LPXBvCNYcDuWhS/q+ynYIhj9nsWQBsiWl2YfPHdhV3mjir0chr072Ls5sl
         wc+fJAU8AzXkmsbc9+vIYyvX7II+RECsyLpPfftr1IKAsDZcfJ9lkSLA225RL7HXz6Am
         Au7+L//Y69J0A87rwJFi0IGcp0MICO+/Q769A1Z+TBShEh5AiMNErjdWvEJGKP4+5CrN
         Hx4gk3i/jsLT5pozLNfeltDWZzCN0HNVB+0jPMs483RIFP2XKRkAsQayZ2RoiaqkBBzT
         YV/g==
X-Gm-Message-State: AOJu0Yx9OEZNM+LYZaOrRlFVKp5uy5bQIKfqm/nMdLEKLwOjSzwtjmmp
	lawlP6cXGLpAi6rbX/L7NCx9Udr6c0Z6aUno0gEMf9wPSXfZN/9b
X-Gm-Gg: ASbGncvrZ6nz1WNIqu2as3D4DOiUN+pqoqA9CJ78obabPiPISpwaJSyCMUIF+ctJp0w
	bibyzK2e8NVt44OA3tJgIhzFUUKrMRfAnrVfqnVqKm2KaLesRbpbLifPo9LaOR0+r15klW1pDCJ
	ku7jOD9qUGy62U5jdnUt+tnBS5xl2f5JhB36woisolUvV6wc59jaGi4j81aednGMtJZOZDWhkgm
	r0n7AItRk3t3rC9QiLjm+XRVDp4ndC5SmWzcR/Bxzt3lkQsH5WClP+loT8GZE7dQcPZsOepUJ3h
	PTr6iHRuOLmh
X-Google-Smtp-Source: AGHT+IFm4gQnyazS6rXADl4N+qjY19r1zNB2DTo5RtDjqVhkRzrsOy9/4AVlgdchuQFg52jO4iYGqg==
X-Received: by 2002:a17:907:2d91:b0:ab7:98e8:dcd4 with SMTP id a640c23a62f3a-ab7f3765a63mr1215945666b.20.1739551647537;
        Fri, 14 Feb 2025 08:47:27 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm375019266b.131.2025.02.14.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:47:27 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 6/6] btrfs-progs: Corrected a minor JSON string error in print_scrub_dev
Date: Fri, 14 Feb 2025 18:47:09 +0200
Message-ID: <20250214164709.51465-7-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214164709.51465-1-racz.zoli@gmail.com>
References: <20250214164709.51465-1-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 cmds/scrub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index e47c1869..88af88b0 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -468,6 +468,7 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
 
 	if (json_output) {
+		fmt_print_start_group(&fctx, NULL, JSON_TYPE_MAP);
 		fmt_print_start_group(&fctx, "device", JSON_TYPE_MAP);
 		fmt_print(&fctx, "dev", di->path);
 		fmt_print(&fctx, "id", di->devid);
@@ -498,8 +499,10 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 		}
 	}
 
-	if (json_output) 
+	if (json_output) {
 		fmt_print_end_group(&fctx, "device");
+		fmt_print_end_group(&fctx, NULL);
+	}
 }
 
 /*
-- 
2.48.1


