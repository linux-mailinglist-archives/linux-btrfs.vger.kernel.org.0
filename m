Return-Path: <linux-btrfs+bounces-4012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BA789B421
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 23:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222191C20A94
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 21:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDE44C7B;
	Sun,  7 Apr 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ofv3Qx8B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF23BB47
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Apr 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712525775; cv=none; b=ZRKiLWNiUWhlAw3zgLONL4Zhnb5y3iju4imzP7aq+0+RWoNG9i5RZkdP4olrHE4ipYUKiWir3QO1c3KRzC1/olEEA+oZM81mOzz89lq/oAA0nzbBUF5la3MwRfDqr6cc063941YCke7Yer8IYGZnLbPLrlk7dY6WIwcaHDGIBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712525775; c=relaxed/simple;
	bh=gE5SCr+jF19781ZV4qbdfH/TSmsJKiG6CmYkS0lkJ3M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=seGwMjUSEyO7gH/hyhfyiC+1pIu15By/6U7wz/ywWdFcggjiAwnWHeM2wdnBZ0+3pOPzRnvZyACZ6yu7m9jF1jhp/NyraUvZrm2I+SBXiHwi568eG2+qrjQVn020SHZnGclpBvGl37AyTTrnue8btB0gRy7gTR81lCwhAZDkKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ofv3Qx8B; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so48139411fa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Apr 2024 14:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712525770; x=1713130570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlYfJxXgcLiH1zrptUwMg9duU2AlhS067GoK1TKl5zg=;
        b=Ofv3Qx8Bd4JPHcmWhuzyyOlQPp3WsLR1jFlvhCOMVZqjojLEqrfTGolM9PJPUSQ6sY
         qLiJ6xoS62BmX+N50o5ONDX4UDGDroqwFxd00yjTUIEW9JaUw430jve52+dr7G1eEMMd
         0kigQ4wpoKXSyGFamTeahQn/M3+IVCtYXtrORcHzjRTwwI5VBqMS2LvbDb2OOF5Pp/uT
         HP2+dAENOEEZnuXws3lYPU6f5KcfsqQ/AgX8UEwPusyR+qQLhLynNhJtDTlDXl98PHzp
         Z29Hfio9rsoL2e4GKI3Jv/C2xQCyju8Vz/aZHt/IDXdFX5lhAPd7sEXj5AckuEz3m4lk
         jnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712525770; x=1713130570;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlYfJxXgcLiH1zrptUwMg9duU2AlhS067GoK1TKl5zg=;
        b=PA7t+28vuX/D32ws8V+8+lghNieGOcD2opMKXiXKuO5heg+cEJZG1HDmEDDkvaDGbA
         jzWMevlEPZPqrVKJcoMVO9hM0l96Qr1rutwVdPuzdNhTdYH+/SGjqd20loYfpJVmc4BD
         iMCdMd2vuEht5VEfxiMa63gz2dvW94ZRzi/SmW0mQMzDM0i+Y2XwC4UZFZLFbjqcDpGH
         6DxCnvdJfzKwoioqi3f1zrYoFZEP2pN4lQNmZI0itcnHksJkt25Iyu1NzkwwFKxorgOc
         be8VjeYdyTOAEKPa+qJYDenPmM47cxDE3CbBRUOX3H2/hZU0uWzW+rqb3zT/OdyPyZAH
         XKFw==
X-Gm-Message-State: AOJu0Yx7EnfzMweTL99TuaD0nwGP0k6mdxBIIMKdavuCujvMzBY3Ytan
	x2QlRcrl4pNvaieEypd82+oHaqrwgRlsdLq7gif0orfO8HNW7Rq7mY4KYELWkZnxlULxThSUIIw
	t
X-Google-Smtp-Source: AGHT+IEtrO8p6a/woMwwDUR12cUoRCFJhSAw/om9WsRU/KXzVeot+L+Te5CKja/yTxq/VxDvTTZ4RQ==
X-Received: by 2002:a2e:978c:0:b0:2d6:ed35:5bc1 with SMTP id y12-20020a2e978c000000b002d6ed355bc1mr5271380lji.24.1712525769675;
        Sun, 07 Apr 2024 14:36:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b006eadfbdcc13sm5095986pfo.67.2024.04.07.14.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:36:09 -0700 (PDT)
Message-ID: <08a4bb06-a110-49d1-917f-9fabf56c5dbb@suse.com>
Date: Mon, 8 Apr 2024 07:06:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: scrub: update last_physical more frequently
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, michel.palleau@gmail.com
References: <cover.1709867186.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <cover.1709867186.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping?

Any feedback on this small series?

Thanks,
Qu

在 2024/3/8 13:55, Qu Wenruo 写道:
> There is a report in the mailling list that scrub only updates its
> @last_physical at the end of a chunk.
> In fact, it can be worse if there is a used stripe (aka, some extents
> exist in the stripe) at the chunk boundary.
> As it would skip the @last_physical for that chunk at all.
> 
> With @last_physical not update for a long time, if we cancel the scrub
> halfway and resume, the resumed one scrub would only start at
> @last_physical, meaning a lot of scrubbed extents would be re-scrubbed,
> wasting quite some IO and CPU.
> 
> This patchset would fix it by updateing @last_physical for each finished
> stripe (including both P/Q stripe of RAID56, and all data stripes for
> all profiles), so that even if the scrub is cancelled, we at most
> re-scrub one stripe.
> 
> Qu Wenruo (2):
>    btrfs: extract the stripe length calculation into a helper
>    btrfs: scrub: update last_physical after scrubing one stripe
> 
>   fs/btrfs/scrub.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 

