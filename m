Return-Path: <linux-btrfs+bounces-8681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22B9963AC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 10:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69211C2178F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FB2191F85;
	Wed,  9 Oct 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Eu3Z13d7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89088152196
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463537; cv=none; b=epog6D3vI/btq551lZ++JCF5z4CzdhBslIFeIak/ExbFtOHaYHgbw0f5gFX89HeoOgQBav59BkQwpBmil9CY/CIc3KLXSiG9OTcWygue5P/+YQBhagGhAUDzm6J8nAWnPBON4kwLxqwvedeV11Nyeh3hVemmESFtDfaxFRFo8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463537; c=relaxed/simple;
	bh=/8jHSgBJrPY2P17JIO9vZWYY0hb9fdfz69Z7F8WKP+g=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=eezE2pc35FaoqBq2wUBpoAaCLsIpvtRGsbIXf+sp6uXp+8xAybRb8iLZcHJvHiFxDEmyCLS5jbZhLq6kxrjJWzLuNAy+RR15SzYLLXNIHFffMfpgBoEc/ARFD2Bmd+yqkS3utIzYT9gsVgNc0nz66FahJ/PdB+dX7jNP7RTFpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Eu3Z13d7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cdac05af9so6044515f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 01:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728463532; x=1729068332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKOl9qL7vGLDJYH66DYqcv1dtqxSuMbWYFM7/+4PJJQ=;
        b=Eu3Z13d7TP1BBxyz2kRkofRLdQSosClo5I1GHi/LTYEKkeRf6fysCPgtqtS7/U0mHs
         LOj1Dd/hWW+43L3JJaaIXA2OUy3ddEljL8/PruoeLG9KS0Vz6WA0ZQv677YPXeqTsJJn
         s6BCPb+ESLIBKrzmapnXvKcZyvWlXsdrFIhO6tvsOrzZRREYwvvEX/97ipILNyuD0336
         1kmRS3e8BJFz+gBe7AO41bbdBK2Ox8j0HdnDZE+1JQ515/jtcfFSgJX0AoQ8oDj0NFlQ
         t5NmHSD+YSTdnAx/dz98R8mCbn7kMPo/0Xo0ZvzwkG7p/aM78niPBOmUnZwTv9QPHl/R
         68HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463532; x=1729068332;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKOl9qL7vGLDJYH66DYqcv1dtqxSuMbWYFM7/+4PJJQ=;
        b=dZR/zPrK2249B6f9T7AxXhjzd9sVFTrMqWgFF0GNv7VzuPQNeZJGZgG0MeeT1+L8nN
         QIAqwIu2pf8dG7gqYxHS32c6w5ERsfmagpZIMK97Pqme66B83PSzRPkkqTOeBDEiO6oO
         IvZ2UKZzuM+I/W2lRFjJobeRNRn34GS1UgbvB/TnTNnuJU3RqIMmlfmfg6IIvxyBj+jK
         XHGAQ6a3P+u3+Vnu0sxIsCAsxMdRYyL91icAcOTdyKIojGOnye4uqloKLZkKRao9ztSJ
         ccZAvlQPTm2lzGP91SQTgsbGu2LZpHPX2zig3KX6Gcm0/MCGrgGEoX50sYODvq/fwFkL
         BHVw==
X-Forwarded-Encrypted: i=1; AJvYcCXCRb+u++y/eLOpd8dREzvHyncCCqPU0qhMB30IzTUEatdfQw2+Z/pzJEyHqylqJTErmvOr+eciLsm8bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5a3k/+YI2B06sowlrOVWSJkRCRqosuFl1MxEzeB4WFuNGbWQl
	a3sU77enRyEaHflQfu04LgXkjTfL6X3B1WXuAS9YQ0Xx0zZlgZe3zCFQEIVbt5JmgMCkANtxBaE
	UHoo=
X-Google-Smtp-Source: AGHT+IHyhhOK3iM8k8MKDaYRfeq6S2g6hd9hQolq77yGMXfXwRcGlKg/SJgZiiCRW5r3xr/EmrkZkw==
X-Received: by 2002:adf:ed46:0:b0:37c:f96c:a089 with SMTP id ffacd0b85a97d-37d3aa5882cmr1368994f8f.31.1728463532309;
        Wed, 09 Oct 2024 01:45:32 -0700 (PDT)
Received: from [10.202.80.134] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afc7csm66578465ad.20.2024.10.09.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:45:31 -0700 (PDT)
Message-ID: <9d7ef6a9de1cdd2bbb6d91a407905254c4784c68.camel@suse.com>
Subject: [PATCH] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: lan@suse.com
Date: Wed, 09 Oct 2024 16:45:37 +0800
Autocrypt: addr=lan@suse.com; prefer-encrypt=mutual; keydata=mQENBFvqfKcBCADKdcrLxNKpkBPfxZwVu1Q3ADpyWdnXZfyQOIO+1Z/WSDeXgr70HUhk/zu81WoO5WyXMK3N1dcS4KrOdNOmDp0H4G5hR+BIkgbIJpo4ekYWVdrAMT8oJgX5EgSIeuDdn2ZJ7K0EDLX9M7969gaw2nHWgBzj/ALGFdCE8zYkZAfPrwN80M5Xl+NBvOrTMypW78WOg5NdGd3E4jjgbKreHFdc9/Bmp2XKQKhjClelfM5aThhsM9wljzWdX1frN2AoAomHKuxKJGvZf30eHoXAs/ikHM4cvoUcY/8H8VgJO3mQMYEFWJR6qSbnfdy3T9Ns/Xy5QGj/XmATwhDg3BMBwvEZABEBAAG0FkFuIExvbmcgPGxhbkBzdXNlLmNvbT6JAU4EEwEIADgWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBmwA3KtD5SBuAwCACDifSf/raZ05H/0l2xAjZo9JFrWib391QLNbDYFi+Nm7nJ3ATse33ibLheOP0hJ07bsZo7uKNio8DIHDZ5CsTMd21ZvvJlNGT+l9BQV/OLRExCTcK9CpLcHoEI3M1niqL42QjVZPkKcjSwbTCa8mySNmIl64K0YTq1HnuWxShTHNlLBBkId9OMEnztgp9Ke4g+SxcU2+058v8ZTnM5wUp6fMsQelsfigJJfRqHbpy6Fap3XIY+1gKuNVIdyKWXovxtwd++fADyZVh/Zh5IKgp/1HyWE9g0MG6TUzJ+LV57jOrIJJbzl39HUp+5mFBI+RSHiJjoBZAQ7diUzT7+ns+0uQENBFvqfKcBCADCPC4telre7E8pAZITzcVsl1BP3PoMAaow4gh1SOO44J34GHJS7CRqpt4YfbPBEVmFZQiJEhb0GL2KH
 qg7J8hO7J9fmpEiCe1Vv+cK8DSxygXXL0fltVkQlgOjFlzYks+tv g58qti7uykoyavLPSu7yuGvDtzIxB3lXwUnvmS0X8MTBFIdK0s4vJOu/2cDIAnYCNdypZ8H44XtYZVDdB9r4E253y35Nd1QDjJFu/8BQxQXK5sReIYl5fRtz+4TzZQPxWt3/j62RmjY5elPEBTd2q4K6reqRuIwDBXjTWjEKylx9yw47nMH7TzIrXpSWLG08+F8Cb9KhUJysBN4tJY1ABEBAAGJATYEGAEIACAWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbDAAKCRBmwA3KtD5SBlJuCACzhZDj5+zuuqYMl07AiV5BqOkGmjghybACLtHjMZDbFOmxnvt7GOfTdf7ug1YguQQI6xIssqzGvXTJVgIfTP38dOSAssrYp78VyFtcAZMiN25GxOOqYlpwhKH1PAr04Ylizz/EZlbfCQ8XCFuTziZ7HwEyjTkvs5XUYJObEhj2Sv9ebhwm3vTZv0VTb8+BpxyQuuGYYakbH94D5Ne5gAC6FaCevXdeqjSCTzV6NZ5seldc3FogQ+TB+riX4G4SA4Nq36Xt4hpAoDoZhh25KsH/9Kq65+eyYKsCnpY+N3f4SAEf5NEODmGF9eKC0K8XcjhXGcpDmnae2tUnjWnjLBXO
Organization: SUSE QE LSG, QE 2, Beijing
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

parse-dev-tree.awk and parse-extent-tree.awk are used by generic/746.
We need to make sure them are installed, otherwise generic/746 will
have problems if fstests is installed via "make install".
---
 src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index 3097c29e..a0396332 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -38,7 +38,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize
preallo_rw_pattern_reader \

 EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
              btrfs_crc32c_forged_name.py popdir.pl popattr.py \
-             soak_duration.awk
+             soak_duration.awk parse-dev-tree.awk parse-extent-
tree.awk

 SUBDIRS =3D log-writes perf

--=20
2.43.0


