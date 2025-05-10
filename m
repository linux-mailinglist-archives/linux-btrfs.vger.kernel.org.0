Return-Path: <linux-btrfs+bounces-13860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8DAB21CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 May 2025 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2684C3801
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 May 2025 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E261E5210;
	Sat, 10 May 2025 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWP7MkT+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678E19AD70;
	Sat, 10 May 2025 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746863296; cv=none; b=SQcnoQkDq0ZuHVkimH27YNV+hxA/wzKA9HChWIhKdRjv/pcH8qZNFDPnF7NCgKAQkYaEU7+qls5bxYAkxjxIPENL9bxa9FQ38e8+ofHJxBvyPT9oLQwpK5TujtDhCaEgIJ03nG28U3FVsLBan0kCGMhK56Kss25Q4N+JM+RYdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746863296; c=relaxed/simple;
	bh=Cd8t/G/GucXe7OoO59rxNrYaeNdZIWCPe5EO5IQB1BI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JMjcqFaH86L5QHqh5lMUgyoBqaJQAJBU8GmMtzSSm7XAUq3BhPNmqDZq0ptRv+hrLywPws0+qmwyI9A95TvGtnMYiyeJcPZL9ZWXSPi7ZgAFikSaTKVtkNoozCexuH0D6lv1Ik4V/uztuWev/62RDhueUhTcT/x0xyf1boXhsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWP7MkT+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac34257295dso469621866b.2;
        Sat, 10 May 2025 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746863293; x=1747468093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eCRydtYot/T77PlmVjAZqprs+6gjk0Q2CtBojQ6anQ=;
        b=jWP7MkT+DFjjzZ65z50edFMaovciPvPo7nQk7FnHWbVVBy0rghwok/srhAHJ/Z3nZf
         MCtPfPT3kBf+9/wAdcKdDW69cVRF0I9uy5mPugOOUJ0woT8bNIAjZJ5eqafrd/H4x2cz
         EBbQZGiuyNSw1JN6MoEINdldHD8RLrNyxnOLzUvd7GWZf1XeE6uSoPMZeRpqMtjfVHPD
         bVyYZKjbPkQEMyk4aJsIUHWGaDdZ5PFW1EAaE2e/HYXVDqDOUnkhWMm/XA+9xmyv9Mik
         8tPA3wKUrIP+XrzCeIr9tW1QD554XgGLRnMDE7C7i0AtAhTay01QVFN+WGhM20kIJ8a1
         kq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746863293; x=1747468093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eCRydtYot/T77PlmVjAZqprs+6gjk0Q2CtBojQ6anQ=;
        b=gaw4hN6jxLaWB7GwSUyXruqSrkjBVKqW2fUhnAgF4bjEDnucmb3vW4Bw/zbKG+RGhw
         zLvCAGz/0Bo9A3OjtCE1PhQXXAvXxLvMkwTv6zpnJ0/OCIo465r+LsHKLmAL0u5npMc2
         7hMNmaGKqn4cmB/THhHssA15AMfXSbPu3gBLpP9qRH4tw9bxF2VIVcvzh6RpgSzQ1WZ6
         VoHTRE7ASmb6BIvOUaAHilPjI/PzsIroRbev/XBtwAT/Vbh4KwxQec1pbLjXnaWfTWPe
         xn/JHAAVKqXUYi0IZ1lI/3/e6ai5UaG7hTNOjiOyEaat2XDq4z59XOPCK70Fmu64kRVb
         R8zg==
X-Forwarded-Encrypted: i=1; AJvYcCWpyXN6/B2sSVm+A5xnBhRaFWWbeopOd6QmkZsC3tVRqGhCfElD0M8rJsuQBSUJ5O/oVp9wv1bbjqA5zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyazCv3UoN/KvCJSQajEFRpomipilJ6cfECtkFPkks+qgxK5hh3
	TVYRE8LAhxHieCQDuutwn+ejb9J5Ab30eqAuPkoU3TdoF1S4ZGNB6gtPxOYDCwvboloQMyTRjqD
	ypASkuXQT/hbr0QKiGgjkbUtjo2M=
X-Gm-Gg: ASbGncuUN0mIUXRuLDceKmtUXu/10S3Ipa6g00Kg+buWZ0k+7mgX9lan09uYfPQ+fFD
	87wx5HhRLFAGS7afiFTJSxAVwt0uoA+ZV6Lzlo94nKF5aCR7B0IWcN2xUEHvQh1X2feW/vZnUF4
	AwsE3F6fFAyB34sf/c5AXMoNpdlKgEMmI=
X-Google-Smtp-Source: AGHT+IGYJ1ic0z6zfmJi28h3XssudanXpRTQJtmTjv6UF/vx8Xs9Ks5qQdxj40CKenH4bTDbXl73dBcDdXcDtG2yoeg=
X-Received: by 2002:a17:907:c312:b0:ace:c225:c71d with SMTP id
 a640c23a62f3a-ad218e92d44mr567941066b.2.1746863292969; Sat, 10 May 2025
 00:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Sat, 10 May 2025 15:48:00 +0800
X-Gm-Features: AX0GCFsYGSe5WMKMfeGtoCt2-4xZ93jFZyCGqTPHyYt8EeiWD2VHF7_44xsa3QU
Message-ID: <CAFRLqsUCLMz0hY-GaPj1Z=fhkgRHjxVXHZ8kz0PvkFN0b=8L2Q@mail.gmail.com>
Subject: [BUG] Data race on delayed_refs->num_heads_ready between
 btrfs_delete_ref_head and btrfs_run_delayed_refs
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers,

I would like to report a data race bug detected in
the Btrfs filesystem on Linux kernel 6.14-rc4.
The issue was discovered by our tools,
which identified unsynchronized concurrent accesses to
`delayed_refs->num_heads_ready`.

The relevant stack trace detail is as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3DDATARACE=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Function: btrfs_delete_ref_head+0x164/0x180 fs/btrfs/delayed-ref.c:550
Function: check_ref_cleanup+0x178/0x290 fs/btrfs/extent-tree.c:3381
Function: btrfs_free_tree_block+0x334/0x7f0 fs/btrfs/extent-tree.c:3444
Function: btrfs_quota_disable+0x4d2/0x750 fs/btrfs/qgroup.c:1414
Function: btrfs_ioctl_quota_ctl+0x18f/0x1f0 fs/btrfs/ioctl.c:3707
Function: btrfs_ioctl+0x943/0xe40 fs/btrfs/ioctl.c:5325
Function: vfs_ioctl fs/ioctl.c:51 [inline]
Function: __do_sys_ioctl fs/ioctl.c:906 [inline]
Function: __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
Function: do_syscall_x64 arch/x86/entry/common.c:52 [inline]
Function: do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
Function: 0x0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 __btrfs_run_delayed_refs+0xe0/0x1a50 fs/btrfs/extent-tree.c:2015
 btrfs_run_delayed_refs+0xd1/0x2b0 fs/btrfs/extent-tree.c:2158
 btrfs_commit_transaction+0x27a/0x1c40 fs/btrfs/transaction.c:2196
 del_balance_item fs/btrfs/volumes.c:3810 [inline]
 reset_balance_state+0x193/0x240 fs/btrfs/volumes.c:3874
 btrfs_balance+0x1698/0x1770 fs/btrfs/volumes.c:4706
 btrfs_ioctl_balance+0x290/0x470 fs/btrfs/ioctl.c:3587
 btrfs_ioctl+0xcaf/0xe40 fs/btrfs/ioctl.c:5305
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

The code locations involved in the data race are:

Write (fs/btrfs/delayed-ref.c):

if (!head->processing)
    delayed_refs->num_heads_ready--;

Reader (fs/btrfs/extent-tree.c):

delayed_refs =3D &trans->transaction->delayed_refs;
if (min_bytes =3D=3D 0) {
    max_count =3D delayed_refs->num_heads_ready;
    ...
}

I=E2=80=99ve verified that this issue still exists in the latest source tre=
e as follows

Write (fs/btrfs/delayed-ref.c):

548        if (!head->processing)
549                delayed_refs->num_heads_ready--;

Reader (fs/btrfs/extent-tree.c):

2007        delayed_refs =3D &trans->transaction->delayed_refs;
2008        if (min_bytes =3D=3D 0) {
2009                max_count =3D delayed_refs->num_heads_ready;
2010                min_bytes =3D U64_MAX;
2011        }

Thank you for your attention to this matter.

Best regards,
Cen Zhang

