Return-Path: <linux-btrfs+bounces-17639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026BBD0075
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EB054E20B2
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DB258CD0;
	Sun, 12 Oct 2025 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmPXt/fA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFD23B62C
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760257462; cv=none; b=VyuAwIt/RAIp4xY7jSJ3Nk9TSh8aQXCgGlNsuiUK1XvxHvG1Q79XrhBghSm+NbUSlq2OyUQLPHwmDD2DVqLhF3/UDnd7wBiAckiME2A8rPQz7K8ZnJBCmi36DpFp7f/GaNhfWCH6izWPzjzciCy4eCbyH2vt91b1E9g5xs7IKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760257462; c=relaxed/simple;
	bh=g0kdLykgyrZedQKVHPh89payJQeJMwZhqaJ2Wn/yj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC1DVDf4u7NFSyAGUY5s8Br3IweQwGNlfEj+MkO7Rgc07uWJ6bs+FjDjyM7cyX2VuuCiRepRR2FSWzZT9pLc9CyurfIaBkoHj1cPDrUKZJP8l5w0xliJuaPuReXaC2774BTI5/DZPNHoOG1hEHYqlJkR6M53QVjL0Tm4VsUY7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmPXt/fA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2726968f8f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760257459; x=1760862259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0z2l7KfDn6RJq1Lvfb8g4qGuEgl8C2qgZKEkkLs+v8=;
        b=OmPXt/fAe6UG8+gL4zIiI1bM6HxTTxC4zBJoJjV/1ga698o1PHwE01pS19Mtlb5PjF
         0J0xAivqKcCKY9sEjC1fH8DR1B5q57ZphD5TlOVdKW2KyRbZzDfrRtLLoYwX7K9bo+BB
         a4zFIOhguQfj20+0WM5QI163FyUDws9t17jsjh1VA0Np8cMu2qTEMcbsWjbpVEKIiTWK
         Lm+4UHLo5UGKTgGVwiET6inxjtYF0Z1WxNDjP6Xmd3KYNfxYHW6nqAmb32iHGPHhAbWi
         7SOThTG9jYU7wetML4akPp8ROJ3sfjetRH1+BSltNHI+66fb3zxfmxtCcsSZpwusqB/v
         DtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760257459; x=1760862259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0z2l7KfDn6RJq1Lvfb8g4qGuEgl8C2qgZKEkkLs+v8=;
        b=Zmkdkgg0WSlA4jmIpSqFVIjET8neIc0bfmPDHSdHs9YtsnxUpNyB4nsQBL1UoG0PiH
         NJXIRITOa8apjdsNKgALQsWnO4x53Heg/nrXeDWRZICg5lAsfOFOyA3wVQXcTrvhT6IW
         z3MmPOpKUk++RIMSgtft7ZlKr7Thp4u1HpE8Nq7EI7h6QcJE/dLoCCxst5MED6TrB7Q9
         fVMBKlK8PowSahcEuwQu/2Sdt3XKPwcfQXqFTMnLBDUwnxdZcGGisKQIwASb0Lr4Z0Mz
         N6v3xn4jyByOCsnH3drAxr+cDTtfIW1+DSVO4RaHz99w9wbCr+TlausiQWAJ3rpEcds0
         XIYg==
X-Gm-Message-State: AOJu0YzFzFfeVObSqqYGM4mNs0vWV5CBR0Yp7LF14MbJji/p2qV9VxqY
	5yYIU+y3Is2wzDXFkRLadBhQMy0i+C//RL4sUWbvJonunQG1hkyWIFh6
X-Gm-Gg: ASbGncuB3kNkqDZT2TPj+e8M44hO4jEpDbDaO4XEby7MvMBXQqVszL2+5q+zoDBDyGN
	Kb0n7FQCczq/hGZXQxWXqNN9ue9mI9Iq0n2SQOSwfEqtconNPaFZWAJd2lFyyranDFpNoeEt85u
	DwY1Ps79SvlXpAGZBEIsfe0y6rtH/y7hkkyuc0eqXdPLDlMDxd2mmV/knqM+jY9ACdSfJDqBzRo
	X+zQl5zNCHWO8l1Pqaz1BLTY2k/Tk3Wj+BvDi6Vde/jmY3/KxMpvm5rcDbR9YFUsWzv71uEa8Ia
	Y++OmrBmxZTfOy1ovW5LDNCkcCsPbpcDDECdYJ4QL5PJkHITa7dFbC/gNLJXSPOgZyrzV4i2rPU
	CC9kW/vOxn3urSrmXTBdqWGCcwc6R5jK7a8jga6of/z3oG/vuEyk=
X-Google-Smtp-Source: AGHT+IGMKTAAKkSYv7hTQ9xsKSm6U/W/OnHIRVB3qiJgLZez14VUJlifIHhUZtKa6PRhU35BZoM5pg==
X-Received: by 2002:a05:6000:2003:b0:3ee:13ba:e133 with SMTP id ffacd0b85a97d-42666ac466amr10312500f8f.1.1760257458521;
        Sun, 12 Oct 2025 01:24:18 -0700 (PDT)
Received: from localhost ([87.241.149.212])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5833dcsm12142557f8f.19.2025.10.12.01.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 01:24:18 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Chris Murphy <lists@colorremedies.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is being frozen
Date: Sun, 12 Oct 2025 11:23:55 +0300
Message-ID: <20251012082355.5226-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <wqu@suse.com>:
> There are some reports that btrfs is unable to be frozen if there is a

I tested your patch on real hardware.

I applied it to current Linux mainline.

I have btrfs-raid on two big disks.

I started "sudo btrfs scrub start -B -d /" and pressed "Suspend" in GUI.

If /sys/power/freeze_filesystems is 0 (this is default), then your patch doesn't work.

If /sys/power/freeze_filesystems is 1, then the system stops to respond for a minute
and then suspends. Here is journalctl:
https://zerobin.net/?e3376d7d056dcb04#LyzGFYeVdWsbZfgC25G4TuSct6QDyZ278gQlZgCfR94= .

As well as I understand from journalctl, systemd tries to freeze userspace
process "btrfs scrub" and fails. Then systemd times out after a minute,
and then suspend proceeds.

So, in short, this is not complete solution yet.

Also I tested Sterba's patch, and it doesn't work either:
https://lore.kernel.org/linux-btrfs/20250720194803.3661-1-safinaskar@zohomail.com/ .

I really want this bug to be fixed. Please, CC me with your future attempts.

-- 
Askar Safin

