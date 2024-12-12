Return-Path: <linux-btrfs+bounces-10316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D854D9EE721
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 13:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9945E1886DCE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BE7213E61;
	Thu, 12 Dec 2024 12:54:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2C1714D7;
	Thu, 12 Dec 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008090; cv=none; b=K+w7gUHU/Ae/IrOSMxvJyUOvSeehOjM5EgxC2vbNDNuKxvpKLhIleET4CCnun0OJoySOhHPdHdbhmf4/P8LYIZYZ/oIqpWNhcENxvAhQBJSh2Zo61w61ge0/lwZ1xRGLcGAKTeSUeY4Z+r6slE7RL3pT+6Iaf412nJ17u/+jlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008090; c=relaxed/simple;
	bh=cj3QOIiWTKzKxX5xV/DwC/gpQ+j9r5EIa2WuZCSQLfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwLC8WyWpDaqTmvT7aKIuQ6q7wvAtX681uNzA2r6b2ymMXdhlnG6ITaszxxse/jIyV/EIj6Nm7T1GJgl3Ni11iR0lcYEWrHRiQ6xfA7ZNQOhfyV85nmjrzPK7SXC48rteGeXSq9wFiHAHqj0kG9hFWMBv1MD1Ka7GwkKqzEAwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so1042896a12.2;
        Thu, 12 Dec 2024 04:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008087; x=1734612887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K3LXkF6vdSz2gq/Hqz8occjAgDdUQkiCLkkIuUs/Zc=;
        b=UYWAi6vkmM1bB6jGF3dtGSVkxpx0GgTBNC413gVRkdfzmYBXxTNr3b/SwDRQnGNPL2
         80brjuCGZyYZ1C9kCdPVR+BOdVUHR2oDAeg0Aev1Dr8c2fEz8H0Ofupcmdj638+ZlaW8
         43rRsj6znRw8BBZ5BfPyu7pJW2SUEFv6ZRoc7m1XMFlInFeifJjysbeDO+ppbLe4uSUr
         VOXyMkv9qclvnzgmKve4yesQMfZC2oWpScrJ9LnWuTMWjyW8QTyD9ochlc1zHEcDLdCD
         GUC1zxuePi9Exz8CgUxncPHmT2BfmTtqziuroGNXbQPYjwYl2VtqZ5aNzIPEn/odTZLW
         2liQ==
X-Forwarded-Encrypted: i=1; AJvYcCU61ddKMiFS6X1ejvj1fEGR4TJnlVJsvAxMDHbwNP81aWVjqGlu/BN4PmhA5yufh3DFF3WvujKjNZJpJEIW@vger.kernel.org, AJvYcCUGCaJAPsTml3xJNCjSA4QOOehca5ZCT2OJB023mfxdwMFJelI0nmyT6U5iSibT4IlomzAXW70wHzXZ7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGmr0Qn2YejXysdmTpSrPfQWgeUXB0oidl5U5IXqlWpy5W72x
	CpFqHyOSaYOv2fGaXZV6m+pGlmdFwuNPzqzLZOkYbwFHNaHNU0QV
X-Gm-Gg: ASbGnctCTZGb4kIGFXwTBARLigcmtI1rX/iIvDmS8p/9ycVsa0fCpdIAr9dkg/Q3cjm
	pVGQp74qF9HleD0tzZPYGiEkb1hZ23126GHubydFPbR6DLlYrZhd8pAQ2yvr8xWu16UvaafbPd3
	VYGqV1Ygxk3dgXzXq2tuENrvkw5vAhgmT7BO6nKAR6hS3hQ+KpsY+iN8YChn3nrVDUSAe6dr1gv
	0H/Mx/pXDax47uSB9C2w7p2QKwh46r2++gnCKx4zfOfAOlzezGs1BSoNbT1SgwN19ycSluh4sPn
	Lu7vX2c3GuQrb2KARgAIp6M0rKpmQHxHmn1xNIM=
X-Google-Smtp-Source: AGHT+IETeg4T03CGls7OXkkjorlHltmXhLmucnnjRQ+laZwNFV0+5F68gUAsCmIKYG8BylO0Ov5SnA==
X-Received: by 2002:a05:6402:50cd:b0:5d2:2768:4f10 with SMTP id 4fb4d7f45d1cf-5d63238c8a6mr165537a12.17.1734008086543;
        Thu, 12 Dec 2024 04:54:46 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm10309638a12.52.2024.12.12.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:54:46 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thjumshirn@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] btrfs: reduce repeated calls to btrfs_need_stripe_tree_update()
Date: Thu, 12 Dec 2024 13:54:25 +0100
Message-ID: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241212-btrfs_need_stripe_tree_update-cleanups-166f5e7e894c
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=jth@kernel.org; h=from:subject:message-id; bh=cj3QOIiWTKzKxX5xV/DwC/gpQ+j9r5EIa2WuZCSQLfQ=; b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRH3XnsenPCCSbJW382zTsZM+N7Rtqab03iW4zXv3229 afb7/fqPR2lLAxiXAyyYoosx0Nt90uYHmGfcui1GcwcViaQIQxcnAIwkU1bGP7wZsf8z+DxfKP3 lDnwc9b7DX4u8hlbRKMkz/1nkP3MMjOSkeHOkQpGteLtLwzWHd/Aben17texKXZSk53rFcs1rKa X/uQCAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp; fpr=EC389CABC2C4F25D8600D0D00393969D2D760850
Content-Transfer-Encoding: 8bit

When working on RST backed RAID56 I was looking for a way to plumb the "use
RST or not" decision into the bio submission code and this way found that
we can cache the return of btrfs_need_raid_stripe_tree_update() in the
btrfs_io_context (and btrfs_io_stripe) so there's no need to do multiple
lookups for the same I/O.

Signed-off-by: Johannes Thumshirn <johannes.thjumshirn@wdc.com>
---
Johannes Thumshirn (3):
      btrfs: cache stripe tree usage in io_geometry
      btrfs: cache RAID stripe tree decission in btrfs_io_context
      btrfs: pass btrfs_io_geometry to is_single_device_io

 fs/btrfs/bio.c     |  3 +--
 fs/btrfs/volumes.c | 17 ++++++++++-------
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 13 insertions(+), 9 deletions(-)
---
base-commit: f7e8118a1c33aff911c3ce414d3e832eaba6b36d
change-id: 20241212-btrfs_need_stripe_tree_update-cleanups-166f5e7e894c

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


