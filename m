Return-Path: <linux-btrfs+bounces-3015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8628721D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 15:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309E51F23EB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA086AE2;
	Tue,  5 Mar 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsXacSwu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2586AC1
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649944; cv=none; b=A6V3SXVesoG55TqVxh12Bf7ne9tw39fktO2oxWpBFHxHfdjFPM72GTIiUalbR+bL9mVUy3VOFJybzPBhEP+QchPondSAA5BVCsXLoLftYCXrSPDo9ltypmJzoNhZYOansqCIV700MAYWCc5bK4rJWZzrTUIXuhxS2J92/mtmJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649944; c=relaxed/simple;
	bh=/QLDHrF6uScNfUVckfvztPo2xW2f2hmAIaMc5nIkxKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIH9Yir4op69lBnBndcava3Zvx1mln28hLUmRSpvy6vDVAXYFV2DKq/A2UbrHH70wtSgpp2DT0iccH2TM81WuxCtbv5hkqHPyHwVl9nWD1ATDVr4rWMbDllyCBHYEGuU6Y6vilyZQUsCNUxgR0E+d7X7ZQmqONeRGdJsdE4yxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsXacSwu; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21fa086008fso2406631fac.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709649942; x=1710254742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7+sw3TtWJvpra3cAdJL7bJ5Dt9TpjqtiA+dOQf58KQ=;
        b=MsXacSwuFMAev3PnVCV2WPZvr9nuFeJrZfVKuDKh9nmvJVJNZjaJYuGDXqlazqwwt+
         spGnkAQ5kpqpOxPM/hm0Yf9s6HZvhb43fHyYC+1Hyx/I1r4FS3hz9ozNOGygmJ1MvSd/
         adGj4sqzp47d1Z28gSPsTagvSkOY0WCBkYvsK7uDGmJpmsiqRiOR73FvBU0Qi1cvHCmK
         Y3spmklGxoMVieRQ8NepFnAzuhdSy8pHo2Rh6OGZ/xjnDL5OX3SjuF7PrEdqPX8hIjV4
         EptVLXssBiHlnkR19btdfKo/GiC7VADL71YuUt5lkvQo2BLsxkIxsJgwqM5eZuJZAQ0n
         HTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649942; x=1710254742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7+sw3TtWJvpra3cAdJL7bJ5Dt9TpjqtiA+dOQf58KQ=;
        b=ZQWu8gToee7DrTWeVoT6RN4Eyd89xEKxiHhAlEHSX0naAHtnEyXc4oLQgU0PvG3kS5
         jCbZDYWNQNt0Yhio5eY0UfPTZU+XAcZwKszlhpVhozHF4omE0d1G10vbX5CVp6dfP/Xq
         ob6fcFcECNF7ycZDbcnbEK40Fv89nhGQWpUgeZtyks2LwiIEmJ9/sYkyyk9k9u6SJDvM
         1LWqFZ4e4geZcwPV+mJosrcGBaWQgyI8dOKKVeJCWYn0v/sEcwJbCLRJy5PgDuabesOV
         XDMRljB4bYPBpqpw8Q6f3WSTbc8DbHbDlZciLOQWgj4nZKOZ0ZUVqRASt/0dEnTU0K+O
         H8JA==
X-Gm-Message-State: AOJu0YyA1TqYQYe994fi8QBHEqz8LTnIOHd3OjBh/AUqxKS8w/aR9ZPC
	imtSmYi3n9YbgsROP325T1XPzo1G7J58hgQ4nI08s3ZJArrHP28aeUeqCJdGa7gjowH0fAbO8ET
	gNJw0ZLf+6OCr/3zKp2CX7oGBhguyq/vTTLdR6kZv
X-Google-Smtp-Source: AGHT+IFZh218tyg5Y3b6OWAvCov7/XGFNT8phZ1FAgjIgq9UHupY1TyaWUEjwHulp/Yul+d00ZxGJW2bXc7y9eOKkyg=
X-Received: by 2002:a05:6870:1002:b0:21f:c7a2:909b with SMTP id
 2-20020a056870100200b0021fc7a2909bmr1571958oai.26.1709649942113; Tue, 05 Mar
 2024 06:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709299316.git.dsterba@suse.com>
In-Reply-To: <cover.1709299316.git.dsterba@suse.com>
From: li zhang <zhanglikernel@gmail.com>
Date: Tue, 5 Mar 2024 22:45:31 +0800
Message-ID: <CAAa-AG=ad-2SxdTUsOWXtee+cnjUb+amOX+7d0EJdsXRV1n-yg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc7, part 2
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
After pulling lasteast version, I can't compile, here's the error message.


In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:251,
                 from ./include/linux/instrumented.h:10,
                 from ./include/linux/uaccess.h:6,
                 from net/core/dev.c:71:
net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
./include/linux/rcupdate.h:462:36: error: dereferencing pointer to
incomplete type =E2=80=98struct dpll_pin=E2=80=99
  462 | #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
      |                                    ^~~~
./include/asm-generic/rwonce.h:55:33: note: in definition of macro
=E2=80=98__WRITE_ONCE=E2=80=99
   55 |  *(volatile typeof(x) *)&(x) =3D (val);    \
      |                                 ^~~
./arch/x86/include/asm/barrier.h:67:2: note: in expansion of macro =E2=80=
=98WRITE_ONCE=E2=80=99
   67 |  WRITE_ONCE(*p, v);      \
      |  ^~~~~~~~~~
./include/asm-generic/barrier.h:172:55: note: in expansion of macro
=E2=80=98__smp_store_release=E2=80=99
  172 | #define smp_store_release(p, v) do { kcsan_release();
__smp_store_release(p, v); } while (0)
      |
^~~~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:503:3: note: in expansion of macro
=E2=80=98smp_store_release=E2=80=99
  503 |   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
      |   ^~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:503:25: note: in expansion of macro =E2=80=98RCU=
_INITIALIZER=E2=80=99
  503 |   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
      |                         ^~~~~~~~~~~~~~~
net/core/dev.c:9081:2: note: in expansion of macro =E2=80=98rcu_assign_poin=
ter=E2=80=99
 9081 |  rcu_assign_pointer(dev->dpll_pin, dpll_pin);
      |  ^~~~~~~~~~~~~~~~~~

David Sterba <dsterba@suse.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=BA=94 21:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> a few more fixes. Please pull, thanks.
>
> - fix freeing allocated id for anon dev when snapshot creation fails
>
> - fiemap fixes
>   - followup for a recent deadlock fix, ranges that fiemap can access
>     can still race with ordered extent completion
>   - make sure fiemap with SYNC flag does not race with writes
>
> ----------------------------------------------------------------
> The following changes since commit c7bb26b847e5b97814f522686068c5628e2b36=
46:
>
>   btrfs: fix data race at btrfs_use_block_rsv() when accessing block rese=
rve (2024-02-22 12:15:12 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-=
6.8-rc6-tag
>
> for you to fetch changes up to e2b54eaf28df0c978626c9736b94f003b523b451:
>
>   btrfs: fix double free of anonymous device after snapshot creation fail=
ure (2024-02-29 22:34:11 +0100)
>
> ----------------------------------------------------------------
> Filipe Manana (3):
>       btrfs: fix race between ordered extent completion and fiemap
>       btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC=
 is given
>       btrfs: fix double free of anonymous device after snapshot creation =
failure
>
>  fs/btrfs/disk-io.c     |  22 ++++-----
>  fs/btrfs/disk-io.h     |   2 +-
>  fs/btrfs/extent_io.c   | 124 +++++++++++++++++++++++++++++++++++++++++--=
------
>  fs/btrfs/inode.c       |  22 ++++++++-
>  fs/btrfs/ioctl.c       |   2 +-
>  fs/btrfs/transaction.c |   2 +-
>  6 files changed, 139 insertions(+), 35 deletions(-)
>

