Return-Path: <linux-btrfs+bounces-10050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E79E3283
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804F3B268C1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 03:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23917AE1D;
	Wed,  4 Dec 2024 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeAo06Q0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BB15442D
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284744; cv=none; b=QgxQbsFIj+c16EPrjgM/pF1F20eYDSxmEtaeKJOK0uZiilrqmSe9wZoMcLYUUYhyIKSqYbItY/cVbds+VVcAmqRFW7NbyAdL3TbfJd3LUk6o/fXqDZIpyC0NrdzqsaZMiXFaV9Dl05CmlY5FsQBsWnKgV2UZBRckLMLCSVvxbAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284744; c=relaxed/simple;
	bh=B4mQLtMiCou/izL8118W2138ugkFsc6LbucBhiVruvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y4d/yGkvHBfXsdy712Pta/8valc3yDUz7iBHEFMnVsakRmdLFHjD80LdveeL6dyz4hmRGzf+RevFkJjJAWJ5n9axoCzftlvg2PLPkQBMOo8ZpBPhjtVsBShxdrRyWvE5yn+U5dtYwHN/5X9SrvUqbVo1N8Jpj4uBJGlNiNTBDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeAo06Q0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b66b64a381so442173285a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 19:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733284742; x=1733889542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImxE//mMI9/4FMSPVPTWsg2Mj8tNpcRr52GzvWnewgg=;
        b=TeAo06Q0flxos5Wx9B/sOkoggW/M6tD0O+NjLBjHStgQhB/9UX8KbB7wC1SOzGT8TC
         fqJcjP0Iyu55D36P68hRvCY4spSUbgapkS2eMN3nbU/jfHlD1sKI68+HlSiD4z+eg7c8
         KmPd8SwOAzVh2BOpOCSMmMw7+8o3yh3Oj45YgaqaTX9RrZqg5nVfL7ZSEyOAFYfBJ45G
         5b7RcTltaa97vYazv2VOnhKcX3HSCsuDqif+bLpi7bepqvVQ5GkeQ4SU8A9YMronWBTp
         LesNPOhtvDlY6ZBvndOgJBiqVekhh+uKQFJPTiEbSwmF5VEiXDSuFzA0159tIBt/7Ywg
         Cvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733284742; x=1733889542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImxE//mMI9/4FMSPVPTWsg2Mj8tNpcRr52GzvWnewgg=;
        b=WDm9RSm9sISdHw0L+7JwFcSNiC95UAczUseN2641eOWktK8NdTk+mAjoLxN3R+lOWq
         F/oc/rH5cslrR7eGSlbiFYj0BAdZ+kMu0uDYZQ+DpXmrCaJAl/XXYTluMW4++1WF4n81
         meImuqX0wIYp7ruEBaCHsQ0YRaWaVSyMAaYTRJB0X19Q74KweGJePqDKLWKqEQYri9Uk
         2ypsVFYH3h/S5f00Rb+XMr6e+xI7Csc2gOOmM6B3zJdqRPekGXeJl5BFJ3J9WJMz9zc2
         hVvWuCg1wBDiTD/QaA9rm8IL8XiP9WRNz6XDzJQwckUpcTIcASNyL+xZ2f3rFim+3UWK
         /PJw==
X-Forwarded-Encrypted: i=1; AJvYcCVyquP7fe2qollM0jwXHvIFRvQbjWgVhjIxmznzKORvIBI+uoxtT8haudJK7d+ya+y87aFLoqOaOeIhJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLq022ST2yGZySXiAxiHMxVh6GAl4ws0xfTrf2+cr3SmPXwjiC
	qABeOETsvMWFJPCwFrd4T3RELVvWWRNriNv/unAh54LDA2YJfR0oec2EwA==
X-Gm-Gg: ASbGncuh5Wk+bRnn9M8aenMTYjgCXSbKZqbfteyElOxrT0Nw5CSoxG17xmQKdRb3ADN
	XBpVygHehGjQR5ohvqigN4jPZ0jkjkhLHc99YuUgeVFmtTa0zpYpxBZhdPOVEK4mE9TOsp/Ix1P
	p/A2IeJ/F3fbdl59sw4r8PNZNmSiICrt4L+iJfIaHP9fvZoF2A86JoC3Kxv4T9fc0Dl1Wn4krl3
	R2jZJkH93MpOMwqCaTnoyvtKkaeMdrUxRuzf5QqnqSvCCnF+Vx41Us/WWsScqtJxvnm/nskKUIi
	es2gOu80s3kDiqGXdJNYIuS0MxGzJ/D1LhxS
X-Google-Smtp-Source: AGHT+IE9sWJj5LFsC70rXiE/H+z/fikE8lh/PBoJ8jJo8ZLE4RDiYS11cT7o/ev3VAbEaB0dBl4M7g==
X-Received: by 2002:a05:620a:31aa:b0:7b6:7ae7:1c14 with SMTP id af79cd13be357-7b6a5d16a16mr646274085a.8.1733284741720;
        Tue, 03 Dec 2024 19:59:01 -0800 (PST)
Received: from ?IPV6:2607:fea8:c1df:ffe5:49ff:c562:46ac:7af6? ([2607:fea8:c1df:ffe5:49ff:c562:46ac:7af6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849b6d11sm575429185a.99.2024.12.03.19.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 19:59:00 -0800 (PST)
Message-ID: <e9544172-ef74-4a65-b14f-8d3addb957d7@gmail.com>
Date: Tue, 3 Dec 2024 22:58:59 -0500
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
Content-Language: fr, en-CA
From: Nicolas Gnyra <nicolas.gnyra@gmail.com>
In-Reply-To: <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for replying so quickly!

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

Ah okay, interesting! I'm glad I reported this then haha.

>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>> `btrfs check --repair` (ran after a discussion in Libera Chat, failed):
>> https://pastebin.com/BGLSx6GM
> 
> In theory, btrfs should be able to repair this particular error,
> but the error message seems to indicate ENOSPC, meaning there is not
> enough space for metadata at least.

Oh, I just remembered I copied a rather large file (just under 400 GiB) 
onto the array while it was doing the balance without thinking about it. 
I think I had around 600 GiB of space left when I first started the 
balance, so I might've messed it up by doing that?

>>
>> I'm currently running btrfs-progs v6.12 but the balance was originally
>> run on v5.10.1. Is there any way to recover from this or should I just
>> nuke the filesystem and restart from scratch? There's nothing super
>> important on there, it's just going to be annoying to restore from a
>> backup, and I thought it'd be interesting to try to figure out what
>> happened here.
> 
> Recommended to run a full memtest before doing anything, just to verify
> if it's really a hardware bitflip.

I started Memtest86+ ~3.5 hours ago (it's on the 7th pass) based on a 
recommendation when I asked in the IRC channel; no errors yet, but I'll 
let it run overnight at least and let you know if it fails.

> Thanks,
> Qu
> 
>>
>> Thanks!
>>
> 


