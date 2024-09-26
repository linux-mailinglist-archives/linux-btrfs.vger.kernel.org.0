Return-Path: <linux-btrfs+bounces-8260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A50C9874E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABA4283B5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1F7A13A;
	Thu, 26 Sep 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOdGv1Kh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6683A8F7;
	Thu, 26 Sep 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359058; cv=none; b=t8pHx2PqP8hMaNgDRyT10ZQhWW+fUvGtWpA5OIytzn7ki0yHMZFWrsLAFiPOVdLsRrfgY1x8/3SrqmoxiZkH99xaSO7q2yQ7m0Vh/RD4tGFhtYgpJPDLFiY3VZhb1caXT5R0WdTI3F0dg/oICAYbGp8cZdQJC58R8pJkHt4QU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359058; c=relaxed/simple;
	bh=HuKbTraMdFS5Cz+lU8xlBVC8V5sYSKy3oeAPaf1t2Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KERVoaFM4ASmYkjFtTcO2xGuq4scTxWlmI3NbXC43D0CjExpusVMAFtixQYfbF+1TuEB4OzGy8sZIYHnjtxkNZvCFiTO/MqoYRXEQBo3JmSZ99v0s4z3PodwYChP+1A54gMWsbtAm23Fa4teebMQ8uatM/xeTkokeXxoP3mJvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOdGv1Kh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so791508a91.1;
        Thu, 26 Sep 2024 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727359056; x=1727963856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRJ2HvXm7OSGhYt96SUGWlF8LCywL56E9HYCqscXpc0=;
        b=jOdGv1KhO5MppowucR6ioEpuy+/fIFR31ExINUPRiA/eJDd+wVGg1pvfThlIhUBqBl
         t4dNkJeQF0XrG0WGEBYR1J5OuKhY1q8ME6Fis5yhwD7zOof0QXroCjJtMOA3mapbQ3Md
         MWvSpXFjLPHaxPdItrJi/cby6FLhB8xd7kdwPxsNXCy42GwgMGCE1sd4VQyUMaFFcTPb
         qem12/IKyUvzAWMrCz1XkjcPIKCPbL3KVO8pv71NYAOGgiuYX6Tc5UvH7pdKYorPw+Gh
         4a85TsJlXECSR8fPhr6vZ82veelRgNP8iF12SiwQM0spio2J6+cQMikb7ifH7Z2r+5rt
         dH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727359056; x=1727963856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRJ2HvXm7OSGhYt96SUGWlF8LCywL56E9HYCqscXpc0=;
        b=DByqqUH3GgtF5KsLpA5Z9lLOnJZz+dgK8iXFztuNSocUkd03+0rJrC+n6fY8toZz2e
         Nh07792Ukrg16UOQG5KuFw1d5rtRSFK3U+nxRrNO16aeHJ+MNbI/WOHkFdbNcBWDFgoI
         HB/bcrtQ6TUxtJOnJXOUd01ce3ajNCMJc2hf9ijU2quYUjmgn2Pp6acX5+s8a9i1RiUE
         BttZG/3wmy8UgNZycsV//HeWMHICujutYoaN/DaBDGzBup326teo7KWUeroqA2DggEsh
         Fknx6r/6cS2n9z4Hasq1tLWFs0SpAClWKUJZl5QPLnaItZWySnUb4Sez1dbkhE25GFYW
         c0xg==
X-Forwarded-Encrypted: i=1; AJvYcCWgHZdWiH7YjwZVIoesUOvVrjKhnGIq2QpK4X/cTNgsJ2CqhrqPR7YGhFEGqcmUQbXShriMU2+ACtjzAhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuiCocxb3SVDznRAGCm5oNRerZ4tee4PkSl+xxdErQdS9EFRA
	784SW8FsawMPcSQ1H1Y8YqHKynrgLwbLInZ0UbjOmsm/twT4PlPrCDQrCh/E
X-Google-Smtp-Source: AGHT+IEyjYlmezkxiInaJX9hSCzwbibA+eX/v0N4ioxPVRgFiKquQWgdB9rWRor5WwQp3/nuS6uBEg==
X-Received: by 2002:a17:90b:784:b0:2cc:f538:7cf0 with SMTP id 98e67ed59e1d1-2e06ae2ccccmr8207603a91.4.1727359055992;
        Thu, 26 Sep 2024 06:57:35 -0700 (PDT)
Received: from fedora.. ([106.219.166.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6ca3bc6sm2623a91.32.2024.09.26.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:57:35 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: fdmanana@kernel.org,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: add missing NULL check in btrfs_free_tree_block()
Date: Thu, 26 Sep 2024 19:26:59 +0530
Message-ID: <20240926135729.4578-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <CAL3q7H5vV1MLODuCHr1p4Dx6tMGOMeqxDnTGMsDz290kw8Vsew@mail.gmail.com>
References: <CAL3q7H5vV1MLODuCHr1p4Dx6tMGOMeqxDnTGMsDz290kw8Vsew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If that happens we want it to be noisy so that it gets reported and we
> look at it.
> Letting a NULL pointer dereference happen is one way of getting our attention.
>
> O more gentle and explicit way would be to have a:    ASSERT(bg != NULL);

I am wondering whether it would be better to have an ASSERT statement here, as you 
suggested, or use a BUG_ON instead.

I haven't personally encountered a null pointer dereference issue in a live kernel 
environment, so I'm not sure how the kernel behaves in such a scenario. However, it 
seems wrong to leave it unhandled as it currently is.

Regards,
Riyan Dhiman

