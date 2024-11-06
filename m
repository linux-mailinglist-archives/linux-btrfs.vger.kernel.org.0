Return-Path: <linux-btrfs+bounces-9344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848C9BDB43
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 02:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104021C223C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4418A92F;
	Wed,  6 Nov 2024 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="EDoFYNxL";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Jo2LHQna"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4F17B50E
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857183; cv=none; b=ozY1F1YKHwsmaH7XeCfqpfpVIgZhzgqEqzjnKLuO6OQ9KB4um0oRR3m8ZfDv6yhcYvNGijbTDsVpd9Rmvq1uzKtVpQcI7RBzQK3FGm32nC5Zeq8NmFqEBjunMjv8sf79d+ZCaswUYqHiU0HZQoAGWZXujybL3EAXW6/r9tydVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857183; c=relaxed/simple;
	bh=c2uxv5qHguLu+StJ/chrI3QGHYueHDNHFb2zBkZAidc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jd8aLTdY2zm9MpNbA7r98DI6vVj/7msY+AvQnTRfWHwaDIidH7EDzjSJhbudcOBTpiRfCcwfV0L7jxcz+JThVZuTrNkX8Gdu8bva44zf+Yv8u8j0sfQNBaV3BnGp5q23gRW9mXDm+vkvpYsZMWjr8wzeFyp5OhpEkFWIHhX7JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=EDoFYNxL; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Jo2LHQna; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1730856581;
	bh=c2uxv5qHguLu+StJ/chrI3QGHYueHDNHFb2zBkZAidc=;
	h=From:To:Cc:Subject:Date:From;
	b=EDoFYNxLNte275Sv2ULn/bgIQfSeuP+I9nkRE/5N5c5gyYl7OLWr/DViEiY+zSGrp
	 8lr/rPGAk5dX9WPJL29DlIHdyTnGhoo1+GMtGSITpSls3gePsu/2z+882xan+pb0gr
	 N3CHKe5Ab0V7V6XK+YDNJpQh9VNxb3QLf+oEf2mwphJylsYXcuAJVCsWRHMXhYQ0sv
	 3meoTWi0LkYzDBunhJS1MxXGZCX57c04v5CfUI4ALu4cQnxOZBn68HT6Oc6+8ZF7Zt
	 KOJX4ZG0GTE2IYWXIhatVAqq4udhOufysOAIyy8R9+ha3EHGyO2FgKPsB+VJeJ/YYw
	 C2idVWSWxjDFQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 770E76E3
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 10:29:41 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Jo2LHQna;
	dkim-atps=neutral
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id BA6216E3
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 10:29:40 +0900 (JST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e479829c8so7805487b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Nov 2024 17:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1730856580; x=1731461380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd5ICPguw1+lRE+0puBHipb5HB9mk41ModgfZE+n2gQ=;
        b=Jo2LHQna2poi6nbFP/U/wAUb3gGsmwZmKEOW0QlhD2yVZkD81TlnTbGNTd8P1i+4BU
         noMwKxuVUBce6exx0Ig/q0HQePXZNxG8Buo4Pq9iq/Fkchq3D4301vsIawqMJpyNZzI2
         4c3pbFvzBEDdO7guI1f7V2nLBKjYSLl30htksbvXmC7w9TI3+eWgDvmqAa1l9+EC7+L6
         wwuPeqcoN3suZnIu2HVHqXVlYTjE9KSUdi2D/yuYHu+sPIrWXY9p3tEyyLCztPnOLqky
         uSWDGIAV4p7s7xyz1AU0DaoQvn5nCSvCCY4wYPWkMfqWrX5fmUzhx/9i4kv27aio2luW
         8hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856580; x=1731461380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fd5ICPguw1+lRE+0puBHipb5HB9mk41ModgfZE+n2gQ=;
        b=uXpw1DpPGuatyfJF2fqRxxfP8oi1vOzXX46nsuwkH9tlEeYFJAy5qUe7W0ZuJ9bKWt
         zySj8WXvG1r3Kj+UiyyXDRHs+bvwMJUcS4PB+i89UkuIeATMESaUSe7c3uEPLdrvKSaa
         1wbGPzLGSkYL6mqtvAZdGgAhvsL//Pe6a4Ng09515fjjzvWC1x9FQarmbmm7XCsd8REk
         t6EjdxYsgr+isQjh5EjnbHS8QFR7p1HkKsTB+c/7cEkwMpxvUfwMAad3eySRozjuktXb
         dKKTeV2sahxDJrZSGLsRJmTv3+vZ1eAgWZ46aYUcYSyzljLviOPKkGWP2yc+GnK9saGq
         9iNA==
X-Forwarded-Encrypted: i=1; AJvYcCVEDjgFd/c0Xa151M/TA4OZPNDEBq0Rt5Kp3djqi1esrwTgkO0voMa23v11Ty9RKr00SBF4KVAQSklh+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3suHknoCVC6ZBG4XkkaUfHj0Kwc4Q+FVL5HUEUfKTo9viWK/r
	uVBKjjpleiqIzzPHvEijsj7ey5fcopduOKdpf429VmbqbUJ7a8rOOsy6Qr+sr0skt41U+24xKbp
	w/sRHsjDG6xLEZ+JD1+BAEzUYeDnQGrNDym2IS4oOxE6Sw3ArWvEUXlpdtGjV9A==
X-Received: by 2002:a05:6a20:6728:b0:1da:5bb:f8ca with SMTP id adf61e73a8af0-1da05bbfd2cmr26539215637.0.1730856579798;
        Tue, 05 Nov 2024 17:29:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7as1amWFonIQwC5GIbgRZsm4z0xynOmhDngNYPoKhimG9557YG5ncgOG/jmOKaxshE0BTBw==
X-Received: by 2002:a05:6a20:6728:b0:1da:5bb:f8ca with SMTP id adf61e73a8af0-1da05bbfd2cmr26539206637.0.1730856579488;
        Tue, 05 Nov 2024 17:29:39 -0800 (PST)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a525494sm211251a91.10.2024.11.05.17.29.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2024 17:29:39 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Tom Rini <trini@konsulko.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	linux-btrfs@vger.kernel.org,
	u-boot@lists.denx.de
Subject: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on 'load'
Date: Wed,  6 Nov 2024 10:29:17 +0900
Message-Id: <20241106012918.1395878-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running commands such as 'load mmc 2:1 $addr $path' when path does not
exists historically do not print any error on filesystems such as ext4
or fat.
Changing the root filesystem to btrfs would make existing boot script
print 'Cannot lookup file xxx' errors, confusing customers wondering if
there is a problem when the mmc load command was used in a if (for
example to load boot.scr conditionally)

Make that printf a debug message so it is not displayed by default, like
it is on other filesystems

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
iirc this also used to trip up some test in test/fs but I don't recall
what.

It might make sense to print that error but I think we ought to be
coherent and either print it for all fs or none; but if we print it
we'll need to prepare a new command to test file existence before
loading it.

Thanks!

 fs/btrfs/btrfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 350cff0cbca0..f3087f690fa4 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -193,7 +193,7 @@ int btrfs_size(const char *file, loff_t *size)
 	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
 				file, &root, &ino, &type, 40);
 	if (ret < 0) {
-		printf("Cannot lookup file %s\n", file);
+		debug("Cannot lookup file %s\n", file);
 		return ret;
 	}
 	if (type != BTRFS_FT_REG_FILE) {
-- 
2.39.5



