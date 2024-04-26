Return-Path: <linux-btrfs+bounces-4560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106DA8B425D
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8461C2241E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B339FC6;
	Fri, 26 Apr 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="kZxz575y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACD374CC
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171942; cv=none; b=XZRBvwSV4/8g6W0BzVBXmxDWkG4PoWFFNvu1EzwWtwKtsdfvLVyKiW7Nct0bCQX/FjWCUB9byjBARoZuDxOw0ZsvpG34jBNDSVro1Kp+zQ8MzkCCu+I2r2NGgxE+Mqb11rdevCpaqB9N370VY9AfEI98N+S17XII/kiV3jMN3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171942; c=relaxed/simple;
	bh=lQPtI6ZrgQ9c//h71VtHUQ1DDN7If3vXpP1dsgFkwSg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=hyDss699+53rnFHtDN62IYJdzhu03J6La0OahluyYJpvOjUdXJyDIblRjQIU8FMU1P7+Gv/ma0BhasYV/wGV71X5/LFAVdly9FgQw+tg2DYV4oWxgP+DYl2fLYUdsoty8fk5ClyQdQtYlH7PG1CJHBK0jN2yMH6TLYmczLGcx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=kZxz575y; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2def8e58471so37780821fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1714171937; x=1714776737; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lQPtI6ZrgQ9c//h71VtHUQ1DDN7If3vXpP1dsgFkwSg=;
        b=kZxz575yn2uWSXnQBwuNZR6LWeugWO1rYSVIPsGfr517ToKolZAPknUSdCLpnIbAu0
         z6hkDyHaZ5sM+8Luw8bpiDVYi+CMl6+ZKjisJEj2BegddGxfDBz9nT7sS8nuo7/JXJqa
         0iOdIb25+UWTp+7ccUcQ1Ao72RFVdklJFop8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714171937; x=1714776737;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQPtI6ZrgQ9c//h71VtHUQ1DDN7If3vXpP1dsgFkwSg=;
        b=mX9LOmsMZ5bnOlF9pNZNUGOkPwAIaTyg2fJANVX9xUyHa4XwiirlKQfiMzTu27C/5Y
         HMGYXWd0BBtq1jy1LMguI0rsSWzxLDOmrHxBofU+GUonLE60EfFb8RJe3TKgTqtqu/nd
         qMu/tV/GL3Mh1L/2btKpK1ejuy97EV2NQO1eDA8JaeuvmHUo7vmlCuXSBxwrzDVEge15
         xbvd8qy2falFg/mkODBtSXRMtyqHPj+8GH3poMyKzmJwjlSIc1NsASYIjvZExF1uVtEM
         KspLaTIfc0Hj46FacnMJUBFUUa1YtzCHP8mlqZB8FHWxHgN/8PoaRxd11MgS4N4/FjO9
         KslQ==
X-Gm-Message-State: AOJu0YwUYs/8Um8oXLrdYpPTdKhvZbd2TOoJ1Yxl5JqkRIWN3oIJu01/
	fFlnZGwKn9wm/iVUzsikilJ+BLpgqf7VcARUEv5NX7vk1sAhw7gUvWdoMtSaPn+zntKvdp8aW/2
	eAuY=
X-Google-Smtp-Source: AGHT+IGqA8QtcH1FoNypXIOgrQ3HplkpFt3Hzb8GG++xYGcayLNzicoFZantPWKkWz+kmUuk9mLT1A==
X-Received: by 2002:a2e:3c0f:0:b0:2de:4710:2dc7 with SMTP id j15-20020a2e3c0f000000b002de47102dc7mr3154804lja.1.1714171937345;
        Fri, 26 Apr 2024 15:52:17 -0700 (PDT)
Received: from able.exile.i.intelfx.name ([109.172.181.47])
        by smtp.gmail.com with ESMTPSA id k25-20020a056402049900b005700ef75274sm10457801edv.33.2024.04.26.15.52.16
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 15:52:16 -0700 (PDT)
Message-ID: <63a537d0467f3bb7683bd412c25c006f8d092ced.camel@intelfx.name>
Subject: What's the difference between `btrfs sub del -c` and `btrfs fi
 sync`?
From: intelfx@intelfx.name
To: linux-btrfs@vger.kernel.org
Date: Sat, 27 Apr 2024 00:52:15 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I've been trying to read btrfs-progs code to understand btrfs ioctls
and one thing evades my understanding.

A `btrfs subvolume delete --commit-{after,each}` operation involves
issuing two ioctls at the commit time: BTRFS_IOC_START_SYNC immediately
followed by BTRFS_IOC_WAIT_SYNC. Notably, the relevant comment says
"<...> issue SYNC ioctl <...>" and the function that encapsulates the
two ioctls is called `wait_for_commit()`.

On the other hand, a `btrfs filesystem sync` operation involves issuing
just one ioctl, BTRFS_IOC_SYNC (encapsulated in a function called
`btrfs_util_sync_fd()`).

I tried to look at the kernel code for the three ioctls but to my
untrained eye, they look like they are doing different things with
different side effects.

What is the difference, and why is it needed (i.e. why are there two
sets of sync-related ioctls)?

Cheers,
--=20
Ivan Shapovalov / intelfx /

