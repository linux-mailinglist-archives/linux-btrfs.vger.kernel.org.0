Return-Path: <linux-btrfs+bounces-8162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399997E6FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8591C1C2117D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A53A745F4;
	Mon, 23 Sep 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EwBErmVa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723493FE55
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078236; cv=none; b=VAq4i9UIIWoOXY5AnltgYmf+yIdkHNJM+ZgImKrLc71Ss0SQUZhwKUc3ExzRLSXoQnKjqumbn52jJNWfLKIdzDIm+fMclbGcx7zZWBK3cA9LM8J7ayeOZatnMRhyEDmAo450SLLPDcTfajA44uSWoa5pdqbHTUeHsSXTedif7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078236; c=relaxed/simple;
	bh=hdJ8meoxuDY9NsYfw8JQThRknsCv1bL+U3BGWtcS2MY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=XYLrQsr6ENpd4rTD4BmvLL92bq2/+SWNOVB4JIA4RtHefa3lKy4R3rmKYLrede2b5ezR6YjUMtnjQ9yB9mO1Fo31qqagjHOxzE9Crcx7v6mdSm6rgo9aLKxACMaxDKTD34ZyQMc7CEpR8IytH8CTtgliG7HO7kT/Efr9jg6ihkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EwBErmVa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37a33e55d01so2983184f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727078233; x=1727683033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5D2bVNr828NtzaaRmivYA2IOgyh3Yc0tQAK07PC1Pvw=;
        b=EwBErmVa8cwoJ9eSfSMahN9oFOVSTHEtySXos48wSXtl7oMqUdZhJ2i3VzHIuYOXCv
         1DXvCQVWfneLt6vtG83cKgryhqCDm2f+aBTi4rLK21HoOeNePxVjfHIMAv6homv8/NzB
         QOg0CnXNaRlTt18ko1sYAbqPGsHnQeYsVTvMF6M9L2Vhs4wv+mDy1E8f6bzzbdD8x0cD
         D6Pb/fNue//QAKjbExKLyucGMwomjX3d/hv60482xlcTz8o+vLPsYFoenSWtNJsfBErw
         +ZhxEUaNHoX/697bqIZ4rqqHEJNdkP037EzIDEUZytfGwr/suEqSiSL/0GBks46Lp73x
         DIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727078233; x=1727683033;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D2bVNr828NtzaaRmivYA2IOgyh3Yc0tQAK07PC1Pvw=;
        b=YBduwaXa3ABG2SIbBOLPpL5Z/QY7AmJc3Va5m+pygftbAvOJ/uH3u3VVWAw93haipU
         CZlQSqL59YdoqVkDOqDLrzm4IVu1lj9GG5R23nuc66rNhwL7Ks/5CY3J5p+9vG6Mfte5
         nmMgpMapHJ7D3vluHroY3zFn1cn0PwkQUtX+KMy1GsXIVhA0DUyeLpS8we0pbszGSEfE
         oCPLMPhPDmdcJibn8QWaeDFigCClWh6oq4+1qhLqOt+yeF3/JaytcWGf1nzActEHkSxW
         S6S8FlKPfiGoI+g85K82VN04qyiKN5XGh2V8CmqluwM7P0VtcyRNoPTWscz96BFqYg6H
         VShg==
X-Forwarded-Encrypted: i=1; AJvYcCWlwnPZnGdC/TXfATRtVPmeazS+sR9/YBvbK6b+T4AxK3scB1Ws/H/vFygmA55F/EX9AmRWI8ABDtwcdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6cEvB05HCqWqKjy2DT3L3WNsfd7Gru+IklRx0F0SDG7D7tpy
	sAElFyDZA5FjkWLm5YxXFb7SrIUljv8DNI8mIbrKiYL2mhS8chKYelc6TQPLz8RL6MeH9hLxkcP
	/X5ZCsw==
X-Google-Smtp-Source: AGHT+IH4y6sePkLaNKuJQLzGOhRsZJbIvNskgol16A2jdAilHmwC9LaOpNfUOp1u5653CsrrfJccBw==
X-Received: by 2002:a5d:6883:0:b0:374:ca92:5e44 with SMTP id ffacd0b85a97d-37a431648eamr5032129f8f.32.1727078232748;
        Mon, 23 Sep 2024 00:57:12 -0700 (PDT)
Received: from [10.202.80.134] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8ce902sm6622792a91.35.2024.09.23.00.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 00:57:12 -0700 (PDT)
Message-ID: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>
Subject: [PATCH v2] btrfs/315: update filter to match mount cmd
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: lan@suse.com
Date: Mon, 23 Sep 2024 15:57:13 +0800
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

Mount error info changed since util-linux v2.40
(91ea38e libmount: report failed syscall name).
So update _filter_mount_error() to match it.

Signed-off-by: An Long <lan@suse.com>
---
 tests/btrfs/315 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/315 b/tests/btrfs/315
index 5852afad..5101a9a3 100755
--- a/tests/btrfs/315
+++ b/tests/btrfs/315
@@ -39,7 +39,11 @@ _filter_mount_error()
        # mount: <mnt-point>: fsconfig system call failed: File exists.
        # dmesg(1) may have more information after failed mount system
call.

-       grep -v dmesg | _filter_test_dir | sed -e
"s/mount(2)\|fsconfig//g"
+       # For util-linux v2.4 and later:
+       # mount: <mountpoint>: mount system call failed: File exists.
+
+       grep -v dmesg | _filter_test_dir | sed -e
"s/mount(2)\|fsconfig//g" | \
+        sed -E "s/mount( system call failed:)/\1/"
 }

 seed_device_must_fail()
--=20
2.43.0


