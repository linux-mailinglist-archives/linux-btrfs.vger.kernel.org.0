Return-Path: <linux-btrfs+bounces-8405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939498C7F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 00:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D42B1C21905
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A681CEE9E;
	Tue,  1 Oct 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e0GbcGIn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769D199FD0
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727820755; cv=none; b=SzxE8hTQVNJ/KRFeUHfsfL31TDVzJLXpnxPPg8iR8IA4H66xshM+o9ivu603laIuBSUjwKNDf3Q3VudQEzF4Pf9MfpZzGQ1WUles8yxUXEG69obtjpfoHKV6Cuv4YLU5oyofR2RTqp8HiuE2KzO9xWF5LDM8HuL+nE/xYlIxPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727820755; c=relaxed/simple;
	bh=7hWld9M2S2lTfgLrXMudPhiusXelVZhwkF7rMJlITV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fiz8PG9/u2Sc/aBH/a0/bGaIZWp7M5kgwjFwFANcXGiOXzv2n7sVp9GN9DxTHdWLzFGLzENBXL+p7z7M9wf9z9G3J7W74DA3I1xVJssYE6kdEaH97VDZxYSjmdTm/S1mMkr+LR9fx6nbyY27NCbwmAKiz3qHbnq5q8gWwi3yeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e0GbcGIn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ccd81de57so164225f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727820752; x=1728425552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDA0ICrMSHI47bl05ObpBkeaxtIdhcpgjwy3e2Oenaw=;
        b=e0GbcGInNE3gwJ84oejpEMg0tw75/cy4pi0A0gTVKiv6Gp/DnSwb20RtJK60zGlCGJ
         vMREjfjBYO1eOHksXTZt3JS9eUwAJ3jpZOHPRVu0eaRrC1mf1osYpeAucHRDEVhpd3D2
         EsqFcK/fIoJMr8srIr0AfmiWFUuiEmxpt/S9EH5L1lx98gRn0HDzD0sC+UlUhvEir6YJ
         bT9iihGERN37xOa1mWql9anlYSzyY9vwJHRCrg4+laEtJhJkJa43gwxjp/GYmnSyR6xa
         1lwgkBfn/LBq/3nTUnbjFVYk4XeAe58DZfr4Yl0GuOr2+NjVjDx6mNsBVwJYDvLrC3fq
         ODEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727820752; x=1728425552;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDA0ICrMSHI47bl05ObpBkeaxtIdhcpgjwy3e2Oenaw=;
        b=mkvojH4fjR3hoJdO4fL69Hl+BLRs4XXjREAKFa9QuI2O68SHMnParKaGGsAeQe7HOR
         Cxj0vDoF/sOUmrUTfWghLsytm+vD4t2ZmFmn1Cu23IVav5evn4f3PkcBr42/laINiapZ
         90I6udJgs+jpi1gw+ccc6/Aw5Irge2Mp4LMsA/GzKLDuj4778ILSRR7bGL89dsMnULD6
         iST+PCcw3AePOhy7t/T86iYZKsk/GFX6KLHidGgmtCMQfFrilyp1Xu7xofA6+LXtlZsR
         OltF0aZu9XvxyKrPQvPoY6ZheMyNco+GGhVhVDqD43cCN4E+mz3GIDjyvL3XLboYW3LP
         LWtQ==
X-Gm-Message-State: AOJu0YzYt/T9RgCq0JtFa140uWUo7eTQZbFgLFPeV8i3V8+6ZZK8E2pQ
	5LdS3TZ5bg6K8Ut4WvxAVfINuHPCURpoawS7Mct9XPswtMYSFWSUgJWf6HalCSBkSPfax86oJFi
	t
X-Google-Smtp-Source: AGHT+IHXQzoUVtwyP1ConvYaPztYffaUsmRXu9i2CyK2myCPk55oPTJaI/zNtVopgJ8m5HBa5GV/RQ==
X-Received: by 2002:a5d:6b0b:0:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-37cf28cdfabmr2720829f8f.21.1727820751235;
        Tue, 01 Oct 2024 15:12:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db293112sm8997580a12.8.2024.10.01.15.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 15:12:30 -0700 (PDT)
Message-ID: <094b3ff1-05f4-4557-80db-947a8224b671@suse.com>
Date: Wed, 2 Oct 2024 07:42:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS critical (device dm-0): corrupt node: root=256
 block=1035372494848 slot=364, bad key order, current (8796143471049 108 0)
 next (50450969 1 0)
To: Peter Volkov <peter.volkov@gmail.com>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <CAE+k_g+XFhkRBF0ErnRCBVaXAwUb3Tf9rm+Yny8u6aOLDQqihA@mail.gmail.com>
 <20241001150941.GB28777@twin.jikos.cz>
 <CAE+k_gJETiAtToyw9LoG3QWj-5Govupt9Shp9TFuqevSbt_RbA@mail.gmail.com>
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
In-Reply-To: <CAE+k_gJETiAtToyw9LoG3QWj-5Govupt9Shp9TFuqevSbt_RbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/2 02:40, Peter Volkov 写道:
> On Tue, Oct 1, 2024 at 3:09 PM David Sterba <dsterba@suse.cz> wrote:
>> On Tue, Oct 01, 2024 at 02:15:51PM +0000, Peter Volkov wrote:
>>> Hi! I've been using this system with this kernel (6.10.10) for a few
>>> months already and today out of nowhere btrfs broke with this error
>>> message:
>>>
>>> [53923.816740] page dumped because: eb page dump
>>> [53923.816743] BTRFS critical (device dm-0): corrupt node: root=256
>>> block=1035372494848 slot=364, bad key order, current (8796143471049
>>> 108 0) next (50450969 1 0)
>>
>> Quite obvious memory bitflip:
>>
>> 8796143471049 = 0x8000301c9c9
>>       50450969 = 0x301d219
>>
>> The first one should probably be 0x301c9c9, but it's impossible to tell
>> how many other data/metadata could have been hit by this or another
>> memory bitflip so check can detect the things but not fix.
> 
> Thank you David! Is my understanding correct, that btrfs catches
> memory problems,
> so this bitflip most probably means that my drive is failing?

In this particular case, it's your hardware memory, not the drive.

The error is happening at write time, so the metadata read from disk is 
fine, thus not your driver returning some weird data.

Furthermore, it's pretty hard that a simple bitflip can pass the 
internal checksums of the storage device, thus it's very unlikely it's 
your drive.

So, please do a full memtest of your system before doing anything else.


And considering your fsck result is already bad, it's no doubt that some 
bitflip has already corrupted extent tree, and I believe the csum tree 
is also corrupted.

Thanks,
Qu
> 
> --
> Peter.
> 


