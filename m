Return-Path: <linux-btrfs+bounces-10054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B59E32B7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 05:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E6168426
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7C01714B3;
	Wed,  4 Dec 2024 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW3oAQXl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A107383
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287439; cv=none; b=lWwI+4xuIcuHwULUkEv9LZyJcztOfT4/zarGOY/EGgaDxq6k6//TZPQFXDVvmS0RFOOW2H4ZW4aSYbA1VmXzSutkw1ZFvfK4opy47h7YmPYDAGrlwG5ok/fJmkWtZdb6n1238R+Tb/Ek7LNwyg2D6IIDYnarEQkU9HbvGoCVPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287439; c=relaxed/simple;
	bh=y1Na5bN9jjAgxzqVIpdUUvZC1pjX197hPagVkRg9FQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fUFdGNpHdmyBotPq8tZ1FvGHigODJ0EXkLAt+t6Q6wC2T/18TpnyNdkS/x0+QTcEzkpD75bAAkAh7E4UbZscEgpNrK8mNWmzgh02ICMQRvMJTl5E0ziiKNH6c4f0OlylXdblbs4Wx/qadbVzI8IXu+mTdwr0FT6usqrgiS11Jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW3oAQXl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4668d7d40f2so46396171cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 20:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733287437; x=1733892237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rY6IzEqTyUB6IUKJXLmp6eCmIXzS+g6bou3QqwxbVs4=;
        b=RW3oAQXlJi+iwR7BoeYB9MqwhRymbMCleFN6wVBFNp5T6HtgBNzM3hLA53Dd8WYkgp
         x0/qLCr6E0fYm0VfowwTzACXwzhvvlGPreYsGCGU0Pm8fY40xC62UuVBZk8A+eNeZ00G
         gGdPT8avJUD2yOtBRPk1MjCgQ5CDdU3bokwjdF10FaVrMynLLayWlUWe0qq1u2KTUqcT
         bQrPmqy2N7B5zJWACsk0qWvnbSuwMdpl08eQIu7C4qI8Q1BXvzgQb9HM7hWC30Fuixk4
         CPDxDX5cWCmEzfTvX58ktFaGleY6XqcJ10GPbYgL6kmZ7xBsTF7m9ft/3pfeBlgDtrEB
         wFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287437; x=1733892237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY6IzEqTyUB6IUKJXLmp6eCmIXzS+g6bou3QqwxbVs4=;
        b=n6ePon2bGo24aLmELhT6w2T/5k8htJnrN6uUjmVqsXhIR9OUj9gCptKCMdY+IXhnHw
         dgnTApVVjuJpe/MZQz7h7wzfhHnfmpcSexomTcnppC3hmoakbuORyt6SIoisqVRPBOPe
         ShJU3jV9AbA8KVbuHU0rCa512R2qzH8g+xlpCVToOePW2mX3bX4zVsrzH/YJJupGttia
         8lUGY4tpOGMJ9r+7hjT2/wLO/4SMpAgmIUjsvsLhKW+AjrMMAflY8GD3cYD/cVkur9/d
         qjR9NcvJEjDq6EUyTfgO7dVV1LFk0UdQDVmtNdv8vM8YJ6RLJ43DXHaHbt7Fj2bgpJkW
         C2nw==
X-Forwarded-Encrypted: i=1; AJvYcCUsTr09GcA4CJ3ukhy+5FRO64CdXTP7Y4EKg5lVGbUzIA0xrQVBeYcaTH98p+1iczNX1M1Nwqzb1wOuIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtdw2gU1m/y/zbE0MadTTNA194CiS+a1qVywY66D8/zdMhbTtK
	qRSg1Bj4rC3q5pgmY2TJ6l7/3kYvu6bV6OnLc9A1fEuAkK1y8vut
X-Gm-Gg: ASbGncuIhA17WHeiVFwAUxxhvITAB1k4mqgKHaPUUK3zhxPAOZ0yX2q+8ZkjPOCWeK/
	Xnuxw11Js63KByH4KwcBM7o7+/YlccysPNCdMmYQ2Tu0hQSL7LDvit1LTAkR5EB98eTg+DWdD1I
	2KANX80RjPQNWPxnRVn7GU+54itoJcn3G+PrPBFM+9XSVn+EDAlcDa00m8Yy+DvRWnS+RSUfk0L
	n/Moh0mhRScTKlcvcMMH6qjM1VilHXL6HslCwpo5jb7paM21Rmnli4PRaSx9GwseuXdq3DApxH/
	FSFWTkJ2LWapyR8AiH0bgX0vmbVIlmlrI8X9
X-Google-Smtp-Source: AGHT+IFujSct9M4gAkanKyW5N4zj9BpUn42CA+OjxINtJIUZmhR+O7jIZhVJOM1WoGdVllQCDYz7dg==
X-Received: by 2002:ac8:5d07:0:b0:463:788e:7912 with SMTP id d75a77b69052e-4670c70dfd9mr88257551cf.56.1733287437204;
        Tue, 03 Dec 2024 20:43:57 -0800 (PST)
Received: from ?IPV6:2607:fea8:c1df:ffe5:49ff:c562:46ac:7af6? ([2607:fea8:c1df:ffe5:49ff:c562:46ac:7af6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c42542b4sm69388191cf.89.2024.12.03.20.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 20:43:56 -0800 (PST)
Message-ID: <78bb97cd-516a-4647-8866-2a67e9bcdbcd@gmail.com>
Date: Tue, 3 Dec 2024 23:43:55 -0500
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
 <e9544172-ef74-4a65-b14f-8d3addb957d7@gmail.com>
 <3fc16982-4f69-4b78-95c7-35964d6fd1e0@gmx.com>
Content-Language: fr
From: Nicolas Gnyra <nicolas.gnyra@gmail.com>
In-Reply-To: <3fc16982-4f69-4b78-95c7-35964d6fd1e0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]
>>>> I'm currently running btrfs-progs v6.12 but the balance was originally
>>>> run on v5.10.1. Is there any way to recover from this or should I just
>>>> nuke the filesystem and restart from scratch? There's nothing super
>>>> important on there, it's just going to be annoying to restore from a
>>>> backup, and I thought it'd be interesting to try to figure out what
>>>> happened here.
>>>
>>> Recommended to run a full memtest before doing anything, just to verify
>>> if it's really a hardware bitflip.
>>
>> I started Memtest86+ ~3.5 hours ago (it's on the 7th pass) based on a
>> recommendation when I asked in the IRC channel; no errors yet, but I'll
>> let it run overnight at least and let you know if it fails.
> 
> Just in case, have you tried memtester?
> 
> There used to be a AMD SFH driver bug that causes random memory corruption.
> 
> Tools like memtest86+ are doing its own EFI payload so that it will
> detect problems caused by kernel drivers.
> 
> Anyway, 7 passes already look good enough to me.
> 
> Then the cause will be much harder to pin down.

Oh alright! I haven't tried memtester - I'll give it a shot and get back 
to you. Thanks again!


