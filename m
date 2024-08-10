Return-Path: <linux-btrfs+bounces-7085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5E094DC5F
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 13:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275561C20B0F
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD31150996;
	Sat, 10 Aug 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TLyC8HtT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171522BB10
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723287730; cv=none; b=VX21XajAf7N1y5VkWOL+2UCm0ntIKBbgI1462ERphRaOEtqoqjnVeG7Al9N6qQquhzdTDS+cPiiAz7j12z2h2gsEa5ld2h84r37is94ApJUkGp4vv30vFrfnV60HOpSYYJ7AUZG5Fg1BJl765HlCuXOY/GoqLIlA/l0sqMoy7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723287730; c=relaxed/simple;
	bh=JMqm2SEhGM268AyxeHVwEcGY2gA6JZJInzuwrmGkr6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AC9mJfe9yps97ZR+PXT8idx67vtmkiqS9CH3VUcHN+HQo/mqAE4wgwOeSO0Z8UD746uqsD5tnmqh+57PoDcGOZwIyyGUcrSG+Jq18vLmuhy4XZ0VZBPGgBh7JrOtoEBjVJwFkeGwNvc5SSUbzPs4tluyf43hGg3iDmRAt/3mpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TLyC8HtT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04c29588so3822152e87.3
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723287724; x=1723892524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v19RECZTRLNDH4zOhf6rCijByNR5oqWIX7j/fmOvpPM=;
        b=TLyC8HtTQjviTAndOYVW2sHS0crSAoOe67NJ8nXP37DA1LUyhmDIMx803bpddJcnnk
         ShaOZgxQOYVCEmvRoodWqcJACheJv10kG91/RWmC5X1BEBrswarmqryXocKaPR6oPQju
         KHNk3Z3UlSg8wjaWmjQiNPEpx9EImPZua1PLqWG4ezfiBIACajuNY0JveeveIRvaG+vx
         rcsMlUF85qn5J4xD9tezuR25BnV8aBpir3TpIDMM3fN6/ZxeaEwjrlRhtZz3Lo8nOuq3
         7aL7MMqh6xgv7Rf5IVg4Wu/xAK/Ay1cecGgja80vv1bwGTn4USa45p1sWOj3SV0nl9L9
         somA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723287724; x=1723892524;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v19RECZTRLNDH4zOhf6rCijByNR5oqWIX7j/fmOvpPM=;
        b=umDraLYnBnu48mhSMkCTmS2bg3z077Bp2U7cMHRsZZhHa4Vsaljh+V+0D3NrxIUn7m
         hSU7DrzNTR+MM5/OPNBYYdyHWRMWmGd9vT3MJn1FAJ26sZyW1dVve9Ia44/RQDC/5nxH
         SNNIZcGR/y0q/yiyk5MteIJof7hkzdrbACYduqu7/8xlE5qDIuYGYDWMbZbkCYPiamfN
         Iw8CP+Dul6u888Gv1ep2XalUoaX4dcnMf5fFgCarAqAjNI8PUD/hC0nJNxymmtLCnJ02
         NGoUT7HFMKEohKOI5Ye3eikoz+3dvipLZeYi83T2q3c/2hqFz/zqEknTUYAGz//0dump
         h3KA==
X-Forwarded-Encrypted: i=1; AJvYcCUgft6zG9heeR9ru6ystM1idcYPYBzYU9D8Bn1inqH/PUBgLH/amoom/6ZDPyhpnLDCIQZS4wtDpKjfPZT0obj4YJM6AqMbObfrYhk=
X-Gm-Message-State: AOJu0Yxp8q00udW0SuVc4qxmYQjtDUv7aot+dH14GoJWEjKO4rxVAIeX
	kQRfGvZ7nkI8T2UrGghmkhJTRSMKAQAtzvowYYCX8OOjJYH7RpKU+5kc8fJVl0g=
X-Google-Smtp-Source: AGHT+IEZfeDQh88Ml3PguWh6jGGCE4GWlQq/4vOdBUKPG/ZNh1o+Fg3u75CBo76xy/OKhKP35r0pqQ==
X-Received: by 2002:a05:6512:1396:b0:52c:850b:cfc6 with SMTP id 2adb3069b0e04-530eea14691mr3172047e87.38.1723287723382;
        Sat, 10 Aug 2024 04:02:03 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fced97a8sm1343058a91.21.2024.08.10.04.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 04:02:02 -0700 (PDT)
Message-ID: <60774a81-7123-4bc9-b59a-4f845529584c@suse.com>
Date: Sat, 10 Aug 2024 20:31:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Andre KALOUGUINE <andre.kalouguine@ensta-paris.fr>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
 <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
 <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
 <133cc484-f609-4274-a745-6567d7635855@ensta-paris.fr>
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
In-Reply-To: <133cc484-f609-4274-a745-6567d7635855@ensta-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/10 20:04, Andre KALOUGUINE 写道:
> On 8/9/24 9:31 AM, Qu Wenruo wrote:
>> But we do not have such tool, so normally one may go with
>> btrfs-find-root, trying to salvage a good fs or your home subvolume root.
> I attempted btrfs-find-root (without options) and it returned this: 
> https://gist.github.com/Semptum/83ff8f1b590d214b34562d53dea5fddd

Sorry I didn't explain it well enough.

TL;DR, if you are not very familiar with the on-disk btrfs format, it 
will be a hell to follow.


The root id you want to find is either 5 (fs tree) or 256 (if you only 
had one subvolume ever).

If you didn't know your subvolume id (or have created new subvolumes 
before), you have to find tree root first.

In that case, your gist is good enough.

You need to try the first view number from line like:

  Well block 231990525952(gen: 52860 level: 1) seems good, but 
generation/level doesn't match, want gen: 52959 level: 1

The block number 231990525952 is what you want to try.

# btrfs ins dump-tree -b 231990525952 <device>

Then look for something like this:

      item 11 key (256 ROOT_ITEM 0) itemoff 12961 itemsize 439

That bytenr 256 is your home subvolume id.

Then go with "btrfs-find-root -o <subvolid>" to find your home directory.
And grab the block number again from the first several candidates (which 
are the best ones), passing it into btrfs-restore:

# btrfs-restore -f <subvolume block number> <device>


>> Then go with btrfs-restore to salve data.
> 
> I attemted to use the dry run restore command with the tree root it 
> found (275009601536) but the error was the same.

But your chance seems pretty low unfortunately.

For your default btrfs-find-root output, you lost too many generations.
The best root tree we can find is:

Well block 231990525952(gen: 52860 level: 1) seems good, but 
generation/level doesn't match, want gen: 52959 level: 1

But the generation is 52860 but the expected one is 52959.
If it's a real power loss, and the device has proper flush done,
we should have either:

- The current tree root and the previous tree root
   Matching the super generation (52959) and generation -1 (52958)

- The current tree root and the next tree root
   Aka, generation 52959 and generation 52960

E.g. for a properly unmounted btrfs from one of my VM, even if it has 
async discard:

  Superblock thinks the generation is 82269
  Superblock thinks the level is 0
  Found tree root at 33587200 gen 82269 level 0
  Well block 33193984(gen: 82268 level: 0) seems good, but 
generation/level doesn't match, want gen: 82269 level: 0

Furthermore, just like my example, if the async discard is properly 
working, we should not have any older tree root than the previous one.

So your btrfs-find-root shows at least btrfs is not discarding all older 
tree blocks.

So far it looks like either the firmware (of the nvme device) is not 
doing discard correctly, thus wiped out the current and previous tree roots.

Or it's not handling flush (aka, barrier) correctly and cheated that the 
tree roots are properly written to disk, but it's not thus those 
critical tree blocks are just lost during power loss.

Thanks,
Qu
> 
> Thanks
> 
> Best regards,
> 
> Andre
> 

