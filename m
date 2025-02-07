Return-Path: <linux-btrfs+bounces-11332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135B9A2B91C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 03:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D4E1666D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 02:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0DF282E1;
	Fri,  7 Feb 2025 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEE7vE3S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218125771
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895603; cv=none; b=j2J6IohdFmiyehAJENsu7UQ2UBmiw5qmc0DU9RWyLmrFJWMv3VvMoppFRosDo0ue2NJSgxu0Fvj+oJ+LaCPB31/1aTNQmrI/vJXrvGkX9MleLHntGrnUKDqgseG6Ixi9u1cQVvk48HHhDXrZwX2tWaL3NaFSSXZrpLB7PLCG4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895603; c=relaxed/simple;
	bh=tDx3CA8D+G6hefSz712chs4XXDIIAtH8PdapRiL4Fj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW/X+fH2DNaHdPi3kz7dfXVYnsC6aYmTExHC8EWFjY2x6RjwoVTPT43e1K3p3oMH+Om+CRiAijXZ3E/rr2s0aZq2qjxalzQQCujwBJcYJdgpgRCf85o4Iicda5Q04zBWUuWVkuuou851YgPpKgD+gT73jJeGUJOFWvcW8JLBsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEE7vE3S; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dcc38c7c6bso3195526a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2025 18:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738895599; x=1739500399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDVnTOG79Mynnpe3tSgGGU8VdN+SxALSLQRbYvx8QQ8=;
        b=BEE7vE3SiaBQDhCT5ZKl0hK6ozqohppsVASlWeiNJ08fF7ACZM/ip9zx/eQBhr+P/p
         bbgrLnWfVCjYCmcRJzU2X0LIBBDlx5gG78zO2XlbNzxJDS8Xuc7uizyS6hr6Jq2ddOLT
         cPCblnZ5m+B23w7g4UlxVUKKWR35xttbphGQDH/KI5xhgwCW286VRUK4tUAgG1H8Rk0M
         5OF1zwBjp85WPgMKHHdSeI5ASTyK1m3J+aj12DZMEwSmTbHGbF08XF6QmaXw5E6xdw9j
         ypsl6YE5eOcBULdfbs8eKIfbCq92+22ObGfNZYY27pzNNfo5NX2E1NncJD1gGt9rZj4W
         aZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738895599; x=1739500399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDVnTOG79Mynnpe3tSgGGU8VdN+SxALSLQRbYvx8QQ8=;
        b=uJzIozyuYXZE2LXyukF3k133/mMx+/U3ubIKXT/TCF1YpuTbEQwlbEphw9KrV6HrgY
         cvrNWZLP/RxiImYhfgblXwVFnilZAjjsXvVwWEj8COo0OdKilwTnpYUWQlu+IihzXEf3
         uIyU3eEQQJwRC5Mouc2/gm7RgEuItPc/ZibKXkuGPgvd6U+nojLTQQ8gB6ZXPxVXhxLu
         CyhbpT4bsDslPQvSS4J0wti0cN5hU3E6o+UztkUi7SYhmi8wPI1wakiNAq8WTW0Vmvkr
         sJp8f9hveahUbACOE/u0jNaQGeQX3Rd4jCrdDtNjZEMpSfNDtyIGmebdwuO9rBQKo3Yw
         qzhQ==
X-Gm-Message-State: AOJu0YxtSKaNjFJ8EfqCnJQMBKHDlbUERM/SNo+kPpvelAGaVy/Ms9y4
	fFH7v3LoCEbhr6mIYbwyqWk5xzE9yKQ1eGxMbhtC3fmG0BuqrZ4l
X-Gm-Gg: ASbGncsgGDTA5WgwjcA35FFJDj7aIef7m6jcyji61DM6gcyHP4clIu+dCyfyFkxNX1L
	eG5DSzEdER7ahalfqVAK03fg74dP5NPq/2kD30kDWw7S3uLz092QKqsnQBdsRIG89F2L8i9G3Eg
	nJm79dXNnnczK4iXU0sfx8LVpVP0UcpoElLU81yWQ5VroUEu9QpgPB0MP0VhHmRCVDGhtuZO9Nz
	NxI8O+DoUSvRIcKGjhIye9KLFhZB/RHFkeNHcfugcUkgPh2MhTjO0HrVg2uEoVZdHb4cYlBVRon
	ZHn+fKzaJlh4DA==
X-Google-Smtp-Source: AGHT+IHqV8tXdVflMahSF+sm1zTB8kEtaLm2DdZZp91a5U/Ik70wCaqq/3WIhG1t5Xn1oyoXMIsZCQ==
X-Received: by 2002:a05:6402:4605:b0:5dc:1f35:563 with SMTP id 4fb4d7f45d1cf-5de44fe9ce7mr1669171a12.7.1738895599369;
        Thu, 06 Feb 2025 18:33:19 -0800 (PST)
Received: from 192.168.1.3 ([82.78.241.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de379cedc6sm1086752a12.44.2025.02.06.18.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 18:33:18 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 1/2] Removed redundant if/else statement
Date: Fri,  7 Feb 2025 04:33:01 +0200
Message-ID: <20250207023302.311829-2-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207023302.311829-1-racz.zoli@gmail.com>
References: <20250207023302.311829-1-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed unnecesary if/else statement in the print_scrub_summary
function. If unit_mode == UNITS_RAW, bytes_per_sec and limit get converted to
UNITS_RAW, otherwise to unit_mode, but in both cases the exact same message is 
written to the output

 cmds/scrub.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index b2cdc924..3507c9d8 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -207,25 +207,15 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 	 * Rate and size units are disproportionate so they are affected only
 	 * by --raw, otherwise it's human readable
 	 */
-	if (unit_mode == UNITS_RAW) {
-		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
-			pretty_size_mode(bytes_per_sec, UNITS_RAW));
-		if (limit > 1)
-			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
-				   pretty_size_mode(limit, UNITS_RAW));
-		else if (limit == 1)
-			pr_verbose(LOG_DEFAULT, " (some device limits set)");
-		pr_verbose(LOG_DEFAULT, "\n");
-	} else {
-		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
-			pretty_size_mode(bytes_per_sec, unit_mode));
-		if (limit > 1)
-			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
-				   pretty_size_mode(limit, unit_mode));
-		else if (limit == 1)
-			pr_verbose(LOG_DEFAULT, " (some device limits set)");
-		pr_verbose(LOG_DEFAULT, "\n");
-	}
+	
+	pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
+		pretty_size_mode(bytes_per_sec, unit_mode));
+	if (limit > 1)
+		pr_verbose(LOG_DEFAULT, " (limit %s/s)",
+			pretty_size_mode(limit, unit_mode));
+	else if (limit == 1)
+		pr_verbose(LOG_DEFAULT, " (some device limits set)");
+	pr_verbose(LOG_DEFAULT, "\n");
 
 	pr_verbose(LOG_DEFAULT, "Error summary:   ");
 	if (err_cnt || err_cnt2) {
-- 
2.48.1


