Return-Path: <linux-btrfs+bounces-19982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68346CD8358
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8499E30380D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519D234973;
	Tue, 23 Dec 2025 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmuGU0S3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4522F49E3
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468349; cv=none; b=aGgqMv1twFIPN+fgHsJQYELVy33Y0WzLbwU5j2D4btWjoVWHLuIXKGGpsO2W6tFafY2372X6XTNfHBSE0ptBScEsYNpu6k6dhyuopZr95lggacojd3lxdQcYrUZL9hPwfXYNFcTuJ30R6bvaBi9bNSJs2WYtr38RPm5vq1BXh/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468349; c=relaxed/simple;
	bh=4EYwI5dt6aXRXkl+FSZUrQuoyCBEuH9OaUQ78T0nqW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mq0ej06I5EbCSr+AOFj2rB3vaiAW5XRJMBgMC3BnVZU4W3jyBa2X08KsBgBNPKbS2GsYxWgv2e1QmO08monNELKkwMsKb+Ub/DZENrWAKC7IxZTA3+EKUNYzCZYrVvBGKj+hYpTZHQHQCILM7rrmd33c57xlEDUJuWADWKyy7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmuGU0S3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a099233e8dso40146405ad.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 21:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468347; x=1767073147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=AmuGU0S3tNTq4XtJ8CPVuHsrup5GslR4U1PsfZM5q7Es9j9PRoBOtcmrNZjZY9bYX2
         UKR+5USfuLaeedQBq8VdFeWlSpdtJwj9cUx0XSPWF6iw2+/Dx0Y5UVucH/qMMErYNCo2
         DmPMJSCgLNX8OFyioDFMPSDOCAjVz+YVUY/Iz/KUSFGJ2xhlgSyingmuGzIf1Ot4VcrN
         bRMe9e6HU5DXOTn41IlUPOezYioUBfH4sOmBJ/VJV2wbgRChwx/8WJgiqq1vVmt2UJG1
         sPq57LHY2hmsktX2yrFZnu8K5GlUfYr80BrqjJruZXf92pssdcqPz8wFkvEzjVdz2E5K
         tIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468347; x=1767073147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=Co+e8W5iYv2y0jBZYCMZK42gRkUjtd319bKSIGUoxt7+tloqKefHmZcnrBMewWSG59
         8SMnhjcztDJkFh19n8TeA07lzGP0/HSXLRISiHr9Ff5H924EVWQM1R4rsuEYw6H5nRr+
         dn5GuBlG2QFKn9iJO629dRdZywgqViRTykkke97poEePGTUyvki6yKRk3ZgJqmIaKWiT
         LzXWyxrUTUnnM1kDnWUeeNfSx1rx84EVaZV4fAf+fKvZqc1bnvOdAzCnFVuKvOrYzocQ
         LHKB0tJVo67P9CxbEoH80rxxPZENVPg2C3JABdc3aa4qVTvld3kgi3JphjPodZS7k1YY
         /Chw==
X-Forwarded-Encrypted: i=1; AJvYcCUxQ2qQV9l31usxD7FJJbCw8Rr9wGSYZwgMsGS2cVuT4hmWp+A6cdtvkYB1jpGxq4wi/6paVgCnb7KRJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywca5+tMUK9stF1uoM3qG8WfExjg9b/DuuGANBWO0tavstj3Msc
	vjUMd9Bzh8P0CcLvC0Nt4G0MbRpIFkmpWk1/ITf7L0D+HxDJWY3xamyU
X-Gm-Gg: AY/fxX7almrVzk5ruVufgneCyRwnvreyMRZx9HmWm1JTbEGaA8WNMluqeYBqXv/cSit
	Syc+pk1J+1jvSuc0t/xw0irCl8heVP7UXH2MkVR/Fuo/hIGTGHxo8HzZE6QHJLxdAeYwBCRFFmJ
	KLI4nO5hG83RGOccN74BAc+H+b7/qcRY2uxHhxsx97nO6h27fGTbmaxcvEz9gaazrHs3tv4GKPS
	Qbi4dhgGCNRptEdSy7wA9eRcIsQbdxJitgF88WpOXIt0FTdd4S+nXqp+XOliJt0mZajV2+ka9mn
	i+dk/U8uVO6vSrXQy8kAt58hFVquZlGY7OOq2tNXNYBmbW+SaZfhDo/BRRG7LB/2EQQBtLPLTtD
	lf4a6jyKBmvVy1Vy9TbufoQhYRU0RQkjOZWsVhF0dUX5KeC9S7e59kbyF2KxpGFVizifJQDJUkZ
	UWRbCmWVVj6zuBmpoN9vYC0J2BEr/Y0qcDJnlGCiiCFmiwl1nJdRw2yuQ0PKTt4S+c
X-Google-Smtp-Source: AGHT+IFzlCLo+BvPmOwaQvXqt6LlTFpUSJebHNJribHXa7k68xn/ydFompByNLrYdKm0zAa3YWAnPw==
X-Received: by 2002:a05:7022:793:b0:11b:9386:8257 with SMTP id a92af1059eb24-12172302180mr11142291c88.44.1766468347292;
        Mon, 22 Dec 2025 21:39:07 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm40285157c88.8.2025.12.22.21.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:39:06 -0800 (PST)
Message-ID: <bc999618-1f1a-4ae7-a81c-57062d57614d@gmail.com>
Date: Mon, 22 Dec 2025 21:39:05 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] xfs: enable non-blocking timestamp updates
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
 <20251223003756.409543-12-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> The lazytime path using the generic helpers can never block in XFS
> because there is no ->dirty_inode method that could block.  Allow
> non-blocking timestamp updates for this case by replacing
> generic_update_time with the open coded version without the S_NOWAIT
> check.
>
> Fixes: 66fa3cedf16a ("fs: Add async write file modification handling.")
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



