Return-Path: <linux-btrfs+bounces-3588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134188B963
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 05:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC8A1F3D288
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 04:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24E12A17E;
	Tue, 26 Mar 2024 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uae3Cbea"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220A129A83
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426751; cv=none; b=osCSd+B+T+G1qb9D9QxWBc0zB8MwBfOjNov9NdZBGoPk+SN7O0a0yigrkMYvLRe+q5ZESWMhqTz/DUYDiqd+mtN3e8OdVnS0+Grcn5ogJhUw5tPBgynwc0zqrtR99198lFQ/Ea7K4JbMaFJDKa2QyBirDKc6b20n7cstz9TU3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426751; c=relaxed/simple;
	bh=sfUjwEC/qCkBYT4yIBPEQpVbRoSjvYbFM5mkUSmhzcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IEB4ApFSKC9sKvVAZbG5cpcQmVlaHOvrogODFcZgw3Oa0mfShiqXx6gGv3uTjljTQ0gQ3wjIWEb+oxUd0q+tC5uT2rvtlE9LobOdTyKUfgyLvT7ESf8KsqJ3lOvE8R2364a7gNFqOpjnUxc0mamvHDwdAmCjhwurMAE57uDi7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uae3Cbea; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so69744481fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 21:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711426747; x=1712031547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ePBYwtLdc2G/kuy0zsVk4kmZlWTXWN5ZLmB/IskgSlE=;
        b=Uae3CbeayhTA35CZVHEeFP5qWM9KiaHGCaAk17Ecs23VwaJfYniI027AIEa72g+gIX
         6D8Z3MV5003QtiUhTHYyRoJWAFNeA3khzpWylbkeQtjtDFMGzoVobx6LPsye2cFh5gXy
         m8eskZQmak8NXtdvyw0hWw2bPkP84mJtXVZQ+gW0ugFipXiqmj7fvM8RwrcEdZgdgBmS
         Z9bhbt33qFxxA6BXyVgFi3tHx24CjjfoOhz22Y8GyUNlGD+SyUnGSR5031seuwxKmNFW
         HwTYDx7YcIrBp2bFEtRi0+xgPRlfkLxrAF5akOgPhHQIWqOnxZY/F1erf5uJ0Zjb7FFQ
         nzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426747; x=1712031547;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePBYwtLdc2G/kuy0zsVk4kmZlWTXWN5ZLmB/IskgSlE=;
        b=FbVO5wxtb1Q4FucV/5UshIkK55kMu1OjakW9dlr8k2B0t1HrRhR6Mzh+mPJri4XwO8
         nybiWjVWJGSyoMcRnB9MHTITFm/APOyKGcr6HjLILcCUIbqqxIctoRQFckXB3mKoeCeo
         gvVSdLUJP9M8kya1nxvIQ778UJt9sMS8f393pL5QudkEU+sYk/D63AZd6o88GsUDB5bY
         FS4mrFvXTOZKhvtkeSmDt2cKvRtii+nyDclw11Uvy/eLpxv0jNuNdVnb1HDnUYP4nKY4
         K/Ux8Fe7UL72PyksB4aFHoEfiOM6REVvsDSlYtMZC5DbkbHK1bN1uzWXV+Xa37eGPxno
         Egjg==
X-Forwarded-Encrypted: i=1; AJvYcCWxqcBrf+Yz/WGNSQb0umMV8FHtOoE1n9Ss9gDaBHE+Z/m1zWgMrOYAjhL4Alhcxh+dH6mEzhlYXO1kAwKr9190C7HaBFtkEXSYWls=
X-Gm-Message-State: AOJu0YxBzJh2TZfNweIx5OpQsxLcEHvBpAPB+x25Je1CIK3XWMmFATUX
	lWyBeQyWFE2ibTIup+OlYGPcpYamPlC8TyCPhUsAWkZbomxT8+TxphuhYHsyCUJEUKH6jHpK6kl
	H
X-Google-Smtp-Source: AGHT+IGCdx2dppGgxI2JQPJ/O9U+rYa9J6RgOZLvbHyy6uTT0pRw3bGbIvmv1F5Ll+P0OWIJOJVMhg==
X-Received: by 2002:a2e:b6d1:0:b0:2d6:c630:c2bb with SMTP id m17-20020a2eb6d1000000b002d6c630c2bbmr4266394ljo.35.1711426747103;
        Mon, 25 Mar 2024 21:19:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 5-20020a056a00072500b006e56277fd45sm4954300pfm.190.2024.03.25.21.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 21:19:06 -0700 (PDT)
Message-ID: <43137d1c-86d1-44b7-affb-d1080cc1ff56@suse.com>
Date: Tue, 26 Mar 2024 14:49:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs forced readonly
To: jane <jane@janeirl.dev>, linux-btrfs@vger.kernel.org
References: <bdcc14cf-7e12-4ae7-92c6-a4924158ea64@janeirl.dev>
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
In-Reply-To: <bdcc14cf-7e12-4ae7-92c6-a4924158ea64@janeirl.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 14:30, jane 写道:
> hello,
> 
> my root mounted btrfs file system becomes forced readonly whenever i try
> to delete a certain directory.
> 
> dmesg output is attached.
> 
> btrfs-check output:
> [1/7] checking root items
> [2/7] checking extents
> data extent[89300512768, 40960] referencer count mismatch (root 257 owner 2995086 offset 258342912) wanted 0 have 1
> data extent[89300512768, 40960] bytenr mimsmatch, extent item bytenr 89300512768 file item bytenr 0
> data extent[89300512768, 40960] referencer count mismatch (root 262401 owner 2995086 offset 258342912) wanted 1 have 0

257 = 0x101
262401 = 0x40101

Another typical memory bitflip from hardware.

Please run memtest to make sure your hardware memory is correct, and 
replace the DIMM if possible.

After all of this, "btrfs check --repair" should be able to repair it.

Thanks,
Qu

> backpointer mismatch on [89300512768 40960]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-1d6b7e71-1055-4632-a647-99391f9e4196
> UUID: 8b26e8c1-2566-4991-a0c4-e64da9a46607
> found 121319567360 bytes used, error(s) found
> total csum bytes: 116268816
> total tree bytes: 2147565568
> total fs tree bytes: 1852407808
> total extent tree bytes: 142704640
> btree space waste bytes: 420429213
> file data blocks allocated: 439455162368
>   referenced 173529853952
> 
> btrfs-scrub output:
> UUID:             8b26e8c1-2566-4991-a0c4-e64da9a46607
> Scrub started:    Mon Mar 25 22:59:39 2024
> Status:           running
> Duration:         0:01:50
> Time left:        0:18:58
> ETA:              Mon Mar 25 23:20:31 2024
> Total to scrub:   114.99GiB
> Bytes scrubbed:   10.13GiB  (8.81%)
> Rate:             94.31MiB/s
> Error summary:    no errors found
> 
> $ uname -a
> Linux jane-fedora 6.2.14-300.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon May  1 00:55:28 UTC 2023 x86_64 GNU/Linux
> 
> $ btrfs --version
> btrfs-progs v6.2.2
> 
> $ btrfs fi show
> Label: 'fedora_localhost-live'  uuid: 8b26e8c1-2566-4991-a0c4-e64da9a46607
> 	Total devices 1 FS bytes used 113.02GiB
> 	devid    1 size 149.27GiB used 118.07GiB path /dev/mapper/luks-1d6b7e71-1055-4632-a647-99391f9e4196
> 
> $ btrfs fi df /
> Data, single: total=112.01GiB, used=111.02GiB
> System, DUP: total=32.00MiB, used=16.00KiB
> Metadata, DUP: total=3.00GiB, used=2.00GiB
> GlobalReserve, single: total=368.64MiB, used=0.00B
> 
> please let me know if there's anything i can do to fix this.
> 
> thanks a lot,
> jane

