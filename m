Return-Path: <linux-btrfs+bounces-15683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9833B12ACD
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA873B0D34
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6A285CAC;
	Sat, 26 Jul 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaqAw/vy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FF376F1
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537950; cv=none; b=GQIG9ykp9Si6NuaMVP0OOew0PRVgtUrBK6C5ltkXei78VAe8an7cxcTGoz865GzCmfWKSVnuNqPaK9op/YojU5NbpQrHqkQs6xxCXY5ZPTFbiOCOuVMiq+zanN+oGv35d9b0VtrvWP6EWxAz3t5nMGHB69QS3/+R2ERSpOqDyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537950; c=relaxed/simple;
	bh=wHLqplwO9uXZB04Y71jJD/xienIXJBMQVByf0fw959A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ue8CR9qRk/m1Jg7OXXREAxGVKhcDSb+nowJTZYr0JdjLzoZBu5s/RABtUQCw4E0c6RkxRc2rEr8DLyXBvgDw1qqVOygmMhUJvatqidMWE2+HMjrB7VHKYFL3crgXxW6FHc0jXIeuRWg+2I8LbWVndYmCY4zNj9L1l6f3ekRABMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaqAw/vy; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-23fc4b64b6eso962835ad.3
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537948; x=1754142748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1lfMmgM1w/B2G/Zcm9MHl5kE3CNV+pGty6MnwAlIXU=;
        b=YaqAw/vymyP0RPCveA0Zsvm+G2+KFK1UDKKNZB8Jb461k/HsjFe2W0GkRd5gbwQ9pz
         u1tNfuAwO2GhYREPEj5LVtYVyiiud+7iaYsbwKuPeO8AZMbY+uO4F++SiitMtAzl6Ez0
         5/Arv00yu3AbLLP2nKlKCeXWLhZRqmgwwKsejSd5s56sraAe7Ubal938SnCk8DF7GQY+
         AfegSU1l8b6+WKRNBc1IEWdfzzinZdOw3nYXPTeblm7si7zo/koElSg4Nb4/oDSw2Xgn
         cmKjKHzoDmBOyUj0GKJvZE/JioupAE+ycdItyBAvL9JPiX9z1raRl3DMNbi4L9CUH1iO
         Ljqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537948; x=1754142748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1lfMmgM1w/B2G/Zcm9MHl5kE3CNV+pGty6MnwAlIXU=;
        b=qEA2MIhdnZ3YETHIMMDfNr3IGGAgcMw+U1YL/X7YyBGDuXB4XD+svO8TNZVcoDIBld
         6t+NU17DXHEu5OWy5KYrToyNyOw8USB+mk96JAQg3s3gv1siDZCpuTivYVzGbf1ADDTQ
         RHCtrw0Bedd4V8S4AD1ymgVlaxNQrnlHi6NHLhlgoO2D+XdPgFyA8MEYeDKspVz684WG
         TOx71JJQYrWBfVP0lhX+zLuG78reTFKAIbEjfAdxBn/VfYWLzlkHcddRjfSN5GMcACi4
         me082VFl42IsfJGg4KJS+2OLGbHBoFOq1YVi9d2vgFjk4BUSaQnr9+58LurPoOllRtQq
         1L+g==
X-Gm-Message-State: AOJu0YwSCwHxGsLlzlZKCXXZSNDkYZ3LvO861Z7ssUW1WWV/Lv11E5j3
	sThDfQ+YkMwKhKDyIAWwuNiO+9dofGJhxC8jWd2tJ35NsnJWQ9OoKAYA
X-Gm-Gg: ASbGnctAu2jURm2OWf6No2+eiHi1SQcG0FQe7Qk5lVuqKRZ4IsodeTr7JmCRL1tBr+5
	eMq9RpSrsUj3SqB7oe+wUDDS/F1WNtpAsMNF4+3Ob4ROhXhjZsL6kYkIoPSwCWZmOxkOsgxjnxe
	fMwnPWRYznmk5wrJUECksIJnYSW2fy36MxIDhm+n+pSMvhKLd8UN4izmxwVjf6Xdm0jFxFZrXmL
	Ttzo6lgpeeWzhhoV4rqUjcsyb5iIkvTo+C5mxgeTooZ6KzcXM9CxObxuK+KpyfvFtAP9aKY2j9N
	E3TMcfPm2aetNqls7rzjdpP5z6cB1O/VDUU13JlscAHeXq+3zMfE0B7bMJynecuiSse7wHddLTV
	IetyAfNG4oK69k+FyFRie5r0VqNIZlMZ7/A==
X-Google-Smtp-Source: AGHT+IHu0GZopGluqp0uQyl1ojTT9d/b2yMDQhhqbCfISDq81c36GE0pwTKpoPV02uDJnSWJtTlK2Q==
X-Received: by 2002:a17:90b:3a81:b0:312:e9d:3fff with SMTP id 98e67ed59e1d1-31e778451b4mr3171198a91.1.1753537948565;
        Sat, 26 Jul 2025 06:52:28 -0700 (PDT)
Received: from SaltyKitkat ([2a0c:9a40:9210:2:be24:11ff:fee6:cbe9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83580856sm1874234a91.38.2025.07.26.06.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:52:28 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: sunk67188@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: search_tree ioctl performance improvements and cleanups
Date: Sat, 26 Jul 2025 21:51:38 +0800
Message-ID: <20250726135214.16000-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250612043311.22955-1-sunk67188@gmail.com>
References: <20250612043311.22955-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series optimizes the search_tree ioctl path used by tools like
compsize and cleans up related code:

Patch 1: Narrow loop variable scope

Patch 2: Early exit for out-of-range keys

    Replace continue with early exit when keys exceed max_key

    Provide measurable performance improvements:
    Cold cache: 34.61s → 30.40s (about 12% improvement)
    Hot cache: 14.19s → 10.57s (about 25% improvement)

Patch 3: Simplify key range checking

    Replace key_in_sk() helper with direct comparisons

    Add ASSERT for min_key validation (safe due to forward search)

    Maintain equivalent functionality with cleaner implementation

These changes optimize a critical path for filesystem analysis tools while
improving code maintainability. The performance gains are particularly
noticeable when scanning large filesystems.

Thanks,
Sun YangKai

---

Changes since v1:

* Replace the WARN_ON with ASSERT, since the condition is a runtime error.
  Suggested by David Sterba.

---

Sun YangKai (3):
  btrfs: narrow loop variable scope in copy_to_sk()
  btrfs: early exit the searching process in search_tree ioctl
  btrfs: replace key_in_sk() with a simple btrfs_key compare

 fs/btrfs/ioctl.c | 55 +++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

-- 
2.50.0


