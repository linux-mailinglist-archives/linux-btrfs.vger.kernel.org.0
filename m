Return-Path: <linux-btrfs+bounces-3354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27787EA76
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCAF1C21296
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB734C3D0;
	Mon, 18 Mar 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAaFYi+H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F54AED2;
	Mon, 18 Mar 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770299; cv=none; b=plj1cDLXbni2xfGjfBuFkVM7jFoLhqA+YsYyOq/lWpd7SjYRRVFbRgsQZlHynKz36Ob9yhnrUzBYCC5IkEHBigMGCYlRojSkA8j4YP4GovleGzZtInX7RT108BhvuLIYS6qz9+wSl2PeFSEfIp4eKmbHnYl3alf16KsrKNEErZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770299; c=relaxed/simple;
	bh=6QxRV6tobGzrYtTQEDu1f/p08nKI5Bg5eQskEppiJiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/baQTbcT6uO2crTHG60dVWnX1I5HyLcAEbu6xaNrdk8U0LGC9SKKUcbaDY6U/D4BdPB2StmzbAfvWj+/Bvj7ioI4Ks2hrE5tHPZYt86H9UyvnbMzG/nmucKL715Lk2QMC0sKDbTbceTWSIohTH5TrAn6HJlR8D6qCM2Tr56yYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAaFYi+H; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789db18e169so336053385a.1;
        Mon, 18 Mar 2024 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710770296; x=1711375096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CvFCY++I3zBVjUi32budzYz2qcp/D+ixqQd6wPMXSKE=;
        b=GAaFYi+H4pn+fo1GQ8YC4fQKZeZUNzUYyzeicEoBiOZw0aFIhgTfzKllyBeBgBygO3
         IZ2lyBllpXm+ArWMKI/M866rjfm4kCV4hZvQT/Fom3QhIvLe68CL0vN4BB71cDtiyng5
         JMIjwTAAqe//GMcpoqAC+F/aqER1H+2rlWLZ270uyQOGC+nEQ1mY+LPxmZAde2JmDNKt
         7eBiSqphiCFGWVIlmN6djSReuAb5iBSrPPzOYgyzIUdgnIMOaJ5zS6cqsZLsu/Zy28c0
         /KQRZbjK1nB731Z2B6O2B47/KmDB4pSaVhMXkUSyAQhLjSyajkEYvUwdMTJDTFK7U0Kk
         lfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710770296; x=1711375096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvFCY++I3zBVjUi32budzYz2qcp/D+ixqQd6wPMXSKE=;
        b=vDhpMC8RfDEoGHFmM2Mtv2jey79CF1aOb/+sYQmEcFtNQ5iWpDQEzeFc1uduoDQCXL
         zxbFC0/3wu5xwJOB9US5e2tULi4RB1rSTMr568Zgp1XCFj8MeCjQQ8m10jt8uoI/23g5
         VuADWWgIalYOUY9TW5uZly0F1KWgln6SsN/hvfd+04zQEVmWuVxV5ObeRMF9M7mNwNvI
         vEd0baaxOzFNU5r6dlp5suV3G7YsNwje+W9FxzOeMbnTHEdnbsgv25j06zOfUvMwWDRz
         kTK9ctO59XBizgETQf8KwZzcqKjloyfdsYv+N8CG6f8GaMVMpTj60oSvCMkaAelPjsz/
         chbA==
X-Forwarded-Encrypted: i=1; AJvYcCWHE6Ax+xSVufLaxVgCiMK1pI3bg5M7LJ79l1/0HeISi3XKkfiw9W4hDM2489oKauDPwRQ/gWXPFcF72VK6AQv6mhEiemNGUdmErgZ3
X-Gm-Message-State: AOJu0YyGBqoxQd1VbJz3poSFSgaDfpvm6OZS68nJZVrM0E3ss2Gk6K0u
	efodfFKnd5vXvuGQkUO8xP6VB3PA4h9zr/NhUysSnGubd8mQmx/LhbUXUoyXvlQ=
X-Google-Smtp-Source: AGHT+IFrDSG0OxhDXEIdkz7aCXoxkObfKaZBsCA7h/JGfjIjXnXNl3+CAMq1vxFEW0BLtYDvXDUoVg==
X-Received: by 2002:a05:622a:191e:b0:42e:9146:a0bd with SMTP id w30-20020a05622a191e00b0042e9146a0bdmr12885414qtc.49.1710770296308;
        Mon, 18 Mar 2024 06:58:16 -0700 (PDT)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id fb19-20020a05622a481300b004309cf16815sm1284968qtb.39.2024.03.18.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 06:58:15 -0700 (PDT)
Sender: Tavian Barnes <tavianator@gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
To: linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Tavian Barnes <tavianator@tavianator.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] extent_buffer read cleanups
Date: Mon, 18 Mar 2024 09:56:52 -0400
Message-ID: <cover.1710769876.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series refactors some duplicated code introduced by a recent
bugfix (which was intentionally duplicated to make stable backports
easier), and adds a WARN_ON() to make it easier to debug similar issues
in the future.

Link: https://lore.kernel.org/linux-btrfs/20240317203508.GA5975@lst.de/T/

Tavian Barnes (2):
  btrfs: New helper to clear EXTENT_BUFFER_READING
  btrfs: WARN if EXTENT_BUFFER_UPTODATE is set while reading

 fs/btrfs/extent_io.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.44.0


