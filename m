Return-Path: <linux-btrfs+bounces-19981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546CCD833D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0DF03029BA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0A2F5A23;
	Tue, 23 Dec 2025 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/39yZPJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5912153D4
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468313; cv=none; b=NxnQ2yO9VvV0rZLfUVemGPXMxEQJcHTtNEXZjh6ixw8s/52caM+CHvzUrL4kwEjbX/xifWBID+9T0+6/M+M9ybkcla39LxwuRc6E/3CFJ47V6DNZwjE+5OjOmjalf7nMaEQ5a0Yulf1dwgU2PYsEnIMbPtxcPkJBGUOGXSdJAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468313; c=relaxed/simple;
	bh=zTV5Fl6uJEq6bikfRl+2GZKAfKdgBpPPlmOrmzDQ1Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpwCRtqu2dKmc6HVqG6bP5Kec4xqk7He0ajvg84Ayi1ZBYDyOl5Jgy5cSyRHYh+DryP9+PP6mkvrnV0e5ZiDxTDTV9G19l9SiGNFoXoT1fKZRyVX3snP8C2SUChejFaB6WaijuT2/mHdioja2ebA1J/JmqW1+lrto6fhLeMbA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/39yZPJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c21417781so4579268a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 21:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468311; x=1767073111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=k/39yZPJRd/lUcRJkV7mXQEWc1+ntOQZ3mgr8kFI765nq8VXzciXpYKgKPQG/tmkAM
         owjPUkIe3CFME/oQ1dh1e+schfxGr1GebTc60fpUHpvMD21xSXHx1R6rHRmQnGi7e77b
         K8gWq0Odf6lE5z7xabI1OfkODM0SiBVhCyDtkdpfiQCqP28IV5iuZ3X2EFOvRV2Gg7UZ
         OwnNQdnzXvu1PxMtIuBAX2FJOYDAFMzk3ZDVkCoSbErCXRMukkSvcsMp9nWx55EwuwEJ
         7Pdlo1cgbWzgOgds7F9Lpvihye3j+92iv8K2QF0XqTlcbb/5O/MwGRalD5ldn/b0XsSo
         WZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468311; x=1767073111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=KnY9GT1IHdneksEb9EposMr5+St1lYLjLp+zRxnFi60GyByfbTx2YkHk5WcxS7jKKV
         mBSAdDkM/7Z8h6U7ZdTzC8zt9dDHJgK1yzIerb2hoee9/Ci4ozOfaioYOcojdn121Z0I
         AweXi11Ydl9hG3yQMfoFsolRYWMTLxlbKu30aQFcgMUOkYEe9ontMh6dRKEghw3p+c15
         x6sAdEyDvSOuH26TpFnKBHUI6sLqomMYBSur4KKSprN+h4CfTdGYcIv9rPDXAwheUs4n
         FJ1SvP7GCCLTDgFbnGU9NMTjZl95TYf67a83SOIzA+q3YuYuEUZ2q05icW6aqoA+FuMI
         OEug==
X-Forwarded-Encrypted: i=1; AJvYcCXLtMQwAx7cH0G4Rba2tj7Fb2oLgBH/KfJ9r7hwMpBEglY3o2IC0r7NDJPnuvFKdYbYyleNL5GlwEVSDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rGkJ/0YtsM/DgC8OhWuWFLiAPP0KtzUkv0Kdh6UvviHG/DZc
	hZDFqWNDULxHifIRqaqpudD+7IOBbrPf+N3fyJ+qty6+RCAddyKqWFTL
X-Gm-Gg: AY/fxX6Fhyw6O8PXljeIFK77RdNRA1Iu8vpclPRjPQ0qxJ8g+lRW9DTSfFOXHVb4wJC
	dRvG4gMKfcs51nH1jT1BR8OPh0skfhqbCtL/trTgw+IzWKu1ex97DG3Ewd61AoXBjjxJCJPpudW
	lgAMfhhott6wzs9HppwAogsOVowac6I0awAvd6Vpb4mL7xwW/5PKvYjSROrh9RRJGBVfl/NjgXP
	P16tDMkBG+s/zdf6RCw0YDQUu470GvRki8UtFPhkYZpwyRRFPLvRTn1MWctSdNQhTl3gxoTAeUt
	g6Oa9XUlcmNgvu7zPhuH4KqCV9yWuYdVqKPAQpkkYmaMcpQRIkrB4M+CO8uVjF12YGNtzUMrCFH
	cX2lvIaci8k+pwljSSNRiiYVTgc1y2TZ95d99jjpE09rdNpyqYKjEJYZWMzNWzMEIsYDCshNYRC
	bDuWHMbPho4YkMyqcilnBWlkvXy6EXdfsKrz/y7Q1HPCR0nnndrwTvEmF9Sfg3oehrRX/CAAqPo
	Rw=
X-Google-Smtp-Source: AGHT+IFwAZOrVWcdz0GU+cDO+t7ewKrgjzgkHtOiGD0/poJQvRMMxSdMeBecD46MhF4AsSDjM1RyIA==
X-Received: by 2002:a05:7022:799:b0:119:e56b:957e with SMTP id a92af1059eb24-121722ac244mr18354800c88.3.1766468311123;
        Mon, 22 Dec 2025 21:38:31 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm56187439c88.16.2025.12.22.21.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:38:30 -0800 (PST)
Message-ID: <37febb65-038e-47a7-9a5b-3b4c2773994f@gmail.com>
Date: Mon, 22 Dec 2025 21:38:29 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] fs: add support for non-blocking timestamp updates
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
 <20251223003756.409543-9-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Currently file_update_time_flags unconditionally returns -EAGAIN if any
> timestamp needs to be updated and IOCB_NOWAIT is passed.  This makes
> non-blocking direct writes impossible on file systems with granular
> enough timestamps.
>
> Add a S_NOWAIT to ask for timestamps to not block, and return -EAGAIN in
> all methods for now.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



