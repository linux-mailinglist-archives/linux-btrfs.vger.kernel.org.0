Return-Path: <linux-btrfs+bounces-10688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D59FF9E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 14:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E868E7A202D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2AF1B043A;
	Thu,  2 Jan 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmJD0inw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A46FB0
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735825230; cv=none; b=hiZoqv9BS2kUH5/wxGfK809F0mZNiUL3u4+jJDhz3YyKc6ymNxEn0gmxu+927t56sH49RmHh6cH5mxCLBnQuZKgBi7K3g9OseZSE3i+3d+672F6nPAwOpN4xtV0Eh+4EN2Cde96Mui8braGp+qwZdVzNPnpuGpq8oDCrQXg1Wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735825230; c=relaxed/simple;
	bh=n8Ggta4uKJzerJ+/rHCJoNN92v8o2DsLYesCPBzdbPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+00o7ngzouy1xEKCwxxqmgjHp+mNLKhYpry+TEkBoVsqs2Tun7IVja02MTzTvBIB37zLwCgZUSSrfXq+TKK7Pv5zeP1BCw+jiQoYd6RHoqhKW1dXR7VM2Pl6trSX1ziD0A5hRwfxKQeQ5wka8VSYtaSd9eVK6jmosHYpfe8A1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmJD0inw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso72473605e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2025 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735825227; x=1736430027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9e/Fj6lahxmi3XK2JPYQ80z6Wjz7SwoHPp/XK71Fr+A=;
        b=lmJD0inwrrJ2qvgcD4QqGZ2+kvaH6yFkTYw5+uasVfLF8qSCL2WZb2Ah4BJNrc3Yr+
         OOymPYQp8KGBDqhXq/pGNkkiuM7LisZhKKEkeVp1tmvJmhvuoHGDy1UmQPhsfZq44weQ
         gdPLAfrIhxUNOHKcOUO+f5gFWkhLDIW1Mk9Wi2ZEHCIeGmouNomK5bhk93V+b5EXXIGQ
         5tSbWvJhET8XEHT0feozDQRgPs90xpW2qIx3YAqBwxxRBu72SbTWSIqXmPUJUQRtXWqG
         e2iYKJnRdv8yiuTE5PmS4RVDrILqUWhhmqchtEI+yQsEq4MaVZGM9McXIAwUd1X5X2mD
         ub2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735825227; x=1736430027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9e/Fj6lahxmi3XK2JPYQ80z6Wjz7SwoHPp/XK71Fr+A=;
        b=M8DfJZAfHsxWTvB1scmWcv5usUoTnduQJNmh2p+/Xjjm38AHBUdYAuAhzbCH5sKSyC
         MFqnrADA+5NHHdTaHAh2zC7RA324ysSmCto3PG+GFmq0v/3YUoylg63209y+FzxxFwop
         E1kPizsRTDsrjPZBuNIydjrTgrwdykF10bcTAgTeiD25rg9YuVHrDIxNw/K0A6XkLBuX
         c3/3c21aRaa2KKxyLLJHX2VZsuq5JDX0X1guqxWkVk0fVopvE3IINj9oiXmA5gxvzUsp
         vSIF8Ovrk3elhLT+HvjDaM+6/5Vbtbl5g7/5oZFlxFhQyOdWT9N/y50VroT7bRhRDEOa
         +xZw==
X-Forwarded-Encrypted: i=1; AJvYcCVUR1PB0fxN/xh9h/2V1spfDcIoS+Br9Q+ZHbF90bpULcY8exRbRo/9T2VMZ9Vdzh36kc21wFZXLXDQUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzadF8nefPhyvNN+JphbureA+maCog1TGsQit9OTtlh5BjfRgU
	YPL6kG1ZtshtiNwQ9s2plLW6qmnni8cibWsZHkqwInjvMIKwWgdqEfKWsPevfrjMvQ==
X-Gm-Gg: ASbGncuSCyuS2uVMG8S7TUP8t30bNa1vPsigVhUhczIQ37SB+WNH+Cw2v7ghadTl33q
	diTPaQ1nVhpy2VjdBth8aaQsXQCGQfp8oCKwQK8LWLbe0G/yhmUqmZONKqZGMS49ux7XNwcpZqv
	+P5OIkntiHVuMzfesdKH7Z7KkZB/zP/pyPD5wHUYkqMIDQV6U9ZnoE6TPRkP42ycKy0YXVqw8Sg
	j3bNNCSogvFtAi6m7CdNwKhyudF/YIr+JwkzbaaWHMA4FdkwfDHCTN0c7Tse34dHXVXrScddbAk
	W8rnMEYFF4+4qYq/
X-Google-Smtp-Source: AGHT+IHGIAkQabMmXGzQBgiumMFz6WodpBcenPp23VO/3YbkmzAb3L4grwCiAqFP7K2RqRir7FVShg==
X-Received: by 2002:a7b:c3d9:0:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-4365c79aa7dmr429657945e9.13.1735825226555;
        Thu, 02 Jan 2025 05:40:26 -0800 (PST)
Received: from [128.93.66.153] (ptb-02008469.paris.inria.fr. [128.93.66.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c4esm487034295e9.4.2025.01.02.05.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 05:40:26 -0800 (PST)
Message-ID: <5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
Date: Thu, 2 Jan 2025 14:40:25 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS errors following bad SATA connection
To: Roman Mamedov <rm@romanrm.net>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
 <76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
 <f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
 <a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
 <20250102183329.35047254@nvm>
Content-Language: en-US
From: Victor Banon <banon.victor@gmail.com>
In-Reply-To: <20250102183329.35047254@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2025 14:33, Roman Mamedov wrote:
> Btrfs stores checksums for data, so unless you turned that off, reading
> corrupted files will return an I/O error, not bad content. So you can just
> reread all files into /dev/null, and the corrupted ones will be unreadable.
I have run `find . -type f -exec cat {} >/dev/null +` a few times, but 
issues persist even after deleting all the i/o error files. It's like 
there's always new files that get borked.
> Overall for your FS it's not looking good, there is no proper fix for "parent
> transid verify failed" and this may require a reformat.
Sad to hear. So there's no way I can fix this by deleting corrupted 
files and running a scrub? What's the best case scenario here, and what 
should be my next steps?
> I remember reading something about the mdadm RAID5 making this issue of Btrfs
> worse, due to mdraid "write hole", which its PPL feature is supposed to fix.

Sadly I have heard all of the warnings about btrfs and RAID 56 much too 
late. More recently I have read conflicting things about whether or not 
that issue was better, worse, or the same with mdadm. Not that it 
matters at this point.

Thanks.



