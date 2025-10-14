Return-Path: <linux-btrfs+bounces-17775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10021BDA1D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 16:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0DD1884FB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB822FFFAD;
	Tue, 14 Oct 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csf7Mhwt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E222FFDFC
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452742; cv=none; b=Fxq0U7p1lOED9tCvLIjwGOMDHvLJ1VuVMcD4+8F52LTDcmhJrctX06X98p+K6kUecHhDf/d4m6gpQD+5nCmOG10whWiS1NvIX4c8ZNT2byquowagoxNxfnE+4QR09+ZupC/3p9zYxJE/igy309pkJonm2QfVWZVI1PBMOK84iZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452742; c=relaxed/simple;
	bh=gEk3t4S9waDtJgDByDPn4LtGM9xH0Oa/XbWa0erf0iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWUDLsSfhtw/Gywd7pufrwKL/fnnkoe6gNqgn4r+1OyQeteiUOpXsoYGhk/nJx11LC7ky6+wbKS0H3aYTapiPe6R2IPomXMBFJGQ2FhJ4HwID6qadhuVOxREejw803UwVRrokf7pjvFzX+SzjdMLB5ODczhGuTN64cbYBYhNYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csf7Mhwt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-273a0aeed57so79559225ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452740; x=1761057540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqEDkib+N30KXArKpe7ewNMkywXK95kyiRz44nBvWWM=;
        b=csf7MhwtaocVoruSf6V9DDpVISfYKTvVspshQeFGQG3U4xOO+VNVnTpi7HHi20yomQ
         dfi54PbGenISskmZjSnZmUyo46scxUggc5BBfqYFPYKCsbYfAF5Q24Gfpa+Z/Z1N+fGL
         GF+mznGtYqYOFINEBRkkWeDN/OuckSiSNlM8bgR9ImIMN2vVhuLIIsnneI41veq/Kat0
         U/UQ96bW9556hEbDUX0mbhrog1yw8Y77OoD8x1Pi67DMBeTeZWPDAlOmL7S3n33WCaxy
         bcifj0Gd92dmrF60ilmn9R5EacATQZoJOOcDeKcn7ts9ZF21uxqWq123hQRjSklnurOi
         /sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452740; x=1761057540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqEDkib+N30KXArKpe7ewNMkywXK95kyiRz44nBvWWM=;
        b=RYigr5HxkTNFfCCCpq8FqrTv70aLISkccuU1HwhT+uP/KP1G+opod8J9tO7NpvRssp
         3yLC6EI69J0QccbkimK0U0DibvyI2AOt8NSC+y1e7YVJrVeDOXNUmr3m0OBm6XPyWgH5
         Mwtdjx5WOKFBP8DY7AkVnDNTjWYFSCLuT5e5mr1BewMcCmEnHSo82Ap+KejT9SPTQ+wf
         Q8UegOq7YL0aaEx2CNzqZJ6E3JfS6EoTDmC8iSNeAw8XWsDhsmZ+GicjxDHoWvU9xU+u
         balVVrTKKdimkIaSoytrdFtUz8WbsQGxBI3urN7E/5DDUCGyYPelhIHN4zZcOz1GXZQJ
         TcJw==
X-Forwarded-Encrypted: i=1; AJvYcCVvXRrTRA4I7RRzqOJgkzm50j4RDGKIjvoB9a/rwz8zxG03P9T4mtNhD4nbEwl4yqCpUREC5XWl4CJyew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfTl3CcFEPIAv/NzYTutKs1DfqwDQcQFoGrXFC4Tawb8Lh16N
	UHvatf8+z4mmNw+y490oNBnzPOGgcfSDy7tLCoF2XCptXVMTotThU1GW
X-Gm-Gg: ASbGncuAGOH7QwVkThysPp2jwlDvls9LG0Upg4C6h6CRtpE9wtwmuZsiP+p6ZyMJfh0
	QaV/F4UsnwDS9MN6zcC3mg6+8VJNTwwnZO79T793U0515SOvNuwNWwJ0BiFbzQdXpVLqGE8M9g1
	Z3cey6WxlHJZ9rY3TE0vTDObAIoH6o0DuP4TyBYAvChjiHVft/10remM391zw/jg7E/7Gnf0tEp
	nNyuJ0ag8Xn7t8HcZEJi38cPl3mc3k8guawy3tQq1CxQ3q5s0/h+sFU5529PocljiArzRBpP0zP
	GrLLk3qRaQTlELRNBuhwyvhWIM66MCDSmRymJ5HcpYJvmPzTSiCufO7RN9PQG6z8QqlxnSnGFiP
	uRn+oE9/39C+sBnSem7lpHVGzlJVFePEuCb0+ZCMGCvAUpyoJd+Ax+Uh8KuSBlcEtlFIsZnBTPQ
	ImxukwV9sT0hlXs96nEwWFYzFs
X-Google-Smtp-Source: AGHT+IH9w7PaazGz7BQlcE2QlZOxdcMFUlkEfobVeM3DVC8y7AEtX5FV4nOl7zADROBVB9vnEIadbQ==
X-Received: by 2002:a17:902:e550:b0:265:f460:ab26 with SMTP id d9443c01a7336-28ec9c0c7d6mr378617155ad.3.1760452740152;
        Tue, 14 Oct 2025 07:39:00 -0700 (PDT)
Received: from [192.168.50.102] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df276b0sm12241194a12.23.2025.10.14.07.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:38:59 -0700 (PDT)
Message-ID: <fb51de17-1d18-4763-8eb4-454e6e6f55d9@gmail.com>
Date: Tue, 14 Oct 2025 22:38:55 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
To: hch <hch@lst.de>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Carlos Maiolino <cmaiolino@redhat.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
 <20251013080759.295348-4-johannes.thumshirn@wdc.com>
 <006ae40b-b2e6-441a-b2d3-296d1e166787@gmail.com>
 <4eeb481f-b94d-4c2f-909e-7c29ac2440b2@wdc.com>
 <97aece25-d146-4447-9756-f537acadace1@gmail.com>
 <20251014043000.GA30741@lst.de>
Content-Language: en-GB
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251014043000.GA30741@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14-Oct-25 12:30 PM, hch wrote:
> On Mon, Oct 13, 2025 at 10:42:03PM +0800, Anand Jain wrote:
>>> So I /think/ you just validated that the skip if !CONFIG_BLK_DEV_ZONED
>>> && !CONFIG_XFS_RT check works.
>>>
>>
>> Ah, thanks for clarifying. Any idea if the redirect to seqres.full can be
>> fixed? It was missing the mkfs errors.
> 
> With "fixed" you mean not having the mkfs errors in $seqres.full?  It's
> kinda useful to have the messages there to see why the test wasn't run.
> What speaks against having the messages logged?
> 

Right now (v3) the errors are going to stdout instead
of $seqres.full. I was thinking it'd be cleaner if they
went to $seqres.full instead.

Now:
   _try_mkfs_dev $zloop 2>&1 >> $seqres.full ||

Suggested:
   _try_mkfs_dev $zloop >> $seqres.full 2>&1 ||

Best. Anand

