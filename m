Return-Path: <linux-btrfs+bounces-17429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCFBBB8D54
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D052B19C06FA
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7024274B23;
	Sat,  4 Oct 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiB41kFk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A88273D68
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759582158; cv=none; b=FMuwqrtoMhQpZiAoMxXEpAiJgq6alURn8gG5GymT9HO6i5AXkAWVuOy42PBgHa68cmfLJ2luz40Sht4BDTaZklMTsPcd+jhdZTI2rVQIkPUCSfiwlBsG7Hts4KZE6HdPyskWwBDFwBSduOfZbMMUeb0KTAbAikckDp7PseK6cDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759582158; c=relaxed/simple;
	bh=aCq8UePDrB42tXJGgjcw8YR+eV84q6rBDEO2j9CV+4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRw+E6RNhAC7QJbq6plGqTdW5GD3ki8vFIdKFYX+XC6rgMJXM+HWrWvOwSwT0T4xZDp5LIgtpvLHNuY0/K56ZTp3e1s7Q0qO0x7ygyUgyH3tWnEKeUYCj88U5ewCs5JlR1reZtQoY//1WKC/7d0w0C5zk2LlnlUjs74I7A+v7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiB41kFk; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso600009a91.0
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759582156; x=1760186956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEDE+vZuKH4UaT6ouGdjH+9d6WJx4gCrcMQATF+m2EI=;
        b=NiB41kFkDrHnGWXXBOLNlj/RIVFtLGfoMDCrUQNN2PYXne0gJ62NSgBy7Ag3onQhve
         SpYoySnpDmVPJbROvVvNyIfRgMdc8/ajIZm1EboZT4j9ssdw76mJxPxqIcC93kUnR2aH
         VsoC7M7R+pQxg0ItiKSaTipm+ff8g9FccnTflmQ9yalRsx4hV7yBOOt0dS/jVyL5N7RY
         DzwqRW4gf7C4vNw7aI+ZS8Rpdwi5JZcSQMhZw74wwHgFksTev3wOREiPuA3VaPwwSjJV
         USkE3+9wkL6XB+oKWjmgSy27hK1JbDOaAn+XEhneiLbE90+sd+JCfAU5GO2HMGNS+9UO
         2x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759582156; x=1760186956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEDE+vZuKH4UaT6ouGdjH+9d6WJx4gCrcMQATF+m2EI=;
        b=qeytQS36BD2w4WLwwdtX7CkYe9wjNandiDNSwVTk+J5zLLUCuVG6QOJLJKAAGVDztj
         pxXEwwUKAXHKiMaURPjtCKAXh4I2LbwJc1fD3qXjRU/yqEfnducQoBlaVV05HIpBfUDs
         cUhgEaojqlVmdaQ1Q6kBou963qM3kHQvm76N7IvpjoMwMahq+4bkKaqDWl9ggjdHXaCj
         0lKLJKzaYSllNVXCm08J+s56YhIZs5QipOKECJSsa2xzkjgmTpOeCHDSq5iHw/POPrd6
         OpSDrMSS0TMsJ2+nsR45zAZa0URUYh7sI6PngqDwGYPwbMhLVrjp6v5Zq8+1jryrBGEr
         BdSw==
X-Gm-Message-State: AOJu0YxNolT5+0IV6fylj6pvctqluoBToVeGS1iQVJXYWk+DAHYpnPBP
	aTPEZpsk0lvh7IvDG2Fd7nXrQ+RITmSHBGteV3ccK+W20koErVPouw1/Kkggm6zYZ6q9Bafj
X-Gm-Gg: ASbGncsl4RRXeAVE+UEULFbuAgyA+bR4QtxUs4Spfa5HRVnELFgRuQmGUdsaUje1V3+
	JeBc9ZEKq/FyrsOs5ZTMYSOUZJD8n3s5JIjvML9ENhn/fbdwPDFrrmvoW5RgChwPCId1zAS1IbE
	XQLYIl8IvUp/P5VPPPBpqfuM7hFADkxD5usiywy2VFknJdWcRFFwNTOzsf5numexY9oVv+Q74Vk
	YKnw1ID7rqmqYGmJN66wGDI0D1BnKUWPrE4/TRVFSw2c7i0NtVSsHuH7s7sna9IJvr4Y9zcfTJ/
	0YucVqb+55wq7wdylS6Pm0aodqoWs/21Inj9aelwVbumeZDdbnKS9PGuDYyJwuVCaFyPtCWm9NZ
	sc3QTRi6a7LPOV9bpXMsbi2hRQzH8Fv7U2oQysvSVMEbFPxJ2jvCu+hPUuV2FvO+Ms2Z66RgkOa
	ClLBFYzWOmRg==
X-Google-Smtp-Source: AGHT+IGMLp6AKRLGcrkl2rElAYSPW3t3W7gBkJrHzmycDQ9ush6BmPCynn2qmtFWwEhFEEwjvXlYrg==
X-Received: by 2002:a17:90b:3890:b0:32d:e413:964b with SMTP id 98e67ed59e1d1-339c271cf88mr4015519a91.2.1759582155775;
        Sat, 04 Oct 2025 05:49:15 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebe5f2sm10942789a91.11.2025.10.04.05.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 05:49:15 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: goto out -> return conversions for previous patch
Date: Sat, 04 Oct 2025 20:49:08 +0800
Message-ID: <5045431.31r3eYUQgx@saltykitkat>
In-Reply-To: <20251002155611.GI4052@twin.jikos.cz>
References:
 <20251002133920.24528-1-sunk67188@gmail.com>
 <20251002155611.GI4052@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> On Thu, Oct 02, 2025 at 09:39:00PM +0800, Sun YangKai wrote:
> > Tested with btrfs/auto group. Tests that require $SCRATCH_DEV_POOL,
> > $LOGWRITES_DEV, zoned block devices and dm flakey support are skipped.
> 
> Is this a standalone patch or fixup to the path auto freeing? The
> changelog should describe the change, not what you tested it on. This
> may matter in some cases but this is better under the "---" line in the
> patch.

Sorry. This is a fixup to the previous path auto freeing patch. I'll resend the 
patches with corrected message later.

> 
> > Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> > ---
> 
> (here)
> 
> >  fs/btrfs/uuid-tree.c | 102 +++++++++++++++----------------------------
> >  fs/btrfs/verity.c    |  14 +++---
> >  fs/btrfs/volumes.c   |  98 +++++++++++++++--------------------------
> >  fs/btrfs/xattr.c     |  29 ++++--------
> >  4 files changed, 86 insertions(+), 157 deletions(-)





