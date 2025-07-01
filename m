Return-Path: <linux-btrfs+bounces-15181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98943AF0347
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 21:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEC33B6964
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF627FD5B;
	Tue,  1 Jul 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KrGHFDHq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23B22A7E2
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396642; cv=none; b=K2qfX8ZqPawxzdVZzJS/yAdnajgXIfpcAUetjCol9GzAv6echXIQVSaSzT+0wTSQWJeIRvtkl0rAT95PSEg9lEm7bkk81HF7Tg77RuvsAOjsAdTURvzNFXCy+1IfzRHLXPkg8XAjH+Ns2ASuGkTz5pY92qIiD8zWb5+ipPSYdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396642; c=relaxed/simple;
	bh=cwAPXgdl+hKLrBAUN++bv9WfGRh0/jEqtxFs1hUDy+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdkDuBUw11q2iDkNVyeBUxakkCFomVoJsVL72ZLFURXjzLoLSv34GKPIfPini8c5FnyIfVTniL9OdTBl1q6B4ZSvihR9DZ+zrL3GEEWnecLyhjnqtg2WyS48EW6ANF7OqvSA0yUS9vLhCyqS+mPW+FKoXEkhlp1FCiKkrJVMBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KrGHFDHq; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddb4a7ac19so22173515ab.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751396640; x=1752001440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1OO9XKq5rOhwEPdCxdc4lC2/SKoAK+PxaPLLCcb7dc=;
        b=KrGHFDHqFa1Xh63PvlFyS6Wjnrd7ik4zMEAcs8o0uWHPAz8KILJWgOXpUlicUgexAb
         CkqP9UihNXPT7+O9aRExZXsKbEZevyE9tN9Sm0sC10XE5V6BJMjblVzuUG9cfyk/O8P5
         FJKQsXE1TBiPrxXSs4p9GCuXj5txC5KP54Md1P3UHdOozdQ63bqU3phyGCugyQAtLDdv
         oiU3OZg2413JKlaIt0bzL2VkT95rfs4DEMhxnpPFgncE+RK5katI0rkhQUf1sIHAa37/
         QuzHbCfVrKvKL4XsdBzkgKCMWX4oy/0HTJiF6lwwJx97ioKdtfZoe36vWlC6x/V6crk8
         ZIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751396640; x=1752001440;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1OO9XKq5rOhwEPdCxdc4lC2/SKoAK+PxaPLLCcb7dc=;
        b=ENE4DztrLRrfzFE8eZQiYWj8/LdPvZT8jzT86W/ewISuds6wjU4Hk9OgF3uNdhdIxT
         nwClHppoZuU/gv16vgpFkn6MacNxnKD747rKl+Ebqn8b8aY9Ag/VRZ6mE67Hzna7CtWc
         ghkI7ZqYP04+DDqXgbvwMnK6K7TPShP7m2Xr5DKAhMksRQKMr/DZ8EjjvkOpfVBfP613
         GZ4OjckjvYStLlmrHbGMM0NaPZloOLI+hhLvfrsysmHWsphYzyUAuKstkKo2gbHXHeFv
         edSGuBqm5ex6xMYkrHdEoDmea2lyZO0S+OqTVa5LAvWKRCpJM82UAEpCIeqgkTOFLbkk
         mE+w==
X-Forwarded-Encrypted: i=1; AJvYcCXsMN8fDgk4q3QG3qoY9CUsmvdDb/47YDuGgYyxctpX6AEkNMm57nIKpf29TbxVyZGTWjNii3d0F13tPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNIwDx27kSaSTeuV/WVsfwQXjqI/G2hKxjnxNMq5mbX9iWokZ
	LnlvxGApdmv0L8bJZhBjWsrfkh0m4p+BFKrKHhqsZCo5BfKNwKKP4oZgOZtJKcnWHYI=
X-Gm-Gg: ASbGnctqYdkulLm29bFKVU9m/ZRJhhrIA0tQdZWi5OQcQvRCihCEL+IYBbPIBmfet5/
	+vRNfG/5vestNAsB8XihcEL4MyyVgismUH/fXSGCZ1CW/KvEMfBYqBvfgzEmO8xrp8A/U4eDTDC
	pt244pctZLG2/Dj7AmcJ7a+EB7XT/skbuqDPYJMQrDAjqLuFnFleZi46YFsLv3sz3UlHIe5dz2h
	b/7DK9C6evQI+psCreL3oqmLPPdOH7wFPEUnzM4DHsztPyruHfQwaMAxueTYaAonQJg0+OC3OfW
	L15Q9STFULFlqC6l0dAUh60S/Mk905U5Bn9pYstMdi14dTwnfIU+Xb8uaF+yazWviPug
X-Google-Smtp-Source: AGHT+IG7i3qoJ1qUqfQDZSOEDLwZsJ/iz/Ni2hzM4Q/Bn5B1fjgADlo2DriX2xo8k7cBTXFyqEIbVw==
X-Received: by 2002:a05:6e02:1d8b:b0:3df:3bc5:bac1 with SMTP id e9e14a558f8ab-3e05495ef63mr1597045ab.5.1751396639972;
        Tue, 01 Jul 2025 12:03:59 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204ab618bsm2596889173.124.2025.07.01.12.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:03:59 -0700 (PDT)
Message-ID: <76d3c110-821a-471a-ae95-3a4ab1bf3324@kernel.dk>
Date: Tue, 1 Jul 2025 13:03:58 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] io_uring/cmd: introduce IORING_URING_CMD_REISSUE flag
To: Caleb Sander Mateos <csander@purestorage.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-3-csander@purestorage.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250619192748.3602122-3-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 1:27 PM, Caleb Sander Mateos wrote:
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 929cad6ee326..7cddc4c1c554 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -257,10 +257,12 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>  			req->iopoll_start = ktime_get_ns();
>  		}
>  	}
>  
>  	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
> +	if (ret == -EAGAIN)
> +		ioucmd->flags |= IORING_URING_CMD_REISSUE;
>  	if (ret == -EAGAIN || ret == -EIOCBQUEUED)
>  		return ret;

Probably fold that under the next statement?

	if (ret == -EAGAIN || ret == -EIOCBQUEUED) {
		if (ret == -EAGAIN) {
			ioucmd->flags |= IORING_URING_CMD_REISSUE;
		return ret;
	}

?

-- 
Jens Axboe

