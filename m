Return-Path: <linux-btrfs+bounces-9400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A29C2D85
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2024 14:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90DC1C20FDB
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112C197A81;
	Sat,  9 Nov 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1yAgy2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16306195385
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731158474; cv=none; b=BOAqef45gcH214D7N3cQjqL60Mzw/a/8kmNtaHK6CqUhByTsxt3YgFJEigXKTWwqi/BadFpHY9w+nm3pohBq4XQjxUkY+5juRr6RfiWWZcRXSaJKezF17Hg8qyts3DVLi1ER6rQqSccg9jLbxU+QY5JuxS3EJLyANpOLxL3F67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731158474; c=relaxed/simple;
	bh=5JJLo2a8rI60wGee5CTsU0I0QUnlU2RsPjxjDX8nGLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyXzRXB9o3iwDLSdUvJw5NdSpA1J8G5gEdKE5/bkvkSlipknbzoqFgyNNeDOjGBHzpO0WxM6C2IJOBgO6InSuWPeXMoRRUJTuR2ksKWp9FyDeebtXipYShP6qpbSXAsgXiU0VRPenapWX236LK2Chq7E+zOo6L5ev7uv9ywGEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1yAgy2m; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539fe02c386so4019794e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Nov 2024 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731158471; x=1731763271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHeKvIjiCu/ngUTSkWrd9Z9AM5NsweZyS9tn4aso7LQ=;
        b=L1yAgy2m2aJMxretFbQZj4LfEYkd97Ap3KP8H85ukbRECJyZXQSAQtDCsJfRTRlUQ4
         UaWVCmfY4MkptSkGvQ+merrs3kMfZPLyhW9ZyqkewOlp4ohsTgM6f7A9QPV2kL/PtrI6
         r5GUj10hM0ubo24sy1RkqB5Lhx6HysndgRzku6XOraT3LUNKbJiFKNB0xIj1X/S70eCa
         6RV13FgVEM0eILliUKSn70OpWq3ZPuvcDbx8ny6vWgtou8m0Ba9i+bTXQzMyaBMJsVPt
         9/e+OTeGCJ2p609PIkdjkgMdO5NAioNFn8vIDn5IQ2pln4mRUM8gC8zG/y8Q7QZG0Ks8
         myTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731158471; x=1731763271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHeKvIjiCu/ngUTSkWrd9Z9AM5NsweZyS9tn4aso7LQ=;
        b=wy9Mq4BIFmxFV+jcOm6AzrzDMPKw82x72DPy+qV9gLF166jr2P0sv3uF79HoAagvEx
         XsPS6hEQITqnBCHGLX8XQ4RGpatjLScTuC5kdFXi4o2hBR+z6vmz8m3egOc+s8vqb5C2
         idFdcF0Brb08LsCmdSeC1y3nwalry6eWzN26BAdfvrKK2zGSgxpDcjyLqLjci1gag7Rr
         J6XKvLbIB+LlUS9fYe+JM3zSGEDnqynbwvJFaFhA4Cf5u+5m+WL7ymCNMDJei9Aq4Krj
         LI9i3zywLrIh3wZPLiz6TrPKne7XhKCJvS4E6sB/MlGKp0xgugKqVQjMb63rDUOBFIIJ
         +txg==
X-Forwarded-Encrypted: i=1; AJvYcCUbedjOeKfIVWlN1KGtryp7/VYq/pzrP4ZulSs9LqGsxhwgyBs9h+o9FTnPkXw7WBaE/ywsIKCOna8CKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkmRFeaCDfNAW84g5xI+gkEQ7QIBKRd+xVFcj8fN+FweDGXJU
	1NMeGkElgwsvKvs9AJ50Nw3J8TBK6L8Hith2rWQQ8pVhdBH/B6zvjHshqA==
X-Google-Smtp-Source: AGHT+IE2k/AnkDoLZR41gv12tlg/U/7oOc/7pmq8XxJ8LQH8E1MRLaiaqqFT8eI/Hp49pbf/JvOv7Q==
X-Received: by 2002:a05:6512:2813:b0:539:f1d2:725b with SMTP id 2adb3069b0e04-53d866b2220mr2226254e87.4.1731158470806;
        Sat, 09 Nov 2024 05:21:10 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:371b:43bf:b92f:f22:ccb5? ([2a00:1370:8180:371b:43bf:b92f:f22:ccb5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d8c3cbf20sm203723e87.132.2024.11.09.05.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 05:21:10 -0800 (PST)
Message-ID: <1cf9958b-bc89-4000-9c14-ef800e5f58bd@gmail.com>
Date: Sat, 9 Nov 2024 16:21:03 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering from/avoiding metadata space exhaustion
To: Stefan N <stefannnau@gmail.com>, Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+W5K0pYAyHS6K5Oy2h03KKgP9+6Q0stOYBrNY7vSmA+J4SdfA@mail.gmail.com>
 <CA+W5K0pnbNZL+rPu=vF1TTYnrx+=qhUSuNjx-ueDNc=ip+yjpA@mail.gmail.com>
 <fb093ca9-2deb-4eae-93ee-8442e01e7470@app.fastmail.com>
 <CAK-xaQaCY5uLz0Sg4f4VupFFxf707RS26DBLaVxJ3UJgs5Eoug@mail.gmail.com>
 <CA+W5K0ovc1fbgYJMDhXx_kJNUBdV7pZ0DSwqkPzcqodAEn0=Qw@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CA+W5K0ovc1fbgYJMDhXx_kJNUBdV7pZ0DSwqkPzcqodAEn0=Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

09.11.2024 10:01, Stefan N wrote:
> 
> $ mount -o rw,degraded,clear_cache,skip_balance -U my-uuid /mnt/array
> 
> BTRFS info (device sdd1): first mount of my-uuid
> BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
> BTRFS info (device sdd1): using free-space-tree
> BTRFS info (device sdd1): rebuilding free space tree

You could try mounting with clear-cache,nospace_cache or btrfs-check 
--clear-space-cache.



