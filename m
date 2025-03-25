Return-Path: <linux-btrfs+bounces-12583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41899A70BB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 21:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AD13B3F86
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 20:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B7266B63;
	Tue, 25 Mar 2025 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KdHO2J00"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20219D086
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935312; cv=none; b=HTksKIvV0B5mmlxjYjy1xg9+ds8+jYdN2whr2deWZL3kEm7zTDz2zDHWmKbGyiWhHqeCknoWKxqR3YstWeLlvHIweLDnSqo6rSBxOLvzR20AYgurS5yQaAqFJS0bRY6ANjIIYavNLn6XzqpWm3rw03gu8RQPxoIOHxbZ/p2FZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935312; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2vezoab98SC8cXmtSqRyL/H2gemQXw5uSRTU1u4/riqtedPBPiIOPUSbZ6HTarq/MlOy9Efsd50olq3tBtaX9Ks4rFYRwIn7C/oDvsmf2q/RLg6jR3cUqqOVAP4y3TE8bKB3tb4gS2yCqpWvmY3PTDWyFXL5iyv6TWmxzNyrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KdHO2J00; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so9372246a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935309; x=1743540109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=KdHO2J00TAe4cgySGHdLO47Aqso/bC/fKKMo8P2q/ImYFczI0grhq/U4sPkIJUmEDy
         wjtClJSVXHJ1pOD8LMyYg2X7mAznVxjHKeIPF32qWD8ufaiPjjOCh68DkC/zxqiOwzLy
         ZF3akULDuXPyv9SoRnB6XsiGX4HBqH9K1Kblw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935309; x=1743540109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=qPL2NwnFDwanVjw6mbf5xUQE0ibyn3/LhMQIRR7OSa8khzYM8cWTeE4joT0kyAkNDJ
         tQ37kQz+7kNEJFclaqvqjT0eb+mcv1koTkHY1d59C3hWZ9/7zJKzBzgKkhkc6htKyeYX
         FZFbrInrUEoM43pu+CaBDmorj5eEJC9S1f4PBmVeNwVYqsS9uwzaLVkjWXoXKmHsZwLj
         J393BrW8rMWI3YPgxuLEz3clreG9NdtRS96kazikUdG5Vi4c3H47/+b31igUECHxj77T
         Z+EJlzMY6IsA/1EoF25YBEi/8P2oax1o/NlxgVmeu+zh+t/lhs8GZVlvfqsOhWCNSrsY
         rAyw==
X-Forwarded-Encrypted: i=1; AJvYcCWUfH9g4DVVLLmEPMxkXHHeT4xX0XiVb02NLKj/5W6pg/no3/Fu6iq29Q+4GDV9RQ56XHvCejog0tImuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtG7ZwWqJFT8aT6NiG7QCIR2D/Gqtt3kqUEhGKoHutkZOkYbT
	Qgkq2AiNPS9rfcKpmOSxUq1b2J1mMwdZRDip7UMcvKk+HXD21GspjXSFCAcDPzrvZqz2xUDimgV
	+Ppw=
X-Gm-Gg: ASbGncv5BdC89dPfSOrZBL3QWarvbfZyqgEUsOuki3l0K9t6Qi6zcILf6xqxshDiK0P
	xI54Upas1jmvxyG9mIpGBM3mgJwoXdIGChR3adHSKSNXAEsVjXtbaWb0taYgwdKv0aaFvE11WL/
	w15oVCh8Nv9ZAXXtquqLTuJwmTF4mMEID0KPKGYdoZfh86tYNvlWHBYSkzTdQhEcquyE9klRSVS
	3LNgyIMY9N78nrI02yHygL833q3LgKJim2VW+ilqxkFSYSzW6D/2PkbwZHJYxD6aJYOvt9Ql3Iq
	LIPqRVSHeZ2VpnQ0MXEWxGYEAF/3VOdQD09f09CWgS6kcZ1sOovvrnn+K+tMMSq6mLRjNqngdft
	6thWq9TDPLZ3usmEnmhw=
X-Google-Smtp-Source: AGHT+IExUY2Xu2pO1XsPN6urn6h2DY9k4pni2E0Jwy1OnYRu2jWucx8rmEAjIQ6Pmc5j8t+ffYnx/Q==
X-Received: by 2002:a17:907:7e5e:b0:ac6:b811:e65b with SMTP id a640c23a62f3a-ac6b812299bmr613524666b.36.1742935308786;
        Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd3aab3sm890884866b.156.2025.03.25.13.41.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf3d64849dso989642066b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVne/0zZ3n7tvphCkMloFUPaqFJj67lImxQxhy2qBBybZVFnaay86samCVVLZUSqgF8/G7MfBnDfuzPQ==@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

