Return-Path: <linux-btrfs+bounces-5829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725890F9B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D5F282878
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A815B158;
	Wed, 19 Jun 2024 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EWDJhDP0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1EC15ADA4
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718839314; cv=none; b=UjS/2sUtDqW/26ORWbWylkXGgWDfimbwMJiE8ytgp/j/mvHGq4WsWOqH0sNTuHyIoJozEQVEpiK6ix6BzfyzIYMSIFf3QuX9BwilfcuwBLkG/XDT3/BQnnW6mwpI6+Vk6GBWMeJJ3qN+1HZ1pYE8sHTtU1TMw/goqdD+gm+7ijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718839314; c=relaxed/simple;
	bh=pDyiXasF9mQwUYbbCwf/coPWRh83vGOk2WxDSaiShBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ri/LVuu+UwirZYI3iv22AQSFQXNTCFPa+xmpLpz6jgC24xFOU0Kr8Ljpic9q3b0FLNoxzznNK752FDu1aAX0iiexkOBto8ccGTh3/8+7mUMv6kqdTyyrLV4NrgyNuuyKFGWfk17E5JCd7c9AibXITWvWuGSFyQr/PGruRJ8WYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EWDJhDP0; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so2968991fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718839307; x=1719444107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e0wnflayjimDOr+oVJ6Pp3H8NuBoX6Pw8Ez5tW3IngE=;
        b=EWDJhDP0oDoeUlLZwpCviAdmB3a4KgyVmUtZ2dpyGbq8VS7gimTG31wUXwEo1ptgY4
         QV3mmeANvj/ycuxZelie9c6LYDuy5/gEdqdIg+OPw7XgJMcqIp/1nLC0dGAw2xUJOzkG
         z3oojm48rhlP5Cu8gZY1iElScss0XQzv0Hv2rJt8+InU3mkIhS3F04d8Z8cieCEbWF5T
         eq7Mc65KaI/Auyp39wWCImRaPTmh+XEbiIPjgxJIkwvCntC383da/QMZ+5Q5q6R/uojz
         /cKf8he7EMKotBz0PduLE92DTLACfzGAK9B9qds+XCa8Bte2UezJ4Q250KfL1rU0KXy2
         +QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718839307; x=1719444107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0wnflayjimDOr+oVJ6Pp3H8NuBoX6Pw8Ez5tW3IngE=;
        b=A+XW7OWLVv7gBiRaUnHe6uEGv1kII85XGlaF5tA5ldtdnIy6BlSuNbG39Qyts4cPNu
         yNzdAHLNPeSDB4bw9GFX7YEQYi+pSzguRHvNkW1CwODpYWmasHx7h3Wsgwc/FZssG39a
         x/l4NpcNI15Bs1/n7mj+xslkaElhVVPBVGEggpelAc/A+TRqMR1Codwsk0QOYhuV2mZc
         2TXYwquseaCnEeB0ywt9HycXDjfEb3e/gAs8/RoEru1Jcmewinh8kqQaZ5amljSdgc70
         7qEWE9v40/t1l67A85c6VNdzeeER24bIXKdKfshxAbL9juUGvgK2Vjg7EGyMADJVNBbO
         1Dzw==
X-Forwarded-Encrypted: i=1; AJvYcCVFk3NF0p9QuCC9K+A3Gy4Jjk8Y+LdsaS+03zFPlgSytJjrnOVd1wx7Nd3El8iuVUP5rVzkPOMDbxIeD6hKYeap+dIIK/UIduS+uoA=
X-Gm-Message-State: AOJu0YxzSq00eFHeIigtrktLCr+NfwqnMk9KN/dDwYnwn9GPJp2HUUoW
	IwIoUcxwUZ0HnWXTpsah3peVrRsvrLKiiR+l8bcXG2GECwlSIHfi1ieDZOLf7ypMm93BNgkqPgg
	q
X-Google-Smtp-Source: AGHT+IHiffoNE+xJGc1eZzDTnSg52pN1rSy5I+zNxaorFHUuMDasqGSkUbyCMKYUlpQiXPbwcpWQfQ==
X-Received: by 2002:a2e:3109:0:b0:2eb:e01e:3699 with SMTP id 38308e7fff4ca-2ec3ce940admr27341501fa.17.1718839307267;
        Wed, 19 Jun 2024 16:21:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96750esm11197922b3a.53.2024.06.19.16.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 16:21:46 -0700 (PDT)
Message-ID: <1801114a-715d-4c54-bb8f-08fe0c317946@suse.com>
Date: Thu, 20 Jun 2024 08:51:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Error handling fixes
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1718816796.git.dsterba@suse.com>
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
In-Reply-To: <cover.1718816796.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/20 02:38, David Sterba 写道:
> A few replacements of btrfs_handle_fs_error() with transaction abort or
> other means.
> 
> David Sterba (5):
>    btrfs: abort transaction if we don't find extref in
>      btrfs_del_inode_extref()
>    btrfs: only print error message when checking item size in
>      print_extent_item()

I guess it's the usual mailing list problem, but I didn't see the first 
two patches, only 3~5 are in the list.

Thanks,
Qu

>    btrfs: abort transaction on errors in btrfs_free_chunk()
>    btrfs: qgroup: preallocate memory before adding a relation
>    btrfs: qgroup: warn about inconsistent qgroups when relation update
>      fails
> 
>   fs/btrfs/inode-item.c |  4 ++--
>   fs/btrfs/ioctl.c      | 25 +++++++++++++++++++------
>   fs/btrfs/print-tree.c |  2 +-
>   fs/btrfs/qgroup.c     | 25 ++++++++-----------------
>   fs/btrfs/qgroup.h     | 11 ++++++++++-
>   fs/btrfs/volumes.c    | 15 +++++++++------
>   6 files changed, 49 insertions(+), 33 deletions(-)
> 

