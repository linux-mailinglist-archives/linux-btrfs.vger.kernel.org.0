Return-Path: <linux-btrfs+bounces-1464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D482E93E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 06:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36579B22574
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 05:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7081CA7C;
	Tue, 16 Jan 2024 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkejzLjk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171F8826
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-5cf87cdc4c5so289534a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 21:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705384301; x=1705989101; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eUz24UqMoiRGdyvWpIQc+WFa5h8HIEkpCem8hDMklQA=;
        b=OkejzLjkSJE/iqFLtKRWz/Kkb+xMhszdqmXh+bMh2MmH6JQBgbf9i+RM5d5UJWYlf2
         nqz+J787cY1M+OkKvpVaISaGvZCEPs+a1Se4+iCbL7XNU59WudYVRxSo6ATnLFpR4Bf+
         8FtXyJa/cccFwQnIj5M4oAJe7jfpWfyDMvAR6Iz3vVnEXo6k+2x/NlrmpsJ5ICF/ZFTw
         ReMQJjMXlt9RcwQC9bLOoLP3h7XpeJbL1YiEuJ+dCS8DuWHEceyQDGQfc+c+g0mcH+Kq
         B6SulKSuinabaJmD1fyWyveNJjcp49BmdUHD7rfjqkRWmTzOU/pVAyKvV6fPwIIeQIPF
         mpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705384301; x=1705989101;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUz24UqMoiRGdyvWpIQc+WFa5h8HIEkpCem8hDMklQA=;
        b=RTjIo4RsZnLnItDywJ50g5oHnPtYMptV3pEpRaeUoCur152nq7gwqxAPJf6Gkki/ey
         J3K3GLmf3B0OWbqkgLeA4t5DkG8K58OOhuyVoZm7lrgKPwkUTNoNLkJVj28X0zsHvzzI
         ++HJGdqKxkAna6DbtDlA8FZtVKHBhlJvWbt90cQdQN/e6fxSEAad/fr4pgsHzP+uFicM
         B9xcOYepBY5T3YZ9CgIgqJZ3CovsfCKsNgABLDbhMjc2uGiy7zATZ2qTvLWWOHMKHunT
         ugD2JTTSHc2/BccfWy9/6jKT3hR8Lwwa/DMU3sfX6UTYKaIH6yfdVWPHnYhM2cLTXduN
         yl4Q==
X-Gm-Message-State: AOJu0Yz7lBNhhMLSZ8bRQok1ewDLAoxAQmu7GGW+NdnqM3UwCIsIYmne
	a9wcBWAW7xkmNOrr1vcA/5keRNqxO0vHR7a/uJC0pjmtV9gQG1ZaZB0=
X-Google-Smtp-Source: AGHT+IFa9v67bUHJVgzmI3YG2P3Ik0QWfMpb+w6kBF8vaiE582y1/k5usrw/pte0iUXSEE9YxuH3k/fI2d9xmYGBOp8=
X-Received: by 2002:a05:6a21:150d:b0:19a:fc52:4423 with SMTP id
 nq13-20020a056a21150d00b0019afc524423mr3064653pzb.11.1705384300794; Mon, 15
 Jan 2024 21:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gowtham <trgowtham123@gmail.com>
Date: Tue, 16 Jan 2024 11:21:29 +0530
Message-ID: <CA+XNQ=j6re4bhRDUebzPLDvMtZecqtx+GRRPgpd9apss+vOaBg@mail.gmail.com>
Subject: Disk write deterioration in 5.x kernel
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

We use BTRFS as a root filesystem and have recently upgraded our
servers from Ubuntu 16.04 to 20.04 (from 4.15.0-36 linux kernel to
5.4.0-137). Post that we see a deterioration in the disk write speeds

# dd if=/dev/zero of=/var/nvOS/log/dd.img bs=1G count=2 oflag=dsync;date
2+0 records in
2+0 records out
2147483648 bytes (2.1 GB, 2.0 GiB) copied, 2.72458 s, 788 MB/s

vs

# dd if=/dev/zero of=/var/nvOS/log/dd.img bs=1G count=2 oflag=dsync;date
2+0 records in
2+0 records out
2147483648 bytes (2.1 GB, 2.0 GiB) copied, 3.11866 s, 689 MB/s

# btrfs --version
btrfs-progs v5.4.1

BTRFS options
rw,noatime,compress=lzo,ssd,flushoncommit,space_cache,subvolid=269,subvol=

On average we see 10-15% slower speeds on 20.04 when compared with
16.04. And this data has been recorded from different systems and
different types of SSD.

Are there any known enhancements in BTRFS that can affect the write speeds?

Regards,
Gowtham

