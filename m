Return-Path: <linux-btrfs+bounces-5986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA291791B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3286B23941
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CC14EC65;
	Wed, 26 Jun 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMiNS1UI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39F10F4
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384063; cv=none; b=LoBF95Zv5PLFgFmu2qnwh71ZxAPJ9GB84cg43WMoNMATqdayydo9ixtd1pPOz1fsitjtUSfof4YrVW7ckz6QTjAxKv3S38BqnarwHXjDlqWCHRe4DFIwXyg0QiXpHHYAHn1UZHkjLLOyL0YNF8AhZYz5eiDyiE+5Yckt3vhZIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384063; c=relaxed/simple;
	bh=cbV4lamy9ShFT9t8wsLH5W+4cVV24uftLC+KqqGCrvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mL4KVaP3jgYAoZhy6EEWpiVF+npqQf40/91SdZ9SYWft7gHaHIfr84UxrVfU3cV7EVAR1uIf1162BTpOF695XZu0zCFZD53nYmr6Qwip0Ixd131uhqZmcr5kGwAOc9N2yX+UzxBa1cmtlSTnVzO4GoDfw26gz49lA2HVif2v1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMiNS1UI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cd7cf12d9so645335e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384060; x=1719988860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBa54FgVDp26jhcEWjqI6gmVYuzhqfvJ2aR5Jvb+sHY=;
        b=bMiNS1UIaCQWGMZIiZyP4S05UPYtD3lCcsDktezdDy2PSQXBoY+9hGbLILFRlSflVI
         LzYx4r8L5eQ1T42zgPdATOT1agbs+u6EcolANty7bvmRzel1XRvwk6RQeyadAN0k3BzR
         ViTw4KXXgh0l9Sw8FHnAX8a0la6tI8gXK41S5J1pgcKhblTU5mW+QriLYJNUcsRIrxIL
         DkeaYswuoweMCbNTQJlaIzZCf+9sLNKwaHbLC9CEBxXXQY/F7L1lrTQk3Ui5r+24RA7a
         b3nC7h0+1ZlTp75N0uFEMtHEqPsGnxU3jQIVhZPEk8MIAyearHQToI1gZpbdyC+mrXkr
         55lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384060; x=1719988860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBa54FgVDp26jhcEWjqI6gmVYuzhqfvJ2aR5Jvb+sHY=;
        b=s3oDhAFqEqS+ON1FFjAZl60yR59/30vzmgkMaKCF/vX8ewGaWvD9WpbwNGpGmRvCkN
         EPWkUlTbAcNoESUWwlfeVUIejf+mILa3TzdZ/vtRaurLKx70I9ZEA28B37mBxmW7VPOa
         pS3TSkZDBUEBrAlyYP4esvEQKctT30VUU/5RvW7osO9AiAfhINFI0X5h+ry4I8fTza76
         jMDhEEy2VkNoOJ5R7rfKuWSDH4HdXuYvU32UsLaA5Wb1AJS+77Ro23NHTceJuaXxnfkl
         Zjh0Z/gRw2jCw1dkhReJp0yX3PMy3nHDaity3F9ryGUAlbi1bkUI4olp7b76f+GI4PFI
         Vhqw==
X-Forwarded-Encrypted: i=1; AJvYcCWJYH8bj1a8lvGq9RqikMVgPrCyTCFkVjFqrvtfRGdaOR552Y3ptK7I9zLbdvdKd8BFgM/UYpU+2UaiinRqw5WWLdTKHqloW6UFhLM=
X-Gm-Message-State: AOJu0YymXtBqKGCzdXSJn7v6NiyuShL0IigK2sU2LdplthteQgfqjQKw
	vutKCuUdOu8QSBa69unEH8Kch26VBK8zxDwxUQUcmFcaT2uJg/B8+TSfXoHA
X-Google-Smtp-Source: AGHT+IFpsC7UDAC5vzgThYWt0YvDjq14r95Ww+5bcG4clQCfqfkMf091GqCJ02okdr25rmNbyG1kgg==
X-Received: by 2002:a05:6512:3484:b0:52c:df28:de54 with SMTP id 2adb3069b0e04-52cdf28def2mr5248766e87.4.1719384059722;
        Tue, 25 Jun 2024 23:40:59 -0700 (PDT)
Received: from [192.168.1.110] ([176.124.146.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce12a789dsm976779e87.271.2024.06.25.23.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:40:58 -0700 (PDT)
Message-ID: <303dee41-7b6e-4a54-be75-acbc3b4da5a5@gmail.com>
Date: Wed, 26 Jun 2024 09:40:56 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: workaround for buggy GNU df
To: Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
References: <20240621065709.GA598391@tik.uni-stuttgart.de>
 <87le2s6gbw.fsf@vps.thesusis.net>
 <4da3947b-5412-ccaa-527d-d2263da7f36d@georgianit.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <4da3947b-5412-ccaa-527d-d2263da7f36d@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.06.2024 22:12, Remi Gauvin wrote:
> On 2024-06-25 2:13 p.m., Phillip Susi wrote:
>>> The GNU tool df does not work correctly on btrfs, example:
>>>
>>> root@fex:/test/test/test# df -T phoon.png
>>> Filesystem     Type 1K-blocks     Used Available Use% Mounted on
>>> -              -     67107840 16458828  47946692  26% /test/test
>>>
>>> root@fex:/test/test/test# grep /test /proc/mounts || echo nope
>>> nope
>>>
>>> The mountpoint is wrong, the kernel knows the truth.
>> How did you get this to happen?
>>
> 
> Very easy to replicate.  If you call df with a path, it prints the
> location of the subvolume in the "Mounted As" column.  No other steps
> necessary.
> 
> 

bor@tw:~> df -T /home
Filesystem     Type  1K-blocks     Used Available Use% Mounted on
/dev/sda2      btrfs  39835648 20799988  16982220  56% /home
bor@tw:~> df -T /home/bor
Filesystem     Type  1K-blocks     Used Available Use% Mounted on
/dev/sda2      btrfs  39835648 20799988  16982220  56% /home
bor@tw:~> df -T /home/bor/bin
Filesystem     Type  1K-blocks     Used Available Use% Mounted on
/dev/sda2      btrfs  39835648 20799988  16982220  56% /home
bor@tw:~>



