Return-Path: <linux-btrfs+bounces-5830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C685F90F9C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 01:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48339B21EFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 23:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319015B553;
	Wed, 19 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V/7tPmkB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D7762C1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718839502; cv=none; b=ajnVOVk4n+HfNMOcbOQC6dz9rytCUUV8yCbdTcVOGwmjBKGG2IXyZnwix9GE1dqfaC+n9Ea6miqeeG9YswhYNQSDB1Tm0wKG4TT5sFvNgJVscVOfaAMhM9vdw3bxizGOAXCzcw4w1KLFE/yPoLi/Zl0wisYkUDvUcFvpjtJghGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718839502; c=relaxed/simple;
	bh=zyeeDuCpHhuqJ8rFh9Gqyl3Cfzs/eTjgYwi+9ZC7Wmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lK+0qWOOGwXX3khEU1lFN7FHjk0ZDIL2LQE/+sAEHdxN8QdtsM2dkeE6VFoDdkhPVTGL1d2b0+shF/n1QFntFQduV5XEGxFygBCLrNJXN/mfgqdWmJcNiuWuzkkmxX9ES00v13v+vea4zKlz8kGwiDLKAEZb5AnXKZ04JP/SyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V/7tPmkB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so2985031fa.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718839498; x=1719444298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hhTHlVVDHiZG4jZZuCq3Q7IMoXY53eIHTvJn3Jz/vD8=;
        b=V/7tPmkBRI1u0I6JleCdNL+9T2K3w3JP5ttZ/sGx0esK+iIzfszQlrKTWl3uLdMM2C
         r/iN7pYXHFF4nhDfmaJ7wSu71MOSfn9tH6jJixgX/JYn2fl0ZlzN+rCg3DSZ+EXZ/Unb
         Qkq1v2IWraebHZu28z3t18tVU6Wq+dgLhcYCe52rDtUXp2tSDnS84hRJLVtX/8b4hgYm
         fJ1v7to4ct0yyWsW6vE8bOfX7A2gH51ccnAYbzzS/bwDwGs3NgQE1KLJyBc1dvZfhl/v
         GqFdvhY+ZoKFnsnSkKOAR0t1y3GK3WcY603SjC6TZinO+WAmpeHgB65dKoHxCg0IANVP
         8bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718839498; x=1719444298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhTHlVVDHiZG4jZZuCq3Q7IMoXY53eIHTvJn3Jz/vD8=;
        b=sWv4/ucSmJuJX286XWNY/WKoE5z+YRmSXsoDCIffs36CjZqw7E8E88D64EmlI0QkKe
         +dw4hYWIXQNBRS2myYejXoeFnf75zjojRaMUJ5cIisyjcBCFpdUGGQWhFt0XI6YOlfjK
         ofZpkFZMJHBm8ECFA8QETXaJapSmKN3tsQwekEtjjmX1DIdFq638KEf6IG7JAZ859agK
         1vBg+h21okUtBRmOMR4nyrzmP/e8JFwUumCzmVYtaG++osXEsGOiAVODTDcr5PHOBDeQ
         YTUPhbfWVc3Q5znfKI0PD8strWLXbtJqFi4tweOF77rRjv9nmkAulG6F9A2bQDiID08n
         xlGA==
X-Forwarded-Encrypted: i=1; AJvYcCWUAZa7A3xG5rJActdrr+EAaUqpaDKV7+3mYxbnJ3gx3Us8QAnzfONBcDowyHKshEWbcq1ie52eI+ejOy752QoFRdczV1HfVNT4lMQ=
X-Gm-Message-State: AOJu0Yx6XlCmW/T/KI4uBb+G5Ek05IXKIq921On0JMoCO0/Tw9sOUb2D
	+8Nq3694uYaNwISrLiStZL8b8udLhjhcwpqUvwl9VNkRA5y0oKN3Xd8sB52oVisWuTfqCGbFZ4Y
	6
X-Google-Smtp-Source: AGHT+IHKiyK/tMRRfgWwGEFS/vU1HaDYE2GpJ6Q6J9gUJ6hjUDwuIeYI5DUhsw7XOo5ItSocYtmQNw==
X-Received: by 2002:a2e:9085:0:b0:2ec:30ee:6972 with SMTP id 38308e7fff4ca-2ec3ced0e89mr24428071fa.24.1718839497618;
        Wed, 19 Jun 2024 16:24:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f998e34324sm38638385ad.45.2024.06.19.16.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 16:24:57 -0700 (PDT)
Message-ID: <e6bddf4c-6817-409b-ba36-3844dc8b8c65@suse.com>
Date: Thu, 20 Jun 2024 08:54:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: some cleanups for btrfs_lookup_extent_info()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1718794792.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1718794792.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/19 20:36, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs. Trivial changes.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Filipe Manana (3):
>    btrfs: remove superfluous metadata check at btrfs_lookup_extent_info()
>    btrfs: reduce nesting for extent processing at btrfs_lookup_extent_info()
>    btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
> 
>   fs/btrfs/extent-tree.c | 48 ++++++++++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 18 deletions(-)
> 

