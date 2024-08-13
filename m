Return-Path: <linux-btrfs+bounces-7181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE6951064
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 01:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE4FB21AE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 23:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4451AB520;
	Tue, 13 Aug 2024 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E2yoEuum"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6918153BF6
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591071; cv=none; b=XU9jaNplb3AfRng1U7QkmZPAhxT8bVD2L/5da57Q3s24cld3pzO8LM4inYyDKlsoLIoJwQZlFjrDwGjYoXcfzHhZTSSt86MmAOMVI16TtYf+L0h8PMPB5WWxZRRgqBnb0kpUYkdNMMxXb+YdpfC86I6UH+iGUSPhUqFI2JnjVpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591071; c=relaxed/simple;
	bh=jCI73ybgBln5lxyGDBmMHNSIwYrEgiWCKLv98TZr6L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kV5B7AAxD1Fej793f68gcm3qOEhXerKX5udoURYY+fA6yBqsClfCuMEN5wcHEM4qFj6oe8JNQYB442QmFwRZd73QrgD9H0GDIbSJyJuvr8ndUeojM9dpjezQvqouhArSIkfZHPXfO3iaNdMA0DgPK/xNyZWjq+1tu03DSJLHscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E2yoEuum; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso62750901fa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723591066; x=1724195866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uxobwvhNc04P6k/OHRTKp8hufnz7u2c2eme+ubfxLe8=;
        b=E2yoEuumJYQKYPi6jd+mn5z35xrp+BI6EQOBhnl8Sn1fQtUos0odAQeKp+fcNUoh4J
         WN/GE7OwJpQAka0ydWmiaOQ/oWZ3SxFS45BqFmbXkRM9lEcsMGSIm/rnwboU9dAJgsvn
         zrc0+XmsoMOozbVS7FvrJEuPQsASvGnk40DmEpewI9BCvIP+R+ca/yX+SlYe7S9nMFpF
         31BcJ3QeHIhV8KOgkxGCyZgCf8oWSe6boh50QP3iLbnGOlMT/64yPL4HF7y6BPxy47S1
         2WluOuR0gVaH8aCURGjHQY+GUUnlxlfYwoDNBi/u+v4lvfc+qgTYZy85ya30uHpMk8yq
         JeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723591066; x=1724195866;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxobwvhNc04P6k/OHRTKp8hufnz7u2c2eme+ubfxLe8=;
        b=tBRRi5yP2Q9eLBTWwLPSmWy0cuKWQ9bqR5bOdYtuIR1+h6XLZ4Zj2zgFXvvQ/wk1DF
         IIegQmC8X8/QZZv6fptPQ2v+TFojxMYzR2ahfbPIKvQCG8XuhUVXuGbub+B9MORyiYzv
         ZS2cOuwcuCojJx93X463lNGlVWUq45JoqdmYMEW/bwu/IY89VLP9W3t1yvf/6V/l/ae8
         toS6KmRgqCMx1a5FD02bP6gShdiBC7P4bs1RDay5zlOlmeJl4FOzSXrp+wkTF59+Tyis
         Gd9sUOUIqZczuV81SIcYZY7Z54mHJ2mweWHE+rm4DockbNCETJrGWZteAw/8cjaQnIre
         Uo2A==
X-Gm-Message-State: AOJu0YwqnLoYOplz0pNNwRJAtoVExI/HdT2NZvaOwggW/AGXHyFpD0sk
	PyviYqNJiKPu/JDaMR70aR7G0FOew1f/yTnY84qnAkyePcYEYO1AsJZnd+TheXnqXn41iOuQI1O
	f
X-Google-Smtp-Source: AGHT+IH+kCuq11zmzRpdBBp2vOAsagDWgnN8Rq90cEs6ANcBb8oUD/uXit/yZI4TX6rs7tJCjwbxcw==
X-Received: by 2002:a2e:a99b:0:b0:2ef:2eb6:e3ed with SMTP id 38308e7fff4ca-2f3aa1a56f8mr5738091fa.4.1723591065155;
        Tue, 13 Aug 2024 16:17:45 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1d6128sm18593155ad.290.2024.08.13.16.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 16:17:44 -0700 (PDT)
Message-ID: <0d1da382-8cf1-480d-941a-9e01298e466f@suse.com>
Date: Wed, 14 Aug 2024 08:47:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add btrfs dev extent checks
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
 <20240813231146.GW25962@twin.jikos.cz>
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
In-Reply-To: <20240813231146.GW25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/14 08:41, David Sterba 写道:
> On Sun, Aug 11, 2024 at 03:20:08PM +0930, Qu Wenruo wrote:
>> [REPORT]
>> There is a corruption report that btrfs refuse to mount a fs that has
>> overlapping dev extents:
>>
>>   BTRFS error (device sdc): dev extent devid 4 physical offset
>> 14263979671552 overlap with previous dev extent end 14263980982272
>>   BTRFS error (device sdc): failed to verify dev extents against chunks: -117
>>   BTRFS error (device sdc): open_ctree failed
>>
>> [CAUSE]
>> The cause is very obvious, there is a bad dev extent item with incorrect
>> length.
>> Although we are not 100% sure of the cause before getting the dev tree
>> dump, I'm already surprised that we do not have any checks on dev tree.
>>
>> Currently we only do the dev-extent verification at mount time, but if the
>> corruption is caused by memory bitflip, we really want to catch it before
>> writing the corruption to the storage.
>>
>> Furthermore the dev extent items has the following key definition:
>>
>> 	(<device id> DEV_EXTENT <physical offset>)
>>
>> Thus we can not just rely on the generic key order check to make sure
>> there is no overlapping.
>>
>> [ENHANCEMENT]
>> Introduce dedicated dev extent checks, including:
>>
>> - Fixed member checks
>>    * chunk_tree should always be BTRFS_CHUNK_TREE_OBJECTID (3)
>>    * chunk_objectid should always be
>>      BTRFS_FIRST_CHUNK_CHUNK_TREE_OBJECTID (256)
>>
>> - Alignment checks
>>    * chunk_offset should be aligned to sectorsize
>>    * length should be aligned to sectorsize
>>    * key.offset should be aligned to sectorsize
>>
>> - Overlap checks
>>    If the previous key is also a dev-extent item, with the same
>>    device id, make sure we do not overlap with the previous dev extent.
>>
>> Reported: Stefan N <stefannnau@gmail.com>
>> Link: https://lore.kernel.org/linux-btrfs/CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Looks like we missed some simple tree item checks indeed.

The original idea is, we have btrfs_verify_dev_extents() at mount time, 
thus it's enough to reject bad dev extents, and no need for tree-checker 
for dev-extents.

But this method doesn't prevent bitflip from sneaking in during runtime.

So in the long run, our sanity checks should:

- Do cross-checks at mount time for critical infrastructure
   To prevent corruption sneaking in undetected.

- Do in-leaf checks at tree-checker
   To prevent corruption reach storage.

- Do extra read-time cross-checks
   Just like the dir item checks we did.

Thanks,
Qu
> 
> Reviewed-by: David Sterba <dsterba@suse.com>

