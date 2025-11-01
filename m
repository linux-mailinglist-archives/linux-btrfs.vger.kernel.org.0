Return-Path: <linux-btrfs+bounces-18510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798FC28142
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2B21892256
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE242264BA;
	Sat,  1 Nov 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEVPikw3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105315D1
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762009475; cv=none; b=BxD7h0fs6FoMJSZlPnNstqS3mXzRmUmij035NqW4Oagzd+j31OfduQx/s5QWqZQStJHZVqJ973NNYF3niclJDvL9CyapS/BJCBUZVudKgAkOTymtrx1QVdfGhGhAJSfWwxDijPyjt3Z4k0xegod3rRGmdnuHSDUPMP3KzK9j1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762009475; c=relaxed/simple;
	bh=8/AzzlUS9pf9J+fVpw+CXSaVru4yyPYre7gWD0NR4TE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dDrepyfYPwudm9gP0XTVb9MykCfWIm8dHeP4VWHz0Y0Lhh/l1WfVZ9R7HVf49cDXQuLkbyLE4HJGrrMPI6l7JVDGbKVLanIxwqD84rSu1ENzY7rMGvF2DK9Nx8ZzN0b8lE0GOsGQkgoFiVkWbTcvWg3jbyGn7wFoBCDcqzERWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEVPikw3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so213859f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Nov 2025 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762009471; x=1762614271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KR/hd6QDr0h82iIZliYeKQ6TuSrEWo+U7hdgLEVQaFc=;
        b=aEVPikw3FZFu2t3CLbWtw0jHMFm1FMPOKg2b4kleH5poi/Xd/NnI+qarLA/9oYC7X9
         Ttikr04lhn74tCTUUqKiC7vOxAKWZy3JdVbz4+td8qh7bVmR0NTBx0qo+8OERN04jCEm
         1vFR5j2uTncnqHKDrLWLDPKdH6gbGeGnkrkDT5FjPZ8yFMd+ByLmjQfrCQ4kGn+bIdXO
         M//CW0wHMESuvyhJ9DpIdWZ5lQDT4VrV+y2FRwS1NzoV7kb6g03xGwuAQdyk/aiHzrfv
         FJL3Iy9uoqJVzA6END2U9Z00P8K/2p1dGzMNzTmFbulzEtc3YWOZtPY2hbpg85pTxAQ1
         z8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762009471; x=1762614271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR/hd6QDr0h82iIZliYeKQ6TuSrEWo+U7hdgLEVQaFc=;
        b=Q2v/zg3TknqNqelzwJLJ856S6D59tMlOLtqT3FGbWeHOx+BpQ09LeWB0pDaAXHo7FS
         +vxz+yo3xWWSBDRjv1cmAbQUAWa+KyaZDcxhfNVDua3BSVTZerpFZlT9EhklXXHI03FS
         wqFXS/jjxomOUBQf7nC8pNYuGwn2Hc9KRP6KDsUH61Qs3UQQ4aWPoSnkf07zqfFvwAgX
         a/mhOt06mZW8XNhOcO5BsKxEVOJXWog+fhIBpElD83wNodEi7066mjstjx+nyVyDGwmD
         sVQUi7YCz4jjIGgkFWtKZ9XiCMoRZlmiek3wtqXRcwVccAYxo50zWdNJ+06VN75Wa//r
         hrRg==
X-Gm-Message-State: AOJu0YxSvjgG4hioKwn+CpfDuF8yPThUPekkyUAW/doWO+NPWeiJ5ojY
	ME4g87//v1gdUU1Bkk4g2H/QYtawiQwovdNWzEyjnXxIV/JJdqBJ6yQZW3kkGg==
X-Gm-Gg: ASbGncsVy+31oOIVaXcTwQh0TBiAqrefYAj0A9j5BlDgjfPaE9Yf0+B1bZE6ajQZR7S
	w6w8eFiIul63OkikGlBV2qAblUshKMhNJgz3hTqe9rSEovgJx02nmXu/H44zIEtxyu7N2PWY1qo
	OPW9AUCdkxPgTw4STsDjJ3ktdpPKfTs+XLnGVNSabhKUyRy5n6MX0zlhj9KcHLvDcv0Xv7Jw45Y
	MmtFxgPmo3QCR+UnuH1A2yE1wl20DuEBJrDaUognAuQzUQED9jyQVCMSvo0d/QDP3QXa+aQ8upx
	ai5OsVvsQY+fAsfY6FrFNjAhkKKv9U+iBSzpB4YppU+PzP0MvO1KERCJTjEFq1KqgclGLJZe1Om
	buQuskWFCfZEDFO8z4aKc/HotUwpyQMqA9euyddnyS08Gp8v95yexFzfWAHzFshVoiAfINeOi
X-Google-Smtp-Source: AGHT+IFmp2m1PujyXa5NADEP+RbUNUNezpI2AflY3x1iOhhbA/Mnx+t6T0d9dXj+zi0NCnwM73HRdw==
X-Received: by 2002:a05:6000:25c2:b0:429:b8c7:1848 with SMTP id ffacd0b85a97d-429bcd5c6ccmr6410384f8f.19.1762009471407;
        Sat, 01 Nov 2025 08:04:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c13f62d0sm9379008f8f.44.2025.11.01.08.04.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 08:04:31 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-btrfs@vger.kernel.org
Subject: btrfs bug: SysRq-S SysRq-U don't sync btrfs
Date: Sat,  1 Nov 2025 18:04:25 +0300
Message-ID: <20251101150429.321537-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Press SysRq-S, wait 5 seconds, press SysRq-U, wait 5 seconds, press SysRq-O"
doesn't sync btrfs.

Here is script to reproduce this in Qemu:
https://zerobin.net/?677f7ff6c348d96f#Ka5RFMytXRmyvrwPVp1wuMAgWzaunkJ1+A+/5ahVn2A=

- The bug is reproducible on current master (e53642b87a4f)
- The bug is reproducible with btrfs, but is not reproducible with ext4
- The bug is reproducible both in Qemu and on real hardware
- If I replace SysRq with "sync" or "mount -o remount,ro /disk" command,
the bug disappeares

-- 
Askar Safin

