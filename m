Return-Path: <linux-btrfs+bounces-11180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5ABA22E3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB37188228B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48F1E47A8;
	Thu, 30 Jan 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="ewZ5jKHT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69C1E522
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245120; cv=none; b=OLiQb+7baRgr9sI0u9RgEP7WL9ayZy6OI70p4OtoqUFvul9Z2qo6F8z06/zeuhFnCgw9oVbfCPO/4TwHIg6jp6o6s707FPd4fpaTZzqEgmeMiInVbWrPSqky1XCbiPzQUerSUwywtLKDIxhy/eYj8hPJRJV2yimD5LlGSFqOEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245120; c=relaxed/simple;
	bh=M31ZRa9vvYtOrk0EZww8M67+WnuIPC6BqW1sTLOGhMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OLNebOonELkNQWmO3ZKbHZ6N/4TbOcwKZy6Kyl+MZzb/VtEsMV6m7pd6fduwVsNTwN24M9b5GGRZbMS7u6oVYAnKxQ0Gzzqr55oSIQUhEunpqNtHJs7UajDw0lw/UYV63BJkrkXF8OLWgfufL9TcpnhC0GqWkWmWpNA0NdJHywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=ewZ5jKHT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30227ccf803so6290271fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1738245114; x=1738849914; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M31ZRa9vvYtOrk0EZww8M67+WnuIPC6BqW1sTLOGhMI=;
        b=ewZ5jKHT7f+WPhCPP8AZiqsiePFUCrGx3ZX6AzXqRB4S76QNWlh17UG7+RDD4TlXN+
         9Z39ycYFA0eqO2G/oNa4tMhqWVUeaSHk/UeXpmDi1TPtJMDapoxuoOa34ctHUkNF3cr+
         cxLAV14AuXY+1Lv3qKUGENIsVdwwWqy0pGYwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738245114; x=1738849914;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M31ZRa9vvYtOrk0EZww8M67+WnuIPC6BqW1sTLOGhMI=;
        b=Po8v9rXnoMGQ/o6drHnsGfZ5MC7NI25WqiSx+9Ji5uU+QwieJ59JqmZlB5oAfL1cM2
         YRTUYuTpZBnfd8XrGBo4CSAUHPXU7JyK+stFIh6rXW46ewIRyvFq2I0g8ZVGou8YRnnq
         4ShFgBPO7pCkpkjuqBXM6dLs3deRm3+zotJOW0mDIzx4xcv19Q9l0aR8qx5gT86d8GKL
         XJ4qsEwVPFWWM0xfMVakMsuwYcrkfWFFA+5a5B/CP2P53132ccWb1sYpSLwdxjDkMonG
         fkJ9wIVPXqfOmkwWcFrryjj/J/gUAQ/YoutcPxTCS8E0N5fdixSfLk22TCk2PflQIbZ0
         f06w==
X-Gm-Message-State: AOJu0YzrpLlAGsRYLbPtG7dymftEW4eKGMl/M1T4kG6hiaXZHwoI2GfT
	fW1bnx9OBfu2Fz0rEOczLXSrracGFCX4c1hA0nseIqLNgHsd09Jnr7Mgg05m2cf1zaUXV6QOFoD
	I5VdFSu9rLWypbFaTfHGhnz6uW7oXHOf2Ov/YJ5RRafs1wExkuUytFw==
X-Gm-Gg: ASbGncvff3IUVs7xs3TmP+8SFN3nFueio7azRQvwnp4iEB2t+sZiZZI1Sr4N8ZKcZeo
	qs8ij/9RmQjio6kyXpr4OTxeDCfXxuVn/iwnkCXAaLC72SdKzMno/GQ6mXq4QhUpztCkRg2SdW/
	4Rx1M93erHZaSFXaU6vfvaDCj+yrGE
X-Google-Smtp-Source: AGHT+IGAnzxhecYxO9fMbTE0e9UWvLcJySaBFCx/EFUYWvmalcxdoCiQZ3LZnvYdqKH1oiOe3NEDqgc9OeS3RL6sQ8k=
X-Received: by 2002:a05:651c:220e:b0:300:2d54:c2c8 with SMTP id
 38308e7fff4ca-30796811e9fmr27941931fa.8.1738245114328; Thu, 30 Jan 2025
 05:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han-Wen Nienhuys <hanwen@engflow.com>
Date: Thu, 30 Jan 2025 14:51:43 +0100
X-Gm-Features: AWEUYZlmzENA06mJ4Dd_mEBDCdw9NYLpgPgAOsp3b09SUGg9iFY_7ox8DFKr9Yc
Message-ID: <CAOjC7oMrMRy4jemm+910qwPHSTVM2evWSDi3xi9sh5+n=Qf4Qw@mail.gmail.com>
Subject: Bacik's recommendations on parallel FS modification?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there,

at $DAYJOB, we are considering whether to use XFS or BTRFS for an
application that needs reflink functionality. I was reading up on
BTRFS, and came across this bit on Josef Bacik's blog,

"For heavy applications that modify the file system in a
multi-threaded way we=E2=80=99ll often advise making subvolumes for the
directories that are being modified."

(https://josefbacik.github.io/kernel/btrfs/extent-tree-v2/2021/11/10/btrfs-=
global-roots.html)

Is this advice still relevant, and is there any documentation that
explains best practices in more detail?

I looked over the docs at https://btrfs.readthedocs.io/ but couldn't
find anything of the sort.

thanks!

--=20
Han-Wen Nienhuys | hanwen@engflow.com | EngFlow GmbH
Fischerweg 51, 82194 Gr=C3=B6benzell, Germany
Amtsgericht M=C3=BCnchen, HRB 255664
Gesch=C3=A4ftsf=C3=BChrer (Managing Director): Ulf Adams
https://www.engflow.com/

