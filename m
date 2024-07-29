Return-Path: <linux-btrfs+bounces-6819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A393F009
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15B7282FDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5E13CF82;
	Mon, 29 Jul 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbvhd5dx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B9137905
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242596; cv=none; b=gavyf/jT2qkOEOpxLU3XgnJgpXFc+BE2bOjpAfAldPPQvqV11wakzv5kajRaIdMrkXmFs+W1AU0NDZ9qR7xKXOgJzraz/wBjIeM8rpZ5h5fR+8z5tmhdhXDlVEqjFT0HYuexXDys6IPQ6ea5NfEjI1HaBSLU92QhkcljFHkQmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242596; c=relaxed/simple;
	bh=e3AQIxsW86aJSO8qm0oCe6gbLiNqAqjluwwcDogVBq8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=hoeXtBgsUSASGZgmN4XsW+7OwkR87L+F49xbYYKdp0y6A0Rq2TrVOr+zvzT3lDQfgU/LNwszj0LPPrZ0F0wZIZ6cCydHz2h3xB1RwZR6BMt/1Fk2kZrN/M903KBEW8YQG7Wly9V8oK3OX6H/tAODKDQj8dO2oef1knLF8eTii7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbvhd5dx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aada2358fso595398066b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722242593; x=1722847393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3AQIxsW86aJSO8qm0oCe6gbLiNqAqjluwwcDogVBq8=;
        b=Vbvhd5dx+xUyIp9RXls31TZyw5BQfsn4Mi9BGHfXzH76LLyNE5em60fToX9lSuh9eH
         I2kACtalfwde6bimEtmhtPf7g4ogswXqCXUJqdzX+4V73df+UzclHfnMw91+RYZpa+MH
         i7H2SgWtX0ND993xAk5dNalgaaR7T/a2xU5uQY5sztbS4wfTbo0Yr4cv/LgB1dvTFpy8
         6zc/a9depy4HVetLmPWqzY2bpy/Bk1UE62QSlBCv8VLsuHYPdsyJsb+26TXivReOVQUR
         P0s3lZjIoP0vRuRSBq3x/V3FSMg0vX/pjgUIuwtKjZXCu6Dcnj+Q+tByNqCqzuaK1/R7
         cHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722242593; x=1722847393;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3AQIxsW86aJSO8qm0oCe6gbLiNqAqjluwwcDogVBq8=;
        b=oe0ijlg0iw1t3dd7weJKAu2LmiSIWZiS8Sq32ve60I7eKB5USLdk7B8DtU0BxXMagf
         3m8iUpQW7H0/A+DYOKR2qIv/h2ED68fgK50kX1jgsbPfRFua3lFFClinDiP+W6KE0YKJ
         K4fjGly8JCHZOsaH59gg4xGHm5FxIlkqhenBlCPR9YU4ehDjcvw90whEhUA1cixEzwdR
         YmRGFOR9FcMdZ4zTb5BRF2fUlfw6cwIgf+5xQ+EsVukgd5ljJfjGEtPridTt7CszftVV
         xQkBKD4Xn5ADmtz6I/6JcCHkzN0AA/3ZCl2nmnqt8/8c5Q62nFl5P3CyqLIJrljro2r3
         FjZg==
X-Gm-Message-State: AOJu0YxOwkxGMpOtSUBWubufWddvTGjmK5wYUNE3DNBMh4FkfwtWtB7Z
	eJ1e1vMxpw1RiB2Pi4mmsS/KVVt4G9eEJFrjS4LuCyVF0G7jHCiayqgLfEFP
X-Google-Smtp-Source: AGHT+IGAyhU4R6DCyxoKs9RNmm+Xh8x7WKJzBp/uFbkFkp5k3Ac3o0n1rPlbbUU1uOev1kKTS/u+bA==
X-Received: by 2002:a17:906:c14b:b0:a77:ca9d:1d46 with SMTP id a640c23a62f3a-a7d3fa36c1emr750148566b.33.1722242592784;
        Mon, 29 Jul 2024 01:43:12 -0700 (PDT)
Received: from [10.1.1.2] ([77.253.223.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2302dsm478702466b.39.2024.07.29.01.43.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 01:43:12 -0700 (PDT)
Message-ID: <37cfd270-4b64-4415-8fee-fa732575d3a9@gmail.com>
Date: Mon, 29 Jul 2024 10:43:11 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: ein <ein.net@gmail.com>
Subject: Re: RAID1 two chunks of the same data on the same physical disk, one
 file keeps being corrupted
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6ae187b3-7770-4b64-aa65-43fff3120213@gmail.com>
Content-Language: en-US
In-Reply-To: <6ae187b3-7770-4b64-aa65-43fff3120213@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.06.2024 16:56, ein wrote:
> [...]
>
> I don't think that it's RAM related because,
> - HW is new, RAM is good quality and I did mem. check couple months ago,
> - it affects only one file, I have other much busier VMs, that one mostly stays idle,
> - other OS operations seems to be working perfectly for months.
>
> Sincerely,

Hi,

after spotting this:
https://www.reddit.com/r/GlobalOffensive/comments/1eb00pg/intel_processors_are_causing_significant/

I decided to move from:
cpupower frequency-set -g performance
to:
cpupower frequency-set -g powersave

I have got:

~# lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          46 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   32
  On-line CPU(s) list:    0-31
Vendor ID:                GenuineIntel
  BIOS Vendor ID:         Intel(R) Corporation
  Model name:             13th Gen Intel(R) Core(TM) i9-13900K
    BIOS Model name:      13th Gen Intel(R) Core(TM) i9-13900K To Be Filled By O.E.M. CPU @ 5.3GHz

One week without corruptions.

Sincerely,


