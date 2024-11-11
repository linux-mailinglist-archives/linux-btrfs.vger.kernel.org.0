Return-Path: <linux-btrfs+bounces-9419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9629C3ADB
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 10:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A811F2254E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E131714D3;
	Mon, 11 Nov 2024 09:28:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB51553AB
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317320; cv=none; b=lcTyr33DIIzwKLQGtQyiYQIcW7CTqxxr3JVRCeEIU2UVS37MSAdgwcK9Zk5TAUfGdz7NBUHQyru/GkqX3NUvMIHh1CeJ/37qeRmaZEogGhG1v/IzB1ocDCuWpENuB2eGTcWBGSzMD4y+3aOTd4AN+6029tFpjvL8QUWMZuUEUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317320; c=relaxed/simple;
	bh=HTRgW83md8apLELbJsrenMNC6QEts4M19C33bRnUCMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nl46KQ3xh8wRuOtk/+Pm0lYIb9eOfzipsLOIdMgrdW8x3qidBx/ZTJ8lWBBVFCqSzd4PgnlV4OkVYo4CRN4F/xPQoCUvyHn1RN04Pf3ctJQ6vAfrV9PiMTRdOTNR8oS2Nolbyp0eWP7ZChR3+hvShS6AhmS8W4A7F+l3nlP0k18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4319399a411so40699765e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 01:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731317317; x=1731922117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O03a+RknWWn7SP8va9iwb8tTlTNByrftLme2QsP4PKY=;
        b=TdzURl57/bqtXFnLLHpKQHYlHnps20Q0NJCfGsBYPR7o6l0amV4jjHIWQDT6dUmTH1
         Ga96TqfDKqupAZt74YsNiQq9PJkloCXkKCYS3Y4Jl/Uf2/tEzxDiiIMhmVZ/eXPbWETC
         +nAMRCGsIlzuItgEZi+6r3hIaMatGESt+35qbVrZrqwmELGd9Fa4dB1VdGpSrKxqlko6
         Cci1cWUpVOv7B8SaNnFqdm5YzGIrdK6yunOvGGnu8ZM1U55WsHIrCUIrQ8XrpnSF8252
         k5rNkFaoZVZkU+4rE5ZXb9zoJ5IMrBEs/ZyChsy1uw7rRBfM3Qk7eqVaE9LdK3VgqRHu
         zhfQ==
X-Gm-Message-State: AOJu0YzOCOtWUclh+uXYEshJSYCUXzouUgiqOoBTcJuv6TyjruGLDXgY
	+Ij7EoRzVv+/6560vwqmiqqGDUg0C7fdmXamc5HOTcxrkh6cauwlkNLFyA==
X-Google-Smtp-Source: AGHT+IFhPXT5Ei8YZsh42JVpgA8O9jgKSyIBFfArU2E6CpProFmQErvGP3N3G1xn709m0VqLmlyKzg==
X-Received: by 2002:a05:600c:3ca8:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-432b7501d59mr98677575e9.10.1731317317168;
        Mon, 11 Nov 2024 01:28:37 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm173711505e9.30.2024.11.11.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:28:36 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 0/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
Date: Mon, 11 Nov 2024 10:28:25 +0100
Message-ID: <cover.1731316882.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shinichiro reported a occassional memory corruption in our CI system with
btrfs/248 that lead to panics. He also managed to reproduce this
corruption reliably on one host. See patch 1/2 for details on the
corruption and the fix, patch 2/2 is a cleanup Damien suggested on top of
the fix to make the code more obvious.

Mark, I've tried your test tool for the encoded read io_uring path, but didn't
succeed building it. Can you please have a look at these patches with an
io_uring hat on?

Johannes Thumshirn (2):
  btrfs: fix use-after-free in btrfs_encoded_read_endio
  btrfs: simplify waiting for encoded read endios

 fs/btrfs/inode.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.43.0


