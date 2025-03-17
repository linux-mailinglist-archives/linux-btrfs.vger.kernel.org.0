Return-Path: <linux-btrfs+bounces-12325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A25A64C71
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 12:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DCE7A6ABC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D11C23717D;
	Mon, 17 Mar 2025 11:25:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC323536A
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210714; cv=none; b=uXDh9rceoIWSjbwe55cIq7Y6qp6KWwNqXUBj1ruYPkES7EK+uFn9j8KSGDe67rKJckd67vegG2DS5fPRi37y5Og9DVasv1C6Rw/VW9BTLt9YqYdMaQzXn62nnW4nPePp5hjFxfuCd+i1gMIGqbWSmr9kjyl6MtOsYDElUQkxaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210714; c=relaxed/simple;
	bh=WFTQObJeBgqTifLsJnZAZr146fA5suikahPaynSlOAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svxTVTiEMCiB/n3HJIWOkLQFxY+VZLc5hPeJCKvcnVgY/hA6vWOzIYQqn80fi0+1va9jbpx+2WFsf73SFYFrhvxUUBwHQaVm6HDWdjON0wQXDIWvf78cZGq0Xt2Qmac49dS3V8ZBOZ+dvp5sRn+00yWhyseJ2QVWOo6LTNo837c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0618746bso14574265e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 04:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210711; x=1742815511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iZg1OnuY3zc1SWvxo4hgdT/28NnoisoH5cdKdOxKck=;
        b=cX1l+IzD+dHPvP39bNxXgYuQC+muEKCwTllbXgRJsGWCiJLCQq6EZ5+tepZbpzrzKw
         Qvlx3sLot3Ogm1tiOkaSlQN3FGug1Hlmp6AGEMEta4Z4cWWfT6G460R/R+FDsK7wT8tg
         HwdwAR6Js3noDwakcEFZHcSSYf8qgDXGk2U/eEbVAJfuetI3k7bfAiZaKn+pVre2LDJt
         WGJMnTietsu02J3aIZTQ0B09vNoUF7UUrHOe07ND0jWqb3CxLv0CWFRcMG3WZNkXmLCn
         AFw2IDvcy+0izdIzYd2HWIcFkigUu45V97HWjzFlaVyi9WHsAPrN+ey40yFeND8KkqIg
         vAUQ==
X-Gm-Message-State: AOJu0YxZTdS55Jm4hFcWC5ezXUbtiIDMGuoOvaoAGdIpDuN5ScFxeQdA
	vNYXLav30iSVU9ON0+qCq9sBqhf7LyeGIks5Bn4c4/WjjDl74Yh7mBkJ1w==
X-Gm-Gg: ASbGncuXnWMyzJfJHR4mnFDn4dGUyPWPHlW/mr1Q7Mua/aNeUPGzPnxMI+qsFduCQNw
	2ZfOS8oT9PWKQ83qU0nWXofouBtvey8boEBMJMqgCB/EpiZb+QgtcAetjDDoBLlkcMnVNfZaPpc
	csvZtdRCE0TqpfKIK+1Xk5GWSRo1lIr/fbCoBpq12EgZ4gY6swF56HdqDGu0Bxz5JK3+bhQbnip
	Ggk+WBO5qSyNwfujTjX+MAJgQc93TzJs+SxRFUHG1h8euLaLyLn/PXw5+oCwblm/hWtoRYvjC2I
	Dl9Mtyjr0To/RcFP7wvVQwDjLMqQiJd6gmClPUS1y0eCUFi6KafnD4MvwDxnLnt+JcUlUoo/s/N
	OOBRAiwddbmcHSwEtn2Ky1jiVAIU=
X-Google-Smtp-Source: AGHT+IF6SApgx/ewA0fbNm4YIaoMVYR4is5G+EahS7hhkC3pLdrkvCUpKUhlaOuEttqyn3XLzioA9w==
X-Received: by 2002:a5d:64e7:0:b0:391:29c0:83f5 with SMTP id ffacd0b85a97d-39720d47357mr12583608f8f.44.1742210710676;
        Mon, 17 Mar 2025 04:25:10 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71d1000fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71d:1000:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad59sm103188675e9.26.2025.03.17.04.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:25:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] btrfs: zoned: fix zone activation with missing devices
Date: Mon, 17 Mar 2025 12:24:58 +0100
Message-ID: <5a221a55c0a170aa6073b997a160d94f9880e40e.1742210138.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742210138.git.jth@kernel.org>
References: <cover.1742210138.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

If btrfs_zone_activate() is called with a filesystem that has missing
devices (e.g. a RAID file system mounted in degraded mode) it is accessing
the btrfs_device::zone_info pointer, which will not be set if the device in
question is missing.

Check if the device is present (by checking if it has a valid block
device pointer associated) and if not, skip zone activation for it.

Fixes: f9a912a3c45f ("btrfs: zoned: make zone activation multi stripe capable")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c21a97b32f9a..8924f58919e8 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2110,6 +2110,9 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		physical = map->stripes[i].physical;
 		zinfo = device->zone_info;
 
+		if (!device->bdev)
+			continue;
+
 		if (zinfo->max_active_zones == 0)
 			continue;
 
-- 
2.43.0


