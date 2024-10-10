Return-Path: <linux-btrfs+bounces-8763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E4997B5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 05:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EA2285A9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9E191F81;
	Thu, 10 Oct 2024 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZDrZre8q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAB192B78
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531619; cv=none; b=cG6y49EcmI4JMIfWjFinKMg8MLmcPTITQqKs8BxYgbvDyk280iwBJG57cFCgPssIQP9z6xgOMp08ngZ+L3HU1be7WZ/zvaiS2t+LUzd5JaOQ92V0otMrKoawq5B1UU23cNhKkxJ6meDE9DDSLom+iFT+aWJqcec+I8NDyaBusJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531619; c=relaxed/simple;
	bh=xBoFjKCLGh3t9tQ6V8jR6zbuuIIb7WZVjQOFe5NXOIw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=A50r3EQGdukbZKyCIkwNFNsD1Jy8hCki/V7venSHwmF2Z1JY/ozjzb2ZjEHLf33WIHP+3+RHu88mGihHMhLwSGVZNY82FfHbTq5I70cyUBy6RDV7FtDrYdytzLSdgiMm/H1jbEx0Z7V+sYIhahxSEWMNJLKcF7WlqEX4B2DJgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZDrZre8q; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so5456301fa.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 20:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728531615; x=1729136415; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYdoqcRyvuGhdouI7k53siU5lFdXx0ZxH1uXwx1Sf7o=;
        b=ZDrZre8q+XcQ6X6gwuw8zuwjDgzWxf4E79zfhkBLZAsGY5X6mr7hf862Upv/DbRqN1
         /aMY3sy+fCffbgY1VY/90XBGVoCefZfHmKpI/+AWQdp18t723u7Ik2Kr2yj/4oN/mj2H
         Ns+WV8/c5VsXkEnMkjKdKuPyjFnYxleLXNztEqkG7PFqez7/HNRNwXTMFRpVYpE3SYp/
         fsmpt3r3g9h9lRfTQwIDCTfj8HPnYOwQ9WZbtZX0RW7BWx6tx8H8W/1wTiR7oK7xurBZ
         uCeeHmG3Kyy0p1YtwqHBBADZS/drFXmj6ezd7lktm9Fzw3NO94JnUJIS1HE4jD77it/2
         VujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728531615; x=1729136415;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYdoqcRyvuGhdouI7k53siU5lFdXx0ZxH1uXwx1Sf7o=;
        b=oO3MWfqyKCpp7YIEa1M26YrK0HeE9PUxacl0CRPZOL4a23V3EDcPKEnpH6pkhR25Yg
         0urSSRIkcZXpFs5lUhKX50+XqFbothhvrek2GHKmwrK64dqgzKOzl5BP3xsn7UyQG56L
         GU01Og798SAQdgUoh94ReFsxeczfzJ/aJqtPFLeEbZTZTSuBHYJxSC1PCCaa+buA9ZcR
         SgArKoclibAh6JQHFk1XkvS29XtwF7eT8w682MrDPuvlNlOJ0AMOPQOK9U7K/IcEsEtw
         8kilc1tTrsA5JgYvHVvesXUpupXvhkueGzpTWXjbyC96zXrIJNXQ2CBzNXkpM0lzrvKK
         e9nA==
X-Forwarded-Encrypted: i=1; AJvYcCVUfpgS4wpPDctRLvXS1xelHibMjE6/wy/6RDat3fAKCMcsNMKXUL3anx1GxGpvj009xZinDoOIPbxcsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+j/r+lhahNAXVjvX3FHLS78vXEF4BS9sHzgPwlSL21EjMdhw4
	L8lw9I+qMHVOLe3ZYWrbCmHpMYPaA2+OjqJreBaRcIxlfpLlk9HX8xd2MHW5mCx5peVfaWVN7nM
	0oE4=
X-Google-Smtp-Source: AGHT+IHpH4p31fOGa5pkfN3L3U24p/tpvpeK+PzNsww0yR0uQjYmmk8M2Zt6IGdkgZ3QokODNtMHjw==
X-Received: by 2002:a2e:719:0:b0:2f6:5f0a:9cfe with SMTP id 38308e7fff4ca-2fb187ce928mr20426521fa.30.1728531614828;
        Wed, 09 Oct 2024 20:40:14 -0700 (PDT)
Received: from [10.202.112.42] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e760asm1505215ad.174.2024.10.09.20.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:40:14 -0700 (PDT)
Message-ID: <aaf23db45854222bbcfa470b25812e42a2ab9eda.camel@suse.com>
Subject: [PATCH v3] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: lan@suse.com
Date: Thu, 10 Oct 2024 11:40:20 +0800
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

Signed-off-by: An Long <lan@suse.com>
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


