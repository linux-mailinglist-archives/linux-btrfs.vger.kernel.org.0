Return-Path: <linux-btrfs+bounces-10717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E34A00FD3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D6B16516F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895D1C07EA;
	Fri,  3 Jan 2025 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUAHRIiu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A46191494
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939464; cv=none; b=GpJyIqSr6l+oIse/+2/TBfN3+efwOLFPM3SXM+oCk+wn3nFWaxKUB+TWSByz6PSsBQBl6/4cio76LhdcqQIsodcBt5XHPA89Z+a5M/kxONojoJ1keawZQPvXPoKW5DRTouuTg74UU1k6E4cY+bZJtI6gRxPb75QmzoSdoiMxow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939464; c=relaxed/simple;
	bh=XSQopwZQDVoEUbFxMXWcY8+qFpDPMO8rKnDrTHBEgKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXANzKKTGEO2z/Rx01zZTFliFMAH8AgRb0voJFcZOtUuZtLnq6WPPdR4bPHW0kinZbaosD37o9RCnl0wIll2VIK6YzLtLyleEjYWeWgRYUYCriSE/Ujoo2B10CdlOF711WPpLKV2zjSO8Yy2mW6oC6F3o+IoyEOaKuBgqibGBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUAHRIiu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa67f31a858so2242616166b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 13:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735939461; x=1736544261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjGkqdO3pX7pPOw1JYALCBxofh/XkX/eoH4E26Ta1o0=;
        b=hUAHRIiuBsS8N3HK6mgxekf1KN2tpOGVAjvzlDXtGq6RWl7OMHdDrfHtm9ZZ2Fz7U8
         ShHa2Kw3mLTva9z9KbcdFYmL+81zXuL28ckAkWIUzlK4SIMMWqkYalnYO2gQ+T7+btCG
         glKBcjjHTqNbET5bzq/e6nB+wEEtSIZSqQqiYEfwD3tWcwNUgJ5wDPMSVj8Lqq8hw1QC
         XXhzZQx+pxip5E8ifNz+qwo2JsQ9SOw9XZLDMQRkuTjrmF0OGKaTib8qolJhE5l7Tu9m
         tPeGDUB3VeK1cJdjejc94jli+CGYhf04r1nz/AxYUYJ1XrmcEpCUhTbtXpCMLwsEP8iD
         HLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735939461; x=1736544261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjGkqdO3pX7pPOw1JYALCBxofh/XkX/eoH4E26Ta1o0=;
        b=lmMVOG6e84a6TQ/e10AWn2jalYNBn+2xLowJFZQ7IiELMd7pbDcGOxWxH1pirNSeAP
         ckXEKUb+J6i4FDBYqcsF43TCacT+GjDVoCZq8lVWqnO4///3AVQZc034lwYqVYvNnute
         7f6bgtzkaJBu6Q756J+p9x3BQzJNDlrvTd0am4e9KRNaC5FZwDTVzetavBbf7cfp1RrK
         dj3uqsutdr9ePWd2PAlLC2ouMB/bBSvlgvTEHQYaOYPuTT+af35b+HXq/oQeBUkl6FY9
         pHclZrTh9Tu3wwk1jgwL/tmECPY/DMQ2ftQxPP06knY8FouGjbXj/wLjo5GXuAJST0XC
         8Gtg==
X-Forwarded-Encrypted: i=1; AJvYcCW0HPCJNrP2WlF+nUn14VvOIoWVKT7VU0manMWoCbLcbMM5eNjm/P8WMVAMB5NP7x2sNOxXhIjlK3uoSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXF+l3BEcj5CQO7zdKs18vDHCw9hbKi1g5fV1n6zrppsxmE6C
	H/19bajp7RqRwtIdt3g2EVfEEPnslO7bEOQTNw9iK+8pt1DPXIjJ0NTWHBvl
X-Gm-Gg: ASbGncv9S90hs2lMNkYSM+iqlI5Li+pgMLAaMV3TWibMRHd6EFXpgirAah4f41uqNeY
	FBdPoJFFQj+BYCJex1DsGqo64ZJ4uKOZgwdyZNuOI1mTvDyyxjP+tVlYN+hZdj4tEd1zHhT0hzA
	iV31Nd5RRBQeLPNBiajehBo0dgW4M6T8mbK1r9w9a76QPdr3mIeG27meGfbzWpZm87hVE5Co5Og
	UKMKeWpKHmwhgEWCkiGKPjS5kwvurylX81w/16+XCEx7LvbInoe4rr08F+y/FxUhshd69o5RnFn
	2Yr2IYwxPPlp80Yz04Ve6DDT+uURXpwF8/vpNDdqpDOO0kEXUqZCyT1yWY5OyaZ/nO5qRGLViAU
	6OlmmjmQbibZoQjE=
X-Google-Smtp-Source: AGHT+IE61QtnFKiiZ9QfhTrUU/jBzUnwNvUyqhZp+F7ktFTOZhk5prwbmVeGgCfXeeCQeI9jd2jYqQ==
X-Received: by 2002:a17:907:6d01:b0:aaf:5c9:19f9 with SMTP id a640c23a62f3a-aaf05c91b72mr3494614266b.27.1735939460391;
        Fri, 03 Jan 2025 13:24:20 -0800 (PST)
Received: from ?IPV6:2a01:cb04:91:ab00:546e:9d21:e7f5:ca84? (2a01cb040091ab00546e9d21e7f5ca84.ipv6.abo.wanadoo.fr. [2a01:cb04:91:ab00:546e:9d21:e7f5:ca84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8301bdsm1929708166b.31.2025.01.03.13.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 13:24:19 -0800 (PST)
Message-ID: <70008910-2c6f-4fcd-ba36-68ff16992504@gmail.com>
Date: Fri, 3 Jan 2025 22:24:19 +0100
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
 <5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
 <02affeaa-aafa-4225-94f6-bee621a9a4b6@gmail.com>
 <20250103170900.7016c4c4@nvm>
 <032d71e6-954e-4fc6-bf43-18a6762d08b9@gmail.com>
 <20250103184549.78c383b0@nvm>
 <2ff268f4-8565-45e1-b752-3ca85c736841@gmail.com>
 <20250104020426.3899f4c8@nvm>
Content-Language: en-US
From: Victor Banon <banon.victor@gmail.com>
In-Reply-To: <20250104020426.3899f4c8@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/01/2025 22:04, Roman Mamedov wrote:
> You mean a scan as suggested previously, trying to rename unreadable files to
> "bad", or just a read-only pass too? It is probably way too broken after all,
> so you might as well start planning backup+recreate.
No, not read-only. I tried a few things, but for example when I tried to 
delete the unreadable files (tweaked version of your command), the 
filesystem became read-only.
> Not sure what to make of it

Oh well. Maybe I'll try again once to be sure and then move on to 
recreating everything. Right now I can probably retrieve and store about 
5 TB of data, so not all is lost.

It just occurred to me that I might have a way to have enough space to 
retrieve most of the un-backed up files. The 4th disk of the RAID was a 
recent addition (that's probably when the SATA issues appeared), so I 
have closer to 24 TB of data than 36 TB. So I'm thinking I may be able 
to leverage up to 2 extra disks. Can I get your input on how dumb the 
following ideas are:

A. Delete some files then shrink the array (4x12TB RAID5 aka 36 usable 
TB -> 3x12 TB RAID5 aka 24 usable TB). Remove 1 drive, use it for extra 
storage.

B. Degrade the array (4x12TB RAID5 aka 36 usable TB -> degraded 3x12 TB 
RAID5 aka 36 usable TB). Remove 1 drive, use it for extra storage.

C. Do both (4x12TB RAID5 aka 36 usable TB -> degraded 2x12 TB RAID5 aka 
24 usable TB) . Remove 2 drives, use them for extra storage

It doesn't seem smart to do any of this while the array is in this 
precarious state, but I feel like I don't have a whole lot to lose by 
trying this-- even if it fails catastrophically, the alternative is to 
do nothing and reformat anyway. But I'd like to have some idea of what 
to expect before I do that... Is it even possible to shrink or degrade 
the array?

> moving the containing directory away
> somewhere and ignoring it for the time being
> I believe you should be able to move or rename the directory
Ah yes, that seems like it would have worked :) Didn't think of that.

