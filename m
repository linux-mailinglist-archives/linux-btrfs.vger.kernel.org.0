Return-Path: <linux-btrfs+bounces-7379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D76E95A6A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 23:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258FD1F22809
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7748178378;
	Wed, 21 Aug 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BruqV51d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C513A3E8
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275904; cv=none; b=Zrvwv3nrSEHAgIHyff+zXIXF890Cjs6RIAMXS5Zd3iFZY9V8d6KROsb8+JGnnJzFrvmiwzYYqnIiVr/d8cBkn49KhKALJPHYOYgbm0f0/zOT5Q8bwouSu2PH/1LOK+ygku058gxDZs3FawXuRtLvg98U2xyMciW1BlYds6EUh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275904; c=relaxed/simple;
	bh=H8GdSP2EjhV2e+6TemI5mXMEPE1mhhOlR+7kxKShS+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mQ0CZeCYxzr7KpookwSrDeygxVddQbu9Gcldj1wMv06kYTkv/0vwY2DGbPmPTqjn6R1yWBW8gmPHnBYQYFNzEwW3L8g6H0RV92POD4unTN3tbDeFxL/zw3UwdEZGnRC85aSN6Qv+xMBCMnh6lBzLk28FaGY44qsVaJHcJS041SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BruqV51d; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-70949118d26so155389a34.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275900; x=1724880700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrWaLCMet6s+dAWavkF789pUfClW0cMRPzr3bcI9j8I=;
        b=BruqV51dhzEYAEGAUaK4hlIEpa+5rBzPkCaAl2c6DTPzqIacSsMHcX3/DsySogWQsD
         V72EzPLgVce5re5cuW2eZXxY+tC5VMYGaESa2JwkLvN6AZH3mYp18d80cX9VSmSU4XNb
         ZfOijgxDaP2ja6JnjfjK6jLVJDaJRCZLmibjl8R1gxrKYIXNqybOziz+YAmk0k3G0Ls4
         Vz85j2yntwvE+LRpWDWPIygootTYouPsmA61BhEfNXmSuJTqBlGqI3VFmu5UgfzPzB03
         UM+SiosYF8x2P+4hWWXwBq4e8njI2N/YqJUBXU2qLz0vkSJ274WFwWtrdzyH3oHnfAMX
         MT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275900; x=1724880700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrWaLCMet6s+dAWavkF789pUfClW0cMRPzr3bcI9j8I=;
        b=ibOkZnTHCAL0Sx7IyqcJ/8wVdtR4Zn3i3fdA5xvcDo3LWDVYBmzns/irkm9Cd/rn2L
         sy/T5icrcK4UTf3YYlDOj+LTVYfkzVM2LlQ4XIogqjl3Y2VWoNN7k8XCMewJn1NM0Iwf
         rHxK+yFNe5ia1t9Y8StBQzqphHoCmo5rkLnKp57bGMBZ7p/B4MwF1tPoAxy1mEThA2gk
         4vmmMlXyNMauS4Mbyxy7zY4uDo2XDH63zW5Ypf4RpsqV/5SB8Ydl+NSvqr9SsI6CXMz3
         rC3NYXPy7MKvxYR8qgCbDEmhkpcd2dHX4dJvgwwVZ6lp1pQLjMH7Ey84qD0awX/HtXR1
         JIPg==
X-Gm-Message-State: AOJu0YyJcRnKogTuYXcElovOpaDv1022hGeM/+uAt7FKCQOhDJzSxCl6
	/tLp2bW5VfC66lFSn1A9MgGcVYZGJxNzwd6xFLPgay61XkWARq13EPw+inxx
X-Google-Smtp-Source: AGHT+IG0OKr43MnEEuF7WiAwBsbaXiOhxhAt4qfuTpzbjIqbbEkiN0V1i2CZBZW7GS+JZTLSO4sHGg==
X-Received: by 2002:a05:6870:d14d:b0:270:1708:b7 with SMTP id 586e51a60fabf-2737ef57af6mr3877639fac.28.1724275900339;
        Wed, 21 Aug 2024 14:31:40 -0700 (PDT)
Received: from localhost (fwdproxy-eag-114.fbsv.net. [2a03:2880:3ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273ce73b661sm25497fac.0.2024.08.21.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:31:40 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/2] clean up iget_path, read_locked_inode
Date: Wed, 21 Aug 2024 14:31:01 -0700
Message-ID: <cover.1724267937.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch moves the path allocation from
btrfs_read_locked_inode to btrfs_iget_path. It makes
more sense to handle a path allocation outside of 
read_locked_inode.

The second patch moves the clean up code from
btrfs_iget_path into btrfs_read_locked_inode 
simplifying btrfs_iget_path.

Leo Martins (2):
  btrfs: move path allocation to btrfs_iget_path
  btrfs: move cleanup code to read_locked_inode

 fs/btrfs/inode.c | 125 +++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 63 deletions(-)

-- 
2.43.5


