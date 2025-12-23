Return-Path: <linux-btrfs+bounces-19979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74246CD82F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3054830115CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1D2F60A1;
	Tue, 23 Dec 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAaAzbrs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2012F3C02
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468187; cv=none; b=Uxk4iEs0Ka58pMGAKnDsWnAQE0GuKysUQN2aRA3mGbZYR2QqIS1TjRp5fbOZv7681t1Te7AanNy6wuJ6oVI/QqtEouYQWWHWWVxg3dqEuVH+fSBDh97kSHKQtS65eDubKuJ5Yt74mWmviJqgVKhHpt39FnWRPnPBJZbQKdtYMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468187; c=relaxed/simple;
	bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvwI94qpcROztLXkALFWTPW5RAZnGF89Fk56tUg2fRzDZINj2GESZ/LHlOfbyZqdQDns89lPd8rIcKxkc6iO31fVSXiMpFW1fmJJ89/N7DKOTIMzOFGIzl/E54pdeHOAYa5qKf8gYFOKJNy/YsrdiLvMfZ0Hievlz0UOEzi+y3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAaAzbrs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34e90f7b49cso3303803a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 21:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468184; x=1767072984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
        b=KAaAzbrsGMa/yJ+ZeX66ACX313azU6u48dvdzrBwSic4HN62sJmYDXTq+VchukDU1L
         8sG8trF29f9VOcpuO7lWFH+BtnrkVzkWLbshB/5Fh07Cpq7NqkxHa1xuesIgnE8tH8Qo
         c3+byqUdmpSNC/AP16Hdfch35yejCD2kiF38JOHoQK6gtdj4WyMVRlnjcQ++8plqDvIq
         NINaKHODJxbdRib8oUYW69eNX7+AvJttzXqe0FP4ujNyHKM+xMXIBDuh4kEtf5cTmD4y
         0aVURA8jPi1DS5UAj6B/qSuo7DCtY/esApe51d34XyvYMy48PHQzwV0SOMUwYx1DdqtY
         fU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468184; x=1767072984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlgqwkzGyrE3K5mQqCM6bG2Y747dQIeSyi7etFJLJbQ=;
        b=Bcub8+ICZ7+zSDREmwIv1douYFFIgIYDMAc+2GNIZaqhhXxEkvqHvlXoTlF1YD9C2d
         xgEReAh/vZRexRsvIJ18RpB+IdRjchoMlaCzzarNXiwW3EvZtqjDBwxpBBKIYKI66HsO
         pZ0ywrPcKwwJZhXeylX3Q9i0s6SaX7USzPk+gTM7PspLzm3O3OxQSKHzTGMF0WL9Unss
         hnN/9WLFBM2EPgu2fAdlCxKZpZL4doeOhPZExPqAHxzOkxPpa2tk5BG5rmLnq6eJZdsg
         a1d2X+X3W3dKebAx5+WgCGIf/7VKS7bgATJoumLDu4s9tz8zXxvMG1fAJCWKEt8kaL1K
         E3fw==
X-Forwarded-Encrypted: i=1; AJvYcCW/AijcnWAHEwEAbHYP1vB+AuO1Is40oM3JY9mrh16Wmyu4FdfeHeR+nW9sQz3FfSMqXCWDLCTKfDrU2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+OdaSWCX4aZPtqqMYw84ZVm/9C/L8XLM0JKPDTjRcQn/WvbR6
	V/TNpyRv8ZdNTxJTBKe5Lnl75c8rHynTtQfwdBCyFVLxaDSODktd6SQh
X-Gm-Gg: AY/fxX62MiLYkkhkyFxVsunYZbO5FozGipA6NLl3ksVTcEBzdOu0YADiFCBTGv+baL5
	yA6lzV7WkSGRxmr38AN8U3ujZrrqYLBbDS6eqvwILzedesywiQbJmHmPQzI0qLknVTX60zMiB3q
	au+y18Qx3zzY07BgfS9iNeEFTY0JyNJyCTeqvBQaCffuCgVgvDH2MlSn7cTcGh4YNNl5N2Wax7o
	68o2VVHPZIRxiQWGaiwZJZQ4RlmmMIBFtrbCqxZ6RKdkKY3zaWQhc8AWYBJ+33Mt9tGvJfsALgs
	QcwE+UqIr7Z9YYR8+8u3e8PdVJI/Wzq+/LQNlKs1TX1Cn3DRn1Rm4O8F2IFs9Zc9gmH0zuHtJLl
	aoai/afOjrZ9feWbVjTWUaRnUpublLEOAOjl4ABLqIajIqWRL3Ck/D7kx2do5YlkwwECJ0Z9HpB
	5Ven5BTahMST5sQv2cOCha2rCZbVD3INgvRq/k4cvETs3OaCdG7pQspeMeJhgrKsHF
X-Google-Smtp-Source: AGHT+IFX/6+bwcWXg/4km6FqYdkuwnUGcop1hJcfw4hTgcVNu0v2yNrPtPf/mgK+hd5hIFUJyC/N+g==
X-Received: by 2002:a05:7022:3705:b0:119:e56b:91e9 with SMTP id a92af1059eb24-121722dff1cmr11158229c88.26.1766468183950;
        Mon, 22 Dec 2025 21:36:23 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm54039368c88.0.2025.12.22.21.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:36:23 -0800 (PST)
Message-ID: <4e5f6df4-b446-4ec0-a0d9-231756ee934c@gmail.com>
Date: Mon, 22 Dec 2025 21:36:22 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] fs: factor out a sync_lazytime helper
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-7-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Centralize how we synchronize a lazytime update into the actual on-disk
> timestamp into a single helper.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



