Return-Path: <linux-btrfs+bounces-18783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB94C3D11D
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 19:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232183B037E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4CA34CFD1;
	Thu,  6 Nov 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/LOlj75"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DE276051
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453527; cv=none; b=k0yA+4DFHC/ikJp+s2bE4+HD7Q3d2QP+ldhbSYDgIVElRGP5nZoTDr01uLOefLPpozScBrGQyHYwEh5Qm1RRwiS+6r9oNZFNGhiZJrazUtHlHTxyeQF9x32w+4JAn6hmOdNxAGLhyc92gLcwftBB6MLqtS3mLnwH5BZDN7wp0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453527; c=relaxed/simple;
	bh=i3Zv/Rn/6IUaXgpDkoeSFVVHprMl6qLmtNw6FgeVnw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cxD25e7qgXJBNQ0wShVmC9BgrpuhqLAVKbdQgcoSr8Hr5ETm2T0WkYipGPuVZdWmoeSdOYQbns9Op1TFLU0H1M2pbSs+7LEeWfm1r//AQ0dQGD3oECi0hnHZLr97992sb49nqLXAIbGAOA9nT9NHTOURQtuVoKZmFT2dRp2SYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/LOlj75; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e41b6469f5so151068fac.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762453525; x=1763058325; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UERxQtqEcUkXPa3gyfUsiLCG0YIh4dpHqZ/vsKToOM8=;
        b=j/LOlj75ENFB3vXy0Hb2sEOCGBHhB3+Z+pmkjWdA7kpEEcNbDTWwXsqrQjtWUsD8eO
         SLqhmeL8N5Z4XhwdXzzTY0FwLF3dw4SnGfUL9imG0RdYrk/BoLVTim4/JfGf4XiVwjRK
         6PkOQ51R5syERmlueYFwwFJXVPXVOZ0vVUeOOHSJrtBBy4vBj7En1IFSwnW9svt5tBV9
         nUq6nmCZjmkplpA+9E69KReyO8Cuvaz24dLOHtWDL7pWH55KjHUlA0q/dQjoa2upt9YH
         yIGBs/FUFSKFtD2XASXn+slM9TomnpoFRVTmHiauDK8B/X86Yh8sfQtmUl5wCWWKdmfg
         KuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453525; x=1763058325;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UERxQtqEcUkXPa3gyfUsiLCG0YIh4dpHqZ/vsKToOM8=;
        b=o83tQ+ArL9aTEQYrPTp6tJolvPYGR8JQ+sgoGvATgydxr2ytsSRtVL0zQbd1xTGF9l
         Z+mU5Hw6Frb2a6y0LJ3ECne0PpnlCISsimigmlyJlJh8C+y0o5KVXAuuQc2538Jh0E4h
         8GSnPvQ/4qVjyiPwjOpbpbLyx/vtGGeqYVNCHHm68yX4XEuPjPzYQXKwhPCqqO42aJyK
         xlwlQBgam+Z5sIYUFHgCKjfxlgiWpLevQSW6WX/MsSPi359jukEsbUKJgvTyMmFnyQhg
         x+wq3t6xV5dDiTMe52U2M82MOMXn6f+tsljb4mrbS6UeMWAVLDWXYhBqhIasFEoMe24x
         YQoA==
X-Gm-Message-State: AOJu0YyXRbjfgTEv3pLwEoLXCWXUDEJOaUcNpjhAH7WNc8+WIzm2QB/2
	zWwIDGVN7q//sj2lx1fDgcJG8vYjbhnz1N+EZNvYiBykWdzVpyaY3zxTq5xmVyVhv2DBG9LuGhM
	mB+alo812hcNQKMqQ6J2eaASO5nBjmJwO9qQA0T8=
X-Gm-Gg: ASbGnctntV7XBX/MQAGWw21Y13+fyo21OPlcmjpQEI7DHeHJSawFswIC84O/WXSRBT5
	lq1jJkILoka9scA1BxPKbnHFvBSyGt8AvdRrUzOOKtQzHZqwcZbfwjAuglGfj73upKtoPlyWOm3
	sDQiMNDKS+0XIwtbCJKhbwdqfkx4NjWXkKU1Gs1WDS+n5pGDqKSAeGLk69Sa6gOFAz94GrsSwHa
	6WPdCbQ5254FUY3DEk9GJkc5PzRMobFhEFFFoTFFAxi0enq6LBv2jkX+cFN
X-Google-Smtp-Source: AGHT+IF1R3iA2jLssAOT+D5ESROASrM0HbAmc6qfQ+e9bPy8UaLzEFR7JZ5O82eofQXrlPwOl9REuwQB8VrDM72mybU=
X-Received: by 2002:a05:6870:a78a:b0:3d2:3a88:f27 with SMTP id
 586e51a60fabf-3e41e608847mr379226fac.27.1762453524863; Thu, 06 Nov 2025
 10:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOksDzUDn=rEpz1PLRZpxQeytWPP6QVbo50RU-KxP=-eQ@mail.gmail.com>
In-Reply-To: <CABXGCsOksDzUDn=rEpz1PLRZpxQeytWPP6QVbo50RU-KxP=-eQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 6 Nov 2025 23:25:13 +0500
X-Gm-Features: AWmQ_blAFq1YsWS9qZ_iePgfk3asBh9YI5wGXX1UMslZYWBOzIbZTO1H2zFCdCQ
Message-ID: <CABXGCsNy+60GrL8XeJ83HKa3xNNtV4RvUJuSEz=a7PQv951pRg@mail.gmail.com>
Subject: Re: [btrfs-progs 6.17] btrfs check --repair aborts in
 delete_duplicate_records (SIGABRT) on single-device FS
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 12:57=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hello btrfs folks,
>
> btrfs check --repair aborts (SIGABRT) on a single-device filesystem.
> I understand --repair is risky and not recommended unless asked, but
> user space should not crash. I can reproduce reliably, and I provide a
> btrfs-image below.
>
> Distro: Fedora 44
> btrfs-progs: 6.17-1.fc44.x86_64
> glibc: 2.42.9000-7.fc44.x86_64
>
> Program received signal SIGABRT, Aborted.
> __pthread_kill_implementation (...) at pthread_kill.c:44
> #1 __pthread_kill_internal
> #2 __GI_raise
> #3 __GI_abort
> #4 delete_duplicate_records (check/main.c:7583)
> #5 check_extent_refs (check/main.c:8254)
> #6 check_chunks_and_extents (check/main.c:9216)
> #7 do_check_chunks_and_extents (check/main.c:9279)
> #8 cmd_check (check/main.c:10902)
> #9 cmd_execute (cmds/commands.h:126)
> #10 main (/usr/src/debug/btrfs-progs-6.17-1.fc44.x86_64/btrfs.c:469)
>
> Key at crash:
>   key =3D {objectid =3D 17101544210432, type =3D 168, offset =3D 16384}
>
> I captured an image with:
> # btrfs-image -c9 /dev/sda /home/mikhail/sda.btrfs-image
> It did print:
> parent transid verify failed on 4843613831168 wanted 213059 found 213019
> Ignoring transid failure
>
> Image is available here (HTTP download):
> http://213.136.82.171/dumps/sda.btrfs-image (5.4 GB)
>
> If you prefer, I can re-host or provide via a different channel.
>
> I can run additional diagnostics, instrument a debug build, try
> patches, run under valgrind, provide btrfs inspect-internal dump-super
> outputs, etc.
>
> Thanks!

How can I help you?

--=20
Best Regards,
Mike Gavrilov.

