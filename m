Return-Path: <linux-btrfs+bounces-14640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE8AD87E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADEC3AFDF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A42C158C;
	Fri, 13 Jun 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDMfSp1N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA054279DA4
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807073; cv=none; b=cWgKBk4Hje2VCPVc2InjIXXR5wZ+NsYWhRnmiminels4ms5qnAbZ5B2b2gH2GQQuEiOfUMzoLPbjDssvpFUqKTp2sTAWtNtD8knFYf0jJ3JcWsx8LcdwxN51U99icMcKw+kjDjfAaGINOhmTpMMCBARpM7kEukUsC9gyZJZBhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807073; c=relaxed/simple;
	bh=zjLEquiWucI1KxI24HGEPnhAd08diuJlz3c9xAc04Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H1CHi7AIOlM2mbXJLtYPT0bp40G0kaajyqS6bFF70TDqjHm6Bds6shcBk4lw9sO2ojw11UmhAlAtgiJloE/E0ajxFb+fsgv0e5jwTlx4WzcQ4u9B5yCZH1dyBIuWa+MKlftXWXB0Re5PwUna5/uwdgu9V8s8swWPalxLN1qnOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDMfSp1N; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so340425566b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749807069; x=1750411869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/VStjR2nK+e0hWI++f793EqtEkUZyyb9rh0a6/XPFc=;
        b=MDMfSp1N9bbjlJxWI25fmNIIIg292bclsupX4tAaFd00PbMHjI4H4NYay/vXY21xgj
         u1qhjeTrItSFAadbnjdvkRXWX4sZTVKKRMzO9Grg8rOhTpbjqawraSFFBK/yBlxx9SkH
         SXH6iz/btXQe8HKaglXNQwoGb2Wv9IrS/EgSX0Vej01y+XrbUo9+BsrNC/DyL7HgDfME
         8xFvV+fPTaPUq5lrzZuWLy0HaTlmf+Nga3tIwzixtj+H16wyRbav3RkMcXNGyvuHo/OD
         2hAoAJeMkp51Aaj7iuFLJ75k3Vv5wPAW5Q9Kdnol4Ic6I332opk/i7G2Dczoajs1T3Hy
         BrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749807069; x=1750411869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/VStjR2nK+e0hWI++f793EqtEkUZyyb9rh0a6/XPFc=;
        b=nev0ngIXOwpswuJj6tslOsfVJAk4rtj1IfS5xJnDejgUwNOXmGvB1wP0I9XT4eIWVP
         +W2076x0cQFxnlEtbZwcJ/30c4QxfT4m/VwFhZvzVs0zJID3v/i2dyexuwMaNJTzoYam
         YJED6VSgyzKQW9NWvKGx6SbkTNe1VHu2akXSG2qnBATZ6NqPewVQK+WvWQc2Xm7+9fKP
         asyblRECKtwKz4CeXye6cun7wX3zBBFSNuCX0Dd9cKidi5kso2Tmm4Ha246/w9f0o43r
         TY0Fa4UmQ/aJXKczE8CesP4bUMFm4FwUy3ykBYSSiPJopZtHiwe40DWi0gT5sEIJmzmk
         LN3w==
X-Forwarded-Encrypted: i=1; AJvYcCWYj1daIFSRb9OgYx/sCTu25/KTDAqmKoJnQkvCTKdUkweoD+4cSirBLhyz4/YQQn+w2cnEtv0sUw4x2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4V+B/vrPmln8cA6wbkRY/Q36cR02zHsOaO5NkHhtvGsZiuQ3y
	BtAFNdfpMHFnRVQPFkZhSRKsCsn5Fa02TrayJ8IKK3zMawvklK1gozJslJY3qvdd
X-Gm-Gg: ASbGncvaA6FrBCChpFHS4+5sC9oLNcLqgsP0b3pEfeVemJ+SbpdMPgmnZBLavFcA9No
	jgnJL3X4QDs4SqNVK1qG8bhX3j6sHj+2oW1greYXCkB0hPoor1MzFltU/zlUP1ZLdCQBDHshqQ0
	kWdZi9vFilO94KotMpTUVnQv8f0z+6k3G+IGjOO4xu0BQf4jOoObBtR2aAWERBRghmehsARBZuR
	aAvmiaTIU4fot2HkHU9syRXKbX+NsReM/SKz6ZDwOz8BE3PP9BLYRbNZ+41swdDWfNnRC2Fg5zt
	wSUOaWqvK6+VnaJ9yHaedtz54yU4d01MsPDWlPKW6f4RoFNe8XCbpcjvcx3uzxDxCX+OCnX5pLJ
	FdqWuDQ4qMPI5EhV9y5g+FjctoU/hjROE
X-Google-Smtp-Source: AGHT+IGWD40aTWIoByW6TSmbat3dIng4Qkdth7VLsEtI4eZ1qNRjfuyupIwmAOiYv195j7JXQtiJkA==
X-Received: by 2002:a17:907:930b:b0:ade:35fc:1a73 with SMTP id a640c23a62f3a-adec5d6b6c5mr225169866b.55.1749807068858;
        Fri, 13 Jun 2025 02:31:08 -0700 (PDT)
Received: from [192.168.1.62] (bsn-77-20-28.dynamic.siol.net. [193.77.20.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81593ecsm100669266b.18.2025.06.13.02.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:31:08 -0700 (PDT)
Message-ID: <38c007e1-fd3f-4f5c-9f54-ad380d7071ad@gmail.com>
Date: Fri, 13 Jun 2025 11:31:07 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck in CHANGING_BG_TREE state after interrupted btrfstune
 --convert-to-block-group-tree
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
 <d57e673e-f894-48cc-8b34-c3754fa23b70@suse.com>
 <e264b3d7-1242-4470-8a5c-805e29911390@gmail.com>
 <99814fd5-3f80-4d08-af7e-468f7c8885df@suse.com>
Content-Language: en-US
From: Tine Mezgec <tine.mezgec@gmail.com>
In-Reply-To: <99814fd5-3f80-4d08-af7e-468f7c8885df@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Qu,

Your patch did the trick, the conversion completed cleanly, the 
CHANGING_BG_TREE flag is gone, and the incompat BG_TREE bit is now set. 
Mounting the 11‑device volume takes ~5 seconds instead of several 
minutes, so everything is back to normal or even better than before.

Thanks a lot for the quick diagnosis and the fix.

One thought: the optimisation that skips the full extent‑tree scan 
clearly helps in the common case, but when it backfires the only 
recovery path is recompiling progs with a patch. Would it make sense to 
expose a --full-scan (or --no-fast-scan) switch in btrfstune so an 
interrupted conversion can be resumed with stock binaries?

Either way, I really appreciate the help.

Best regards,
-Tine

