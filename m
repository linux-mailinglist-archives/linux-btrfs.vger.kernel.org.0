Return-Path: <linux-btrfs+bounces-14217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F6AC2E09
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5411892144
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 06:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBD11DB365;
	Sat, 24 May 2025 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcMe9s4m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B21714C6
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748069553; cv=none; b=ouuqh31jGVctbT0ubw4RRSc6u1JgmLJDtgjAdtB+r34JLF1w8AyQ8XCPfr3fdPWUt9TVltK3XzvgthZ3vJgnGPKwwgVL5GPFZEg4vhBTsN8MSYUQe1IwL54rfsXFi8wnp+o4svnZmS+zYLWMpu/jE8CvEh2nOos4CHoEjqYHCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748069553; c=relaxed/simple;
	bh=Fabv+duZmVBVspO5OsrfwMl2W+HRWlMuUF5mkGX0UVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODZh3aRYBcLNCGPPHyhC3fSH1/PMXFOx0J+/Q3jjgEGqR7MzzRXhFBFAD4uCLFzzu+HjnIStteGNNwyLzTjGf8ajpMJcW1odbjNuAjtuu/yrAinKc4h3si2WBXR2CGIiYrVMNRqxB86XgkTzf0MsCFbjoQIezfM6o0aEX/w0EFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NcMe9s4m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748069549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6ntayVSbMHKAnivRXqeJJBh6EwS1D/6PChDHFH+YX4=;
	b=NcMe9s4mgc186FNakeDbSWvAVTB8DgU4pGdFjowmjPx5yxDiXgmdEXszujX9i+70jCZayH
	oCg1IbxoWTxxWvt/b3NBEDA08Fwa7D2IfEia0WStqw/UGQpYymWhz86e0hSxY1AZHM2tuJ
	dqPnWR7355Qc9916/PVo9o4kZWoUyTQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-uvsOEfidNweOMhc15gFETQ-1; Sat, 24 May 2025 02:52:28 -0400
X-MC-Unique: uvsOEfidNweOMhc15gFETQ-1
X-Mimecast-MFC-AGG-ID: uvsOEfidNweOMhc15gFETQ_1748069547
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-745e89b0c32so1097435b3a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 23:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748069547; x=1748674347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6ntayVSbMHKAnivRXqeJJBh6EwS1D/6PChDHFH+YX4=;
        b=dVg6BuSKgAAA9Q1Xdp8LtPAP/Rjc7z3JvAYKPwaUoTVLlW601tmhfRqyZ1a/wosnu1
         kNZ9YtslrvXvq484j3iWs3xP63kziRY0CkvbelrGRrZjFehmkj4/YhxqAKCoYwYSf3e0
         SOvr1VdoXM+9JGnfHyg06qvuN0JxoH4ztzWBmhMJ2eTYAWk1z3ZEw8QFWN+s8OnWKz50
         lXVvZr+jPC0ohEW4RhEhq5nKddgsuS2UbYbYAtrNUV41sv+oz7PmJWh/OL9C5Q3USaiP
         KqrzG1hA3ZYrlHnEfCvWVAyqSU3mwe+zBoMMlJWAzRxGY7j3jplK+aGBEk6cwXoNz44L
         UB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbJRE/+E1W2mEjnqd/S9StpjCLqSFG1kKjjA2zvOZiWwdVwfyIemUi3hGYJaam//HOr2IhI/QEk93Waw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIBdcjnqiLZ6RECTOLFzUWNwlljL0Xg6Q8VXRPCcDfCX62AwQ
	2ws92+FqD+8fCdk7Oea4TSv7zM80shMnHbbuEEuXTTHPFcTmJXn7DsdlLN/hj2n7hAv2pFV32Qq
	SYLNREJpAzYcjMl0ZiXwKWByFoL/kKMC3uKIbUb93rfzwy+JxNZny1xRn9IhVeWO1
X-Gm-Gg: ASbGncu5TuockS5+o10QQ42Nn9Il+qsb52dHxMmYDrPm0k666o/atWraMDEWGU888QJ
	fojFaOIYH/7KcyC3d+RJzCT3gPTizKbTHKuOz6jM3cf/4doAWO1eT1ip1F2ZhVCMSv/m/m41Zqo
	KQPDcQGgQlCSPRLLdZxCDRvZSc9aDlixadq5/yOMKKPgS1PU9A3Ercnib3EgRMD+lzECMtjPgYH
	pOTY9CXh2NI6q1Zzr4tnimYrXtN8isTZIxKp7znbkwRjDQctfGaMpHk8CO+DAGhlwlOcrAmHkDd
	U0KACXvTReyrv3RB0VL2FJZpkBI+OZIO85SmP5doTYOHPNodvsfP
X-Received: by 2002:a05:6a21:999d:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-2188c1e7e29mr3532889637.3.1748069546913;
        Fri, 23 May 2025 23:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTUtqF4Y+WOIsa6cEhIkowJGqGE/U+Qoq22RZnoHHlJyf8tY9Un5tIJHvXQYS1yZGk+FZe9Q==
X-Received: by 2002:a05:6a21:999d:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-2188c1e7e29mr3532872637.3.1748069546555;
        Fri, 23 May 2025 23:52:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d1b2sm14247368b3a.66.2025.05.23.23.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 23:52:26 -0700 (PDT)
Date: Sat, 24 May 2025 14:52:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
Message-ID: <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>

On Sat, May 24, 2025 at 03:47:16PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/24 15:14, Qu Wenruo 写道:
> > 
> > 
> > 在 2025/5/24 13:38, Anand Jain 写道:
> > > Zorro,
> > > 
> > > Please pull this branch containing fixes for btrfs testcases.
> > > 
> > > Thank you.
> > > 
> > > The following changes since commit
> > > e161fc34861a36838d03b6aad5e5b178f2a4e8e1:
> > > 
> > >    f2fs/012: test red heart lookup (2025-05-11 22:30:30 +0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://github.com/asj/fstests.git staged-20250523
> > > 
> > > for you to fetch changes up to c4781d69797ce032e4c3e11c285732dc11a519e3:
> > > 
> > >    fstests: btrfs/020: use device pool to avoid busy TEST_DEV
> > > (2025-05-14 09:49:15 +0800)
> > > 
> > > ----------------------------------------------------------------
> > > Johannes Thumshirn (1):
> > >        fstests: btrfs: add git commit ID to btrfs/335
> > > 
> > > Qu Wenruo (2):
> > >        fstests: btrfs/220: do not use nologreplay when possible
> > >        fstests: btrfs/020: use device pool to avoid busy TEST_DEV
> > 
> > There is another patch that got reviewed but not yet included, and it's
> > again related to nologreplay (this time it's norecvoery):
> > 
> > https://lore.kernel.org/linux-btrfs/20250519052839.148623-1-wqu@suse.com/
> 
> Nevermind, Zorro has already included this in the queue.

Yeah, I've gathered some other patches due to I want to start my regression
test on Friday night, to catch up the release on Sunday.

You might care about below commits too, they're in patches-in-queue branch,
feel free to check, and tell me if I missed anything:

  f405f5f6c fstests: generic/537: remove the btrfs specific mount option
  3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
  282e4fe8c btrfs/023: add to the quick group
  3c21ae673 btrfs: add tests that exercise raid profiles to the raid group

Thanks,
Zorro

> 
> Sorry for the noise.
> Qu
> 
> > 
> > Thanks,
> > Qu>
> > >   tests/btrfs/020     | 49 ++++++++++++++++
> > > +--------------------------------
> > >   tests/btrfs/020.out |  2 +-
> > >   tests/btrfs/220     |  7 ++-----
> > >   tests/btrfs/335     |  4 ++--
> > >   4 files changed, 22 insertions(+), 40 deletions(-)
> > > 
> > 
> > 
> 
> 


