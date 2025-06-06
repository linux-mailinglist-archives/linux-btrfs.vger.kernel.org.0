Return-Path: <linux-btrfs+bounces-14536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A9AD07D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DB6188B7C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174128C004;
	Fri,  6 Jun 2025 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4VmGC/u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776AC2CA6;
	Fri,  6 Jun 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232487; cv=none; b=Y+wxZmzzLQ8o0tAJ3PXkADorHOjfLfNQAnJLrbh0ii+Fk0yVdCHPR8Da/BQpVpCjKDqOd8f5uZzfSlh20QUQLurdrQGO3EusSZ2QFuRJ27Li4q0PEYj1SctmSxmlz/gaS72VP4UsgYwd9c4zGVm8ypvmrDRfLVDsbPRrE//qoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232487; c=relaxed/simple;
	bh=xc9Baj9xKeubv6cI8UyjCOofb9PpXbYIYIenD1j5yis=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nB+A1/OqVEkq8IrZg0IpC6Tdtl4CCTUlI9MkK6ET7KEPJibgFSgSV6XWZjPVeTzvVWicBzqvIlG9pmU0FYFubnn5U3ugZjvptjf78rWPUXG6jzRfLZ4FQfrL7TgMg/GLMkXRPL1a2iKcvHoQfEcWrSBcRwvJAn7PC5WjubMO7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4VmGC/u; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58d95ea53so26835881cf.0;
        Fri, 06 Jun 2025 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749232484; x=1749837284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v303+LEPWmWGYvudOjYjljcgtQxIwDl/swbpHAPmF28=;
        b=W4VmGC/uJk5gMceLODxKDHzE/hdPJD7NIFSPyffMO/6YBLZKHGJN0KP3CDOVXvNogE
         /+gwNiAqzaMU+cKtObEoQ0vLTuIX8JHGrclsBqS+ZboswqPMgqSH3jcVILAO3bHiwbfx
         98N6YoAm+SR5hreOp/sKZfdwWDex/Rnz82z7/pFr72fegxlr+tqcVfDmxgmDChpCKqjT
         hl9lI2HOxkTwS/6qnwz1V7pmig7XlKKLBNsxtKae0afpskgDbhDCA3mUViNFGu64tesi
         E/j59y7/mcCq2K1fm/rAv1rCacvarhjqrGBXy+qfcCCepX1MkJrvUlry0r7P5FauFVu/
         qUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749232484; x=1749837284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v303+LEPWmWGYvudOjYjljcgtQxIwDl/swbpHAPmF28=;
        b=l44EPaf853J10BSTjMyY5qPPUGDxWMpPxv+XhUqUp3T7b6/2sqLUf2/Ovz1qOFkd/O
         c0Q53XXAWIZs7l71X3D1mL+XYRjRdVPHrw/WFV13trIBptX2WrLJ8Qm9Q43XSWcDsBL8
         rMnYOrRnSTEqRCTedJ+/cvcq1XPILJgGfOL5Y0OVk2WtBB1hr5yd2Texgnbjniwt8Ycr
         sb+SVCv3GbhspxcUI8yzvjjMyL1eOoYXnbPeiW+Jqb//IDIV6rclTK6ayeMWxAArOCKn
         iU2KjkHCnhmukbowVaqiRhJ/QE5gPU7lJrhLbv/prcFyeU6f6kqgD9Fk+Xxtvoyv/V8k
         ZH1g==
X-Forwarded-Encrypted: i=1; AJvYcCWsHiGlL+Iawf7Y0Y0LZjba6oIeBiCGRdzOdTqPSjGdpORgBMhdJ4nP1Z3Zl1AW0bGRnUu7Q9RbFf3RH84r@vger.kernel.org, AJvYcCXDPKAvTkph0LioP+ueHxNwyeEdMA5qjGuQnzaBBiE8Hq/z4Ej/y5Ex18s2OydlXNV6PM70asdmr7RXhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Pxsb8qvXRG0HsYj4Jvv9KBGY6UNu00oZZYSbISjJjeLxSmGz
	r/xnUME8CUZV1lsaHI/rjYKrI4E+Prs6kuH4yGAo2xmRtjrnd9uYQlT/ItJV1gW0PHNQ9/1GcoJ
	ULbBePeUfIyY1JlEbnYF3eK0qhSLF1D0=
X-Gm-Gg: ASbGncvzP8aHBRN/qzVBqGIvNla8STJTGZnoGtrE/N7Q7m6ptXtkFU44mBok2vDpQ+b
	CU7tPNnTPozpwYI1tKIyW6MkwntfgE3LhBMZeaguoV6bB5Sp/W5JXrkWaSdWgUadocVyhsMIrU1
	C9gAURVlr3Xlu+GM/op/1ACt2FY/9YaIL7KAnN05etY880lGAH5VxjDaw6naQgzsB1epKTu+W9
X-Google-Smtp-Source: AGHT+IH4gSbanWIfrAO6OUUN8429MgEFAP35ued5x4fBPhwBFudzaPJkOa0CR8qo3pSOLm+UaOBXsXBZRRxam/ZUE9M=
X-Received: by 2002:a05:622a:258a:b0:4a0:92a8:16ba with SMTP id
 d75a77b69052e-4a5baa44d82mr54831491cf.3.1749232483997; Fri, 06 Jun 2025
 10:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Sat, 7 Jun 2025 01:54:33 +0800
X-Gm-Features: AX0GCFspLKPjCd9RVrZoMNH3hGObb1LpzRY2I85Csv_jivRF1vffVRUcyZXDKZE
Message-ID: <CALf2hKuQe0R7Bi2L=vMMrQVehv6geC1TFNYiXNY_Sfua53qi9w@mail.gmail.com>
Subject: [Kernel Bug] general protection fault in btrfs_lookup_csum
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Cc: "coregee2000@gmail.com" <coregee2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Developers and Maintainers,

We would like to report a Linux kernel bug titled "general protection
fault in btrfs_lookup_csum" on Linux-6.12.28, we also reproduce the
PoC on the latest 6.15 kernel. Here are the relevant attachments:

kernel config: https://drive.google.com/file/d/15zwNg6D0mF6eeFOw5zz4QkkH1bc=
K8xCl/view?usp=3Dsharing
report: https://drive.google.com/file/d/1BPmRKH5Not1_y5briNsAcaYi0hXTe5um/v=
iew?usp=3Dsharing
syz reproducer:
https://drive.google.com/file/d/1xvAUqtN1mu-49xfCObEYRn1eFc2Tmk8F/view?usp=
=3Dsharing
C reproducer: https://drive.google.com/file/d/1cdDqjEqpqhoenhWzxF_GNc06kRkr=
rjxa/view?usp=3Dsharing

The crash happens on every read I/O against a broken btrfs image whose
checksum tree is missing/corrupted. Specifically,
fs/btrfs/file-item.c:search_csum_tree() calls "csum_root =3D
btrfs_csum_root(fs_info, disk_bytenr);", where csum_root can be NULL
under certain on-disk corruptions. Then btrfs_lookup_csum()
immediately dereferences root->fs_info, causing a general-protection
fault / KASAN report.

--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -201,6 +201,8 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
                  struct btrfs_path *path,
                  u64 bytenr, int cow)
 {
+       if (unlikely(!root))
+               return ERR_PTR(-EINVAL); /* or -ENOENT, see below */
        struct btrfs_fs_info *fs_info =3D root->fs_info;
        int ret;

With this draft patch the PoC no longer panics the kernel.
search_csum_tree() converts -ENOENT (and -EFBIG) to 0, treating the
range as =E2=80=9Cno checksum=E2=80=9D and continuing safely. If we instead=
 return
-EINVAL, the error propagates upward and aborts the read outright. I
am unsure which behaviour is preferred: (1) ENOENT: silently
consistent with existing path handling and avoids spurious I/O errors;
(2) EINVAL: treats the situation as fatal corruption.

Advice on the expected semantics would be appreciated before I submit
a formal patch.

If the issue receives a CVE, we would be grateful to be listed as reporters=
:
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Reported-by: Longxing Li <coregee2000@gmail.com>

Please let us know if a different fix or additional diagnostics are
preferred. We will be happy to respin the patch accordingly.

Thank you for your time!

Best regards,
Zhiyu Zhang

