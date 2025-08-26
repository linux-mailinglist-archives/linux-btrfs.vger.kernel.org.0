Return-Path: <linux-btrfs+bounces-16416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D547DB36EE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D969A46184A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A22D239B;
	Tue, 26 Aug 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BILrCV0W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C6352063
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222923; cv=none; b=goOSLZJvvBKaScCne8G4pU0sqF5JkZzoWiOl0I4LUkmhDUyFnN2MKpg8++qcfRaIOWEtL/WwORB1vmt32DQQJSs5nkw16fn6TkFjmEtl/esN9FJytc1KN+Xo/zo/R8bU9OLLGctUUi5Sw3mPUWMFjySDn1klnh6DrpA6NWfEQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222923; c=relaxed/simple;
	bh=MRbjz58EJk2DIV/CMfsuQeru3Gjlj5upRwbvX0t3mqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pts9Pren+Rg8Jl3BLENI6jM4OE2/g5wsbnUc8gfoZZ44feCXuurmCJ0cgf5LDEDFFz8UT8dUM7jqu2nUzQ8I6CIKzGEJr6blAodNInffoT+dyOOv7Au/QFSAbdjnzObRvS5lNfUZb6yXm8+7m2dD671EpHzBq1Bl93NAs7bDbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BILrCV0W; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71fd1f94ad9so46395697b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222921; x=1756827721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=BILrCV0WYnWT1+2jq6fXe3vKn1IHeBBILGrrJVAnTnpJcJYKAMzR3plnA76m6YeXxF
         a6pcAgQ3YvsnQlJBDZcbjUKnbWHJIRT+cixh8gcWP4ozxfkU3ayzIPS4WbvCgVM1V1J9
         JivlLLAyTLjmRyOshv7iUp7r/q08xiYFz/EZOzzeVwBZrD+XfNGu6Z8H70D2dCsk7QVB
         kMEYOeV4tsj1mLQdqgYFePAosHW+XMhrIGGEFCXaEAWEtoZarqJJMIzyqhK4SfnsdTzY
         duTPScZDefdP6Ngt2VeLd7tNlT3lkFmPY6rGXWhbi9BCBCri92kMMlbCwHc8levsNrco
         GlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222921; x=1756827721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=JPcUt8gI0Gx/DSKjzLgMmdKci7MTLE3YSaLjtm58Fy/jjpR90F5lgIprGXuRz7HYXH
         TXpACn7tkwMC2Bu5+ghMjIBs35SRJZmCD4LseVTM64uX1qv5N6G6GlSHdZpbb3+5peG1
         gFXDe+sfTAn1bfY9nZS0D6P2zyByJf6cGN94jDgYU95zD1dlVky4MPIDyG+4m/NCb9UM
         PZAhzldue+K3c7dz42ZpqU2SXghuG5zr0Ud+0WbCavb/W6M1SqRJO5TED+jCBsqCGAg+
         bN1CmyhtGQEbCeynNZqRUf/TfSURbmrcGQxH9fkGVYAqEZx1NGoDD+spUsdODGoolIC7
         8UXw==
X-Forwarded-Encrypted: i=1; AJvYcCUjTDo+0C8FlJnT9QF6GB+lhKsUU9j/+HppAJ9BGIRSf/99fQDI9LagBnk9o2zso6x5tBCRvU+iGBZnsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUO4JHVsMMuYQN07CFIgFD2cZQ/zsk0xNVeX08x9JhJ1OYxDtC
	OojRsXZQb6ag+aWxtRAIoAVu91AOIbg+VFR6Iz94B9nkrGm/c1YMiNcNl5wYLMRsTX8=
X-Gm-Gg: ASbGncsoo2BkCwW4Q5txl7PD1JLYBI9IayWt30wHwuEkl/ObGQqrQJVlWWwYuwaBqDl
	ysW/6BrT2vsl2qRRUuc12XxwNPAlalDzDUVxVrg8E5ma0V71qf+Ki5C5J3fyiRgz5TG61++omSR
	WkcjOlqV0bi3vpiHvI02GdcuX1PXpkhDMmiSdGX1lA8KAPe8WIAy72PNSclCZo+AajJs//4W4g6
	V0hThdk7E3wmxLfGs2GaUd1DKASza05UxDC6za0zfAo0UKUkAOIbv3c/ekgLvuHB3C3zWDTyl0a
	YaZ+muBgWw/+hohIqFCy9m+yGQNJnYxHHAT+r92wQo6Rz7Yo/4P+U/dB7F6NEmr1qu0BfQjugUc
	CqO+PUft+TmDFxUIYxrfFLyz1N9jrzsmByQStTV6D+emw0FUvvbL7JXxyK5HCBzNtaM1odQ==
X-Google-Smtp-Source: AGHT+IEMOMVn8rVVn/LrSUqLRsgPs8HrTr922RJlf5aayGldBVTuMlA9OhISdmU7x/PsUdxbw40paw==
X-Received: by 2002:a05:690c:680c:b0:71d:5782:9d4c with SMTP id 00721157ae682-71fdc3e0679mr159524887b3.28.1756222920808;
        Tue, 26 Aug 2025 08:42:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5fbb1a885absm419060d50.4.2025.08.26.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 49/54] xfs: remove reference to I_FREEING|I_WILL_FREE
Date: Tue, 26 Aug 2025 11:39:49 -0400
Message-ID: <681053424e9eefe065dc689a325e94f79d0f918b.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs already is using igrab which will do the correct thing, simply
remove the reference to these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/scrub/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..b0bb40490493 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1086,8 +1086,7 @@ xchk_install_handle_inode(
 
 /*
  * Install an already-referenced inode for scrubbing.  Get our own reference to
- * the inode to make disposal simpler.  The inode must not be in I_FREEING or
- * I_WILL_FREE state!
+ * the inode to make disposal simpler.  The inode must be live.
  */
 int
 xchk_install_live_inode(
-- 
2.49.0


