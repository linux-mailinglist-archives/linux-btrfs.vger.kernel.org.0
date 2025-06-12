Return-Path: <linux-btrfs+bounces-14615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E263BAD66CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 06:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7621886DBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 04:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B861C84CE;
	Thu, 12 Jun 2025 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRODQvDd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FA10E5
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702826; cv=none; b=aeK7oqxA5BOVeFXqMBmsS9r3X2JrTzx171mV9fI1gy8Hn9/54VjtqyUWpvm29kldeMCnJjdJT6QeH9N5bkEAn6j4pIbpSDpQSOyZ3BG3J0LJiQN8rI1LYt+FPCljmf7O6d12gjl2+QZQWztPoBATt17AtWXq5A0pNsNX9KrF31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702826; c=relaxed/simple;
	bh=JvQccTIqvCwft3RYayovW4ikViLTJ1CR9WkET5hu4r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bzlJ7RpwFkhzg8XN6N11LYPhblSA3eOUw8HsN4oefjdyyGTZz0f9lTVMzyfJY/xQOk0EhRSM5aTfI6Kh05AGwYwGmanv2MScKPInIzPxOrBxagYiPj96VIiCrI9P0nB+WFghQV7eMqHdg5TVixEgMSmrDGyGUobwcWlm8bbfN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRODQvDd; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7cee016d9baso2613185a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749702823; x=1750307623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXgpYY/t+oI4z1LvtkA/+DCHJQ9LaAYoWedCZt12xjg=;
        b=nRODQvDd18R7Ql1XS2PMQhXf1POMvvczeCXPL2qV8CPdntWYpA3tpRzdW3MG2yPpEm
         MgkM8BKRRDyd8yeFsJ/r3xNTKkRL/Z9aJWGXOAfDptWsg1UBHBsw7Ztvsmp131htopw5
         jDjYpiiYIqAq1g2mvD7yxA78KUFwmgSDaxdfpkLKGATm9HaQa5l/1EEpp1J6xC4iJVgH
         8uI9RsYApRu3Ucb4CDNVvTnSDxaOjxXwx6nKBcPmEShrlt+hvDFTofwZBTwtwTSe8zjQ
         ZkL6P8NXJhgt9LkYNztxZs71MJTrdugH+qYf+59tPOZ1m3gQw2XmGPULgIWCmLHVcoYe
         wVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749702823; x=1750307623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXgpYY/t+oI4z1LvtkA/+DCHJQ9LaAYoWedCZt12xjg=;
        b=u//59/ZEr7HYE5gePEZ1tyGsVUYLm8HfFr3w3/XfdrLjAJiGM7Li+6uvL/Z4Y746Sz
         9AWZ5/b89qdEVFjmdI0IRkNFA/iOL5xKItIuORirykdQo+GsXVl9BUMxF/eyPQMbLBTV
         qjLA9xYvG0perjjgjvDMyhSO6GDcArinSEYHg1jQ8VdOWhS0GS7kJ0qf1fzMNKAPlQBO
         LJXldqKcsng5L1eTtM1mckeNxgL0HvHO36GhI0tApwL48eNTUq0QPAX5asJ6SZp6ldtN
         8WoeYipG0YF0lnAy2dyCnujF7mYccw4qzIfJtVfAoAhMYvFhAjPaSePIBR0so8wRVOOm
         NubA==
X-Gm-Message-State: AOJu0YyrSCoiRaG4JblVoLZv2b4oyTwVD+vKO8bU9jcLbt7EkR7WG8oR
	0TmTtyfjw5FlfXqw0M4MvdG7Xq9ahdhRHMWxpu/s4mnPsY2B7IMcuPjla+mplgPuSxzRQQ==
X-Gm-Gg: ASbGncvdJq9ArpLl2LZB6FPDBwdGtUu9ZxhPDxdr1AbAMUAWA8ktxtvopCLU1UtATn2
	XEM8fCAyW6NxpWTQtej8fcyn2Tq727gJoPWZCjnsAclx2zxpm+BitvqtYDq0AhaG49pBz3yj6pF
	XEp57pR4ksQsg22AC+PaWoRnp4kbxsusXaLOzb3rNY00jYPfUP1kyBWNTTR9FSFHSMZTzSZAJTQ
	Z+xYtuI/2RooqzET3mElNY5VkTGvM4GrAFIihLI617YD7c+YKDTgmtuqAzhSRT59pDg8D4OIl1P
	XE216grNm7aDfZVyPbkWuEjpGakt0vKukDSr51KwO0RWjDFFNJipII55YkTrAg==
X-Google-Smtp-Source: AGHT+IGkVs5I6oW+WiCGQDB/M1T/PYh/jxi97L2BBpRLb9IJ7DZ3V3SkUAw/AtyATJYlQenaDfQTOg==
X-Received: by 2002:a05:620a:3916:b0:7c7:a574:c6d2 with SMTP id af79cd13be357-7d3a88440bamr316808185a.9.1749702823515;
        Wed, 11 Jun 2025 21:33:43 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c42a28sm5524836d6.83.2025.06.11.21.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 21:33:43 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 0/3] btrfs: search_tree ioctl performance improvements and cleanups
Date: Thu, 12 Jun 2025 12:31:10 +0800
Message-ID: <20250612043311.22955-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series optimizes the search_tree ioctl path used by tools like compsize
and cleans up related code:

Patch 1: Narrow loop variable scope

Patch 2: Early exit for out-of-range keys

    Replaces continue with early exit when keys exceed max_key

    Provides measurable performance improvements:
    Cold cache: 34.61s → 30.40s (about 12% improvement)
    Hot cache: 14.19s → 10.57s (about 25% improvement)

Patch 3: Simplify key range checking

    Replaces key_in_sk() helper with direct comparisons

    Adds WARN_ON for min_key validation (safe due to forward search)

    Maintains equivalent functionality with cleaner implementation

These changes optimize a critical path for filesystem analysis tools while
improving code maintainability. The performance gains are particularly
noticeable when scanning large filesystems.

Thanks,
Sun YangKai

Sun YangKai (3):
  btrfs: narrow loop variable scope in copy_to_sk()
  btrfs: early exit the searching process in search_tree ioctl
  btrfs: replace key_in_sk() with a simple btrfs_key compare

 fs/btrfs/ioctl.c | 55 +++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

-- 
2.49.0


