Return-Path: <linux-btrfs+bounces-4464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED118AB98B
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 06:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20FB1F215A4
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 04:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C2E55F;
	Sat, 20 Apr 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFatvvdz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A75C13B
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Apr 2024 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713587422; cv=none; b=UCUiQxqkjrImUxdQ55MYrijMbrHCaBU3D4yIZlXtaM6aQ6TYSACIESuyMBJAhln/0lNuzBim43V9u0YIVmU9Xr6RTqz+ke06RWfvg6DwjM7mviXWvqMCofmeyUgLuD1Vk23FuOlCpPlyiHASyPgd88f2BGl5eOydDyPd/ghj/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713587422; c=relaxed/simple;
	bh=1501/fr089r/pWTA+4wKAi5U709st6zv4kqzQlS/jSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ddUDMm6wDSk+exaTqWHpxl4eXuecGDuieiPlNGWlHfrZsXL/XKx4DEOCVFthHn9M2zQPmKsg8Juy5wTcnllVAWY32BeRX8m++oWWzdGGSo1SCAydYnBmI9v6M0h84BzxTOSYFWdDda1CxR7q+8Q5f2dH8CdEc0dR3RVLtUT20YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFatvvdz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51acb95b892so1337898e87.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713587418; x=1714192218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTt/tZuHqVgodEmq4b5GDz+OeIyXde5jauBEK9W+4JM=;
        b=UFatvvdzZa/isAB5l0+LI4w4zXZVdSkR2ihZkLHzQuTX9OdweK/vpYdVEOuJ2TE/4M
         a38WoZHmTSdhuP48Xhn9XfRqEMUG7wqOUwr/7rG0HWgB+6wNhY1mJT1QDqkCe4qys458
         KQwYXWWDUh4I348GJg/Lg9Q4z9q+z05QcDTJxavT8Qqb6A3kF4Acc5Lu5s23YM7S7j+1
         ykbNpsLS4hic2iyvkqbVpHhghrafEwaxZ7rfuum6loWdFnsXmzj0yqyU8yT94eaesJOm
         X4Z+YkmBTXJjP1iKNkKsdHlg6jWu1WcRe0iZiFgD2DVNxxsNDw+p3QIcEYg2+ei6WCje
         VfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713587418; x=1714192218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTt/tZuHqVgodEmq4b5GDz+OeIyXde5jauBEK9W+4JM=;
        b=WlEY5ebcIZ/zM+KVymNVvStO/6rhlLO0x9K14RrO45MFT5/xjziv8HjgznI0BCAqt2
         YOW7QVHhzaAedv+qfXyyGHj/bhRhYVA4ppcR4AgyrEUeu8y6PT8/r0Crctm17rXicPUM
         41VHawX84jmKiiNgi48z0UbTuWyldsmApqhL08OQW28WRXG4j6nG11E1fEVZgp1yzW+A
         sHmn/dMCM60w0/2N34W2ztCE9yrgWN9Tnd4kVw+py4j/bqYVxEqUza5gsP0ytbJvp+ev
         vRYoJgsztEKMYJcoOysrBJOblxeluNZk29x5zgwoAENC2vQ8ZAUIxhHvW3LWX6g0hnDA
         bXeg==
X-Forwarded-Encrypted: i=1; AJvYcCX2aIlI6I/yRoaB9GdXnjyCU9LEaV/NQoqiyeTarTqP+UAAgvu8dUeaXF0Jb2duwAdSzCCx9tMm4AZtm3sWodTR/Cwa5apfJmwW6vo=
X-Gm-Message-State: AOJu0YzQn5zFjYWWzc9SGushZScB6V6ZS0o7PSB8HDq/zTsx3u0iap3w
	CZVOTpBu4OdJ/WfdAQM0ToXFkNAVPVqUcEZzJsDMCA5RujqzLnMl
X-Google-Smtp-Source: AGHT+IEYd4wsFmXlcB9lmDIiTidl3heFyCHVoCw+6gqBnLWbqBeba+2MgtnyndRl+GWXqp+nd++89w==
X-Received: by 2002:a05:6512:2009:b0:515:d1a6:1b07 with SMTP id a9-20020a056512200900b00515d1a61b07mr2900092lfb.15.1713587418056;
        Fri, 19 Apr 2024 21:30:18 -0700 (PDT)
Received: from [192.168.5.235] ([109.195.103.195])
        by smtp.gmail.com with ESMTPSA id n18-20020a056512389200b00519e1f8cdb1sm862972lft.62.2024.04.19.21.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 21:30:17 -0700 (PDT)
Message-ID: <39a20487-5942-4d9f-965a-4131aaff5e4d@gmail.com>
Date: Sat, 20 Apr 2024 09:30:16 +0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Christoph Anton Mitterer <calestyo@scientia.org>, linux-btrfs@vger.kernel.org
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <c6fcbd44c7ecb06c92f6062e6843a1d106b5799a.camel@scientia.org>
 <45d5ad09-5d22-4a93-8b54-8ac1c61f15f5@gmx.com>
Content-Language: en-GB
From: Skirnir Torvaldsson <skirnir.torvaldsson@gmail.com>
In-Reply-To: <45d5ad09-5d22-4a93-8b54-8ac1c61f15f5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

05.02.2024 10:42, Qu Wenruo пишет:
>
>
> On 2024/2/5 16:09, Christoph Anton Mitterer wrote:
>> Hey there.
>>
>> Is that patch still under consideration?
>>
>> The filesystems on my 6.1 kernel regularly run full because of these IO
>> patterns... and AFAICS the patch hasn't been merged to master or
>> backported to the stables yet.
>>
>>
>> Any ideas how to proceed?
>> I mean if btrfs just break with that specific kind of IO patterns and
>> there will be no fix,... fine,... but then please tell so that I can
>> witch to something else for that use case :-)
>
> Thanks for reminding me to update the patch.
>
> I'll try to address the comments in the next version and hopes we can
> push the next version into the kernel.
>
> Thanks,
> Qu
>>
>>
>> Cheers,
>> Chris.
>>
>
Dear developers,

Could you please update us on the status of this patch? Any hope this 
out of space issue will be resolved?  If for some reason it cannot be 
(or you are not planning to work on it in the foreseeable future) kindly 
let us know.


