Return-Path: <linux-btrfs+bounces-5468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65958FCF9C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4181F26B0F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2B199222;
	Wed,  5 Jun 2024 13:17:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85019645F;
	Wed,  5 Jun 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593477; cv=none; b=FeZMn6VKlzNIfbOSXHDFTYodwGnZx7pyeIFh+k6lha+S2NHuclB6v76z7kfRgECDWVQUvZwJPb2x8qs8qrC5nSVKu0aRk1RJwA49lyVOuOrzgBHup+uq4bsxm6EEboWF1l1KQ7bT5W4lPwY9Jwm0Dilf0qWy3v/dCQ2UBqLk3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593477; c=relaxed/simple;
	bh=SiJR4QyOXbv0uoH3UQPbNfn9H39XLg233Xz0kUcuGW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nYA1w7FstdpRaus47E2SCBlJqrwKr+QAfPojlmqze+zxe1ZSZfhqvdKkAJNgmrh+eJj16T8dewmvmuxAx3Oik9IXVjDhA0tJoKIGc7Nd1uNmj7hDqqCNVoM1ZOffXgwluVvhsh0oElSIgLjOj/9RlaXvEoUIlIvYhPIKrcQVnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1598981a12.1;
        Wed, 05 Jun 2024 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593474; x=1718198274;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIulsvrd3DjfUEdriuUOdIbjRE0w84BRKtp+JqYRaps=;
        b=hycL0G94rBfUjzwqAw09bfZDEsEbd0TaqnYlsYnJF3qmt6YDmFzt0ChcTHhcC/Ph0b
         8ZUWIBGW04pJW62/2ubWkjwzNQPaOdExyv4v7ZVcbA41QIiAlAXNkqKAfv+uXtA9P/yP
         4gpxpUIs++qRk0T3ybZgNuQdHQOcNysM5dYkOSbDL2qOqyr/tMutoVrQY4xx0bCesSez
         KuDbIBUomFik4UI9WYsyMxtGBZdO4/anmnT1SpUvAjcnVTsijiZNoqAWobzByGnrCoau
         8GHr2hxj/SVq+S9BLQeNdX8D+J4b8+rJbda/gkoyHgSwYmMWGbfcItCKmNcD3oPfEBm8
         QYmA==
X-Forwarded-Encrypted: i=1; AJvYcCWKtD1WAvEElzz/MoiWC3H8zvhG7CqZsIQbYPRz1Zq+wnRuNA+vnp+RdkHaRVDs91CkkW/bJB5oAcXtglDwQfHXw5wn7AYzfIndEJhk
X-Gm-Message-State: AOJu0YwQc4LGLD9kx0p6xQdYs/o+yEuLFpMp0MpiH1D7TpBp7Ni1CoHl
	KoyPKJAQxW0ENVP+CtMMnJc6nlhLz4xuN2INKfM6+7oveHThFbs5
X-Google-Smtp-Source: AGHT+IEjLUeC6IGxAFLUe7145LHBtaZpkQJt4KoUxh/Uy4D0sxVdLtb9bVDJLBqsdA9l+f4eOY1iwQ==
X-Received: by 2002:a50:ccd9:0:b0:578:5f9d:9ab7 with SMTP id 4fb4d7f45d1cf-57a7a7219a5mr4695253a12.17.1717593473469;
        Wed, 05 Jun 2024 06:17:53 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99a3fsm9266913a12.9.2024.06.05.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:17:52 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/4] btrfs: small cleanups for relocation code
Date: Wed, 05 Jun 2024 15:17:48 +0200
Message-Id: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHxlYGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNT3aLUnPxk3eSc1MS80oJiXUOzlJQ04xRjM5MkAyWgpoKi1LTMCrC
 B0bG1tQCx7ENzYAAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=785; i=jth@kernel.org;
 h=from:subject:message-id; bh=SiJR4QyOXbv0uoH3UQPbNfn9H39XLg233Xz0kUcuGW8=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlpNZfTvifyWV4We5mFaf1Mr8tnRFTpb5LvHJii4/kM
 HzK8nteRykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAExkXiAjQ9PMyVMt++Yxtnhl
 VarM4LDeHCTgpb7Rn9Op9dvf0xczjjMy/Itbunfr2T+7q5eYlJQqciitvTOzPU7RO14q+V//Kf7
 ZnAA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Here is a small series of cleanups I came across when debugging
relocation related problems on RAID stripe tree.

None of them imposes a functional change.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Johannes Thumshirn (4):
      btrfs: pass reloc_control to relocate_data_extent
      btrfs: pass a reloc_control to relocate_file_extent_cluster
      btrfs: pass a reloc_control to relocate_one_folio
      btrfs: don't pass fs_info to describe_relocation

 fs/btrfs/relocation.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)
---
base-commit: d18729a15cd2ca4b71ac14727c33b7da87359b70
change-id: 20240605-reloc-cleanups-16ddf3d364b0

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


