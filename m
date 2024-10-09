Return-Path: <linux-btrfs+bounces-8733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619249970F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9F2869E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1C1E7C0B;
	Wed,  9 Oct 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e7NvO40G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0C1E47DF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489377; cv=none; b=lpRL2KIHGNcktVBTZet6xcZMZ2uXdjI7uLFm1blSqr4GeOhIftP1fsEDP1UZpuocJ2Ha71XDfBK87IQBEjr/p2BG0iIXB3BaKMM4bL6kD9EIaar55WZN3C7cwmRAjrFUSsaitIvAxPi1yoGST9G9KwqvN0Ld+8o2ALasiOkKmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489377; c=relaxed/simple;
	bh=O7csKkyAUtW73EmBoE0yxykwnLZJ8NxHoBzPx8rkQxo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Iw95lw7lgPPriI/gf3BtnRQHLn0UuVIfmghprwY+/qhkgRqzdVjHNgpPnyW+FPd4mvHrWDzF0Ou012DSiG70Cs1rXi3ayhou0uC93NOV/e27paXYv5gB2oJhMLeXOiIuVpCAdAtdX5d0n5DlZKFrQrfOCocGee3Ovy9FNYnH8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e7NvO40G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d2ddb61c8so1906881f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728489373; x=1729094173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xt+wLZV2LxzPNz2lSLFTi3nnfmZ6/6WPzHA17tFzTGg=;
        b=e7NvO40GZ1Yr89GuVLN3CcSbcDntjoFB7WeSS3mk7chASQAzm8N1GJDHU+sT6uqo14
         HhEkIoCPSNhWP9A5/0rIWu/uk/zMra2oSEoHDPiE4v3V+ngtS51n7kyfpZqzl2X87+25
         PHrJfC1HVKy6QEzCbs6LGycM85SQDPu4F3KUAWFr+oUtOxVywweHyiShF1XQn5oAvsJG
         V3ET/hnoi3L0Wwik0goimoJFBoH3XfnZJtqH8gPzzoIgT0A3EEMFKGX17HmiQZ64UYKt
         tONq/jd8WR93gp7XOcFkqhUpIO+78BhfnKzk6HOEOWADRhTUqfrBVMMUD1+GPOS4sNSY
         oilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489373; x=1729094173;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xt+wLZV2LxzPNz2lSLFTi3nnfmZ6/6WPzHA17tFzTGg=;
        b=pvs7QZFxMIbBcnLlbXkcS69b00lOnnQS4YyGfiVlh8X6wyFejhOXNiqj2jIm3cocpf
         gnNpDIPu/yVO1kOWfoDDTTwElCjElYUYMGXy5eySoShvt39yjr1xVEkppeJUDbHbhOuN
         fbGzdYKqxNzGv90N5QU49/rrK5mdVi87PDlCQYrl9N0g8U2FbnaMphPIGBHcOJarhazl
         zeHz99Cc1maLImXXrv2fVaCDX1NWmy+1PiYAO9aATTMYdImXBkDsGwoPThz/f8681BkH
         us8cv5HkLuSUGlkmZCeeGYnDKbnd0FEYhZkQ9hp7rRAUP6JK8hH2fORQzUBn8f3nfEPx
         VomQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn5scQz9a5aamp/nd9Ud9NVA/DUdIPXtSxD6kpkmShApACi9iexkf7+jLuYVGvw/63J4gyIHdgQlfkwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AcJVL1Zn85eAhj3oaF5+bsvGQlcBovZtdwnEQkWh+JJNajys
	43TSO+TA+HxeLukzGI/bRpXHrElIcuYAVh3njXOyveMNuNREHMEOr5Wzxvs8sy32KT64dFSvvRr
	VK3s=
X-Google-Smtp-Source: AGHT+IFMDPIe8sOlhzOeHJs2mnT/k4d1TUYo6bLXOZKMhjtvVro3twHrsuOMLX9A7Hu6FXaRTQvIqg==
X-Received: by 2002:adf:f48c:0:b0:37c:cdbf:2cc0 with SMTP id ffacd0b85a97d-37d3ab106ddmr2570843f8f.53.1728489372548;
        Wed, 09 Oct 2024 08:56:12 -0700 (PDT)
Received: from [10.202.80.134] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d693dbsm7943275b3a.180.2024.10.09.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:56:12 -0700 (PDT)
Message-ID: <878d46618e9851f7a019f675716630f9517f4e02.camel@suse.com>
Subject: [PATCH v2] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: lan@suse.com
Date: Wed, 09 Oct 2024 23:56:16 +0800
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
@@ -38,7 +38,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preal=
lo_rw_pattern_reader \

 EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
              btrfs_crc32c_forged_name.py popdir.pl popattr.py \
-             soak_duration.awk
+             soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk

 SUBDIRS =3D log-writes perf

--=20
2.43.0


