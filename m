Return-Path: <linux-btrfs+bounces-17824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6261EBDD779
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 414094F46D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891E31327F;
	Wed, 15 Oct 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UCAru5+2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB52D5C9E
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517705; cv=none; b=GuVRAPpCp+dGx2gQqXbwgZHq8yIgd4GTriIsWjYi2FxPhilZ0dNpvizPR/n/rvlTVb3oLULMvoXvvdlxRFkU9+4MYt/SNDgo3a1C2VCBS1EJc0OGKo2DDXApWgp+d/bCb0pMckHYj46ViUv4+jAUSEtE6HjwkOSbcv/lI+aO5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517705; c=relaxed/simple;
	bh=nTDj9aC4JMgXg9dmzg8p8hvYF9jiiWW5JqUpYphlsGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBcASU9ugGBtLpozZBwhmM1U120KtRn1BXOPqgvRQP1CDZpxb6OJoLMno+l+SwKayWPGeXUN63G6SeltJA+IdieRuHhfHQEhEeU+i5F4gDiFj+bCKyr/54TBB1fckN04hLoWbZ92X5U6lH8KL/Eb32qYmshseW2tdKoqn/E+ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UCAru5+2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4257aafab98so5235905f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760517702; x=1761122502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYxXPZrSw1png81NSYjoq7c6zPCTKlHMzNzRP0GRhR4=;
        b=UCAru5+2paeEfb+GbGMf5XPwgxUW+oXaA7OvV1kDG6rsxWFak3kgqIzm8PZz0tkT2D
         l1GavxI/ahpdbie/RBBG2bKq4k3J1EqFFSNzF6S/hDv8ZMH30KPrkFMdYHLxFUZutCpb
         Xu2Psh0QbrLMwq7jebwJHw0R0jOhamL97p8bWSWYpdK3ZQiZ2j7Y/7DP9JsPRtlr9VL/
         aZUe9au6Mn0XHlGF2OR97NrBfOoc914dmSukjmBKKO0THlS4ujh81J3RU0z04pj5FBqo
         zOjLg4c9vtynBIxMjd2DLIXUTjY6+DnBeK8CgDc8Ugw6mYWSnQSVa9VTeEwi9abc9jV0
         OcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517702; x=1761122502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYxXPZrSw1png81NSYjoq7c6zPCTKlHMzNzRP0GRhR4=;
        b=TmlND39nxhyaMapruFHgNQPIWpiCFt592Yvj3Slwb23x1CoSoyjV8heeFD7PWW2Vt4
         ouO185z53hRIc2g6HDS2PYV7PKfhZRXCWEjHr65dpsvkvJEIs9qOnxlJxeVyGaDSe70U
         B+un2qTevHY1/EQMVGt/t1y5yanw2XTijimaO8XETdPk/qKm8i9jNcxROorF547ZRC3I
         LwjeGQ0KcFa5sFnd0ScvMkRSJ+eQ1P1R0+k/X16UFpl+2vvloDZNuDhfT6MJ4ODwKNBQ
         WiMzPlhjIY+la8I9h4kCkvNW23yqnm7dLG2sMUbgB4SKNx0H4P7jZPRrVvMxjKl3cZC+
         JC0A==
X-Forwarded-Encrypted: i=1; AJvYcCVXsGiG6lPsrc2VynNbcOJVNM9WHiN8D4Iexya1VdD8TLWKD2d8J+g8oymXNOYeMiowTPwV+msk6dzdUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPr9wH3zupq/3+BNr3Ps3Chrjm+pEiV+SziUw+bvRa7mfba4K
	OxoJsGAS1cglqilvWwBxt8xkHJOysiKivn/yfPioXshmhanRKUE9jfMve4aF2F0D3VwZswxl21Y
	Ubia2ldPTBSUk8MshvFbVHVywcW0ZKpU/6fDqgNPFbA==
X-Gm-Gg: ASbGnctfXOaEdDcvURRmaZB+BmBAT7Z0Res6xKKIE9iqMQ/TnaMf6v/iNZtsVSvx46z
	6yPaGkT5Y3NVEA0r1ObLR6JpOydEkBM8SCYEB8PyiYeIm41EqEACKumXFhz0aZuA1j1Z6Ql9qYS
	14ZewdNbWvKcSgG1yB+sHVoKuPzn+55xTXL8Uzk44VCgkhSJazun21exEsVTTn0li0456oUaXdo
	5IB7TIq2KJeeA6EpleieAlhiUJfSupd4n0=
X-Google-Smtp-Source: AGHT+IG0vmSgrGg7ZnIxUH+va+yXWbkUh7CxZVL5bNazjAto/3gLeKpiYnTDiPoldFeXxNyZVlgRxgRVglfFwd+nYOM=
X-Received: by 2002:a05:6000:2305:b0:3ec:dd26:6405 with SMTP id
 ffacd0b85a97d-42666ac73a0mr18977125f8f.26.1760517701742; Wed, 15 Oct 2025
 01:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn> <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
In-Reply-To: <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 15 Oct 2025 10:41:30 +0200
X-Gm-Features: AS18NWDcwFM_RsKnyYWNXRd0Zys4gcrH_g_i6aC1w_HrFbZTBYb-or4Z7E3b2A8
Message-ID: <CAPjX3FcOCVj_negEs6nwrQG0aieeSOejGs_OPyTcRiW=Y1n+Lg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix NULL pointer access in btrfs_check_leaked_roots()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Dewei Meng <mengdewei@cqsoftware.com.cn>, clm@fb.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 10:24, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2025/10/15 17:54, Dewei Meng =E5=86=99=E9=81=93:
> > If fs_info->super_copy or fs_info->super_for_commit is NULL in
> > btrfs_get_tree_subvol(),
>
> Please reorganize this sentence. It would be way more easier to read by
> just saying something like "If memory allocation failed for
> fs_info->super_copy or fs_info->super_for_commit in
> btrfs_get_tree_subvol()".
>
> > the btrfs_check_leaked_roots() will get the
> > btrfs_root list entry using the fs_info->allocated_roots->next
> > which is NULL.
> >
> > syzkaller reported the following information:
> >    ------------[ cut here ]------------
> >    BUG: unable to handle page fault for address: fffffffffffffbb0
> >    #PF: supervisor read access in kernel mode
> >    #PF: error_code(0x0000) - not-present page
> >    PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
> >    Oops: Oops: 0000 [#1] SMP KASAN PTI
> >    CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 PREEMPT=
(lazy)
> >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
> >    RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
> >    RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.=
h:457 [inline]
> >    RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 =
[inline]
> >    RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
> >    RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk-io.c:12=
30
> >    [...]
> >    Call Trace:
> >     <TASK>
> >     btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
> >     btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
> >     btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
> >     vfs_get_tree+0x98/0x320 fs/super.c:1759
> >     do_new_mount+0x357/0x660 fs/namespace.c:3899
> >     path_mount+0x716/0x19c0 fs/namespace.c:4226
> >     do_mount fs/namespace.c:4239 [inline]
> >     __do_sys_mount fs/namespace.c:4450 [inline]
> >     __se_sys_mount fs/namespace.c:4427 [inline]
> >     __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
> >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >     do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
> >     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >    RIP: 0033:0x7f032eaffa8d
> >    [...]
> >
> > This should check if the fs_info->allocated_roots->next is NULL before
> > accessing it.
> >
> > Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
> > Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
> > ---
> >   fs/btrfs/disk-io.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 0aa7e5d1b05f..76db7f98187a 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct btrfs_=
fs_info *fs_info)
> >   #ifdef CONFIG_BTRFS_DEBUG
> >       struct btrfs_root *root;
> >
> > +     if (!fs_info->allocated_roots.next)
> > +             return;
> > +
>
> The check looks too adhoc to me.
>
> It would be much easier to just call kvfree() in the error handling of
> super_copy/super_for_commit allocation, we do not and should not call
> btrfs_free_fs_info() before calling btrfs_init_fs_info().

Right. I like this solution better too.

--nX

> Thanks,
> Qu
> >       while (!list_empty(&fs_info->allocated_roots)) {
> >               char buf[BTRFS_ROOT_NAME_BUF_LEN];
> >
>
>

