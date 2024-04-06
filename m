Return-Path: <linux-btrfs+bounces-3996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DC89A8F2
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 07:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736C228282C
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 05:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF81BF58;
	Sat,  6 Apr 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxs1goo8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C31803D
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379817; cv=none; b=Ln+QlrQYqk9Qwf7Sm0t6mLK5bvEncAfvf2EgKLv6B6cVuDV8iw0XXyzEAZk6LoWErriHkxh56+zJteIRK/I7aJRtQtbCxR5EV+hPm2BqjTJic7mVrRdIliswrSrUZc30WyF0acnyymuV47+vg+xPWbAN9qfan9tusF1W3Jb6ZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379817; c=relaxed/simple;
	bh=HXKPsqfHkw4g7t3yK0EySYb9f4uKO9nb64e2q/IonfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wy7krIj+TxR8WJyRsJzBKZgfnkllsf+VZP9Wtv+J55hxBYMo2P7r5Y2H56zjNgMrRrQ1lB1w9y+0x6LSnlz/cihqkBB0+r8g4ceQKfOh4g0aIW8+Kvxqdtq9lgUrgGF1AkZDM3iYXJD+fGDYnwkKuN/zoUOYi8O5z6LaDSgZ5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxs1goo8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d8764656so255431e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 22:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712379814; x=1712984614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k64UXaYVNZmfsGeYBVYcuwBKy0zXIFdS/tQ8KhmLBPQ=;
        b=bxs1goo8yJog2823am1HGJ4Sch9aAdYrhLk9yPo15aZMFh/MWlohhWI3Yp6K3lZo0N
         GaAibTgr63aZefDdnubd1PQZthOKb6dARDa+Gvw5nHhHZBGT7nA9SbsnBkpLC3yTsHW3
         UQrPa55/DQG8Ko3fFOy0yACenBtQHqP0ge+IQqUHvHiIau81IKQspiXniijBFMUe9R+c
         BPSNNMU4MmelvRHe6k1QxP4mGwe1bAwxtETde5Pva+tAw4W+P0ZGwwQPIPb1BU2M5lZM
         TLJgwIm8PcZhgnYYxSjgtVrhse3bi5WxRXn3W3ODrVZk11mKE4jl6egIteEEPHvwWTBw
         blhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712379814; x=1712984614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k64UXaYVNZmfsGeYBVYcuwBKy0zXIFdS/tQ8KhmLBPQ=;
        b=MMVhDMPxlZVvAeZAMwhmRSWxFGRZUAoTXavkSDo6pdmtiUzIC/edgWdoo82ArDGXb2
         Y27HjdR0BoGYp/FfjTrRpdSKpcpvCW/iJjcT218nks31h5PYdYATwQzQ39jeAy/e74gO
         SKFNFYAZj8ed9crzdpFjrD64PvOUUXYJKnU2suIPx0QWeDrmBC3wI5Hf4YE1vhkLUc9s
         nP6Ad7XeksMz+GU0Kfx2TlvAy6NPG5K6NzPhxkZ/6AjUcnB41Z4JMIL++8dDw+PADk9k
         I0fhpk0eFt5hTGK4iCzfJeJKSDq+bwze9OdjoGVHDNLiFH0Xo9dWMjX87vV8CnU0NxkI
         9wgg==
X-Gm-Message-State: AOJu0YwEfh+wr/6VPw2HVjUxTbe6LuZHU/eL3uBW9pPjCBq8YyaU/KXd
	omsA1TVQxtEOPPkeZEZacUn13XYObEElSUwXCQpsN/4oRl918g2xVf+SsZfE
X-Google-Smtp-Source: AGHT+IFgvBAuRAzVbY4kYaVsQTmpajv2O4v07tWiGKEqxCvBS86aIfvotSj8mED4yQqBex4eUnrqOg==
X-Received: by 2002:ac2:58db:0:b0:515:d5e6:d48c with SMTP id u27-20020ac258db000000b00515d5e6d48cmr2157675lfo.0.1712379813881;
        Fri, 05 Apr 2024 22:03:33 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:8557:ad73:1dd9:2fec:a8c7? ([2a00:1370:8180:8557:ad73:1dd9:2fec:a8c7])
        by smtp.gmail.com with ESMTPSA id c27-20020ac25f7b000000b00515ce9f4a2bsm382113lfc.35.2024.04.05.22.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 22:03:33 -0700 (PDT)
Message-ID: <bba42153-f4d9-4fb6-8252-a5cd1929b901@gmail.com>
Date: Sat, 6 Apr 2024 08:03:32 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: exactly shrinking btrfs on a device?
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Roman Mamedov <rm@romanrm.net>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
 <20240406033700.2c2404c1@nvm>
 <0c9f96442083fe6e5ad387adbc496ff2f3370270.camel@scientia.org>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <0c9f96442083fe6e5ad387adbc496ff2f3370270.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.04.2024 01:41, Christoph Anton Mitterer wrote:
> On Sat, 2024-04-06 at 03:37 +0500, Roman Mamedov wrote:
>> Shrink it with a large headroom left to spare, e.g. by 50-100 GB more
>> than
>> necessary (or say by 10%, if it is small). Then shrink the outer
>> container.
>> Then grow the FS using the "max" keyword, to occupy the entire new
>> size of the
>> container.
> 
> Yeah... sure that works... but it's not so suited if one wants to set
> some exact size.
> 
> 
Why not? You set the container to the exact size and let btrfs grow up 
to it. Or may be you need to clarify your question.


