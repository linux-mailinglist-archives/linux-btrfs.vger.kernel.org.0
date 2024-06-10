Return-Path: <linux-btrfs+bounces-5587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E548A901A2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 07:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693541F21790
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 05:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BEF9D4;
	Mon, 10 Jun 2024 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d0uadF1z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCEA935
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717997069; cv=none; b=NS6uRQCkjDyFauEE9ZsR5e6Ptd8WEH0Ao+FgBgwE6F24TRd+MWOScRuvgHxAvwu/k9w+ttg8dvEa3g86J9JWndeVA2K9kkOhy3FKRUcWUaFbclMF3gCRE19hCHUG5kcImHOEn4mtdo9F4l0XvYniz3BnVlqiNyod4WSirXZ3KnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717997069; c=relaxed/simple;
	bh=/08UdSqDiirqDQ0U37m2J+5JugPJ/2LqVwytJseEDio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BddnKW27UqkadKGh09wpZc6ROs/t5ANHCf4t+drYnYfV+/ZbXN0D1JwnnF22iuggoGuV0ztCa4V+XMyh/E4Vm9veSxwRIW64wATgApqdznA1Yo8ESaUqzt73tqHcSJnE8hYP6Y2Ey49YqmJoXmazOpWvz2uKZq8fte7xRlfOT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d0uadF1z; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so45486491fa.2
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Jun 2024 22:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717997065; x=1718601865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oW9b+VUygdRE00bCao6UVImVeHEMfk0kPnTXTCvj270=;
        b=d0uadF1zPSIE5O6EXRxFTLk4w7HwD3akGlcH9jrfwZNqLCmnUz+6m31M/rcgsGT2vd
         1uGiY3iepSglynCfJffU/dPeH4Q2+WjArrpzjSo9FM7k0QM+uSzt4O0yeZOFW3R2z92E
         gotd6etm/qbaZZ5C9hSZAprGbNL0/ZKvAOuX9vy8WXivXfYho5pFCKMyBuoatMvZjSss
         RpIWV5eYREqDkWQVKwFRQekdD13hQmen2GkUgbum3vT3b3UWLlhAQxhgEBiPwbdMnpHO
         DIJ3sQziYDzVBfSQzLsNvaAHvAIrOvJMafF5mZXSBsiaEtp4rwIdnVeJbPiqSqbHY9hn
         1C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717997065; x=1718601865;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW9b+VUygdRE00bCao6UVImVeHEMfk0kPnTXTCvj270=;
        b=Gl0CH05p2dnmwEj2CYqaFnUN5gt9u66SOeqkhDb2SYFp1THI1ADN/faza5ShSVc/J3
         8XU6E2bnnd53rqW1t7LuV18V25tghUQIt9e1AT/R8+0bXnvhvPehMprSg1JXIfhrPo5G
         u3rHxxv3CP8oWJf/nuHHmQm21KVW74SKG83ng8jJfo5JSvyWPXUoc/YRtoMQo4Q6XRiC
         P4PB50I6+vLLUVBrCKmHPwm5M/s17xDYuxmBuhO2rkDasfMpTTvl0s03CXxWw77HQefN
         afvhlf0CusYgHIwQViS14Px62iZovA1PByXtPH9wCOzjkhLzS0LUBKx8pCHnkFWH5wmt
         pD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUQuX/CvfQKYw1+WTBxzdQbYMfZDMITfNujexJM+3EKTlgdeKUOjGaym97p+VRYrOwX3P8dFsAQ8fqCkK6Q3eCvQknbtm7iTXjxh8=
X-Gm-Message-State: AOJu0YyrM99lSp2IjAoJyJC5DeymVLHR0AGeYHPbE7RD4q7K6veg5tAh
	Zwn/89T8DohB/GtMU5yBdtLBoA9PdYoONSR0it0hdfLbzWMIqhkZo3BC5/8baNcEKz+jvPvc4Hs
	R
X-Google-Smtp-Source: AGHT+IEqmYAv3XOQHeUEC2l5iE0CU615IqlEBCjc2o6XozxPqzZx3unPxuPrXqchxLRyB+sM4lb58w==
X-Received: by 2002:a2e:351a:0:b0:2eb:d620:88d9 with SMTP id 38308e7fff4ca-2ebd6208a5cmr22691461fa.30.1717997065387;
        Sun, 09 Jun 2024 22:24:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70423a7f217sm3204875b3a.206.2024.06.09.22.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 22:24:24 -0700 (PDT)
Message-ID: <a2cb9afa-2810-43bb-a6f8-99b56669a304@suse.com>
Date: Mon, 10 Jun 2024 14:54:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The proper handling of failed IO error?
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-fsdevel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <960aa841-8d7c-413f-9a1b-0364ae3b9493@gmx.com>
 <ZmZ3001_gcjAryte@casper.infradead.org>
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
In-Reply-To: <ZmZ3001_gcjAryte@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/10 13:19, Matthew Wilcox 写道:
> On Mon, Jun 10, 2024 at 06:50:11AM +0930, Qu Wenruo wrote:
>> Hi,
>>
>> There is a recent (well a year ago) change in btrfs to remove the usage
>> of page/folio error, which gets me wondering what would happen if we got
>> a lot of write errors and high memory pressure?
>>
>> Yes, all file systems calls mapping_set_error() so that fsync call would
>> return error, but I'm wondering what would happen to those folios that
>> failed to be written?
>>
>> Those folios has their DIRTY flag cleared before submission, and and
>> their endio functions, the WRITEBACK flags is also cleared.
>>
>> Meaning after such write failure, the page/folio has UPTODATE flag, and
>> no DIRTY/ERROR/WRITEBACK flags (at least for btrfs and ext4, meanwhile
>> iomap still set the ERROR flag).
>>
>> Would any memory pressure just reclaim those pages/folios without them
>> really reaching the disk?
> 
> Yes.
> 
> Core code doesn't (and hasn't in some time) checked the page/folio
> error flag.  That's why it's being removed.
> 
> Also, btrfs was using it incorrectly to indicate a write error.
> It was supposed to be used for read errors, not write errors.
> Another good reason to remove it.
> 

Then would it be a good idea to only clear the DIRTY flag when a 
successful writeback happened?

Or MM has some strong requirement to have DIRTY cleared before marking 
WRITEBACK?

And any idea of possible problems if we keep the DIRTY flag?
(I guess if the writeback always fails, we can cause very high memory 
pressure?)

Thanks,
Qu

