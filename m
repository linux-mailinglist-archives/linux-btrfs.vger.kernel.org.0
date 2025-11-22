Return-Path: <linux-btrfs+bounces-19265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE5C7C8A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 07:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A883A7887
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C0023EABF;
	Sat, 22 Nov 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG0boWu+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BB36D4E5
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763793393; cv=none; b=thHVhfmzy30L0ZsWcwXgQAHZQJ3jY23mKmvHGh3nL6ckjVVUwsyK3J5x13ZBFLqlkTj1Y933sqs5MrBskIO5QGjtAeAHNlMZYXiZr+LZgaM1UK8ITGsQFYAzr6Ryd+6GS84fEHQxQpArCmnOVfqhWskMO1P5tbZsDYFOW9KJHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763793393; c=relaxed/simple;
	bh=4oav0DfQLCEI5qsUgCf9TIDEcMaaBFhRBy7nz1Z2ZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8DtI6SS2GMGmQgHvy5UEuBfh5J+LLxH7uhUxxYAepxUchW5eqhByko+5+I3P2ZWMIy/M1cEqiOYN5rWGS8cA5rxJFWIcBQwxPSLMpsP48kd7YcSe503UqcrSv06mfmJzJVIFI934U+zx/cAeRh5J7JyqjLKdTtsU6lBB87+YF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG0boWu+; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-343e2e1a580so497606a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 22:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793391; x=1764398191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh8qmSduDovWLioVoJdo5h+bi68i92qY4Z+USlP/Dtg=;
        b=mG0boWu+xumEepDJPR6IAckTE6wsPDNOAy+f9tMIkkfU4+HD+5bTVUF6z1C3vLGwQh
         jiq1JyFNrPjkV9dpm3c8NF3OWJq9oOL4escTO+aLif3AwPMuinZZfSOSRfZcWXKta7HQ
         sLRiRSK8EuGwuvBU6TbZJM4hPhXrP+CePSnGLDLDFvJ9ZIFkMNf/+qFy/ciWknk2KBAI
         3EdP1c0cVoQHBP3nli/MRXCQNTs9nqxF6nVKmnPe7KUKRq6unIwW5OUtG7abNm7EvY0M
         Eko40eYoX6zB+NwvLtceWx0yDwf6W4vpbtXI/cusdbLPeZp1Ru41SJAK2J/QjYjUl8As
         s1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793391; x=1764398191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh8qmSduDovWLioVoJdo5h+bi68i92qY4Z+USlP/Dtg=;
        b=reYSg+RdMDgTF/YnJ6mJoYoIGHrJr6cW+9oKDi0nNCbeQFhRXjP/hk2nXASs9cdEPR
         GMxY1xZA4h2ztZPCKJkniLSdSBXBiD6cObPzTZRGJkz1To2qm4ZhnmAO5YA+007zNXXZ
         VFa8lShTrLQptf3ALUOEKAJy76Det43L4cx4PAvuKV4ZAQJmNujUh3TPm883cQcYTUSR
         mZy9JiTUZ+8Lu7RJ1jpA2mr1A3IAut7qBnA5VyD7p4rvOq8z1S8T6xfYajAPm3otAepH
         83g9AuzzsjUT9g9Z1WZ96213r7iZlHtTI7cJBqAair7UIHWn0UQLyDMeOov+sEJHi4NI
         /Q5g==
X-Gm-Message-State: AOJu0YyTKQI16Ca2boliaS0vW4LM4/5+yGjeVTwVoVFc2qyW5S4r461L
	5XZLBXY8kEk/B0+padIHZy9J+OIa3Pe2WlS0Ad111vcKpRHrBKFCwbrqbToVdariHszVZqIy
X-Gm-Gg: ASbGnctkOwQ0LTvGicIDPuJVrWxGF+RzMR+8TPk8q9Dok65dE69SMC8Z9RwdHFKSSeo
	9iTNSmwWZUnThqX5Uy1fshQOFQ8dSZXPrAxId7rbc25/L4S688qFWPGBD8EIIGm+7tVJpwsiRty
	uPKRe5NKbS4k60HYc8Mbn5w13SFKCfTBVgzqaybom2pzdEORNSBz7Y9nR98DOaj92q9HdG5eNXB
	PgIB6UP6NOebVko9L8u9Zo+aYq7pqT7y82+nnukzz+UtX0pWSXaERGGm4LPNOvMGyJ1Tmqptqk+
	0ltioGQcHiIjxL1G87sZ+HQF0z96idSODTakZLyaFYFS3eT+wfmq3fr/OiZg8YwO566V4rk7SAQ
	q118SpI2tMMJC9dv2+ykc6J4wnWDIXPr59uZjQMQxssBu0dURBRHjTW24NFGNYSJr9hCOVEdOVy
	nPC8sNQ5mJfYJtj31da3PF8w==
X-Google-Smtp-Source: AGHT+IGeGIWVqkkCvtOg5p8U1Lwb88CYpTuHrUsM0Q3O55mEY9czhahNwm1gPubFumOmvVqvu+5TMw==
X-Received: by 2002:a17:903:3ba5:b0:295:745a:800a with SMTP id d9443c01a7336-29b6be83eb7mr31169885ad.2.1763793391334;
        Fri, 21 Nov 2025 22:36:31 -0800 (PST)
Received: from SaltyKitkat ([203.106.195.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ada18sm75555515ad.90.2025.11.21.22.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 22:36:30 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 0/2] btrfs: use true/false and simplify boolean parameters in btrfs_{inc,dec}_ref
Date: Sat, 22 Nov 2025 14:00:42 +0800
Message-ID: <20251122063516.4516-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tiny series removes the last 0/1 integer literals passed to
btrfs_inc_ref() / btrfs_dec_ref() and replaces the open-coded
if/else blocks with concise boolean expressions.

Patch 1 switches the callsites to the self-documenting true/false
constants, eliminating the implicit bool <-> int mixing.

Patch 2 folds the remaining if/else ladders into a single line
using the condition directly, which shrinks the code and makes the
intent obvious.

No functional change.

[Changelog]

v2:

- Introduce local variable for the conditions in patch 2, suggested by Boris

- Merge the non-zero ret handling blocks in btrfs_copy_root()

Sun YangKai (2):
  btrfs: use true/false for boolean parameters in btrfs_{inc,dec}_ref
  btrfs: simplify boolean argument for btrfs_{inc,dec}_ref

 fs/btrfs/ctree.c       | 46 +++++++++++++++---------------------------
 fs/btrfs/extent-tree.c | 21 +++++++------------
 2 files changed, 23 insertions(+), 44 deletions(-)

-- 
2.51.2


