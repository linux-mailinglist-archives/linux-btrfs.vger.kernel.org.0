Return-Path: <linux-btrfs+bounces-20074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF34CEDFC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 08:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C87CA3007C45
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CB2D249E;
	Fri,  2 Jan 2026 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAO045u1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D252147F9
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767339301; cv=none; b=fSS0UEehwp3Hc8yh9o1po2wM96Q4G5JWJZmEgkptpRvO5d4+meiAJWGR/O/kDF53pskMVXGD5YeWLlcwBJKU+UtajhOkiuGaGJh+kqLjQlTJvcUR2W5llzoJZDXxwPYYVS0qgPZ4prhDeZwE+uTnkziwYxTwqNxv1vudXkTnE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767339301; c=relaxed/simple;
	bh=mG8gsOehsBLTuCQrm1GT6QUgzTQFHED8iiOh4nZbf0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ls5SozITYlg8jVUGFMZI/vefc4orHEYdhUQyzwPF9R/9hUrYOwF6PhuwxaXtgKQGsk35e4dTxC4mWzHtykVDL5jgm4EmLDsQdX2MhOFkyFEXA0pe1t4ua22HNUUJ2FBvYOcLpSduyN/NPMBT/HDKAiR83ZYjebptvn8boW6TaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAO045u1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7a72874af1so2001974366b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jan 2026 23:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767339297; x=1767944097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcmCcZ1jKufS8QhVsq+knxv6VooTfCRyEMTUek+LEDk=;
        b=LAO045u1Z/T8ERWH42Ca2Z69et/x6IDRuDHFSF0K6FLo+a76xEIa6iCKK/+/V+HlKt
         clN3ZB/qZ09WgNuw0Ouecvvtq/ZqSxDq7NMC5Iqm8lOH9blrd2wNp+IJ7Dz0OUFy8DKK
         RguHJupa7x6n0BctB07i6IiJTYW4E/7FLRhdvogmOj4X1CKB1s8EjkQvYEUA8+6Uf/Q5
         krKerQspWLOpd7y2nb7Bigbs1nxXKRUoZhAlNoNvwetlGeUDvt/oX2RLKKP2UKpaHBtE
         l1w+nZKYss44EDD3hKhS+yHkiJURizCyzAMTaV8MFpBOsMOGaVSEuHwfAymx27GJWGcg
         eQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767339297; x=1767944097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcmCcZ1jKufS8QhVsq+knxv6VooTfCRyEMTUek+LEDk=;
        b=a3Y2fnBgXlTyxU6Z/r+onSqjBEk2KlDRxd1ing6fcm05yIaPcoaV/yxKLoodzY07oa
         n/MMlpCu897VpEeJSrhqXt8F+8mffpwLEkulEPE+txWef/h1p1COLMDgotUxXGIzmFtT
         b25HEhK+yqrU4ShWWHcLbqWlNLC4lr1413e3P08U5Vr1h+OfBS5dsJfsKYGpr/eIaqd/
         Mqi8aP9eiObZIuS3AArgosFGuLCoOioPp0NJ4bvFk1Bcnr02uP18JS3Vu650DXVoYMxM
         DImpQA/zHw0G4ZFMXMVGPBXpDIZayOKufxzttshdQ6MIsdxQQB6eChRkrd8TQeFxbgOq
         t0Dw==
X-Gm-Message-State: AOJu0Yx3/EftJuD/asxG8vSmvWmfDk52YayLGAFLFw/GkBguqwTZlIc4
	Ud/qIirh8T62TEzZkFJ78iwZsFVjMJ4m3K93pyenflzSXfhRMZxSQHQ2ZoJE9w==
X-Gm-Gg: AY/fxX4V4r1W1kHiuczTrjeUJdTtsZBXWblI5Ub/YLhtgct51tiBY1n3/W6wbZ9Bofl
	8WjSbPRpkRFROMTH3+pYS4w+MVttNl30MnEBwaAFnx1gMvGk0g1aJiiYnFJntEvjYnxQ/b3HAAO
	7fOBBp7k80JHnTikqibwrfSPCJzwklNSBdafx5J+9i59f+re/3loL1EWFRXvIRQMBEOS9+hInKQ
	k3GWbJBW26JW4kn+tp13yE4L3q4BmaUPsZuyrzF7y0BHwNVUurk625WDsBDnmvRXUJtaBOxpr7X
	KbTv5qgUgWk7aGFbyqKHRlf7pcTr6AeNLUZPMPJVnlQZ/eC2k69v1CHcRbBDsQbZDwP2PaygPu3
	XEttUpKv4YDhGt447BwOod2nXytyFy1RlHlyL/7w6WAZXX+t1udffr8kMmoIxfOJfhxA8m1niiO
	fh1tZuMsrVISx5UyiAqJDLGGWFDpxUt38cXdTvIkyOzDW4KQTljGLp0f5HZBWD
X-Google-Smtp-Source: AGHT+IGECQkBgoKnRMdKQghw7hxmAPmPO6wXorKNGQMD8w/wWtjtcWKEsbbMGHOuqP06NWMm+Uinvg==
X-Received: by 2002:a17:907:7f03:b0:b80:a31:eb08 with SMTP id a640c23a62f3a-b80371c905emr4118954866b.55.1767339297283;
        Thu, 01 Jan 2026 23:34:57 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3b0f:bd68:96d6:7cb4:eb92? ([2a00:1370:8180:3b0f:bd68:96d6:7cb4:eb92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80464e01d9sm4397092266b.42.2026.01.01.23.34.56
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 23:34:56 -0800 (PST)
Message-ID: <14e124e9-c283-4051-a14b-87a58bddea92@gmail.com>
Date: Fri, 2 Jan 2026 10:34:55 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: backup best practise?
To: linux-btrfs@vger.kernel.org
References: <20260101234624.GA1955478@tik.uni-stuttgart.de>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20260101234624.GA1955478@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

02.01.2026 02:46, Ulli Horlacher wrote:
> What is the best practise for backup of a local btrfs file system?
> 
> In my case, I have 2 disks: disk one contains a /home btrfs filesystem,
> disk two contins a /backup btrfs filesystem.
> So far I use:
> rsync -a --delete /home /backup
> 
> The drawback of this methode is: In /home there are also *big* VMs which
> will be copied every time even if they have changed only a few bytes,
> because rsync works file based.
> 

The obvious answer for the btrfs is btrfs send/receive. Any reason you 
do not consider it?

> Using RAID1 is not a backup. When I inadvertently delete a file it has
> gone on the mirror side, too.
> 
> I have snapshots of /home, but they will not help me if disk one has a
> hardware failure.
> 
> 


