Return-Path: <linux-btrfs+bounces-4801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DB8BE487
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 15:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F69928316E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A915749D;
	Tue,  7 May 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdLKWmS4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D613CF9C
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089456; cv=none; b=h5X8JUYYvsD3apCcKsvfv74iFqY/4iw3DGETu4l4FznvbpRueYGl0/QaMehTr54zECXQ9d+ge/S2GHjtxWgVQpWAxa1dezN3pSNRvjzHLH8YEnSK7Iw3W4m7I2UoirTs+eV98OGVVdLViIM0I7QB2x0o1A4ww4PbIlk0EG6xdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089456; c=relaxed/simple;
	bh=C4dIGze5kVbHp87IAoWuWe6Scy6WbU8Ik6O66WLGg+8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=caASaJ3JEI1IqyxtySXNUVtLuZkSUFG20oXX9GeIpNavzaBRwCsVKnVyxAsNPuEOvpeVkod4N2XxZzLBMCeY75Pif06xYstRnEzmcHZJ9tEH1U6JZ7+LeHEWnzuZW3KDAO+5NCOFPGCqObNf2K1JCxK6LH9jHpO/2whJDmr7VIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdLKWmS4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso3017398b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715089454; x=1715694254; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHOftKUN3M/bU3y9C5iad33BZf8kzQV/Yre3ckMd+E0=;
        b=CdLKWmS4jAXyLH4NAOs02+TGQLe/yEKMjTni4ej7BTJRuq7wzugd0Z1lIVtpNZjM6X
         2rTaQe8fFCE4WBJo3yeHsTdwyvs+E2MGP6PcFkww7My1rYTdMbi3sTtPtsDs5D2k4MEQ
         3uFBtYdw0ZhZBP9cfseHw2BCSmWSHNJnKAKKIy7mqPhEazrDpsy5byEb3mihDsq4juKO
         WsqjrnHKCmlzbokuW2etmfcnLE+ls8sYY4LwRSSJk6t8QMBo0XQjSSv7rzJvBVt6l2PX
         h5j/N/uBVY/HZPamH77gAD0XwWO5nIr8TB9vPxxbovdjgEaOYuCuacjNU08kXNgk6kZQ
         oiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089454; x=1715694254;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHOftKUN3M/bU3y9C5iad33BZf8kzQV/Yre3ckMd+E0=;
        b=eZSVmD8jipWfdVj5F385eqz71/95148U70S5V0HCNqYESXYf3l+JY+6PrjjcDrkSCp
         HhTLAYpNi/9lm28z+9alBd9/XzJhMB9ZrHd7BnHGbp8r0XQLdwSb1XNSnh+znoeEhyep
         IRFJ7Uq6KAqGhAW8KMnRo2ohPOMu014ZXX2tFOofI0ULDcnUjn7uwHLiOPoFgvRW8iOu
         mTUU4JX9I/i6lCJDmp6BmA3Gb2ZMZytEyXWzSWkNuTpRQi1EPCRoCUXYFPY8djBiBzNp
         1DeqHGO0g//WB6zhrlKuBRn0GogIfmwr/izMJoSHIclBKeK2yNTVhwsjGjhosGiMZfpK
         FSLA==
X-Gm-Message-State: AOJu0YwfQXEHPUi5eXIq8O3Oni4Np3St+861ZgWU7jG72hn08WisPUr0
	DIrYmZtyIOex9zmLicGgaxVIstQ0qxGCqq37/7dONW3Zd2xv+ao+/vrehA==
X-Google-Smtp-Source: AGHT+IFw5X46tmrJJ3nFX2ES4cSIIsiFSntH1XfnPTD5yV4bezLGEIStjjt36npdpzJf0G1t7YrXkg==
X-Received: by 2002:a05:6a00:1385:b0:6ec:ea4b:f077 with SMTP id t5-20020a056a00138500b006ecea4bf077mr17780672pfg.16.1715089453951;
        Tue, 07 May 2024 06:44:13 -0700 (PDT)
Received: from smtpclient.apple ([2404:c804:b5f:1f00:bc1d:e880:f6fc:71f8])
        by smtp.gmail.com with ESMTPSA id kt20-20020a056a004bb400b006ee1e2eedf3sm9415858pfb.27.2024.05.07.06.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2024 06:44:10 -0700 (PDT)
From: O'Brien Dave <odaiwai@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: BTRFS w/ quotas hangs on read-write mount using all available RAM
 - rev2
Message-Id: <65E2F681-67F5-4AC2-823B-3C6CBE22E891@gmail.com>
Date: Tue, 7 May 2024 21:43:50 +0800
Cc: linux-btrfs@vger.kernel.org
To: quwenruo.btrfs@gmx.com
X-Mailer: Apple Mail (2.3774.500.171.1.1)

> So the only way to get rid of the situation is using the newer sysfs
> interface "/sys/fs/btrfs/<uuid>/qgroups/drop_subtree_treshold=E2=80=9D.
>
> Some lower value like 2 or 3 would be good enough to address the
> situation, which would automatically change qgroup to inconsistent if =
a
> larger enough subtree is dropped.

Setting the threshold to 2 or 3 didn't work - the machine ran until OOM =
failure in both cases - but what did work was setting it to 1 or 0. =
(I=E2=80=99m not sure which fixed it, as I set it to 1, then 0, there =
was a flurry of disk activity and the qgroups were immediately marked as =
inconsistent.)

So, after rebooting into single user mode with /home in ro:

$ vim /etc/fstab # to change /home back to the defaults
$ mount /home
$ echo "0" >/sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold
$ cat/sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold  # to check
$ btrfs qgroup show -pcre /home
$ btrfs quota disable /home

Thanks for your help!=

