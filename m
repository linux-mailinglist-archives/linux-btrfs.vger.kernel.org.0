Return-Path: <linux-btrfs+bounces-7979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A429773B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 23:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E52F284AB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334CD1C2306;
	Thu, 12 Sep 2024 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqh7q1w3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180412C80
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177385; cv=none; b=fYulJdmF7FYnCBHcdKRiSOdnS6R691hxpS65fMoWm/5VNz2SyDCGmJ2n3aELUMJb2YWqUFqTAP9+alhwluAWkuT6bD7x7+HhWfWMxQ4cc1AGjf3oL4P9FyEGKzYvN2tJ9VdTGUJtdDK+dZy98W4LTGpjegAUnpHstcwvz8e5Huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177385; c=relaxed/simple;
	bh=np3G7KBZ+tiCKuzdAhiEKPEplg4juHErDLapNvZecfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ioTVjDbZUkmFfHygk6NWwToujUu0ApqH+tpJ+TVsf9WJP/as6s48eBJ0RsKfjAr/Yq/QPhFC2Rgnf2PNvJrsTG6IJpokODXLt8FnrkR0/qiHLTQLN9eyUAwngki4WppQ+KturTqbwUtyfZ/k0gEtRyTqlqhrQDHKzXiX3yoEdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqh7q1w3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3770320574aso1030620f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726177381; x=1726782181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ll1dsDdskaMu6/mGog4LGmlEDrRvbii0stFY5/8uDhg=;
        b=gqh7q1w3Kp/chV3IQZw4dmTBdvTktz/rnxaEBh2ZZTQcgpw8eOcm6HqbdzJyn/gkqL
         t2HhTPeKnOJlt8fIwDrfAabdAmqfW+reRiAYqMlj2usr26Y0fHk9eQjTWH4B0ZL5jdag
         qbPUuccqDK9l8aMt+TV8LEV78yC+Vlq789v/DlGnchfOujmOoMayGsS8pGxVuHjoIbrr
         bZlUx1YkaNHmsj/JGfO1T57iwNgJhfj+E+AdBJeiw0ec18IknGUvDt8GG7lBn2LamkWQ
         yogylBizyJop4CzmDRQLn8k7/HznypG1z3Z07J9hl/7gQXVE+VRzBLjxsLdMzjaDVeRe
         XInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177381; x=1726782181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll1dsDdskaMu6/mGog4LGmlEDrRvbii0stFY5/8uDhg=;
        b=dQYGLvHtBrLhKkgLJP9z9U7dsw5tr3tOc6HoHiIxm3QtRet4/za/UYunaG5UB5vG2A
         wymsJY9JR/h1bsbvvMv9rr/QKuuyZNplBqqEy6R7WKU8dipCGCNrzysunAKByV9mn+y3
         s+pf3QAS4JBj0tbTmkCoExxt8V9b9TTZoqiSnDsNoiQSCq4RWP6p0y3U7RgvD+3hDNQR
         PnKohS7c0gwqJoAwS9iJ9xu2Phsz7NbJglVrTasH+Q7R5clDOSC5ZLUbLERd/besQX0+
         LAGcEPwFMEj55GcEm/KqYU2q5Pm7ccMsmWxG7vT/+GY2fLzO2zhlUDGoZ6C2rWDVsMIv
         9D4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWa2OOGjWPDRw8Gz1vay9HUaOzwgVdkmvpoSg88On1cZqY+/mlgB4cpTVnQbuq45OJYJJFmKDjBEfXUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74oHo/N1DXyMqY3GyQvaWXnGE9IxXbcMPrIFHREyXqZZ9X9zu
	HFtrkmS8GiQjCw1DQHzBKFCI1uro7evER3w4G7AijMb5sMIxQPf1Ck9nvPcG4vw=
X-Google-Smtp-Source: AGHT+IEfigSXjWrNPlmxPci/Zu9qmeQUz5sw+KFLFzJm7e2+ACPtmmBRgG2PwsL0zaCwwHi50SbJ7g==
X-Received: by 2002:adf:ec07:0:b0:374:c61a:69b8 with SMTP id ffacd0b85a97d-378c2d058abmr2645560f8f.15.1726177380721;
        Thu, 12 Sep 2024 14:43:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090037fbsm5169562b3a.94.2024.09.12.14.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 14:43:00 -0700 (PDT)
Message-ID: <1ee66f34-b855-4a96-bf75-a3d14b9ce392@suse.com>
Date: Fri, 13 Sep 2024 07:12:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
 <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
 <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
 <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
 <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
 <ccf78d58-a050-4ba7-853b-37b6a1386a69@archlinux.org>
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
In-Reply-To: <ccf78d58-a050-4ba7-853b-37b6a1386a69@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/12 21:43, Archange 写道:
> Le 12/09/2024 à 14:23, Qu Wenruo a écrit :
>> 在 2024/9/12 19:34, Archange 写道:
>>> Le 12/09/2024 à 14:01, Qu Wenruo a écrit :
>>>> 在 2024/9/12 19:27, Archange 写道:
>>>>> […]
>>>>>
>>>>> [3/7] checking free space tree
>>>>> there is no free space entry for 0-65536
>>>>> cache appears valid but isn't 0
>>>>
>>>> Then it's totally fine.
>>>>
>>>> For the 0-65536 problem, mind to provide the following dump?
>>>>
>>>> # btrfs ins dump-tree -t fst <device>
>>>>
>>>> I'm afraid since the fs is somewhat old, there may be some corner case
>>>> btrfs-check is not handling properly.
>>>
>>> ERROR: unexpected tree id suffix of 'fst': t
>>
>> My bad, it should be "btrfs ins dump-tree -t free-space <device>".
> 
> The output is too big for an email, so uploaded here:
> 
> https://paste.xinu.at/XtR8/
> 
>> And if possible, also "btrfs ins dump-tree -t extent <device>" just in 
>> case.
> 
> Same thing (even bigger), also output on the terminal and while 
> redirecting to a file was quite different (but maybe that’s more because 
> something changed between the two calls), so here are:
> 
> – the cli run : https://paste.xinu.at/9vs/
> 
> – the file run: https://paste.xinu.at/XpzhbZ/

Thanks a lot.

This indeed shows a very old filesystem, and for a long long time, we no 
longer create any block group at logical bytenr 0, thus it shows an 
corner case that older fs layout doesn't exclude the first 1MiB.

And it's indeed a false alert.

In that case, as long as you still have unallocated space, you can just 
relocate the system chunks:

# btrfs balacne start -s <mnt>

Which should move the system chunks to new locations and will not 
utilize the first 1MiB reserved space.

Thanks,
Qu
> 
> Regards,
> Archange
> 

