Return-Path: <linux-btrfs+bounces-7076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1894D906
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 01:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5B028346F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 23:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95616D31B;
	Fri,  9 Aug 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I528Qrxe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D07168490
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245187; cv=none; b=Dh+f/HOG6MKOK9vcAzv197SRe9fPXbnckA5cW+YY4di5oAa8CKuF7C6aoFx7WJuMFkc/4gldGd1sI7cFLaqjtYuNiBct/r+8ZAZ2qybnCO/zOW++mpC8OnbIPTy1IKaNW+InJDo1haV8ml/AQXBg0XCjk2Tv1zvgfvfgc98iOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245187; c=relaxed/simple;
	bh=SZEmlu+42y+Und6aVK9sUNq0bxXZ1XMOE8fywvIn42w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Eop+K9soAPiZQ0JjVLVaZu2acpcaVrgvuvfEg00LMAFSDX/EYhERrV+HzBhvG+mfpv27mKhnbwiJaQplROc8AAR2nCck8/7LRuOReBRxWjkl7ABC4I3yiiXVX4yKuBiyOun58aVMAnOY7+3vzeb80p7lj9W00iFM/C+WTKxsF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I528Qrxe; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3db145c8010so1697555b6e.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723245185; x=1723849985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eth1IVCefAl1AJVWRPro6fbxa6Uz5lHcbGhdOMrnkVQ=;
        b=I528QrxepaJC7Jz38dkqufPd6+PykC1qQ6FOqge81PVBCymOD2C9xBfKpsyUvf/aie
         w6tUqp39Vk999O56/ipZ6xkvm47kbqLmOPwwZNZhxFJim1W/sbOWkPk59xGfcyRXBTa7
         Pph9Q/pJaUKusVqVr6yYbiRURf5VKKygDTRjMo1KGVsYFaD2TlMj/HJ81SYmbqh4157b
         OGhJ7qDCLABXjss1XyJNmWwvbGm5ftgMHi6fEV90fTo6M2bVQ8keUL6vo9sH6mb+CklU
         dbRqVU1MROs+ZakdZiNn/FKF8ZYa6zmIT8f2v//XMEbKxDznobJPUiM8AWasTxqmE2VC
         YqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723245185; x=1723849985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eth1IVCefAl1AJVWRPro6fbxa6Uz5lHcbGhdOMrnkVQ=;
        b=aEiLkcbPPjZm5p1O1WspY2pZCr4U0V6IE3DiO4BcLiQ6qB5n/5aPaHh4E9BD4jesFZ
         KKFK5Zl7/DYaakewuPuypGE6fDwKwS6DqCcGLSUFjcb/EZgHBG+GV0srOU0aZOaTpaCl
         mxD3pYq9BMIPNveIWeJdLe4mqVz5Q0jbEy0LYliVE0hk+R5BkN/MN7yDA7as3J+5EiyO
         BltaNZjWO3QmOVn8YDVRWsSdbUNALCQ8rbZzHe21sQ9uupjwj17tF7snlaFUC5d1AHdo
         a995JEfiWltpeEp6fcbPbXTRREWFX3upENz5tFigX8cUP2oTvq80zmCEnf0kLbwaBg65
         Xhug==
X-Gm-Message-State: AOJu0YznrAOS4VxXj/+7y24ay27+KGA9QpLCCz0bfy/SE1xsuRvnQTI2
	lLdA5P+CHscth+sC5CP6FWg6LH1TrjpgJNKkQjGuUd/4bJ91I+YYZCMv/P3+
X-Google-Smtp-Source: AGHT+IF/eNfIJ+/jI4YSaSbscZs1w73a6Htd2dvsuFhX9zV/LYvSOsqYY3xJicxyruEVvwgF/JeLEA==
X-Received: by 2002:a05:6808:1a20:b0:3d9:e22a:97a4 with SMTP id 5614622812f47-3dc416da61cmr3913860b6e.36.1723245185199;
        Fri, 09 Aug 2024 16:13:05 -0700 (PDT)
Received: from localhost (fwdproxy-eag-001.fbsv.net. [2a03:2880:3ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd06089105sm147729b6e.28.2024.08.09.16.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:13:04 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: add __free attribute and improve xattr cleanup
Date: Fri,  9 Aug 2024 16:11:47 -0700
Message-ID: <cover.1723245033.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch introduces the __free attribute to the btrfs code, allowing
for automatic memory management of certain variables. This attribute enables
the kernel to automatically call a specified function (in this case,
btrfs_free_path()) on a variable when it goes out of scope, ensuring proper
memory release and preventing potential memory leaks.

The second patch applies the __free attribute to the path variable in the
btrfs_getxattr(), btrfs_setxattr(), and btrfs_listxattr() functions, ensuring
that the memory allocated for this variable is properly released when it goes
out of scope. This improves the memory management of xattr operations in
btrfs, reducing the risk of memory-related bugs and improving overall system
stability.

As a next step, I want to extend the use of the __free attribute to other
instances where btrfs_free_path is being manually called.

Leo Martins (2):
  btrfs: use __free in linux/cleanup.h to reduce btrfs_free_path
    boilerplate
  btrfs: use __free to automatically free btrfs_path on exit

 fs/btrfs/ctree.c |  3 ++-
 fs/btrfs/ctree.h |  1 +
 fs/btrfs/xattr.c | 28 ++++++++--------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

-- 
2.43.5


