Return-Path: <linux-btrfs+bounces-7343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD4958F12
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 22:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E41284F84
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591A1C3F08;
	Tue, 20 Aug 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIMT1Jgb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAB1C0DCA
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184830; cv=none; b=C9Ha1k+c1LgQHDVb/M6gO3LIE5lb9dHXEn9rox1YvLjgJIPspKom7co/GsgjpLm/xBsJYeJ5ztM3gO6JYsDsQAJtAjWFFTJiLucJ7gshB9YdKszZp146I4h8Ro45+8mxLj9u3YoIPI9SyIEAK8/eyass+sw0Ql40yM3c9ihiWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184830; c=relaxed/simple;
	bh=BBME4WMHaoj8QL5oA2PzbWonRxCrwZBeNohEtj2z4J0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hu+Io4tJRFF5ws5fu9vc/p4jAjYT1lbbl+a3mFNAZJ2LAms/4gvR2VvQbZkMvQdopT0Xy2qXSkiMiO5Mya6rm7Jy2z73Col5xNEEA9zTkoWHlqsXXvitx0dGveS7VLzO89RRSlr3yDfLzaA0ciyzd3WxaFs15yeoBeZEAZTNijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIMT1Jgb; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5d5bb2ac2ddso45100eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724184827; x=1724789627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgzvHmZ+wa58vSHTqyiTkA+CYP8BETSzqL2OvY8hMIk=;
        b=jIMT1JgbbaxGZLNkOeXvYZ9pEPuS3nCdePQWMXd+TmSlXeCI5vmRgGJvUeZM+E/Sda
         kwxSUbF893ZwJMj907HIQZZCzpWVz7Hv/2Z9nC6jmLjoJAMSUtVjE572D91NddW+1BxB
         CpXVvGoKCYG/Mwt00OVFES1IsZKLzSjcrJYLbuXdsAf2ZS84kYg0Db2MCMo51izIuyfd
         LY+dCwZZFRcGP/s4WwDdfMaTXxSgx9jj+0G9HTY6CRfGRBIS9YOczke2OAt4ngQ67lQ2
         WTDqV3owypQq3xMmaFcEZtMbHLieKmWZV5OUC77bKJHPVE3Rv+mjg/+PmhbY1+fwfelC
         GwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724184827; x=1724789627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgzvHmZ+wa58vSHTqyiTkA+CYP8BETSzqL2OvY8hMIk=;
        b=p4QHCd3y72oGT7OvgxiZRrd5KfdWr+ALp3oaNSsS9h9i6iG2e4Zi0+AwlRiyxS1WaH
         OS45vBfy/EaeuIEGcUUL1gQn3FtJUbbEbdIbRsAwoUptmG6yqwvlKytmn7911kO59bFr
         JtKIAyrjs1Mep1/9nH4EhHDxu7VhsFRAntA/nHBLkNBhfMTdBvmILHwX8yQA6jEcJ5di
         /KZAAGHfBv9RQQeGDoNIcMF30hL4jnz+9yYHWmk+YzRkanD0Ka/7wIfDX54Sfq2ZAurU
         NdwBqw8IdOPKQgZeaI+vE79bIEzLsxYdPU4/Kd0DnTvBtkSWIQjO0uQutD78ImrA3Qqw
         Gx0Q==
X-Gm-Message-State: AOJu0YwrlAnM5WAUl7fA5VsNATwEyppeAPvZPjbG4OLh0UGDxsRkSwL3
	lMtM5xawl665nFZ6sLKsK9jJV2vW4PVM5YrpX7TjIq5E907TzTl9vJAVWs5A
X-Google-Smtp-Source: AGHT+IGq4Zm/gDieyIMrxje7enQocs9X6UaitrEi7QIg0lvCRXIIYJ+8MxfAxC7xCSmyKDCpZIBOvw==
X-Received: by 2002:a05:6820:2017:b0:5da:6795:a803 with SMTP id 006d021491bc7-5dca28b3472mr77388eaf.0.1724184827373;
        Tue, 20 Aug 2024 13:13:47 -0700 (PDT)
Received: from localhost (fwdproxy-eag-005.fbsv.net. [2a03:2880:3ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dc93a5bcd0sm584773eaf.1.2024.08.20.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:13:47 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs: clean up btrfs_iget, btrfs_iget_path usage
Date: Tue, 20 Aug 2024 13:13:17 -0700
Message-ID: <cover.1724184314.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch moves the path allocation from inside
btrfs_read_locked_inode to btrfs_iget. This makes the code easier to
reason about as it is clear where the allocation occurs and who is in
charge of freeing the path.

The second patch moves the clean up code from btrfs_iget_path into
btrfs_read_locked_inode simplifyiung btrfs_iget_path.

Version 2 includes the modifications suggested by David Sterba:
Patch 1/2:
	- Added an ASSERT(path) to make sure that btrfs_read_locked_inode is
	never called with a null path.
	- Fixed btrfs_iget to more closely match btrfs standards.
	  Contiguous declaration at the top, with no non-trivial
	  assignments.

Leo Martins (2):
  btrfs: remove conditional path allocation from read_locked_inode, add
    path allocation to iget
  btrfs: move clean up code from btrfs_iget_path to
    btrfs_read_locked_inode

 fs/btrfs/inode.c | 128 +++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

-- 
2.43.5


