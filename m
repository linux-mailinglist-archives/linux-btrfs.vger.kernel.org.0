Return-Path: <linux-btrfs+bounces-11162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F58BA22496
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 20:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5A11887952
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 19:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B241E25E3;
	Wed, 29 Jan 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoqB+08m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C0158A09
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179193; cv=none; b=XidcIRpchS86m2SpXiorR3G/VLjACcPqauYCwf/BYqfjvvOnxb+0fgG66xvtidpJvEBa9E4WG2sd+qSswoYNzVlDBxbzyxTS4KTYP7IVLveylANc3xYJxItH2ET3GDltfMEz6W58gEBHcQul5TX+sHfjuEy6onIvX2C2OCOhRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179193; c=relaxed/simple;
	bh=SPyrOmFP1b0SHoi/Hr5W1v1Tsjvbua1Nsr94UT6i2GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fAQwpFwAw4AxQJUkggkTF4Bzs5ArtnLYPiiowEgDoOC3QZqGlnVHM3eIvN4qxIu0BHMmrJO2qHy3fO2WiewwvegKm8qfmgRRNL+wK9S5vUhAXvQSF1OZj7HqtSajh+qURhSAKUYlFwMZNzpu54//cj1DaGQIV3csQ9FVB/TWZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoqB+08m; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b7041273ddso6376085a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738179190; x=1738783990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePBcBCDhA+W8hbOO0HK42hG+UhHkK2Oqm1CJP4jfcEE=;
        b=RoqB+08mjkkIQpV4TCoDmfnt99Cpv/tvyX724wcEuhIISmYN3HI9m4oKlwrYS/ZfIA
         1dlZ4fF9cbcnE9TX5Fkg4+/IxC8rXCE7x9+MNM7PhMTSh1e9X+tOnmgxtxuQ4XCFuVJC
         8Q1gt0yw7jINior7r1LyRQ/s7MNtYue7fmpRaULrlPtHKLBw1t8sTJU7E1vZCNo51yhL
         +0cf1RJlqp8RCLMm/lcYXKpdxcd3XnnLtJ0cOfGsPsyAvOtzCE6JOfSVlBtnYJ0iSfAk
         /Zv9QBIPuQXsrD9PameGbTJKtUeM4PoENGC0bfhgEqcYfJr3rYrZutQsHiI+G0kxb7dY
         K0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738179190; x=1738783990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePBcBCDhA+W8hbOO0HK42hG+UhHkK2Oqm1CJP4jfcEE=;
        b=dNqPN3C3xS8CsHX5m3xd2tFA9j85nXsz/iz8NLAvYBq4C7eOkMtVjMrIc5ChJudarb
         vJn+OnXVt7YrWd8+NsmNBCJmSxCK8Yuelm/9jE0+Lf7JlgKIIe8v/d+6n3S3u76f7Q+U
         8L8mvMvS/UqcXgOc5gtb3QigEJEkTYEAqfwsZhfpOvFn1PFktHF7ab9A4SjCuqav5CiI
         PEThD7JxVU3A8+XY7INFEK82KgKXUZuKQgsPIQ7bdRx4L+rqXisULOXCyj2yCw3HmWFi
         DxucBqC7YusSqgH3xug4d9N6b+2bDy7cdSUC3LVYbY56pdup8g1/tzduG25w+V5MwMBu
         aV1g==
X-Forwarded-Encrypted: i=1; AJvYcCVg4xRATGTGFyuyLJs3rCZUXLD2ZkFI79A182/prazbZya753Fxf8vdtwntc9eVMHKDB7bqfKFsV7LfAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJ1NLGJCoe7EOtxt5m70ZoHRWQnODH/H77dZY1MPzenMr0DSK
	fK/mGk1DwsqTqG/dVBGW+7zBhi4qG67jWZ7jfyNSrv4xfxllYvIy
X-Gm-Gg: ASbGncujL5jHLLIvjYDwrDiU2npGUnBPgZoD8iZW8HbaAepw3sWvRsBz3iaYK5+S3Nl
	8jZKjwEjIdbeEUZtgzBaiMTeb4WYTCNvSz/lFuhtimgY4Hlt8EYxU1CGd6HIleAL5Ns3VX5BQ4l
	mjY2JKo8V9cj3Ir8Gz3F9DZtanNlIUrNtjk6eQhNBahWv6N/+LP40fnFLCe3Lkbfn8JLmz+cp3G
	WHZoVN7QqStsPiAj2M53Fwr3y1ys45aQHFdfvRUlWqnrMcdXePAfQF575RWmqrarP3V5Pu09qkn
	vKvZoX1OogSDnNijINEJgnVL0snqQYoKLwq+1GG+RT/o8/rQ2VhK7XviCs0wfbferyZKwqcoega
	OVg==
X-Google-Smtp-Source: AGHT+IGuUX9YkZlqe6DU7bZx+xKLDwrKGyYJMKzYISYxCvoVPunZEtc1MBdk4DsbrEKx/ERjWPqt3g==
X-Received: by 2002:a05:620a:45a6:b0:7b6:672d:7fc7 with SMTP id af79cd13be357-7bffcd735cemr735248385a.46.1738179190214;
        Wed, 29 Jan 2025 11:33:10 -0800 (PST)
Received: from ?IPV6:2607:fea8:c1df:ffe5:8dbc:1f88:6c7d:4e88? ([2607:fea8:c1df:ffe5:8dbc:1f88:6c7d:4e88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8a67csm658365485a.29.2025.01.29.11.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 11:33:09 -0800 (PST)
Message-ID: <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
Date: Wed, 29 Jan 2025 14:33:09 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
 <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
Content-Language: fr
From: Nicolas Gnyra <nicolas.gnyra@gmail.com>
In-Reply-To: <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 2024-12-03 à 21:50, Qu Wenruo a écrit :
> 
> 
> 在 2024/12/4 10:32, Nicolas Gnyra 写道:
>> Hi all,
>>
>> I seem to have messed up my btrfs filesystem after adding a new (3rd)
>> drive and running `btrfs balance start -dconvert=raid5 -
>> mconvert=raid1c3 /path/to/mount`. It ran for a while and I thought it
>> had finished successfully but after a reboot it's stuck mounting as
>> read-only. I seemingly am able to mount it as read/write if I add `-o
>> skip_balance` but if I try to write to it, it locks up again. I managed
>> to run a scrub in this state but it found no errors.
>>
>> Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd,
>> UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)
> 
> The dmesg shows the problem very straightforward:
> 
>    item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
>      extent refs 1 gen 84178 flags 1
>      ref#0: shared data backref parent 32399126528000 count 0 <<<
>      ref#1: shared data backref parent 31808973717504 count 1
> 
> Notice the count number, it should never be 0, as if one ref goes zero
> it should be removed from the extent item.
> 
> I believe the correct value should just be 1, and 0 -> 1 is also
> possibly an indicator of hardware runtime bitflip.
> 
> This is a new corner case we have never seen, thus I'll send a new patch
> to handle such case in tree-checker.
> 
>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>> `btrfs check --repair` (ran after a discussion in Libera Chat, failed):
>> https://pastebin.com/BGLSx6GM
> 
> In theory, btrfs should be able to repair this particular error,
> but the error message seems to indicate ENOSPC, meaning there is not
> enough space for metadata at least.

I finally had some time to try out a version of the kernel with your fix 
(built locally from commit 0afd22092df4d3473569c197e317f91face7e51b) and 
I can now see the modified error message (see new dmesg contents: 
https://pastebin.com/t7J5TJ0Z). Unfortunately, apart from that, 
behaviour seems to be identical to before. `btrfs check --repair` still 
fails in the exact same way. Is this expected? For some reason I had 
assumed your change would fix it, but I had forgotten this mention of 
ENOSPC so is there any chance of getting back into a writable state or 
should I just reformat the drives?

>> I'm currently running btrfs-progs v6.12 but the balance was originally
>> run on v5.10.1. Is there any way to recover from this or should I just
>> nuke the filesystem and restart from scratch? There's nothing super
>> important on there, it's just going to be annoying to restore from a
>> backup, and I thought it'd be interesting to try to figure out what
>> happened here.
> 
> Recommended to run a full memtest before doing anything, just to verify
> if it's really a hardware bitflip.
> 
> Thanks,
> Qu
> 
>>
>> Thanks!
>>
> 


