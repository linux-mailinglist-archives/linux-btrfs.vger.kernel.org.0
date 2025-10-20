Return-Path: <linux-btrfs+bounces-18056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0FBF1D17
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 866C74E97BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0A2320A39;
	Mon, 20 Oct 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NkDWzw97"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D752FC879
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970157; cv=none; b=K3kdhHV2e2+kJytVZ9GegEzUGEFhw8ryuG5Jg/9IV8ek0routbp0Cd6IxQNLaul8j6mch+a+YDdZgOct50+VTPfN87UTDWny86E+6EBfYch2dOLXQhPhiUBgrCzJJX9PeNjZsbnjzbv3mJQZK5woUmWwg41uMemHdJRN5Tv4st4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970157; c=relaxed/simple;
	bh=Oz4IqpFgqpBt3xWql4AOJbfiltk7mMhCp0ZyesQbAQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+LCi1AemdfE0NJVHPi6RLP/8pe838mNI84Cp9e8otOGrZSh9drc2eN8odeIiWgC0f28iCI3+zCKxnrqdzybKlYwWsfDDk9wg7wpXD1+p8Dh8matuNFO7h4RsAsnn87RZfK3zu+G5XCN0LCndTZFqWLmqn1PfTnhRlQgRQFFWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=NkDWzw97; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-591c98ebe90so4887490e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1760970153; x=1761574953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cEsM2UDXWcIxZXOopZ40CiWy0qeR73LhkBnbP4PEKh0=;
        b=NkDWzw97AYFNYcr1z3tdhfLkVNCuRlWEFtiHbZ0gkgVXk/OfsaOjLNMnPpikFcZr0l
         F7atKQNcshb3sBml2yDmIqEF1ZDVKQ/5ysqP+YqSvq+3KbhJQ1dk/+ns1EHHl+n1n8Wz
         FzhqnaekDh9t2XD7xIwOLroSWPDCJcwFVzdcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970153; x=1761574953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEsM2UDXWcIxZXOopZ40CiWy0qeR73LhkBnbP4PEKh0=;
        b=rdNEsP4K7ltkRQ3xn5ilHa/pnE4lyvqVkx2ad8mLtbdTyq/aPObOtzvQTCJGPeKngK
         VXUR6sgsFljbdRFwm4YhIIe+an6W4Z9QBLV8dP8/SVgjzdnHwn7HJvLsOD9HsbnPVhcz
         +DFv2MhS5+z6uHCZpjxZpUYILfY4dVqcEwyUjU2/0aGafI2WE+fv6XaiGxeI942ZRVWX
         Lrt1uO+zAa+aPcvbtT3s6NpI3NG7XUvREFEl2/EB0J6XRMHVOsg014GSSbv27eVxhr+k
         1j2vAK+nNjejwhAljlpZuacXl0TTLpMe7nPEUARL003h/MTg3244dQJVUWhKOaoSGuf1
         aRXA==
X-Gm-Message-State: AOJu0Yx05uVIcCW/Alse7kNkORUR69FyfELgixkmFMglI9/A2/a5lpB9
	owW6qpkbpn/ywrdwrVGkSn+qN5Ev3KDxiDfgZ2P4BVc+C6xgQwk8YVOUNpDNk2P9T+spDBP6i7G
	ZEsF58zg=
X-Gm-Gg: ASbGncuIDbYLjYN870X2RjBcE1H1Bsx7lZbWQYltmVcVEa5kbSza+BkdO/Bp5snKC6X
	MLkXWDjsqV1KbgUmi5r5FYABZQkiiqG4zR3gnCqvYVZYQ6RqjLBb0QR5Iqlp3MNsHVoZ+2GoDcM
	YxzfhqvyujYonCZ79Mli7rJ+4qZDZh4h8tRbZcX9NThquTsHWmcUiCdsGuP3dzTusP4luMJK1wY
	54cOK3T8qa0WiVSE4cLW9lwiYV/4WF1GBKIcLTTzQg9nQghCJBnYrwNG4QojvQTP2qB0VCOWoCA
	Wnnl9z/pIn/rTo0GcSZexe7So2s+A4HUjQpm14LDiWdpqO1CkxtasX3jUG0bSmEb7tbAorXpaO5
	0AFUWiUTRuPCyKABlGDqW4plNEW4495V0sF8dSpov41Jv18P4QkIgWJ+E1OJLJ2tKfHdEcrQt8w
	qfxHo=
X-Google-Smtp-Source: AGHT+IH8CITSDcBr5jj8af68sm6VIVnQn6PvilfsQL4jwYaHj1901Cy23sK3Zh+yLzraL0p3PLkNPw==
X-Received: by 2002:a05:6512:308d:b0:579:f0fc:46f7 with SMTP id 2adb3069b0e04-591d8591a81mr4103987e87.56.1760970152552;
        Mon, 20 Oct 2025 07:22:32 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def16900sm2568436e87.56.2025.10.20.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:22:32 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/2] Kbuild: enable -fms-extensions, make btrfs the first user
Date: Mon, 20 Oct 2025 16:22:26 +0200
Message-ID: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since -fms-extensions once again came up as potentially useful, Linus
suggested that we bite the bullet and enable it.

https://lore.kernel.org/lkml/CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com/

So that's what patch 1 does, and patch 2 puts it to use in the btrfs
case.

Compile-tested only, with gcc (15.2.1) and clang (20.1.8).

Rasmus Villemoes (2):
  Kbuild: enable -fms-extensions
  btrfs: send: make use of -fms-extensions for defining struct fs_path

 Makefile        |  9 +++++++++
 fs/btrfs/send.c | 39 ++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.51.0


