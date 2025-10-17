Return-Path: <linux-btrfs+bounces-17952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0CBBE7DF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA558264D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F32D661D;
	Fri, 17 Oct 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKRrrO33"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833E248176
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694012; cv=none; b=seND1Jm5BawMfcPRYJohRmWD7qpNl9ofneiJLz4hChmr+7dLbfAWsqq8Wpdy2xoK0kBrbT+gtnexLSUVvToUWMNjKHt7gD76Umz+2qAvbrqL9EK+azEhshMKzPwP09YsRB4hHLlYzUwIOy0hWRry6KEFxR9+tWalbnvR6KT9Ucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694012; c=relaxed/simple;
	bh=MaJomP1EZ8uF1S96+yrnP5w4lNFNsIDthEU2FjcaC+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1AhTeJ+PCwog+HtV/3qiPxVbF2GXjWrnU9BLLDvWhhc8pOvvm5Bp7Wb9v6YLalBC5a9A1/w0e4p3Gdew6/ZA9SStAjlCFwyEnx4GDvK8/mgGsyuFSYTtAwT7lsZPjD1KFDR3TVIKGaKeJ/Qjpx2iDYyXvGURq+igqgL+RV94kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKRrrO33; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1237914f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694009; x=1761298809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkn0Myu0VpuTF3KQKkLk5LYTtobcdRAY+R/nXn5no7k=;
        b=TKRrrO3361p8UCok+0mi6aYRfdBr+74lTWI55JwAVirHzIfIjwIyoHfQMth6K0hXCA
         wRrej53qyXdkvy3V0OmgQthbUmL10eFxRofjGZug7F5+hj9gQWzPE2fRCEwmqzx19nLe
         /qZEl9VyqHiH+ONHDPlCogKBsYsKV3lyvcmVGrM863I5994x7N6yKf265knd6cL9DVM9
         klz6gq4+mmu0PoVGetYwdqBhKtgsjrhj26tezrfUItpkVWJFBsjPPVWgE006793N2gPX
         FiY+hMHA5oszwez4pvH4ul28ygV/T/Srw+rRBQYOr/U9mjJUiupTlwcOMtBFg8Q2baDh
         7yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694009; x=1761298809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkn0Myu0VpuTF3KQKkLk5LYTtobcdRAY+R/nXn5no7k=;
        b=Ig73rwuR1ZJbQXzaH8EqBS9ucjKO/S6YgQmmKKoAiHVGc1eAdi+2U8DOKE0hr8vppo
         dtuLYi7hyclp+Gjvl1NvcpJLe1LpJX04GUI6tsaiY0meSCol8K3jGjZpEXpYsuHFzMT4
         Bz5MyjdRjnLgnasSUuFnzd9a73JFlxnxp57APyHtocGonac8o92fYYi7kVjvrD7EiYfg
         2cZeK96uSxBTZm0tm3a0hEqu5VlzHSP6sBW80To8x9Ct9jMmu2QmXr7uzXFius8xIj+m
         m8Psa7ku5CjwTpsmzS4VN0qsCOGnzt/y3y1Kb7Yc+xTKimF9yQ3a5Zefl+CLN9KIHyWI
         NHQw==
X-Gm-Message-State: AOJu0YxuPXyps7cvYZwejErT5ISt0Cbbzv3efmwVYVaZqzn6MWXGuW5Q
	P0lREH4FruHwdfWCd7Rd/3nijRglevFdR3COlFAuDCLQKzn/lbBPOR4E
X-Gm-Gg: ASbGnctFiZnEnzD8UUBTckRRtIcpireZY2eeAeCytX4rsYwjJ6pXjmh5yIBZpQlnYqI
	VWVTBc6dmre1KFKBFryQJXCVg9z5p2uqgj72PBJe2J0UoPr7WP/vkLZdxGcf6VrSckm+FgpZ2E+
	CAIYzjSzEyyBR68F83JRnXjBLMi5b/fGEvllI4bCXnxB+bLn2NnUz3enno27fHYDHuFye5elWFI
	D6O7R5rO+reeNvQ6d4KLKFhspiZe0UOwaXcpDOGTUIXxO7eNgH0bBtBgH9hMxaZi4+Pa+pZ8AsB
	p0CxGgTu26n192/EWXCNVdlbm3sYfadSjq+x9OoZCJGcuHH/0p4zt3CwayG8m0Latb9oVvkYIgq
	ofMn6FhvDU96AdIgHM6apWL3cQXOwoBusFaHXVS7OX/8Kt9kBMLhGOEity6Mo5qU8WpHkjCLXcT
	jN
X-Google-Smtp-Source: AGHT+IEfblUF21rhuQ2AQ80ftwKH0eoUInt/DUEIz13+ErrbfYckFUOU1Ngr0V3TaORs4zO4ZT+H4w==
X-Received: by 2002:a5d:5c89:0:b0:3ed:a43d:8eba with SMTP id ffacd0b85a97d-42704dab119mr2037147f8f.52.1760694009026;
        Fri, 17 Oct 2025 02:40:09 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5d0006sm39856881f8f.34.2025.10.17.02.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:40:08 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Fri, 17 Oct 2025 12:39:47 +0300
Message-ID: <20251017093947.1170945-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1760607566.git.wqu@suse.com>
References: <cover.1760607566.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <wqu@suse.com>:
> - Systemd slice freezing
>   This is the most complex part that I have not yet fully pinned down,
>   but during the tests it looks like systemd is sending some signals to
>   the processes under the user slice.

Systemd doesn't send any signals. First it freezes user slices using
cgroup freezer. This happens here:

https://github.com/systemd/systemd/blob/28aa0a1f25470b21fbe3b8af2d9d99e616c000a4/src/sleep/sleep.c#L665

Ultimately this code does cgroup freezing, see "cgroup.freeze" in
https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html .

Then systemd initiates actual kernel-based suspend.

But it is still useful to catch signals, because systemd does
send signals when we poweroff.

(Please, CC me, if you send future versions of this patchset.)

-- 
Askar Safin

