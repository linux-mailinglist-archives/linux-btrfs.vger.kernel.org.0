Return-Path: <linux-btrfs+bounces-9560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383729C633C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 22:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0517283CD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 21:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A7821A4B9;
	Tue, 12 Nov 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W9yGcKdm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E514C59C
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446373; cv=none; b=G1DAtcOP1fx4YcVCcfvzK+AZB4Ha/R0Tsxi15nr44bLlUDYQp7ErZvT82pigVan4D3eRgXfE2YJbC+XWaq5PTMuMFF2Uu6EtCFXp18z+c6Hx1s2MxXsGCyPkSL8FvWdTWcoe6ZbITJzQZyCgcUtE50fSVxJ6WBjO+jOZQeZMp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446373; c=relaxed/simple;
	bh=SEL6X6hdUxF6ym4A9NUSeFNUTCyHas6dfssLeN1VhQo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qdsaBq1Z+ZOvRVGq4QEtI060yG9MPFK1B8yDDBVs7f1rPvEkrQiqKf3smLZW84+RboAqe1e9889qhOjv4JPZLwhd5tuio7SMN9BblmHZOVWhxn0iLClVnYEgJEA2TMnJZvpeYYcdC2ncYDvOTeNmSheIVvg5inUh/XTYNgDXUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W9yGcKdm; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e604425aa0so3583830b6e.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731446371; x=1732051171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0LGAAhnzSPN+1d55yonk1/GMChB/jRmj1V/dRhQ/hk=;
        b=W9yGcKdm9K8ak393hUNH6YNvpU7+rVuMK+LhHjG9X5mUJQ3I4xbZMgY605A+2HgtwW
         0ybjcxib3ozswqOJL7yaznh51ZtEcS/9Uy6t15KTrhZtZSD9w6pK1rYczs2SzGKQXLSQ
         K8zDwGDMJfq4ToU9TOhQhGyGjTeEpjcllk4R7NHme08rV5hqJkmwK3+n8DiIzfb2O4sn
         l94nnyZ48ErGGT4J7C85e1OxFbV+9yBgxHm7YfveVIAnki1MDQTt6Vi6DxTAPXaEKceS
         4pWI/VqPMs0ZSdd/OaTxMLeXgXH9Y1I6C/8Bgp8qly+d8gLUZfd7Oz1kn/zmvwikkNLu
         MipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731446371; x=1732051171;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0LGAAhnzSPN+1d55yonk1/GMChB/jRmj1V/dRhQ/hk=;
        b=G7hk67FSoYANAdlJuBZALfP5NHnGo2yQUNKYu6VtSd88uLnRDqzp5SDBauClpuXrFK
         PQoNcnEOvhAbEweLq7yknuaq6SyL2q3gDQRX75E5W892Lgv++pGiyZuMrrlsOLcji1Gn
         ozStQQjd5O49szg5DWj+7wDNii4PTAlOOL5NKuNliOxeCDCnuHa/9NKZAnkFIqjCDTEp
         PbkeJTDn0jM8+AtDUC7AXPwBQxTtRdTJDQc1GDAwZAV6zJXxWJob+a8fRZIy0ASJCGI1
         KR0Ty4zz2u2PvbthNKV0vBFg9YqtUc0DwOf0VJ/Vze9EJ1lRrv1/xWRjUBhM5mDiA8m2
         wGAg==
X-Forwarded-Encrypted: i=1; AJvYcCX0BRxzryXJZIlLb0eEuzq3WgZFXFsYooS1c6M/G+xtqwEHXmKFlPu/cVu5JOGDPqdOXr+HLwOBRq3ddg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5PlWOaWYpVdH7hgElPxpSr8R4ulPsH/xzTu3wUasv1zp1LgU
	k2jYZVnlUaKeyz9fw4kEya3RZtn3CM/FbL8vVThpJ6+bmKSQ2f6VsnuKCry/mfUwxw/t5ZvLeVC
	5EAw=
X-Google-Smtp-Source: AGHT+IHRWQzNVJxVEAh22puDycpcVGRjweG7PJYNurtD1CyzmW7C4IptCPtXOB2QuJi+mTvvENQ8tw==
X-Received: by 2002:a05:6808:138c:b0:3e6:2f8c:317a with SMTP id 5614622812f47-3e79469a506mr14762715b6e.2.1731446371234;
        Tue, 12 Nov 2024 13:19:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7b0969cddsm74292b6e.17.2024.11.12.13.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 13:19:30 -0800 (PST)
Message-ID: <4c59f6ff-c766-4820-9b7d-c5bd453ed3bc@kernel.dk>
Date: Tue, 12 Nov 2024 14:19:29 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add io_uring interface for encoded writes
From: Jens Axboe <axboe@kernel.dk>
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20241112163021.1948119-1-maharmstone@fb.com>
 <5ecbdce7-d143-4cee-b771-bf94a08f801a@kernel.dk>
Content-Language: en-US
In-Reply-To: <5ecbdce7-d143-4cee-b771-bf94a08f801a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 2:01 PM, Jens Axboe wrote:
> I'm also pondering if the encoded read side suffers from the same issue?

It does, it needs the same fixup.

-- 
Jens Axboe

