Return-Path: <linux-btrfs+bounces-9327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6B9BB9F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 17:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0766AB215DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0F1C07EF;
	Mon,  4 Nov 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eUugIARc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16520326
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736946; cv=none; b=b1tvc3N/E6NgwnCtfuPxVOBmARRhA1yfEmWSeNf8OVws++XO4BVsnCFb18xUMMf3dsV0+i5aPeSQlP0Y5u/CirxRFxjuLzHsmwaxXDnN1J4q8RL7muvcUp3T+S2b2+d3GU7x9IqtaDsmNHdOXIzRzAeYuqBHnmhPHUdxtCAQvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736946; c=relaxed/simple;
	bh=iDGWSd4lGsDSKD2H3kvb2AUPVM6GA3L9+xku4qWoJb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFhDAQcA840+gITm45n/94TDpxAfkJeY0xMlyw63tZmlUTRr255+Bv2U6lh9DWb5QEb1fMNZsaeqcp6QAPdEAO3rFieB1K6lDCiEz9lXylCFFg31qOfq8bkPn8hlQbS33uO8/yxGkgANkrnek6BT3OboZz5S6RISYCV3JT2nuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eUugIARc; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3aeb19ea2so16206995ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2024 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730736942; x=1731341742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzYcI+HoGHtyxlAluQmMZ1wutOKnJ7kSApi34DO5wUE=;
        b=eUugIARcqo+PfuS0gTEXjS4QvZHA9fN0zydojG1QSb/s0o5pCDSM6czen+pGqMEbMU
         pfQ0ilS3nSTp8EUN1ZaqE327JXSBXyX1NDilB5fZqbZdMNiNTjH+nu3vNmD1mwB3waMz
         hQudQKpoEmeQpKNJAV3feMlb/rRM3vx0fEu5JBGbDptkq4RPP8GQrlQSjn+JcOmrxnsP
         1j8vv7hq0Bid3ZH0kBn8qU7xpHRBMdqsUzIq0WQTQvQbnd7O2UmW//JAMXZfNpcjIUzf
         D4s5WHOVvCB0a6o090LeSn1ppCLz6ByC+52ngtKN7RHkTImzjREJu4x5+PEg+4clBTKr
         KBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730736942; x=1731341742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzYcI+HoGHtyxlAluQmMZ1wutOKnJ7kSApi34DO5wUE=;
        b=WjiuNQDiZuFM0la6ijGSvw0QnHaDFBg82Y33Gg38slo1MFBXwnuJzhKSEs51S1jcId
         fS6aI8Oo2wC7wVIVD4gnZIlnrf3zTlbBKT3zIazcmEdxf1zrBBlU5lvou+kESE/z4jut
         jNSUoVsJUIAm/seF6cFMmhRJoCyCD22SpkGs5LDZTep//R/YOLKGevSkxnEXrfSnS099
         hIszofElfw0CuPYwHCljmsCjq2b2oikavaHXKWjh9Rz+qRJp740GMPK8gh8cHFekhpNU
         Mx/79IHwvdzxp6488rYd5etQQM4MvFRmDEv2GO6Kl6pOuBzLI9WhkMr2NAp5JKDHoMMr
         Dwsg==
X-Forwarded-Encrypted: i=1; AJvYcCVsYUk/tdw9SsbdUa+wZqKm7P8ZXnmyhguFtsv020KBJs/jBETOyVgvq2XWpQbATTRGFub6O5+iNbMBRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlWHNzay2/9XyVkBdtR37xrCRXOp610rNgSaNEHrja2xRf0zg
	w/Yt6lgyLahfwAONK+qUQgrDid329iFK+vML+9CC2lNOIxtfP/Avdm1etcWpVHM=
X-Google-Smtp-Source: AGHT+IF/Rb/EiBkKGajr1s97okJ0WskTuIeC4cuVrTm5TG5tUiKS/6kUYNIhdt7WjgDMXxaGzTz1Jg==
X-Received: by 2002:a92:c26d:0:b0:3a0:c820:c5f0 with SMTP id e9e14a558f8ab-3a4ed2fe492mr281416775ab.24.1730736941731;
        Mon, 04 Nov 2024 08:15:41 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6ac34f190sm22351025ab.24.2024.11.04.08.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 08:15:41 -0800 (PST)
Message-ID: <269a3887-070f-4faf-85d6-73e833f727ab@kernel.dk>
Date: Mon, 4 Nov 2024 09:15:39 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/cmd: let cmds to know about dying task
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: maharmstone@fb.com, linux-btrfs@vger.kernel.org
References: <55888b6a644b4fc490849832fd5c5e5bfed523ef.1730687879.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <55888b6a644b4fc490849832fd5c5e5bfed523ef.1730687879.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 9:12 AM, Pavel Begunkov wrote:
> When the taks that submitted a request is dying, a task work for that
> request might get run by a kernel thread or even worse by a half
> dismantled task. We can't just cancel the task work without running the
> callback as the cmd might need to do some clean up, so pass a flag
> instead. If set, it's not safe to access any task resources and the
> callback is expected to cancel the cmd ASAP.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> Made a bit fancier to avoid conflicts. Mark, as before I'd suggest you
> to take it and send together with the fix.

That's fine, or we can just take it through the io_uring tree, it's not
like this matters as both will land before -rc1.

But if it goes through the btrfs tree, we can adjust this to use
io_should_terminate_tw() after the fact.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

