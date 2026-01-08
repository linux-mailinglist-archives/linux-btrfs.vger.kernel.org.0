Return-Path: <linux-btrfs+bounces-20247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9488ED03B93
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56C25302DD56
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD278352923;
	Thu,  8 Jan 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2nDhClp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9B34FF71
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885101; cv=none; b=i027PbIYFVgK6hHJgwE7ESZgHUmFjNUjN5Pmk7PjxelE5GZttG4UZqwfepf2rPPy+eXuh9jwXSHK5O3zYtsl7Ruge1DCHL8fDeU1rlY44f3+ZeZp52lq71ZWlvZvN3qniLytoZZ0/yRfmjqkaelOm/hdWiWVhheRR26vaypa0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885101; c=relaxed/simple;
	bh=rLKZXAzSLW2nGIFmIREizKx+XbfHYom+5HNWdcnKqvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3ieOZZ1QKtEkeMx1CCihXkd8mTojpqEGXX2+FX3QcNGnjucKS5iPRC8zfTkFQeUzdKJzxIAoUjpSk0cfPYzWx7QNdaXjn/Bca6vqvl6zv6IogLCnpqSSk29LLQpc/wWR6j27hPPoFsc8sEksd5Qno7YFe8ZVdsAO/Pmb4n2ecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2nDhClp; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78e611f3f1aso1975477b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 07:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767885098; x=1768489898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rpeg9aTQCjPejv30vDpZrOSJzLXN8xb4eNVM62bX55U=;
        b=L2nDhClpe7qpa4BxsHGdzJ7hkNDQtSDX4ZDvNOVdaAEP0ZV/wydip+4qTKkbeqvlMq
         h6ePecCYzCtj2HjsimDAUzoWZfKsLA58LA+zXOsllzPy4FPOuxBcg1DLR9N8NGCMKh10
         SxIHcQxeRoaJXoJj9B7C7/W2cutX6GSiiEzp2vrDAmpfmfBuXWMggm8qKF1yl4HkvUT+
         uFQsEYaaxz3w9/FztQ3i5pXdiYS/YzsQ7EiTt/Z6B6jhIEenu9+511YpYEQDKlnbyhui
         4zQtRxjJORcpF/gKtRhqJmqPLnidO+3g0FV0AMVHcUjURmFGbIUmwcu55SAU7hS66kXz
         YteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885098; x=1768489898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rpeg9aTQCjPejv30vDpZrOSJzLXN8xb4eNVM62bX55U=;
        b=OBnsb2bU19HAlufOFvVO/bsA1TLxCTXs7JV+eYGphMEsCXX0kCXU+kU5M8frubEyYB
         ZyXeWJ74CouFcPZ9Jg64yN3rAmwU4RHI5X2+92ib/MgKmP3EOkF0ZwiyZF7uF1NYdBP7
         YJkGU2OpoVNgA7r2Q6x1p/CfjkiOeZ0ehuhuxk8qdpklxvoqB6UB+qFsR0oRltTDuzax
         EzS8VixYmj4S1zTMRpubFLSFtednEcZcCJgFVP2vf8SK+CqKUWscXP26iHLtCrqGcBQd
         xU8xggQ/i7HEQ48thIPfiF17QSBoVDR4qBHljcOHYZjD6pdK2t8vXElSretYznUa23ie
         fbdg==
X-Gm-Message-State: AOJu0Yx1RbGIJWydt8ivBryUu4DvvU9FsCIbHzKTdI3Sm7u9v+Tai5fK
	MjAeS/PrWOqCIHxj9P5krxP9z0r6u9g56Xy8/i1dXy8S4lwytgUDsm7rjyPripRTkM/aUw==
X-Gm-Gg: AY/fxX6ww2r3JWKS56Fev0ha3yojU3+oex8C6e3uL6w3pZAmJd5LFJWw/342dr2m4lO
	fOOtuuqnH5gmFLTJ8TOrUjM6dA/DTYE2dbVkVKerVixF8YMihALSgFY4s0YbpsFgNK1zN9yQOFL
	B5eOK3y3ugxrxc7BBIEOb9NymoomFLgWK4znWd1xQwAYfYIwiMX01zhzNQh5Ybs+WvHHaUyOfxm
	BRgLghBZTlx6ojsksB8cPcSJQH0C1T3wQfq1RdG/psK3aBYuxRXCYMLW0N9HJfhA6s5nRlBvFkN
	pGBZFX32q8rzx7Rsqrf4nAyQ2xnYWhcvYsYl/pWffR2LMqilnpSQyMxF95rD1aGBdObcIlcBOKc
	q7zprkguIqC7fkOvXoTzzPQTJfMg6qEW+TdqjoZRf/krsVwmjBBgh9K1R8GE4iTaO6a5F6NuMT5
	cmllHWPrSg4AdFHR3HjQ8cX70=
X-Google-Smtp-Source: AGHT+IEigjm0Q1C3Ma1DvkaxBz4dn3xrq62ai9lq1tRXhtc92VMN4fEyFTNqC0QzUGsDOxWnQyCkJQ==
X-Received: by 2002:a05:690c:fd1:b0:78c:2d45:519f with SMTP id 00721157ae682-790b5490599mr57017147b3.0.1767885098445;
        Thu, 08 Jan 2026 07:11:38 -0800 (PST)
Received: from [192.168.1.13] ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dcd4asm30267557b3.52.2026.01.08.07.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:11:38 -0800 (PST)
Message-ID: <f3e46742-2385-49b6-865a-03d5cdbc54cf@gmail.com>
Date: Thu, 8 Jan 2026 23:11:31 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] btrfs: fix periodic reclaim condition
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20260103122504.10924-2-sunk67188@gmail.com>
 <20260103122504.10924-3-sunk67188@gmail.com>
 <20260104194008.GA416121@zen.localdomain>
 <7797d6e2-99b6-4112-9c7c-4cb09dde8486@gmail.com>
 <20260105182102.GA1015682@zen.localdomain>
 <f5986918-d95f-400c-8d45-86551ec16397@gmail.com>
 <20260107175715.GA2206053@zen.localdomain>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20260107175715.GA2206053@zen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/8 01:57, Boris Burkov 写道:
> Given this and your other comments below about my proposed patch,
> would you like to send a v3 which mixes our two approaches and does
> something like:
> 
> - no new "pause" concept, keep the reclaim_ready (like my patch)
> - only set ready = false in cases 2 and 3 (like your patch)
> 
> In that case we will *not* stop on pure success, and we will stop on
> both failures modes.

I'm drafting the new patch and got something seems a little stupid:

@@ -1989,13 +1991,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
                        spin_lock(&space_info->lock);
                        space_info->reclaim_errors++;
                        if (READ_ONCE(space_info->periodic_reclaim))
-                               space_info->periodic_reclaim_ready = false;
+                               btrfs_set_periodic_reclaim_ready(space_info, false);
                        spin_unlock(&space_info->lock);
                }
                spin_lock(&space_info->lock);
                space_info->reclaim_count++;
                space_info->reclaim_bytes += used;
                space_info->reclaim_bytes += reserved;
+               if (space_info->total_bytes < old_total)
+                       btrfs_set_periodic_reclaim_ready(space_info, true);
                spin_unlock(&space_info->lock);

Maybe we should change it to something like this in future:

		if (ret) {
			btrfs_dec_block_group_ro(bg);
			btrfs_err(fs_info, "error relocating chunk %llu",
				  bg->start);
			spin_lock(&space_info->lock);
			space_info->reclaim_count++;
			space_info->reclaim_errors++;
			if (READ_ONCE(space_info->periodic_reclaim))
				btrfs_set_periodic_reclaim_ready(space_info, false);
			spin_unlock(&space_info->lock);
		} else {
			spin_lock(&space_info->lock);
			space_info->reclaim_count++;
			space_info->reclaim_bytes += used;
			space_info->reclaim_bytes += reserved;
			if (space_info->total_bytes < old_total)
				btrfs_set_periodic_reclaim_ready(space_info, true);
			spin_unlock(&space_info->lock);
		}

But it's beyond the scope of this patch :)

> Going forward on top of that with deeper testing, there can be more changes
> like "special pause on 4 which gets unpaused on threshold change" or
> something. Or "always unpause on threshold change" and of course more radical
> ideas.
> 
> I'd just like to keep moving towards at least fixing the obvious
> horrible bug.
> 
> Thanks,
> Boris

