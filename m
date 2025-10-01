Return-Path: <linux-btrfs+bounces-17312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE7BB0834
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350521C2FB8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9022ED85F;
	Wed,  1 Oct 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYohrVHU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24C222564
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325581; cv=none; b=VjwUMGsH14N1FadWZ3d/fm+IWVye5wj29n1YHvlDwSzxLeXZmvy14H+bqxEJ89P5k1KGdsniQ8AHZnK5fD9iyS0zyhnU7OrZgFE720KvfAzMJAU65vVWt/cQPO8qLls31OT/pjA4/yTvBkFh1b4syp4ockik0Qf+Tmx1fzPMWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325581; c=relaxed/simple;
	bh=4b2Cb87Lsvw1SVKTY4AJ/JZMcWAjz/k0IC5D8xxbhNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=V/tV6EqqkRfZatfDksNTlObZEKj+x+3wmy+L82BjPtVWhGJlY3o+yn8tKEV1SDDsRSgVPfy/S9e47QDCI7QlM9iY/vNKzqyaG/JXZE2sAo1XjrOjri6dxxejvB9PUSrKpfd/2+N0+QsqWtA3XJ/K5CRYOqFMJrM3nvCdV0HP6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYohrVHU; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-32eb8144fecso1153291a91.2
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759325579; x=1759930379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4b2Cb87Lsvw1SVKTY4AJ/JZMcWAjz/k0IC5D8xxbhNM=;
        b=YYohrVHUs7wB0RMJ3P3Ly9OTeS1tgwm09OsOMlpRwAlJGGkPXBYcRiI80cncz14pFK
         Kaf7BXEVvDwC7u8548zUKPKqXYtEfR1ZkeZGchmVITvFeH5U7ITiHDQ80QHtLJ3ir23N
         YdYRN/vU4iYY65V0jzcboGC/WT2zLwXSV6nF/frttGjxg1eCAsdO3kkYeB8FVH1X+DDA
         631/Cws+ME9SI+MwUNhbBgeaJYO7rsBMCgG4zRMCu/L4OzI70c+33Dtx+4Am+cH8Oy/m
         nRRxbewurQWNdFAaQqzMCFHhy3Inb4CjnI7FIlKxh2FrVNiXXy9tNpw67gz7UngZYt21
         9SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759325579; x=1759930379;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b2Cb87Lsvw1SVKTY4AJ/JZMcWAjz/k0IC5D8xxbhNM=;
        b=e52XoAcnBZmgdR/3jHzRmromxc0nM7nS9QaujL+bzFDLMuWL/9IgI7PjI4fuDM2GWQ
         u/0R/pDTwdbjfXad/FArEajISH30yEzCpQswGGkWe18Ufwdv2RPeyqiYPdmBVMk5sINR
         2bHPZA/e5PqkEGP6FgmbvNubjF/NmdtrrtSMmpvh2QlINMUsefPg+wYRalWObCGnjDWB
         Q6VbdYdbMqVx0LVfT7PU2abkj6tOvM7kQO54/zZC27gbD1qvzUJtRBHb1FIBl15+fTY/
         axV6Nq7VhMkLUUAEnv2OpsFxvIF3Mx823QlkODkWe9G6myiJY3/mDl1kVEgwxrsdUuFS
         mYCg==
X-Gm-Message-State: AOJu0Yz/Yk5SNgPmCCJXSH7yf4+q8jjfFyZ0ye7NnodoujbbU1ovFhiE
	qFGSHIn5cC/LhQKkBkLDgxTQrUlfdNRzQF2PUYEeOhgx0tdPH4a6dZaV
X-Gm-Gg: ASbGnctN2ZbF3G3UnvrNcwrKYePOUOdFLmWYTm+gPJbrSIJrMtWDZMT4UUS2iQAadbL
	+HmyBrP9eHV9+Q6aQFJlA6Jbi65zD2oSL1dJGZU0esdyRWvi+cSuT6BZPq1/DrslpImXGKIhtEJ
	u+seGHchgZYvtS4ngSpHaGTwZT4+LFoe9Jkzy2aA2wA8ujtTpDCWnOrxxeDpOUXPeAXr06x5GV8
	yjg/47UA7xLxfYaAtJwdFFZkeRG+doxwd5kNKO3spfNKkOdOalghdI4TCHClOIhMJ33BOBKJqNZ
	GIem6ILqP1Y9uKnpGzmaUEA+HkN9V0U/d+ef+vIi7BT68+pvhGVAURrzrUhKjBeSMqjJ9a/l5s8
	ks2LAMRN6OqICdlINJFlVSojAstM4s96Pa3oR4kK0kssDXqPAa1dG9eRndvbewrKHPPhM4ZnuB6
	GGLJQ=
X-Google-Smtp-Source: AGHT+IHeMQktSa3nemNUD/6ZNlawEsAWC0stxPAafBkY6OycZHytlbW2SSGTj5u5Zv8pXkU683TVew==
X-Received: by 2002:a17:90b:1642:b0:32a:8b55:5b82 with SMTP id 98e67ed59e1d1-339a6d8a2c0mr2042946a91.0.1759325578684;
        Wed, 01 Oct 2025 06:32:58 -0700 (PDT)
Received: from saltykitkat.localnet ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9fb12sm2440019a91.5.2025.10.01.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:32:58 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, sunk67188@gmail.com
Subject: Re: [PATCH] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Wed, 01 Oct 2025 21:32:50 +0800
Message-ID: <5927246.DvuYhMxLoT@saltykitkat>
In-Reply-To: <20250930163547.GC4052@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Here and in several other places you did not convert gotos to returns
> and removed the out: label. What I've seen in other places in the patch
> the conversions are straightforward and you already did that in other
> patches. Can you please do it here as well?

OK. I'll send a v2 patch with goto -> return conversions later.



