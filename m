Return-Path: <linux-btrfs+bounces-20038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D369CE8802
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 02:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEFE23003B1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 01:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06C2BE657;
	Tue, 30 Dec 2025 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsXPmb52"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558102DA774
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767058879; cv=none; b=WaORDhSCzdEP++1OcOEfI7LC9Ywrt+9U0+ZZpZA0OBV83PINJAX2pk1TiBqyZphANJIGa3yoRjqc9S6eHTesDXlW348NiBV+cQ+feJxDKvGq2cpaJdQuTU/W8OLVw8V/+U+1nrcgdzK4RYzQ/zToFHy4Jie6FUv4HaiEyx+OpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767058879; c=relaxed/simple;
	bh=i24M2AOX54Xv99z084wipoXZbLqt+UnQFVDEuKg7zcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJV/sl/lMerfS682yfq5DeVsja+P7fqfm4YUDh1FNZz/jTB+mdMi4j7u/6gBs5llc5IgOnjCGRci2He1++fVaIo6kXFSwQtVGRlEz7JriYh7JiKOqpp4O+YbdJUs3ePq4gipa3C+XDA3VagN5Qua66BiBdg75p5qr3Ve5FMNws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsXPmb52; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29f08b909aeso19903745ad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 17:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767058877; x=1767663677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56Z/TWecevd5AX/RhAsKE6IgQrncmCFikGUJfgW1l1o=;
        b=nsXPmb52AQCuFrWww21IAvm8izaQnYZ/JvlTkga9ktAR0bvBVjDiBsoD4o+VJlHSzK
         Jy9zfYWraWfJ/i6KTKc7AdXJiaUi5tZ+ygmNFZ2YiYfm4LTiREgVpmihgPh55I6v9GzV
         5py2WdXB4VAUUt0SfMNPdnWpCbsSr6WyeEAKraFgkacKd4swh3UWxvz9OVKwkUQPiZp4
         KF5bWTUeWrIC1kkTCB8+kNHJhUjiwyPyjWeeK6WpAPCXj+lLAK7UctrxH3CswJlLz1pS
         XB6UcMubKQA5EVu69FlP1yO5wIdef3xyTMEaVp0A6/1a8y9MJ6WoKOXcKLNb8lOeG9vz
         OlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767058877; x=1767663677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56Z/TWecevd5AX/RhAsKE6IgQrncmCFikGUJfgW1l1o=;
        b=tYLT/ce69iI3c5cj8+uSwd81qgz6sZD+0J5s2VF/AcaXDa5YIZ3L47MG/Itl2C135h
         Zgfta9MJLtpHJem+XmYEuVT8e1dyCXLp3hQ2a97n5wsjqfRA43Y26eEenaJzA7MqP2Gh
         d6U+DNFj9kdGKUa/tgfACbhAAN4j6WwnT2i5Je6AKe5/CCgR+pYNGlCVx5BY0Y1t3tL3
         1k3D19dfYu/ZPq8IwyGI51+FujKyfluF8Pas/nhA8Rw1hMrTdJRm5kAg76qrhYK0UaPk
         Ufw7xKVtDJRnFOT3gu2GEN8BPsdLXY8TfnDgf/ykgJhRs6ZYzi2GFacZJCy/BaRi7zLy
         IXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB0TffkwTUtg2zmj9te7+Ihs6PQGHGweOUBwDiSiqgpGTvl+SXDc3u6/n3D5B+0rFqM8OqNy9rPCb09w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxORA4YTOa/WZ7wle7fT7LX1NTrbRfBP2jlgtPNZjMQhypsQcmr
	Ioih9N6bXnjr9Wx5g/E9Fg26QmE4GJ6Ji+gs/e7LQxCW6wBoTCltmnhZhcNqLGjJ64pjcg==
X-Gm-Gg: AY/fxX7JSqDroa1luu9FUAp0Jxs6PhBVTPFfp052TzNaMahjo8HnBCB6iJISmHcEPOB
	oN9pYKfCf/9VGDNo5DdEsjbIdsHzg4T2iVa9+Fz0fOk8Y9JCkMx5doVXYtkHo0LrIiHOtn7GBsS
	OzEMQod/Dvx2qbEr5KF2c1L+GRNXO0e9wM9Nbso9H4TipqihBoVjIPyYEPHNZ9Jm7uI3gp+wjHM
	eLU08DZX7Ir6K0O4GF8uIHRz+2Scr4ATVkkcAc52j4YJnAWFeuAjHBBYQMRdyKbBNzorlDsXD7f
	x2FsMykGkyZBwv4Zh5wP1ZoljD2OWqGe6bXb/2vob7pzuORly6Y8Fjv4IGZFuAJzxcRrVFG+aLT
	1FRCWW5ntN5QhzHpK/n+Xte0sBPFFq0arLijta2zTd70L3G2DsW4jQ3a+DDxsbvYlRZZB6MTcPb
	dMHVapjv6EN0o+SU0O6/2hdLHV
X-Google-Smtp-Source: AGHT+IEGdJmgahk28Ch8BjSMn1fpFVQPVfO3sNKInQE+LlnXStCflQUbBNlNJJIPPLU03QRew7dFvA==
X-Received: by 2002:a17:903:40cf:b0:2a3:1b2f:3db5 with SMTP id d9443c01a7336-2a31b2f3fa4mr186330225ad.9.1767058877470;
        Mon, 29 Dec 2025 17:41:17 -0800 (PST)
Received: from [192.168.1.13] ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8279esm279017695ad.28.2025.12.29.17.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 17:41:17 -0800 (PST)
Message-ID: <17b6ed66-6427-4098-8574-ac780cc1103b@gmail.com>
Date: Tue, 30 Dec 2025 09:41:12 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
To: Boris Burkov <boris@bur.io>
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
 <18e6a584-b6fb-47f9-b526-4e97798052a2@gmail.com>
 <aVMWI7bVCZX4RAAa@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <aVMWI7bVCZX4RAAa@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Please let me know if I can assist you with that, or if you do have a
> reproducer I could also look at.

I just come with a ... thing I found and I have no idea why it happened.

I've wrote a script to show the 10 least used block groups(used_space is just
calculated from length and used_pct, so please just ignore them) and before
periodic reclaim, I got:

Searching for the 10 least used DATA block groups...

       vaddr           length     used_pct   used_space
--------------------------------------------------------
 6353387388928       1024MiB          5%         51MiB
 6354461130752       1024MiB         30%        307MiB
 6295292084224       1024MiB         80%        819MiB
 6056900427776       1024MiB         89%        911MiB
 4620552634368       1024MiB         97%        993MiB
 6050457976832       1024MiB         98%       1003MiB
 6122398679040       1024MiB         98%       1003MiB
 6270596022272       1024MiB         98%       1003MiB
 6350166163456       1024MiB         98%       1003MiB
  383347851264       1024MiB         99%       1013MiB

And unallocated space is 3GiB so with dynamic periodic reclaim, the first two
block groups will be reclaimed:

[12月28 21:47] [  T357] BTRFS info (device sda): relocating block group
6353387388928 flags data
[  +0.262467] [  T357] BTRFS info (device sda): found 1970 extents, stage: move
data extents
[  +1.334556] [  T357] BTRFS info (device sda): found 1966 extents, stage:
update data pointers
[  +0.618457] [  T357] BTRFS info (device sda): relocating block group
6354461130752 flags data
[  +1.009694] [  T357] BTRFS info (device sda): found 166 extents, stage: move
data extents
[  +0.388070] [  T357] BTRFS info (device sda): found 166 extents, stage: update
data pointers

And after the reclaim I got:

Searching for the 10 least used DATA block groups...

       vaddr           length     used_pct   used_space
--------------------------------------------------------
 6355534872576       1024MiB          6%         61MiB
 6356608614400       1024MiB         16%        163MiB
 6295292084224       1024MiB         80%        819MiB
 4620552634368       1024MiB         97%        993MiB
 6050457976832       1024MiB         98%       1003MiB
 6270596022272       1024MiB         98%       1003MiB
 3782605471744       1024MiB         99%       1013MiB
 4549685673984       1024MiB         99%       1013MiB
 5882820034560       1024MiB         99%       1013MiB
 5909764243456       1024MiB         99%       1013MiB

These two block groups could be merged into existing chunks, but I have no idea
why that didn't happen. But when I run

btrfs balance start -dvrange=6355534872576..6355534872576 /mnt

It can be merged and free some unallocated space.

So I think the periodic reclaim has a different behavior with manually balance?

Thanks,
Sun YangKai

