Return-Path: <linux-btrfs+bounces-19983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73965CD8444
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 07:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DCFB302F815
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B367303CB0;
	Tue, 23 Dec 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwAmUTBH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66B1DA60D
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471647; cv=none; b=dlKLpVRJ0Uq8MP00B4hjeHBuqj5CsGXaM5SgSDUuqklqVLqj3HeJlybAsZcdIp7SsXiFKAyb1nVfwFEA5BL7eK0EL/A7rx9nozDhq13QEJgb2CYWAuLQybjjXEZh6+DWVVrfW+Fd55nEjpLLzm4cbMRGxBONhV/Wxi1LPPxxeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471647; c=relaxed/simple;
	bh=zQMCxWwv+vy2hbOmutXkA1vn5ZNuVRvD6yhOueNtNZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nflj1T4hzDon7qgr7ulnuLU+G+GgxXMJJuQA2mZQamkjQB/kN5Z2lLEugpbo2HZpxli+Bowhw2YJDvc/O2lWsXILkjQae4w7Xmmy/luSyjQ4B1BSSfbMpz0Fq5Z85kjdWdjDH0bn0Bstr5mNSjjN5dyO7TCwIZDXwpPuYpEV4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwAmUTBH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so39229341fa.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 22:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766471644; x=1767076444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=048jzD37H8lsx/zZlGI/PEx4g5lnBiNM8RokzD3mdsY=;
        b=WwAmUTBH+Z8XRKtBCqY+p4vhvOZdSmb+n+f1cbt8viJVJQHBr5U0jo/4s6d7qWWbBf
         m0+yEyt1/jvRcNLPLCeivO4iEJDrI+k3zJ4jS2PQa2ZNeiL1Tlbub2tME3cf4CpV5t5x
         y2v7G9wdrigZhwrK4c7Yef+E/fzqp/cS5XJetFqG4hBREaOaTvMWzFG+nlcM12NpLnyV
         bWftFqc5KSBKZ0BFk6cyJPxHYk5+KPRoe6KeznkQ0/TJBWIgfaUW2op7B7NEb1bQFuep
         6NgElzoJ6xi+uJ6OfcZAZFe+8coZdOUBZ5vF3OSWtmJtAEFFTI3kGZUoLI04b5pvc8/0
         nauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766471644; x=1767076444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=048jzD37H8lsx/zZlGI/PEx4g5lnBiNM8RokzD3mdsY=;
        b=nnPQkFkr/pPgLs/Pq0jQdQCRnITTD8be+AS+MlzmbQfYjrMcFaLcx4Jh8mnslooqY+
         CiLvB7MDaZXBgSkNaiu+ul9F9MgQZMWyl2ot57pZB+vJpPT7AENT9itnnTxE9yDwQTYo
         SqpNlttMATrxc++8IOJHXK2TQ6U6yIFLoUC7+9TLWzq/9hqV4KzerVdfBR4DD4xISLSr
         vkZHf1ZXS0rt15dWNbuwUTuf7milE1EjOxVg+E2fNtq2eeW0MUPeD3aU4WSexZA/pJ4a
         Ye5r/qe+HCSnEWXO5rZkE9BTnXvAYAiIUxs5PhOybeZCLMKglJfDEd5X4znsgqhsHBrY
         A4nA==
X-Forwarded-Encrypted: i=1; AJvYcCW54jStaENZivv9Zf4ZyrIB4EToNBSbTuaZ8y6N8RjuZ8ZlXf+4KAodSs2LWHh5nq+iBu3pH6nbIAVapw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9+wgeZ7iO2rJ6t6/sJZC+GzvbpLvuQoR3o2Q5YMoSLryrA1B
	BS4lxXKHfe2GS2i6VgAIGabc15hLdGE6GVWQ5Bo8a4ybUEiEV/0IOj9P
X-Gm-Gg: AY/fxX6+ki5etdp2Z8ulpVDILYV+WSds67UIYJME4gCK9peKjptQVybQgyKAMgIGobG
	aOhiHbqEjT6m0+AivIXV202YuAgrSBZFkYq2Pu3vK2/m0Zl76r7gi6UVHstuEL4lM+DC5boPgiy
	Ami5AAVSup6FakF84GTy4Ks+T0Vr0vPXfgUJowlw7yAaL/bzW4F2+PRvlnQ6LFA9DtRB3GbQxFb
	WSXSNcEBd7VUuZFCGvu/ooPXNQn99mFOv7y1yM8S9TN8hcIJ03w86OJT4nhumSLOazkjY6Q9uJ5
	vUUPRcpTZetgZhp9ANFj5KIyJ4Jw1RwQo5KNaxns+ELg5cY2KlBXhIJr34n1KZpl8hdR91MXuW2
	ZJTVb403I+UXx22kEY3YZ+EBPwGXWo4wEPkRHsaANdUmKCJyg2pAqY4M3GuJ7i8qq+uTtpYrtIx
	CzHal1KCECHlWZYsXzR7g=
X-Google-Smtp-Source: AGHT+IFaFE0nlDnowk+Ou3U+M9eX56ZCvZ4aEX/mIAF0sQ5oS0z9Fh1vnyWDY8DQIpJC2t19J66zfQ==
X-Received: by 2002:a05:651c:1506:b0:378:e055:3150 with SMTP id 38308e7fff4ca-38121566b66mr43783861fa.5.1766471643890;
        Mon, 22 Dec 2025 22:34:03 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-381224de6eesm33742031fa.6.2025.12.22.22.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:34:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	safinaskar@gmail.com
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 09:33:55 +0300
Message-ID: <20251223063355.2740782-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

Okay, I just read some more code and docs.

dm-integrity fortunately uses bufio for checksums only.

And bufio allocates memory without __GFP_IO (thus allocation should not
lead to recursion). And bufio claims that "dm-bufio is resistant to allocation failures":
https://elixir.bootlin.com/linux/v6.19-rc2/source/drivers/md/dm-bufio.c#L1603 .

This still seems to be fragile.

So I will change mode to 'D' and hope for the best. :)

-- 
Askar Safin

