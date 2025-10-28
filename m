Return-Path: <linux-btrfs+bounces-18384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57EC1479E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 12:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E84B4F7D01
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1030F7FB;
	Tue, 28 Oct 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heqeLLJ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188042E06ED
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652382; cv=none; b=I97DEe75lIpSMh2uxZsWAmIFQKUncQEP4UKDb7fJgZzQS5tLa26tKOoCRL8JPacj6i9sIYv9HoiHnLO3K6bltSc2wJ0MNFH+gNjer1aL7VKEg9mMEs+c67R2NVjoUVfGWXw37FmI7u5vI30w44h08U3fpsI11b24+KybDVwKujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652382; c=relaxed/simple;
	bh=Vi0FhiX/ggITd3I3NaqAnYfWEtdEdBan5sFdli9E1x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8pVGKPqvkL5v3M6iynRQov6xFQ35E8spwz/qTtLV69KdtwoBhe5WdeLaPp0JtM2VWf0ibBJFXKq9Ixf1GStiygYhTbnA955Dcs8o/T6jKO0CNBWtSfZ3wRTgmSUZFaryvOkh6q9jLO1+tIAOWuzl95PPtDN0vvKTTNM778fFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heqeLLJ0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-269639879c3so50457625ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761652380; x=1762257180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9q6iVQdHrPdlSbkfXY8WLj2PD38JvG6sOUR5lttSodQ=;
        b=heqeLLJ068Girb2vt3WbZP96ddf6IJffG+EkLX57+qbPV2ZVZkL9gtEB6iX1t1zrCn
         lCF+KDCNwWYJ/zDEn4s3y3Ft1zJvFBytnhmWYYCK2QBUFUKPoKXqKge4sZnvKYO0ojmr
         4fLKhSjqXY1ih02Z5j/8KM61ixb8Rqa+lbiz5qPrW5cVBzU4HePdEpI7aeuCGoBhcrPt
         ysWaHc6ZQm6KMet2fhGYK+9tNVYKpphdYvz/oV+QrVVDVUqqnmx8UgVdsckTNQpaLP0z
         ee88+2bB1x0g/4A06RNxzsKOlcU7S1PFTh7+0qkmSVL2P1XcRrH6Miyhwg3f5m/QmR0Y
         xBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652380; x=1762257180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9q6iVQdHrPdlSbkfXY8WLj2PD38JvG6sOUR5lttSodQ=;
        b=JwzhnAfiOZlCEqtIJVfvw+JZ+d8NJKeCRIYRQYr+DTov+p2ERsBoW40kBwsHpLrV3l
         8qD+ChQDUlB3TcjovwS6ffsld0WZGLfKWuaVYmuP0ivz3Xpfl7KPQNn0TxhgQi+Fy5z1
         26qpVC1M786G4VhaIp1ZvwadIjRKfFmzjtjKQvAQXL8/u0f431GgU/NZ4oGSZmfnJ0E5
         4DnzcdR1VjWfmNGEr+DIgTWQcm2aUJpm+Fz43nW7/6ZbW8eModyinOG0Ic9+pEuEOOsZ
         mQ8Hxvumd58J9gN/CN8rL2AoIt3RpR+014KI3rnjN04FbL0DFM7J2ho6hsm7qxonMGYJ
         e6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJyNbgM/PzCVHrOKCMZhW9XZPvuRBJQ+a078YI/FSPe/iSMWOVs9S3gIyR7+ayGV1VhEAs/R4UgKCjRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeSjoFn7Sff/GVm5wfZ4OFzP600lvHj/oEb7vEg30ieGiShFP
	vI7BheklnrkRcsKOtDAemPH29iQGpKkZC4Myy7ytIQ/cIAhvb/IxFcCj
X-Gm-Gg: ASbGncv1BcPgNDIK0BMhNdtP1/D7bIOpL9BjLs+YA0Zb2KImPzk2QKzv058W8JxYFBt
	DJ2fK75PQtm+w9pMlLMwwtiOzUmwxP90tMo9UhtJQxieFV3LTbIOTIzn8kqBItq+UMvF52DkBYE
	Y4ouClSQ3WJraINLUqKHOD6BVFGBKu65R4hEkEyXkIPV35606C6qCPIGGC0xIcX/gudrin8Xoug
	enFGkwF6NIWv4/sME6i1pq5BoIjoHR1q3vXbbZXTR4Nx2zsZ0zMQm/Yj6q6N0ZAiJ3XpnUb0WV+
	bfCghESfHk2TvAOVTksZ3M+HFWil+YVVRU4pp1m/QUs5wj7DqFaxv0CkGS2hbJEqRhCPzoPVgGw
	pdUNQoD36g9SpAD/Z8aI2TnzqaWSFGbBXB3oiem0BGDoGM8jU2E1BeINVmySoDfuV4T5Q1dYZgl
	yLilMfqWmguMHbdwk=
X-Google-Smtp-Source: AGHT+IG4v4AwOlK6aSbRgipc1yI6p/3NKXN0fH+1iuKSdkqn9RVuz1RC/ZsuBzjtQhG2qSX1tRVw/A==
X-Received: by 2002:a17:902:fc84:b0:267:ed5e:c902 with SMTP id d9443c01a7336-294cb392202mr52068325ad.20.1761652380349;
        Tue, 28 Oct 2025 04:53:00 -0700 (PDT)
Received: from [192.168.50.87] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm113605605ad.37.2025.10.28.04.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:53:00 -0700 (PDT)
Message-ID: <a76731af-72c3-42a2-ae14-d26c911d5c9a@gmail.com>
Date: Tue, 28 Oct 2025 19:52:56 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 Hans Holmberg <Hans.Holmberg@wdc.com>, linux-xfs@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
References: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
 <20251022092707.196710-3-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251022092707.196710-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



v6->v7 is missing. I guess ...

> +
> +_find_next_zloop()
> +{
> +    local id=0
> +

added local in v7.

Reviewed-by: Anand Jain <asj@kernel.org>



Thanks, Anand


