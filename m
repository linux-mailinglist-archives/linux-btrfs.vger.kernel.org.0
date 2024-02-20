Return-Path: <linux-btrfs+bounces-2562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00985B50F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A771C214E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FF5C8E5;
	Tue, 20 Feb 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P1GWGZ4/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6335C61A
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417604; cv=none; b=GMwiBCl3Psh8201A22cU0lcHe9NRh02jrN3QuyBVzamly75UWTBza6+L9XoPmEf2XINGiiXnzsIDFFjfri47t5pCDtZUMGGYXLw1AV6p772F7A7CPvpAzdd6IMgcV2RaMNj+oWZuLyfXWSf61d3sg1ybGJ2gcBmTFUuD8McK0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417604; c=relaxed/simple;
	bh=DQ1EMONEQg+hyOeWsVI197jFrB7eEBnObZDQNOV6pBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDPi35wwU6bkB7rCdPIz57AHeqUvLSQMVHeUg9eI9hLqmaygjjEBhXCvaHxv6wGAC6/6L9Rwo4t182HQuZO+VaJRA5fq1mrMKqrX8evmF5uMMuRM66UG7D6mX1xj+goSPG5LYerbhpEHe72fl88TY1tZZ97+0ty60lU4f6JMNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P1GWGZ4/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso61762941fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 00:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708417600; x=1709022400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSGLHi46/BCGaJHFcy5mvilGU1yxYp2IJrJsOciQ/ZU=;
        b=P1GWGZ4/zj91eNd6wmweYfM297Wkigs/XfrLxglNfvkOrpUmx4oAGmeXixpPXxXBm6
         r4XhK4kp2DItDu0TUmaiOTStNxN6ckuViLtD9heQvTsDKUvtmArVykOGA3F1a1VvTJ1o
         Rk1mE3y/H3Y0JYD1FyhAWWLjRyVRlMvrbQBxttJZpTatvZ8w8AQ793hcS0epIDAEgt//
         MhB5JhWe6s2JaqgA8vrZ3V/du0tg7dRjlBmmgzibOjvmlUS3Q5OfrOrRTxNnbg/fpe9j
         dqRrz4Z4IS5pvT67rh6qTEnKIDTnU4SxCw3+mWwHorIe34oAVyEf7WhNT1JKm6ur+sKk
         ar5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417600; x=1709022400;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSGLHi46/BCGaJHFcy5mvilGU1yxYp2IJrJsOciQ/ZU=;
        b=wcVuHIt2AU2bIvZbS3GbwA0gC80n0J3ZbnTUrByrKeoSku+xUbJpd5v6W6Uz/B3J3g
         aVQYRfp9v7HTzAux95JMG+lafiT8FjAzTn4QbdCuQgfOqIO9b720hxByBN+ZYo8tQIpf
         Iqp3Hw/6f6LUJAdhned+gzP5oCvV+C+INuehV9yY3fR8v8ADSHD1l2oIFGBJgJdlLE3r
         SxkC8MeMMQJqb85PD4aJ0jSvsJ9zuo+VoovUuwH/HpQ5MeN/JbxoWsMz+gFDkqqAXJcx
         03F+7eI5O7VbPOeKroXKmHN64vRjf2xjonLjDmWJwlhvFPef0uw9EQzmb6SlPWhBT6P1
         8kyw==
X-Forwarded-Encrypted: i=1; AJvYcCVdACjjX6VAFnj9pcgzKKCzZg9zNoNcapb884orHIhDM95PdfEo94XuiMddWMNza1TlSusYG6jn6rsiorsmfBmmVQBsj9XNamR8hyU=
X-Gm-Message-State: AOJu0YwIPH7DhEaIzcxnkNizUJL9ZIhPa3XtOeSHYFlua76UZHyzquuu
	2lkDRo5iVogQRiNGJ80DcESGkUD5klijOyacEeEkyMnrYqDxL7N7a1kQzlL3ZGw=
X-Google-Smtp-Source: AGHT+IH+7KU4pxvMJsVYL6NIzH/IO6pQ83GJAuMYQ6ErXdZdwWTzlctIMQi/JWfLyWBnLG8AEgdKVg==
X-Received: by 2002:a05:651c:1a07:b0:2d2:399c:df25 with SMTP id by7-20020a05651c1a0700b002d2399cdf25mr4020755ljb.16.1708417599877;
        Tue, 20 Feb 2024 00:26:39 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id sw8-20020a17090b2c8800b0029732fc0154sm6905301pjb.3.2024.02.20.00.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:26:39 -0800 (PST)
Message-ID: <f4a2d37d-33fc-426d-975e-5408ada21710@suse.com>
Date: Tue, 20 Feb 2024 18:56:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs: subpage: introduce helpers to handle subpage
 delalloc locking
Content-Language: en-US
To: Yujie Liu <yujie.liu@intel.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev
References: <02f5ad17b6415670bea37433c8ca332a06253315.1708322044.git.wqu@suse.com>
 <202402200823.Su3xBnia-lkp@intel.com>
 <549a5778-ee2f-4520-9147-f09854a50948@gmx.com> <ZdRbi3gumI2fGhUq@yujie-X299>
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
In-Reply-To: <ZdRbi3gumI2fGhUq@yujie-X299>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/20 18:28, Yujie Liu 写道:
> Hi Qu,
> 
> On Tue, Feb 20, 2024 at 11:46:17AM +1030, Qu Wenruo wrote:
>> 在 2024/2/20 11:22, kernel test robot 写道:
>>> Hi Qu,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on kdave/for-next]
>>> [also build test ERROR on linus/master v6.8-rc5 next-20240219]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>
>> This is applied without the previous preparation patches.
>>
>> Is it possible to teach LKP to fetch from certain branch other than
>> applying them directly to for-next?
>>
>> Do I need certain keyword in the cover letter?
> 
> Sorry for applying this patchset on an incorrect base. If the cover
> letter mentions that the patches has already been pushed to a certain
> branch, usually we will skip the patchset and directly test that branch,
> but seems the bot didn't recognize that there is a github link in the
> cover letter. We will investigate this and fix it ASAP.

My guess is, I'm using github's branch URL in the cover letter:

   https://github.com/adam900710/linux/tree/subpage_delalloc

I guess I should go something more traditional like?

   https://github.com/adam900710/linux.git subpage_delalloc

Thanks,
Qu
> 
> Best Regards,
> Yujie

