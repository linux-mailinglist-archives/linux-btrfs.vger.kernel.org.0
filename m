Return-Path: <linux-btrfs+bounces-6320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266392B170
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D7B1C2109A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DDE14E2D9;
	Tue,  9 Jul 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gANHOw5g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2313E032
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jul 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511187; cv=none; b=f56MAKsT/P6vm9FIxn3uLW3WjjCIULgS0ltPLWzEtGscpV/mNMvhQ8mOw0qj77NOrR+VvzscjUfOmWAHZB1xdgoGicDz4lrp/xfYU5iErBzNxxbWW5FhtzpTqpHjlhb9ZKe5uAzecdBTzTnXBNrwaUMT22wKsawAx/DI8s8LEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511187; c=relaxed/simple;
	bh=ga1z06v/+Qn1EDVPvTkLZxiC3vvzYTIQaO9U1oJ3FVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JG+Vmkq9bB/ZrWB5T4+xTKeTyx/rGSOTs4dI4nVfHhSv+WN+oAAqhG9dOPyF/n2fOn8H8TMhBYK6iEvYSNdWgro0tbKhmKbFhemMQHdP0pnhVL94Rx5cAqDWdzxBxO+lqe4LwSjgy/s/sfbO6vsF9oxKPNANMsu9gblYZJLNnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gANHOw5g; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee9505cd37so38861871fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jul 2024 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720511182; x=1721115982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=97DdeyQzZ6NpVDRuHLam7+G9SbKJZZTLVkPODrKJaac=;
        b=gANHOw5gtG8ne9v0hIBpN61/Q7qauiNfxYJy1jcLZDVdyb+hqLzf1r5vc5J5wtKOaj
         1u78lmDig1+lFRhVoEId69yYHVVDYggV7kpbeUIWEIx52dQSvl7B0MR3QGe9pTthHDES
         FjeOONWyatiBto/9BMM8x9F6iy8hLckQOZ5dDucEvsN59VhVzbNh7BdvI/uY6GbgFU1l
         /tdglYbK1k9eiMZqqo3kXpvpVeGiGjVMTurve7YPLFi8jyrs6J4/ilLZTi0jwziaP3Zz
         ulIx6FVQPY0OBZyljEtgwVfntLXgRwL59vHplDuFuWhJEZGoBv/nLDz78/eQ13SKvrU7
         bfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511182; x=1721115982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97DdeyQzZ6NpVDRuHLam7+G9SbKJZZTLVkPODrKJaac=;
        b=RmeFWV1cWCaFl8gu+WIxqb9vSr7QF1+VTH3OY2e3Ty9Xag0woIBYu3LylgLnG+TY5f
         rNkXsmYqFtoAnQs8X5om1+NsrELfNF2GlAXE4XIm4dWRhVsyN8crLhjrLykjrjtlQ6jA
         mYpA6vH9zIb4tDJhl0S1GGg28SSpufnSnhxk+RpxwTMymPOD2tPnaTxWT24UpOwDclzv
         cYv8U7CHEfzw3ebdQ6wPPdKf7N6ru2digDqC2DSfvT6+j04IyYU39HBIFW9XjPzGPQfb
         RKvowBeJzOQlsBufEnKPUvqWklfTSCTY+lA5S69G7dHSnMjJ+Kd2nB1N9asObm7D9QJp
         9uSA==
X-Gm-Message-State: AOJu0YxrTL1XXUW/GIGiDaNj73Sw1diaEzpQyN8hRA3JdzzJ17ofzVyn
	YsqlHnY9vp8fLw0vmKtTRxh7HQI4bTu5YLgqROmeQw5FEkKdDRFFrjzOs6CnYG4=
X-Google-Smtp-Source: AGHT+IENOFpRlTwre+m1idW8+pYjDS3+Jb5oEQc8R1zju3pmKNgccy/pfr9NdHF/PqnDXRglo+y4ww==
X-Received: by 2002:a2e:8297:0:b0:2ec:5b17:29a2 with SMTP id 38308e7fff4ca-2eeb318aaf4mr10904531fa.32.1720511181485;
        Tue, 09 Jul 2024 00:46:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca3bd7892dsm353179a91.0.2024.07.09.00.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 00:46:20 -0700 (PDT)
Message-ID: <bca6a8d7-b23e-49be-9cfa-f387aca82e60@suse.com>
Date: Tue, 9 Jul 2024 17:16:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: replace stripe extents
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Filipe Manana <fdmanana@suse.com>
References: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
 <20240709-b4-rst-updates-v1-2-200800dfe0fd@kernel.org>
 <4211723f-ddc9-4646-91c3-14a9a1769d22@gmx.com>
 <09f08d98-a615-4952-9949-daf4a7119b96@wdc.com>
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
In-Reply-To: <09f08d98-a615-4952-9949-daf4a7119b96@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/9 17:00, Johannes Thumshirn 写道:
> On 09.07.24 09:18, Qu Wenruo wrote:
>>
>>
>> 在 2024/7/9 16:02, Johannes Thumshirn 写道:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Update stripe extents in case a write to an already existing address
>>> incoming.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Looks good to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> But still as I mentioned in the original thread, I'm wondering why
>> dev-replace of RST needs to update RST entry.
>>
>> I'd prefer to do a dev-extent level copy so that no RST/chunk needs to
>> be updated, just like what we did for non-RST cases.
>>
>> But so far the change should be good enough for us to continue the testing.
> 
> I /think/ I have a fix for the ASSERT() as well. It survived btrfs/060
> once already (which it hasn't before) and it's trivial and I feel stupid
> for it:

Wow, it's indeed a little embarrassing, but I'm still a little confused.

> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index fd56535b2289..6b1c6004f94c 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -57,6 +57,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle
> *trans, u64 start, u64 le
>                   /* That stripe ends before we start, we're done. */

Didn't all the btrfs_delete_raid_extent() callers expects to delete 
exact the range? Thus I though we should always hit 0 from 
btrfs_search_slot().

>                   if (found_end <= start)
>                           break;
> +               /* That stripe starts after we end, we're done as well */
> +               if (found_start >= end)
> +                       break;

Another thing is, just to be safer, you may want to do the RST entry 
search using key.offset = 0 or key.offset = -1, instead of an exact search.

The key.offset == 0 search example can be found in scrub_enumerate_chunk().
And the key.offset == -1 search example can be found in 
btrfs_free_dev_extent().

And do extra length check to ensure we always hit an exact match.

Thanks,
Qu

> 
>                   trace_btrfs_raid_extent_delete(fs_info, start, end,
>                                                  found_start, found_end);
> 

