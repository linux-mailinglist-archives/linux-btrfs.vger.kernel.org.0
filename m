Return-Path: <linux-btrfs+bounces-5112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A78C9BFA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 13:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767B828231C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC1535B5;
	Mon, 20 May 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fwQMy7DD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C194DA09
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203226; cv=none; b=Zn9PTcSPqwn6Jpo5Ncu+Wyic/Jj71E2YOHnbPkBl5pYrNXStAmzKg22oaM+rR16z+r6iFhplREG83Q7vvTOaoP98AGn90welIu9kxFGNkbYgpk73VXpfo9d+UgFepDEnUsdX1IFvFEMFnU9QH5lBwRRqlzJCXLgp7dhv+WIOUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203226; c=relaxed/simple;
	bh=HUYQkGw6laUBNCCMHBBqBEtdcBYpec31TCDeX+lD0iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSHmayuGwbmloKkkM6GBHlXN8jckVp+qedrJ7Bf4KJyFr7CXFBHX2QomD/ATkcBqkP7Ye+W7VC5tSJLN//9/aXsdpiHz0RB9nNF1O+OTHqHbW8MQcO03hdivLK+Am5tZIrp1L3qNyruPZV3HgvFe9kidEVTOXGIagpFNmjUGLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fwQMy7DD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f40b5e059so3634608e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716203222; x=1716808022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jsGtT/zt+SOrLBCRlAYITwhB/NC+pktw4F5AgoBGaFs=;
        b=fwQMy7DDfEalUFNZ3S2KPiX9H7XhvvAPdrIJvH1BsqAFy54/Y4YaYZyspiZECz7R6y
         KwmtnwLmAhZAnjnRowQYRhQ6Q/ZFQJLj4O3YCLJ5rdAq9hY5y7l8BMv890fMoy/XvJtD
         4tzhWq/Flc2gWwl7rgvepC/29EXni6ggArLoIIM1GT8XebYJvS0510tUAjvRL5ZE0zBR
         iT+1nqFsZlygd1YvIAwchB09vT0ePazOPtc2wgcPcvfTLE5CocUmBdjOb/od7//g6Tim
         0afgRLuO0ENOsWsMHUtGdmgHAzuWuy6UCnk0Fr1C7tdZV3jJEk5qEsJ5+/T63a7U06uf
         dCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716203222; x=1716808022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsGtT/zt+SOrLBCRlAYITwhB/NC+pktw4F5AgoBGaFs=;
        b=bMDIWnpbr/+cCXaC3h+Y7wU1JRZJ1IwsR0aNYcIesJ9uDhSJ2MFx3jo8Ls1MfKG2ky
         6WrO27fUHzDGoVhkmVau1uJFoHR1s5zXc4UXe/a9fzi8/vVZ0CQ9Vm9yCj0RHCcpt/o6
         Va4+1GU8LeKnsNPFzLYBmRSMvBv54YyNZTGexRZlKi6OZH6UerKf++4Rt5BvXbX7B7pP
         rpLXR194cUueTB4Z/I5b/KMK0h+Q3NsJWj5GNZhBSnewciKytB/rID1QY5Zh9IRemsSJ
         8k1rxdaxNzMg97zmVkM8x2T54pw1FjhYf9ADIcVi8Tk2G5wJJU7HyRNxQJNX9DNDffjW
         juyA==
X-Gm-Message-State: AOJu0YwwufB6SW84eFDiCnU8LAjIMJ+zmYPM8lEe9krpK4OXl+lr7c6D
	yGg+tQ5WkG1FTaIHzpI0vFO4WzCTV8r8VBy+cMCTTMiW+BowGEMwXF4GALJr0B8=
X-Google-Smtp-Source: AGHT+IFh46cRQt9sZSLPE/Bd4hk1ZcMDo78VB23SwRQMqbR1HQimvZA0akBGYYS7A3Sel3tjC2okDA==
X-Received: by 2002:ac2:5970:0:b0:523:481e:9f32 with SMTP id 2adb3069b0e04-523481ea355mr12046883e87.69.1716203222253;
        Mon, 20 May 2024 04:07:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2f46c28desm32850425ad.221.2024.05.20.04.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 04:07:01 -0700 (PDT)
Message-ID: <48ed0d56-7a14-4216-9f85-cd2a48e592aa@suse.com>
Date: Mon, 20 May 2024 20:36:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: enhance function extent_range_clear_dirty_for_io()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <31b95191f9f1c8aa600370b70a77d69ebfd30bd3.1716177342.git.wqu@suse.com>
 <CAL3q7H7RxYhiTTMZU_qQ9yZKRm7Qo_YdhDq1zNxz=g_gVALhcw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7RxYhiTTMZU_qQ9yZKRm7Qo_YdhDq1zNxz=g_gVALhcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/20 20:21, Filipe Manana 写道:
> On Mon, May 20, 2024 at 4:56 AM Qu Wenruo <wqu@suse.com> wrote:
[...]
>> - Make it subpage compatible
>>    Although currently compression only happens in a full page basis even
>>    for subpage routine, there is no harm to make it subpage compatible
>>    now.
> 
> The changes seem ok and reasonable to me.
> 
> However I think these are really 3 separate changes that should be in
> 3 different patches.
> It makes it easier to review and to revert in case there's a need to do so.
> 
> So I would make the move to inode.c first, and then the other changes.
> Or the move last in case we need to backport the other changes.

Sure, that indeed sounds better

[...]
>> +       if (missing_folio)
>> +               return -ENOENT;
> 
> Why not return the error from filemap_get_folio()? We could keep it
> and then return it after finishing the loop.
> Currently it can only return -ENOENT, according to the function's
> comment, but it would be better future proof and return whatever error
> it returns.

Sure, although we can only either keep the first or the last error.

Thanks,
Qu

> 
> Thanks.
> 
>> +       return 0;
>> +}
>> +
>>   /*
>>    * Work queue call back to started compression on a file and pages.
>>    *
>> @@ -931,7 +957,10 @@ static void compress_file_range(struct btrfs_work *work)
>>           * Otherwise applications with the file mmap'd can wander in and change
>>           * the page contents while we are compressing them.
>>           */
>> -       extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
>> +       ret = extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
>> +
>> +       /* We have locked all the involved pagse, shouldn't hit a missing page. */
>> +       ASSERT(ret == 0);
>>
>>          /*
>>           * We need to save i_size before now because it could change in between
>> --
>> 2.45.1
>>
>>

