Return-Path: <linux-btrfs+bounces-7172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28246950DF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 22:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F36283E43
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9621A7073;
	Tue, 13 Aug 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/AdrisK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5C1A4F2E
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580928; cv=none; b=QWLQFHeKls03VfZwDrHM19zcZYjTcY0CVmzBUReqPJP9+B4VTa2M78ZSi/TYR20vrihIVpsdckZnxSjO9c/AljHQzg8QLy5IRVP5cpJg8++Ex8jF346/XMmNoCeAyBAyGt+gH491a/+FyjGTf0oTFkUxUYmf+TUPt7HbAfZ++sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580928; c=relaxed/simple;
	bh=6gjUZaNfnL2GOHdN+bC3PBQ94V0RZUC+xxt/N1kaLCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jElpwVj18DV80VdPWrl6rpB7naVwtcLYkQLW2cndy9WSpcS5BQ302FLB2dXPtwPbRDzDBMFTCpZ2L89paavBcBvW2gLFhX6VfsCAIOaFyNyBOckrYZIu3BVnVtN2o7NyV0hVcdViAFjKMvnX6vAtPHZ/cocC/+HRdGj9toy2pU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/AdrisK; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3db51133978so4069791b6e.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723580924; x=1724185724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HI978QHb8t2A8hFOYIPLni1KVdxneWeqBM1CK2HPp6Q=;
        b=O/AdrisK09OSXzS5swyhZPRygyTBjMzQ0FVUDzkdRC8XNHGoSf7jRx6kW06pg73d3r
         F4qBuzZUAsCKfCQu2DfC7wqAo1Ynis7YVCzDjGm13VFAmbq2bmP7U69jxWBqE9sJ6iW0
         KemQaiy66GObMDppDVPGZXb2KVGdbV+L1QXew0G0vskBRW3ZFYaAHJ4hVWNuyMkmLX5H
         QGCHFfyjbtH2xA2OX3dob5lTPpEWOwT8pMY0tchogNtJKILXJU9kTGPZAUxRomohKd9r
         xPy7qsjbjrU3jHKRm7MLl19+yKAQM3HHMYFxe8LnkrmnO3nFZNHQN2uVR1BRU1vwTeyp
         jM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580924; x=1724185724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI978QHb8t2A8hFOYIPLni1KVdxneWeqBM1CK2HPp6Q=;
        b=FQv+0ZzBC0hnvnIosHDa1B7keZFG39bmmmvy8rPuyGBkZV/2iHEr8J9ry4I/kHP4h/
         Ea050Df6JuKaw6PYWAowiHC/meHXYJb+3o6Fl5zOFONADEb0vQIATSEmXfuMjxK8sott
         3SE50dQcujD4qvLfRZ5uQkYi9Fbc2AOe7QOKAg9n+lVmPyF6Zt41kMBz7dya5/SpOm28
         /zCPrA1xxi8szXZiCo0DJrstZRKJYHYRzxrbIWf0J8qxDE3pwcNzV2Du1fkDWCeSmgwW
         jfB01Ft0gd4ioKm1rbQmTjmCi05JSLRjgiah4yfoXKqB8Fu8wRkXQCkpmMjy/LphbdJG
         wAvA==
X-Gm-Message-State: AOJu0YzypBd4/kDiBArMp2A2ibHHAbF9+9zeh2Awqe05/7rkyxtHO6qP
	1eCFdJd+3ndqSSSvcoIJIykYebT+6vMZ1OH+FnAPMSyHHYJ5tYvjWK8SrfPO
X-Google-Smtp-Source: AGHT+IFAeIZSYlhKxR05pN8DGHKWL85rJ0T8n7AIwPpD8JoVlVCHqybQhpfRx5wX3BKKIIYFECcqVw==
X-Received: by 2002:a05:6870:8186:b0:261:12a8:5b69 with SMTP id 586e51a60fabf-26fe5a4178emr882089fac.18.1723580924490;
        Tue, 13 Aug 2024 13:28:44 -0700 (PDT)
Received: from localhost (fwdproxy-eag-006.fbsv.net. [2a03:2880:3ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c92d2decdsm630406a34.58.2024.08.13.13.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:28:44 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: clean up btrfs_iget, btrfs_iget_path usage
Date: Tue, 13 Aug 2024 13:27:32 -0700
Message-ID: <cover.1723580508.git.loemra.dev@gmail.com>
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

Leo Martins (2):
  btrfs: remove conditional path allocation from read_locked_inode, add
    path allocation to iget
  btrfs: move clean up code from btrfs_iget_path to
    btrfs_read_locked_inode

 fs/btrfs/inode.c | 123 ++++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 61 deletions(-)

-- 
2.43.5


