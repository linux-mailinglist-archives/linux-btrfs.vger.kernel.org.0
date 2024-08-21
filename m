Return-Path: <linux-btrfs+bounces-7358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D45959684
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF0B1F215C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562191B5EDF;
	Wed, 21 Aug 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JH8JLBwL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9001B5ED8
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227156; cv=none; b=TrEQVABdy7R6hkpOVFgE5KNUsBXtzs4wBTaJdGnnJeeq5Kgg+zSZQ1SwwX5nCQz+L0nWHDxXXq/MN5ncgftkfefI7/NjmIDZM0ZJ0qOVkHRCmUGdF7ylkJ1y9VZgcACWl17xt6A64gdecGYrwURdQAv0EasRfly3Y7aEuEIYCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227156; c=relaxed/simple;
	bh=8TqsxMXjMsFbjOyzwa65DYMaYhopRNjOlyxVvyLo7bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CK2REBITB2/Fogc47KYNyH/4x2UrFnf6rFae5AX1fKdS2AAalyMHCnQJjmm2l3EuApdRcenJ1W5ClL9NK3gcIwxPuKzDz7N57BRYsWVVm6FfyYoNzPdFWKyJITGSlGBzCi64ifFebnqeQsaDtyFxoE3w1hKofEz86FoefaaJg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JH8JLBwL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371ba7e46easo1755881f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724227152; x=1724831952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v2Mum6mWa0zhKw+LAu50HyGPHd8Zi+ysRzbLhxF67X4=;
        b=JH8JLBwLRkcRxeovsuZvkzl881nG5dz9iL5OjVRp46DIkQ16209KgnxyEyU6tvC58A
         FGc4wxLGe46Hzcm5Tg/oahwqQSWmH8+PWRZIz1EOuPNijKnphazlIPuoHsZDKaHzxsQ/
         pbqlA5/qf0jNP/DglZmPciJDpKG+eTNea2T8+J623JzmONGjtf+pt/MuoT/v/VhcRw+K
         R4/JrcWiBX5U2q0Fyh4mDKMpqxWJ04vxs3gfz1guXYuldioU4E4IJIZ+fRYG/XDZFXcY
         jGp8VRQGcuWB/r4OL6kYDRbZ1xJZrHOsjKn7XXThzm2OsmG4zp/v60ZQjCqjH/gmQT93
         RNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227152; x=1724831952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2Mum6mWa0zhKw+LAu50HyGPHd8Zi+ysRzbLhxF67X4=;
        b=siqeT7Xu8Rj538bxqXhJJFViqXM4dnz36kRh/fr7sLeKz535Bg4Jif99QUVNFyIeW4
         PIHoMNkJBOx58n1vq/prnXj20Pvb2+YEhw7sIoGv13hPhTAsmPv021OThJEIOOjURE2T
         Eu3mLxigu8HMQZI4BfMkR3wiiRGUNic7qsM5i47aRMbsy9PcMkQLD2lJh6uhFFGyTbvQ
         vQBEPxVKzIGQa6DRHsdLY8u8J/gZVIpgTLWe2JD585R+BCKO/X0nYKyVZC5tonB27x1m
         6eWlHCE8gMsXWuIUmS6L2aP8YdgJMj2NWstxQTltM+uHter2dYTQKqpcW53T27U3qiuF
         wGlg==
X-Gm-Message-State: AOJu0YzBLicTqE62Yv7AcaNEEq/9RB2LZ3YyrD/jbXF1otNisIqLMd2a
	7+UzCiIrA9EHuW/CG+f0E9/6UcI6lU+fXeV6gc2XIUIMZFaLbfUK5FCWnJmfJph7+9XYXXm92QY
	c
X-Google-Smtp-Source: AGHT+IGHQ6VdPAGQ7EaXxp0tC2ddsnXg4fk9l3UeLWYOwZ2Aa6RePLwXwNb7KyW4n9Z124sm8gbRjw==
X-Received: by 2002:a5d:59a3:0:b0:371:8ec6:f2f0 with SMTP id ffacd0b85a97d-372fd585cfdmr1057036f8f.16.1724227152152;
        Wed, 21 Aug 2024 00:59:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aefa520sm9374167b3a.101.2024.08.21.00.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:59:11 -0700 (PDT)
Message-ID: <ef2bec82-8ae1-493e-8f56-5aca164db8bd@suse.com>
Date: Wed, 21 Aug 2024 17:29:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: out of space (>865 GB free), filesystem remounts read-only - how
 to recover?
To: Tomasz Chmielewski <mangoo@wpkg.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <f11daee5026d303e673d480f3f812b15@wpkg.org>
 <6b17f157-49c3-4874-898f-68541b2dce0a@gmx.com>
 <6505eaf6b2bdaefa835944c7617d2725@wpkg.org>
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
In-Reply-To: <6505eaf6b2bdaefa835944c7617d2725@wpkg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/21 16:56, Tomasz Chmielewski 写道:
> On 2024-08-21 00:09, Qu Wenruo wrote:
>> 在 2024/8/20 23:07, Tomasz Chmielewski 写道:
>>> My 44 TB filesystem was getting full (~865 GB free out of 44 TB in
>>> total), so I thought removing some old data would be a good thing to do.
>>
>> btrfs fi usage output please.
>>
>> I bet it's some btrfs RAID setup, maybe RAID1/10 or RAID1C3/C4 for 
>> metadata.
>> And the disk usages got unbalanced, the metadata overcommitment did a
>> wrong estimation and cause the ENOSPC.
> 
> # btrfs filesystem usage /data1
> Overall:
>      Device size:                  43.75TiB
>      Device allocated:             43.66TiB
>      Device unallocated:          100.00GiB
>      Device missing:                  0.00B
>      Used:                         42.51TiB
>      Free (estimated):            951.71GiB      (min: 926.71GiB)
>      Free (statfs, df):           876.71GiB
>      Data ratio:                       1.33
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 64.00KiB)
>      Multiple profiles:                  no
> 
> Data,RAID5: Size:32.63TiB, Used:31.78TiB (97.38%)
>     /dev/sdc1      10.88TiB
>     /dev/sdd1      10.88TiB
>     /dev/sde1      10.88TiB
>     /dev/sdf1      10.88TiB
> 
> Metadata,RAID1: Size:73.00GiB, Used:71.89GiB (98.48%)
>     /dev/sdc1      37.00GiB
>     /dev/sdd1      37.00GiB
>     /dev/sde1      36.00GiB
>     /dev/sdf1      36.00GiB
> 
> System,RAID1: Size:8.00MiB, Used:2.30MiB (28.71%)
>     /dev/sde1       8.00MiB
>     /dev/sdf1       8.00MiB
> 
> Unallocated:
>     /dev/sdc1       1.00MiB
>     /dev/sdd1       1.00MiB
>     /dev/sde1       1.00MiB
>     /dev/sdf1       1.00MiB
>     /dev/loop0    100.00GiB
> # btrfs filesystem usage /data1
> Overall:
>      Device size:                  43.75TiB
>      Device allocated:             43.66TiB
>      Device unallocated:          100.00GiB
>      Device missing:                  0.00B
>      Used:                         42.51TiB
>      Free (estimated):            951.71GiB      (min: 926.71GiB)
>      Free (statfs, df):           876.71GiB
>      Data ratio:                       1.33
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 64.00KiB)
>      Multiple profiles:                  no
> 
> Data,RAID5: Size:32.63TiB, Used:31.78TiB (97.38%)
>     /dev/sdc1      10.88TiB
>     /dev/sdd1      10.88TiB
>     /dev/sde1      10.88TiB
>     /dev/sdf1      10.88TiB
> 
> Metadata,RAID1: Size:73.00GiB, Used:71.89GiB (98.48%)
>     /dev/sdc1      37.00GiB
>     /dev/sdd1      37.00GiB
>     /dev/sde1      36.00GiB
>     /dev/sdf1      36.00GiB

Your metadata is obviously near full.

But it's still a bug that btrfs free space reservation code didn't 
return ENOSPC early, other than hitting ENOSPC at transaction commit time.

> 
> System,RAID1: Size:8.00MiB, Used:2.30MiB (28.71%)
>     /dev/sde1       8.00MiB
>     /dev/sdf1       8.00MiB
> 
> Unallocated:
>     /dev/sdc1       1.00MiB
>     /dev/sdd1       1.00MiB
>     /dev/sde1       1.00MiB
>     /dev/sdf1       1.00MiB

At least one good news is, all your four devices are usage are very 
balanced.
>     /dev/loop0    100.00GiB

You just need to add another device to fulfill the RAID1 requirement.

Then you will still need to remove enough data to get at least 1GiB for 
two devices, then you can go balance data to free some space for your 
metadata.

Thanks,
Qu
> 
> 
> # btrfs filesystem df /data1
> Data, RAID5: total=32.63TiB, used=31.78TiB
> System, RAID1: total=8.00MiB, used=2.30MiB
> Metadata, RAID1: total=73.00GiB, used=71.89GiB
> GlobalReserve, single: total=512.00MiB, used=64.00KiB
> 
> 
> # btrfs filesystem show /data1
> Label: 'data'  uuid: a80ce575-8c39-4065-80ce-2ca015fa1d51
>          Total devices 5 FS bytes used 31.85TiB
>          devid    1 size 10.91TiB used 10.91TiB path /dev/sdc1
>          devid    2 size 10.91TiB used 10.91TiB path /dev/sdd1
>          devid    3 size 10.91TiB used 10.91TiB path /dev/sde1
>          devid    4 size 10.91TiB used 10.91TiB path /dev/sdf1
>          devid    5 size 100.00GiB used 0.00B path /dev/loop0
> 
> 
> Tomasz
> 

