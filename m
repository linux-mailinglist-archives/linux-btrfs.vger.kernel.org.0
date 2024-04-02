Return-Path: <linux-btrfs+bounces-3818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFD7894D5F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF411C21147
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467203DB9A;
	Tue,  2 Apr 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eRy1DkvY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9E328A0
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046341; cv=none; b=IN0sURs2r1oJd1LPb8KFoTADQpNYrTHXgpFu6prMBUbc8LZdJr3J2U5opDc1x87gBOfogVArYKZb/FtqbE1nPzdu6Nx/MSB1UfWUipd5LKNi8gPcSyYGTN19SXDfeecNCoeJYSmo7nFCWHM0YfsCF8E05/5CsOp8Spnl3WSb89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046341; c=relaxed/simple;
	bh=CI0F5wQNEhsbFgO7w3NYtFuLSJkmwjbd4lt6+fiV1KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h83k6paZ87hQr2hkuEoCBvp3K8+GIwsPzhd4Ltx8VJSQXuf09VgVLWkj13fpAmotHi60UBlGCnKlu5YI3MmN74mAlW2qkAn4KbQHAVShmmdQ2znBsOCtxY4uIo+jXSw4kWkLlWdwFe1mD2/rUNq6yVZFG0uLxx7a8biq1KtWtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eRy1DkvY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d485886545so80278301fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712046337; x=1712651137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=96mRhZig/fayy9/ULl3ETEsLCZ3KbNvmSXCwNLMsal8=;
        b=eRy1DkvYOmfTHn5Du20MQz6uY2reautzj6TcinJOV1TIH5WHPwPGzFj3MimMpEaPwe
         /FVcM7U46oVsENuOrliWKeRWcv5TFQeN/62ANuAdbUPgovOdvM0t/o+Xn+be2wzxvppy
         v1g4ekLGyMz03uWUuNogj2CZolyEb6UdNbDu8lXTwnnqqgStLVDztI9VS/hhXQVldg8G
         R1EPvjYw0iB0pGIlB7lK+EXueC1/VRk2CiKhtkiAt+1nvaT6IAY41QVUSu683F8k1/fV
         diIG3xY37BlVOnMdmEAoJCAz+6piHifQvQJPaqvvbqpx3KbnLrBnxgBdYopzfTJQ2fri
         n2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712046337; x=1712651137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96mRhZig/fayy9/ULl3ETEsLCZ3KbNvmSXCwNLMsal8=;
        b=Ooz87OE6JdJ9OOlgvRS1iWOVkq9/Da1JEuGCws0cgGsDpSCq8FVtfsErml62txfwqj
         ZaMgu+jpAB3oM9Rl49H/lqfenC7aXEbs8gI6/PDMvafWHEtptg0DvAhJ/IAxSs/f3VOd
         KOp7/zwuzxzg2cR+quirstxwJs/jawq62iZw0lvH+ojm61Chie0qqn0ueAu2HVkaVfsI
         WXArxQy0X3pcQuRQ4/xmc/UD/dt9/XvSOBMATY/BejQ63ceC123JW3KBarXWW9g3oV3z
         cvgK6iFZgPqcbNtwpPU9tdHZmQKGzKr29TZkdK06zQtmZAWPycHjEvqSfgTJiNGeV4WQ
         DEvQ==
X-Gm-Message-State: AOJu0YwsWfqYc06vToaUsPq2uGba5cW2+8T0wooJ+GKJDkCcElKCzvW9
	tNui7VquaVzwfMkjQpnBMmjD14lcClImIgY0ruvslkH0RcxCxRc2kf+VjKO+POs=
X-Google-Smtp-Source: AGHT+IHu7yFpA0ctic/mHLBg91zHobx1HQ6r5qUYg2m6f7efx7TyenFFXnqg55wywdXyFAJYauWXrA==
X-Received: by 2002:a2e:848f:0:b0:2d4:7373:2a5b with SMTP id b15-20020a2e848f000000b002d473732a5bmr705489ljh.47.1712046337028;
        Tue, 02 Apr 2024 01:25:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902864200b001e2602fd756sm1739674plt.95.2024.04.02.01.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:25:36 -0700 (PDT)
Message-ID: <cdea8ec0-04cd-42c9-8b7f-ec46d8e31136@suse.com>
Date: Tue, 2 Apr 2024 18:55:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: add extra comments on extent_map members
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712038308.git.wqu@suse.com>
 <50b37f24a3ac5a2c68529a2373ad98d9c45e6f33.1712038308.git.wqu@suse.com>
 <CAK-xaQYwyT0zyqgVbca26zGOyYzFoA4YGDVxLT3Xve6_=sA0LQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAK-xaQYwyT0zyqgVbca26zGOyYzFoA4YGDVxLT3Xve6_=sA0LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/2 18:03, Andrea Gelmini 写道:
> Il giorno mar 2 apr 2024 alle ore 08:24 Qu Wenruo <wqu@suse.com> ha scritto:
>>
>> +        * This is an in-memory-only member, matching
> 
> Just a stupid fix about "mathcing".

Thanks for pointing out, I guess David is already giving up on my grammar...

Thanks,
Qu
> 
> Thanks a lot Qu,
> Gelma

