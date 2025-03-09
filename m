Return-Path: <linux-btrfs+bounces-12113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD07A58165
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 08:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F62188F154
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C9189902;
	Sun,  9 Mar 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxIqp1dR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48A229A2
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Mar 2025 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507127; cv=none; b=MfH6uD8ufq/OBtuVg4lvWfcqVWdCvr5DKmy9jHwTM8S44/qWRrYcH5juXWxA8mwtklmKXRfs7EWBCAlMtLEy1aYYJGFUqW7C3qey+M6WuFhQ7JcPBy+K8o1LiIow7SkAPvW5CxM22D47RM3b920idLP+UYzuyDwRsgbA1HZIaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507127; c=relaxed/simple;
	bh=dSgvz0fQzI6iLmfZWMIhFkW+o7r/3kypGdDJoXJvE5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcX6Z0FlFnz7q4sxrdCsZPbMaPEDLlpSuYJ6gsJL1eCuG6zk1thWDkQLEsUA04f/mX58PVFBbnWeREZe9dHGhY6KO/gifRxLKdAXqmrgyf5/c5RTfQikqWBVfWkT3gD1NT7o/CVeM4hlww8EkJ2PxAvLSqVaQJemSCYFPJJlECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxIqp1dR; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so903352a91.0
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Mar 2025 23:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741507125; x=1742111925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJdTh+gX4hEkk9EWW3nDAjBwUw7Zfa31nL6OGFHHcr4=;
        b=SxIqp1dRaI6c7wk5H1+k6nLeAIskCNMGWvXcT3I5KmuIUP8KxWu6xO+rpJOiFTGksV
         Y7hyXgcpW2Njb9MskQRbE2CePijkzhRMsQnqPvzrwAuzI47dd8U4cSccEMeSs+XVixjY
         nAJn/kb7hYXGVi0ZoYUFkiekSP9UaWugqlTsDvWFuI0GWBT1A8/WirGEe320t93fV5e1
         j14rusugq0t3R0bG1EcWtpEKLBJp+0Vljz7vR4+jhF5B8E8Phpi8y4VWWIPHDU43jyIl
         1xGr9zzw8nzcZ9L94tpVlrbSeuyAK9IS/PzGwop3xT3prbCPZ73ugHtlPhPpyaNnhKTl
         aODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741507125; x=1742111925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJdTh+gX4hEkk9EWW3nDAjBwUw7Zfa31nL6OGFHHcr4=;
        b=QmeCCIR8zbKPhEUj3u+hOrkF9eCAnRO69Rno/o7vbwbcBFTTdJvyP6UUgD6Nevw9aX
         SdjPyUzyA2HHTvGjGkmP3KxQyVDOT1DJn50GrrXnrcq+soDHxTS2hfQeze0n0al695WS
         LHmV8EiLj2P7XBAFnYhe0pNWJ1/LnCQAv4NyK0eROkKjFKuATGIA1OhR6X42C9oSGTGi
         ajLW+hqoujynL8MypVmYVFvGK02oM2ZeoBAw5SOy6gjUBgpYylWngov/ZWS413K8b21F
         3ekDvqr/PCEeY6dO97wIAC+t+98Gh30WGFWMAgKIPTxFnYRxOJflJKQuzbOHp3ngWxgf
         5HBw==
X-Gm-Message-State: AOJu0YyCACZsP4g+5DsAydb4jqvK7haE9YLlUNd0v0+LXTfDwuXFK9Hg
	pjsF7MzHJpsqRryOWnTZ3ngmZZHGHcSqjkBAIQ3pkfyfEmnOqkDsJS8T7q5txkZQ3w==
X-Gm-Gg: ASbGnctC8ZJt+Sd0t0HBdNqtqKXPcMTnuXovXcf4oqp0IfIQYIUOhnNT8zavJQuyLlw
	qAaWi3D/oEfWmKHjC8VZ27XtaW9CGTDsqhmOS0QL5VHOoHNY8S2o7mG4NMN7exWWIwI9an9vqxR
	NlGVBcyJAPDkdDpwONNS/opukptEng3icRZtcMhQTqAPlx2cbxcEPWEW+NtcRAb13CGpeK9eOTf
	hhAdpnlRA+8RBOSeDYCvq5Wmo9YCSBmVP23YtHcUA56jeNbmVNQsvq/LcRKuxlEs/QOKhPYTymC
	mxsHSnk7VLbGIj5MgAgGjhvqzfVoQf5WTog2iESNVKv7kw==
X-Google-Smtp-Source: AGHT+IEfdbfQN3XSSeZgcC1/fJHb/RW03ETawxUCnQG4i6fayV19noDcK/JlY4T5cS3jmRyXGBqyLA==
X-Received: by 2002:a17:902:f684:b0:223:5696:44d6 with SMTP id d9443c01a7336-2254229d0aamr32544625ad.12.1741507124898;
        Sat, 08 Mar 2025 23:58:44 -0800 (PST)
Received: from SaltyKitkat.. ([2403:18c0:5:3e0:98c6:7dff:fe56:ac2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd627sm57045605ad.50.2025.03.08.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 23:58:44 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 0/3] btrfs: random code cleanup
Date: Sun,  9 Mar 2025 15:57:58 +0800
Message-ID: <20250309075820.30999-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are not intented to change any behavior of current code.
Just trying to make the codes easier to read, and, maybe, perform better.
I'm working on btrfs_search_forward(), trying to improve it and fix some
misbehaviors. And I'll send some patches that will change the behavior of
the code later.

I'm new to the maillist, trying to read the implements, and improve it from
my perspective.
If you have any feedback or questions, please let me know :)

Sun YangKai (3):
  btrfs: improve readability in search_ioctl()
  btrfs: remove unnecessary 'found_key' local variable in
    btrfs_search_forward()
  btrfs: avoid redundant slot assignment in btrfs_search_forward()

 fs/btrfs/ctree.c | 12 +++++-------
 fs/btrfs/ioctl.c | 15 +++++++--------
 2 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.48.1


