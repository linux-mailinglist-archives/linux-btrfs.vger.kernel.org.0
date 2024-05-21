Return-Path: <linux-btrfs+bounces-5164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63598CB0E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F291F219F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2F143C40;
	Tue, 21 May 2024 14:58:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E1142E70;
	Tue, 21 May 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303495; cv=none; b=mu/kk+AvoK0933z70KSeS0/pVaqPfEdYQDLbRlRRGLd7Co3luGTb/9/YadBOxRxBuMAT67lAhxv/VbeWqaQy47oowAo+CnmDANcOUZEMH/VNW8Ku/MxFdRZKwlmpoYsFPwTf5M3DwNu5g5XAbNN8jFRab4XomiyhmjG8lebWeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303495; c=relaxed/simple;
	bh=siUgWbHhxL4TK76HiW2ed7T6aitCV6weK3PRkTuu578=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRiWpD1s40gA9/JngizfR2oMXi3vRausQBffuF0XF4JwuvTI8ZD9qnjEkFhx+UkYgCkP9W8XotkRWwQwj7wMTrSKnNNoIBy5/K0Dr2TR3AC9IaFUaf+fOarUSZk3TG31cs45TFIgw6oxA7v+Ldi41Bl3OJdjSwcMFhckxErK5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so9032630a12.0;
        Tue, 21 May 2024 07:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303492; x=1716908292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GFlLsFYMU0MyX+LsJFXhkG/Vkyrq1yBglyohH/2pv0=;
        b=LpWcZ+g757cWIJfVxDaAjy6tXylNW4ceK8eyMcCTDctMQEcz0ZGF6CYsNK8Lbx9YEk
         Sea3pIC161c5tfC45F/hyejplVw3HKr48vkXxRedq9nwKYGtpgFIyC48nxKsEuaUSn+A
         r08qmacyntK2bZ+3vzuvivoHVGONKZn8kHsa5p73U32ZOBkXSvLD8SG35RYSNWw/NPk1
         Nb+r3jgn/wJEmcTb6B6tw0OY7L3cWR1DIQuvlgHkrkGA1eBGng4kEaIj6y8nk27GRDvu
         P2imC359S+rhYjmZuy6tG+7Dlu/lXRS4+d9IlZQnIbQpivmeL+WrtzHOitoFI9v2OHRq
         jBuw==
X-Forwarded-Encrypted: i=1; AJvYcCUv2oU6D58HbhWPAdb9UyV5hAKJeJzaS1jGxgSwWXymNrF/0LfVrIyzque0TTG+HpDerl1D3xmBCPvSUYtZyI6999VFfiD0aTeXP3ffIWtyPtvqJb4nAfPxOhvePJS24yhVBbwPZ/K4MNQ=
X-Gm-Message-State: AOJu0YwW7+OdsuNwFWbdtxxL0zM1DdkZc8GWasofJRV8He9gddRO8+LD
	Wfjk12ZevpIAO3bV47GS+n3AFpKTdzgbznwGGkA9m0LyEiSYFfQuBixsOlMy
X-Google-Smtp-Source: AGHT+IF3vFtNu0QeIcZyZxcuFIGxi+SMkfdq6OXjzr0hZUcY3XxJrukTZw1J6eFwtigh8UU9OUvYvw==
X-Received: by 2002:a50:a44f:0:b0:572:9dbf:1538 with SMTP id 4fb4d7f45d1cf-5734d6b2914mr21805142a12.31.1716303492553;
        Tue, 21 May 2024 07:58:12 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm8912502a12.82.2024.05.21.07.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:58:12 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 21 May 2024 16:58:08 +0200
Subject: [PATCH v3 2/2] btrfs: reserve new relocation block-group after
 successful relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-zoned-gc-v3-2-7db9742454c7@kernel.org>
References: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org>
In-Reply-To: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

After we've committed a relocation transaction, we know we have just freed
up space. Set it as hint for the next relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa1..764317a1c55d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3811,6 +3811,13 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	ret = btrfs_commit_transaction(trans);
 	if (ret && !err)
 		err = ret;
+
+	/*
+	 * We know we have just freed space, set it as hint for the
+	 * next relocation.
+	 */
+	if (!err)
+		btrfs_reserve_relocation_bg(fs_info);
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)

-- 
2.43.0


