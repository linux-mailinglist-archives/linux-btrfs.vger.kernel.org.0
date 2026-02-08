Return-Path: <linux-btrfs+bounces-21469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKqKAvECiGm8hAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21469-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:28:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95224107BF3
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA3593003816
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019652BE034;
	Sun,  8 Feb 2026 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0tVtQjI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B53EBF13
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521323; cv=none; b=CGnXzKRBLYnAz30jUvIn6lsj8sEZTmO135eu7UakM3iZQT2F3iIxpRDiinI0nZS3OFZTLPTIdfuqgPcUsYvekjQadKDaBHVuiDe05uWFetXd1gmqbVAIiF8GgQmSYd9dt1a5qKDM1snIANylSXpz2RKxB1oTp+Ip8cnkwJIduHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521323; c=relaxed/simple;
	bh=p8jbBduNbpuiYZGcg60VDK/fWyHMbg3lk4Fhm32kdTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAajuDysk1+YxgsTn2vR/H3PFxyJYhp7LYtROZAfe8Llja4Tcdu+d/n5mPC+CppJl4N3pnGDWm2IeU8WtTdCyRg7tPq3wKXd4Fz7VAWMLCkitdUcc3HxCZ/eGrgDw2y5s6dyzW7P9c+rCOLxG0i1DJvq6SxAeOpRh8oYAeS1YhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0tVtQjI; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64ad9343163so68667d50.3
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 19:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770521322; x=1771126122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLbRqOeA2TpvxAyuA+lErNn40iO43cHGgmJRfA9YGnI=;
        b=l0tVtQjIxUorUNkIqXggS3vfERwQ99JRAuCEQaXLwuMi7yZsaTXW0nm16/s0QduG3C
         mfv5o19srFaqZfJNEDpApLZ7J2hlPoRreHm3+u1y0h6933ZV1CLL/ZUCAA5qs1GBkL8h
         N7L2TtMj00q3hE4HW9pA2j8vEFMYhQW+5+ND3z5yZYzIs0Act79umi1J8FLKuGuBKazD
         XApzGo488/gZAUDOv1R0DEF/NzVzfFuroAayHSxXJeTafspE0MRwnFoaJ4zP0knJW8RW
         DAskB/oyiMLKvblXGq6nAulZ82gdX2wqkiAuyfei9AQPL0OG5h/J9FFvnm/SMV4906Vp
         6Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770521322; x=1771126122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLbRqOeA2TpvxAyuA+lErNn40iO43cHGgmJRfA9YGnI=;
        b=K4ePfqcdXxjFiRXdgEsyC6uWsQ5eVrxkegQABtlDBkh0fGUuDjaHQBQgL8iwMVpaTR
         /ieOCNOM528Vwd4QwMFv+/jVIyoi8r7T4VtZShwbV4HewqnSAlxiCYceWKoPJVzASMJr
         //k1TwMYLchtdJ8yMjwx6JmsU9ZxzSZdVd3u7479682boaQ9tZ3zDseD1h7RGNpKs1Bo
         HxFZqo52DadEGYoRDVs5eaUmQUG+09T2nbEt4fj6/Kl1/VDtcVLe1u38MbH0So+p1Xnz
         QWh+rIibWiC71hWVN4XbHxjL5nZjTIw6A9hdpHD0BJpN49Dg5NFNb941Dhjt6dtIHCiY
         dxPg==
X-Gm-Message-State: AOJu0YwzTPKLn6fjvTpvzuQXo7YnyqGp4eplBfEepLRuPwz0xSXdsl/T
	iblNYgRG13kTsmJ2Qks9sdSZ/Mht8lL+41x+Hjf0kTfmDCifocRySVN6BxEofpGnQvgK/Q==
X-Gm-Gg: AZuq6aIMYxBxH6AXtwtvv/wmij3MdCEEXYQG00BzvSezzFs0SZohaTDuE6O+eK8eTYJ
	WrtntP/hBMOh4DQumu52jU2OdgLltS3NlMYuAOUuD4VJwBoSPDgnrPZ+RAeMwuTmAl4sW+/5iqR
	jsFHpe40QQU0H8nzL4FCx7qPD4Q5bY7t7dLzw9ubIY/v7lE+aZOT0SCuKXF+YIq+jHIBpJQEVSE
	El/FaTh2DemlHlXX1ustExMIB9f6wl8JN1WAEt+RXAkTylhxZC4bYP5bwVJHIWG3TRIiiERZOfK
	GrQqQCMqiz7aEqAkvEMKJ20mXc3cNq9nHGV2CsmAMElcZZzmpLdacIpGpubBCyJa6mRgJ2bhrxh
	R5CvnuTWR2jy9gxWWx7zPObF/4WKuEUDooYG69wzH5RCM8MglHRy3sOx74u/JsmiI9nWOL1MBj5
	nWySfzVrHxk5USs8Hl+Q==
X-Received: by 2002:a05:690c:c510:b0:793:a268:81f with SMTP id 00721157ae682-7952aa39f1fmr55422517b3.2.1770521321874;
        Sat, 07 Feb 2026 19:28:41 -0800 (PST)
Received: from SaltyKitkat ([163.176.176.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a1d8c66sm59956607b3.30.2026.02.07.19.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 19:28:41 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 0/3] btrfs: remove unused return_any parameter from btrfs_search_slot_for_read()
Date: Sun,  8 Feb 2026 11:19:35 +0800
Message-ID: <20260208032705.27040-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21469-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95224107BF3
X-Rspamd-Action: no action

The return_any parameter in btrfs_search_slot_for_read() was designed
to allow falling back to the opposite search direction when no item
is found in the requested direction. However, analysis shows that:

- The vast majority of callers pass return_any=0, meaning the fallback
  logic is effectively dead code for the common case.
  
- The few callers that did pass return_any=1 were doing so unnecessarily

  - get_last_extent() in send.c: There is always a previous item (at
    minimum the inode_item) before an extent data item, making the fallback
    impossible to trigger.
    
  - btrfs_read_qgroup_config() in qgroup.c: When searching from the
    zeroed key (0,0,0) with find_higher=1, there cannot possibly be a
    lower key to fall back to, making return_any=1 logically nonsensical.

This series removes these unnecessary return_any=1 usages (patches 1-2),
then removes the now-unused parameter and associated dead code from
btrfs_search_slot_for_read() (patch 3).

The final result is a significantly simplified interface and implementation,
with no functional change for any existing code path.

Patch 1: Drop pointless return_any fallback in qgroup config reading
Patch 2: Drop unnecessary return_any search in send's get_last_extent()
Patch 3: Remove return_any parameter and simplify implementation

Sun YangKai (3):
  btrfs: qgroup: drop pointless return_any fallback when reading qgroup
    config
  btrfs: send: drop unnecessary return_any search in get_last_extent()
  btrfs: simplify btrfs_search_slot_for_read() by removing return_any
    parameter

 fs/btrfs/ctree.c           | 48 +++++++-------------------------------
 fs/btrfs/ctree.h           |  3 +--
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/qgroup.c          | 10 ++++----
 fs/btrfs/send.c            | 22 ++++++++---------
 5 files changed, 25 insertions(+), 60 deletions(-)

-- 
2.52.0


