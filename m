Return-Path: <linux-btrfs+bounces-3482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD4881B71
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 04:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737AB282092
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529F79C3;
	Thu, 21 Mar 2024 03:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M3vZ4VCG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622E1C05
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991287; cv=none; b=C37Gf/qQt2CjnZgIBvb/JK0xzCoO3HiAC0YQrrc7yDi1gXkBTU12G8EunOghZsuuR1Pk28uCM1x6nX1trR+pIxmAo6KERum0ytDey2GBlYffHja0tT624UpEbQOQ9ZxBwKeqyKfHtGyU2Gr6A2n1T/gPDfojmeWQ+HWPsm7oYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991287; c=relaxed/simple;
	bh=rs+L0AQdC/betsdSuUMEKZdRhyHzLn51lanm39pIQEw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VzLMzy0SBgok5y9tUY4Fa3xc1rp8RAvMbS5x74x1pUDbF306qmBd2htW1nNqlSy07H8EvPNXJPe2l9eSNcbF8phoBuG7jpPiFrxMwmG3o3YYJmZfS+oVsLxhFsrlFUpDE01G2m1o7jm+JCNdJja88+zcY82bgn66c3SPz2120mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M3vZ4VCG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ed6078884so904830f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710991282; x=1711596082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p56a2z+cAqnsTfs06gQP96z3RZVqE4tRXZwlrZMujzU=;
        b=M3vZ4VCGiuKhP6/2zxqQZ7eT6U+JZ/3EH1Mlakad4/e5dY6LBuHSeEuH4snRZLfGYS
         wVNiz6SZYns7xfxJnavMh1eVZ+chWM4lkDPw1WTOXctgT3bPrh622YhGr+l3uwRrKtdF
         nje6Hx0z7lU3HbnUjyM2q1b6OSUZA1Y2KZBXlPytTwgw8yc0g7nYL90Nb1exRZy+aJ5R
         wpnWP3CMUtiWiStPXGiVi/nAPU2ry/c9Tq7plVqrfMfCfOnxPsBsQpeTRgMGrqmI0PM0
         CtyJ5B+OG13NtcylnUXPd0wiXK5U7yuU8DPh9DWCGu0saZQH+dEJwKLQl9AF8Ayxa0RZ
         sing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710991282; x=1711596082;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p56a2z+cAqnsTfs06gQP96z3RZVqE4tRXZwlrZMujzU=;
        b=GgL5J+YQ/IeTUSJTfphOsJ/yDRGBIh9EKDcBG+vaICJ01InCVVGBFCpxd1uE3u//s6
         lmt1/MmzFoLKoHoXOACa+IpRRvLol995acIZRViDKQcQu/L+lhXwIeK+ds91/ig9y0QN
         M04q7o1Pq2jujBIbheRxXNs1HgD+ZpJPqQTJUcISBr+AfV5+7Z9GddQWtzCExzjSQAQk
         wx53VgXcXHzdl9/zoDF3pvo8eSYgVhpSDg0Ybeh8/s2/s6MBTiC8mA6vuw0+w2+OYUtY
         HqnsEnMtHCAO9tYxmsgkwu6NXitusFSVpugHC6F9ONH8PV6Sb/RwMmdHiKnyv5lwDOnk
         PU5A==
X-Gm-Message-State: AOJu0YwxBPw+xzapJX+LrOY7HoT0jvgikbuYHLKNiZ5joB5Z9N0DQpUd
	8KUtwXt1brsvb+XrhXweYiLa1yHm9PgTe7xgv/dnb20Fp1yp0HNXwvGo2dExBCIZ7L/GtJOu5r8
	H
X-Google-Smtp-Source: AGHT+IFEdxd96frBAeXO9TZnYpHNp2TNmekbhI1ZyX6gSxFuEuqe66rrU5EAhDeCIOT5zjrjJ5Kjug==
X-Received: by 2002:adf:e6c9:0:b0:33e:5970:e045 with SMTP id y9-20020adfe6c9000000b0033e5970e045mr1172179wrm.21.1710991282329;
        Wed, 20 Mar 2024 20:21:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id rr3-20020a17090b2b4300b0029e0e9ccf6esm2456124pjb.8.2024.03.20.20.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 20:21:21 -0700 (PDT)
Message-ID: <8f062313-1d73-4bfd-9cf8-259ad0fe4fe0@suse.com>
Date: Thu, 21 Mar 2024 13:51:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs-progs: subvolume-list: add qgroup sizes output
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc: william.brown@suse.com
References: <cover.1701160698.git.wqu@suse.com>
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
In-Reply-To: <cover.1701160698.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A gentle ping?

Any feedback on the new columns?

Thanks,
Qu

在 2023/11/28 19:14, Qu Wenruo 写道:
> ZFS' management tool is way better received than btrfs-progs, one of the
> user-friendly point is the default `zpool list`, which includes the size
> of each subvolume.
> 
> I'm not sure how ZFS handles it, but for btrfs we need qgroups (or the
> faster but slightly less accurate squota) to get the accurate numbers.
> 
> But considering a lot of distro is enabling qgroup by default for
> exactly the same reason, and during the years qgroup itself is also
> under a lot of optimization, I believe adding sizes output for `btrfs
> subvolume list` is an overall benefit for end uesrs.
> 
> This patch would do exactly so, the output example is:
> 
>   # ./btrfs subv list -t /mnt/btrfs/
>   ID	gen	top level	rfer	excl	path
>   --	---	---------	----	----	----
>   256	11	5		1064960	1064960	subvol1
>   257	11	5		4210688	4210688	subvol2
> 
> The extra columns are added depending on if qgroup is enabled, and we
> allow users to force such output, but if qgroup is not enabled and we're
> forced to output such sizes, a warning would be outputted and fill all
> the sizes value as 0.
> 
> Thanks William Brown for the UI suggestion.
> 
> Although there are still some pitfalls, mentioned in the last patch.
> 
> Qu Wenruo (3):
>    btrfs-progs: separate root attributes into a dedicated structure from
>      root_info
>    btrfs-progs: use root_attr structure to pass various attributes
>    btrfs-progs: subvolume-list: output qgroup sizes for subvolumes
> 
>   Documentation/btrfs-subvolume.rst |  12 +-
>   cmds/subvolume-list.c             | 572 ++++++++++++++++++------------
>   2 files changed, 349 insertions(+), 235 deletions(-)
> 
> --
> 2.42.1
> 
> 

