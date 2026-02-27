Return-Path: <linux-btrfs+bounces-22075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKeOFzHjoWmUwwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22075-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:32:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4301BBFFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A005730E507C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1218394464;
	Fri, 27 Feb 2026 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG3mcnxz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9638F920
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217086; cv=none; b=BjsjMRCQ0OQqf/cHcVU5TBB/TAEPtcWerMyiw+hZs6puHz1fsvVly3mwPBKSOvfbAXQjmkF73jpjIaJvIYB3DFu1qMta0Aeq1C6t1WebzhCA3hsuc1VFmjqvm+LntMxbu9EpMSlc250Nnp6FaozhDUQRs0u7WCsP+ow3D6/GjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217086; c=relaxed/simple;
	bh=IuAJM7ewLWuW+lMmEWaxGWInm0JuSJTrLjKDVCXOUg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpVPdHQ5ukGxz94zC0USThko4/ul1b0cpqdthGH3ZJajg1/XeZ4KuNdxrsNzgAxIuXNbrhAugsmda2RN4BAVmop3/W3rXtXjj3VtAUGLBnyjd+eOOTRk62xuGVpjBo4FniSI4Gx5tN9xxLcXY40Hf7Syv21vULcRdU7TeC4lKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG3mcnxz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab46931cf1so24841445ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217084; x=1772821884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+UUWyQ4erbExF0G2PX4Z/Tr4sDL1PTXiAYTjLIt6zU=;
        b=fG3mcnxz6MEO5ui5fEdqQ2drBomIkaSzgCdvIPYwPkrMgg2eb+V16sfHLd6nvVJgLa
         KKTe1pvkDzoUxXbv3WulZiQAh2bIrRbrSZnhtLCLeicusGWcBnr1gtMP5MtlnqDYd2xR
         WXC5ict5d1cn90k7hOpV0DDDvY1u8zBJPsiJZ/hvLFjTodqleDMoy6y5i9sdwMJOj/Az
         Bv/pyq0UD0fLdozMCaldFvEXROb7Fi3fVDAOLWyURt8wX5mrVddVO2UEeXu6mj9ZNFtu
         5d6jfyKmDrjfYPbNyCceyHyfWJndRI03rknZagK4jWhZtV9v3fZfTy8FnSw8WFZBr2t2
         7nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217084; x=1772821884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+UUWyQ4erbExF0G2PX4Z/Tr4sDL1PTXiAYTjLIt6zU=;
        b=T4ewgsu6TSnAfokmW8X4Sd1MinSioyOXzd94rqTEMI9NgAUYC8o6f6xsZ2AHoj47wc
         gvWvfeiPposCJw+1bM+sW0v3ltjusa3h5IK/Zju81LDdJyxqmsEEpf30vNOAXddyZ4XI
         zKAOe/WHMal5URnuQ9jnshvT4jo+wCMjrsm3RPAyacZSsxc0cpkpDWRXqE6PJk2nXln8
         nx11GvrQ3kEcvg4ITniW442F/I2UEuOXaek9+aHCHTz/sxtf/slAIFYXv0KgBV2bVjoI
         EI2avYW7ioEL4qfMt1283xgZuhSBCsah54q0tQY0PPjoO7EJfmTNymtYinhgL1eGtmuQ
         061Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdoLri08DkLsqbMNuoRZUn3zL4opAVte5IpnNUYUFP6JCI7dvvYS8Z+RYvArYqwfpBd60oYVRr8aUn4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBwzl1G/UKPAwkCBJmSNjRoCPzeVeXCoFUQ/SJOCjsPDY7Hyw
	RPz2jvkNYIvAxX6mV+XB1oNSr6Tk7DTTFRN8v3G2wRIit/BoxHj63NomwdhdBDo0xJ4=
X-Gm-Gg: ATEYQzx6HRXJR9l6EayrT/0cuuZWHUtmE9oDTWsVAqrFrXC7u1/Oamv8jc3kcpf2HxS
	lsfV82aXy/WbDjO7l0mct5SEEmw0anrVOpK3Li7IoB82nprwuxZkNTk6MQNgVTJc0q+OKmGxR0q
	Tu17kPXOmfEcp73JL0yyesjeYbi11ArGggRc0F82SBl48iNTsw4rABJUu8CsTLU2iQq90ivhduC
	CIGf6WiquAf6kpK//VTYjXppVOCvHK9Y9LXN88l2mgv76tJHD1pNmANeEc7dfONiR9O/j1Uz4lP
	buZhd/oOlwmpnAl962GDCIR5+9PJKjJ659gwSGj3yrMM+J/Sn1krEgXJt4EWgAIC0Q12ScfIQ/6
	BqwI5vPDK8lcT6ZJiUP2c6YlFjyLFCmb4U9y8n+Rv9nR1hS45ac6estOfuwMGWi6DkSTnulxoxW
	FJxXwFU5d7vwjxrOSpYijDYE4A
X-Received: by 2002:a17:902:e88f:b0:2aa:dc83:242c with SMTP id d9443c01a7336-2adf79c2f84mr72959815ad.26.1772217084526;
        Fri, 27 Feb 2026 10:31:24 -0800 (PST)
Received: from archlinux ([103.208.68.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbad2sm61932485ad.34.2026.02.27.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:31:24 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: terrelln@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 0/4] btrfs: replace BUG() and BUG_ON() with error handling
Date: Sat, 28 Feb 2026 00:01:07 +0530
Message-ID: <20260227183111.9311-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22075-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A4301BBFFD
X-Rspamd-Action: no action

Replace BUG() and BUG_ON() calls in compression.c and extent-tree.c
with proper error handling so the kernel does not crash on unexpected
conditions. Also fix checkpatch warnings and errors found in both files.

Adarsh Das (4):
  btrfs: replace BUG() with error handling in compression.c
  btrfs: clean coding style errors and warnings in compression.c
  btrfs: replace BUG() and BUG_ON() with error handling in extent-tree.c
  btrfs: clean coding style errors in extent-tree.c

 fs/btrfs/compression.c | 66 ++++++++++++-------------------
 fs/btrfs/extent-tree.c | 89 +++++++++++++++++++++++++++++++-----------
 2 files changed, 91 insertions(+), 64 deletions(-)

-- 
2.53.0


