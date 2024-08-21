Return-Path: <linux-btrfs+bounces-7360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1CC9596AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 10:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7311F21E1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A71A7AC0;
	Wed, 21 Aug 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R1b2xlO5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C549199FB6
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227691; cv=none; b=rpYpc33KDWVi4sziq9FQDLZOiUDte/aRc8RDcvL1D+cpbr7td139WZ17T6JNh1iMvaQgzVfP+cyjW2A3rCWKJ5W18mBvbckTnGmRU+lrweHdYFNLll8haVd67tkFNck7n+Oz0AU7PKj9uMjlRqxqGD23Civy71XWpPoApcS55wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227691; c=relaxed/simple;
	bh=cfuE2+qK4ZhenYYXD2mqJIrQ2s2XcZVCW0Ex4O26i/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBfpWGVFaIfkKPss+jEPjJ0Q/+b+M+jIpPig5Qjzn8AcvcmzRxF3oChgpVQJV9Y3PZHAx5VEyEdxbi34JSdRSbjoW7EV+NT8PYACuxX5Ace99Xr2hxDu+fpi/x2ZHFqqxHTeHtaa4zVq+5GXLLdlE3/oIqMnYHvc6WJmGdIebbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R1b2xlO5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37182eee02dso288585f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724227687; x=1724832487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1sINodkC7Y1ctXOGbKrRfSqe60Nv0l+9VaUpQQmw/4U=;
        b=R1b2xlO5s84RZ5GVJ5cRiYuX1EqEvGvyEhhh5HN7sgfPAKZ8SVjommkeW58w81KbWo
         qQKu5SDWyqiETcIFLrBwmLa/g6j47DZ+kwtz48rlVlCm7Wr9XKonMjnXncAFcGsKblpI
         wt1YJM9fZ5NjJxp+96+JFFNCYoAKiM/F9hS8Hbq43Y2pwIuN3aXuR0EgOLwi765zw56i
         fwKrrJgXFksKmFX4/wXuizKT+xqTzKlDZqPT9bHzHr5exdwjQiP3SuXOSnCbGJJl5Kwa
         f8kZlLjD9dSDAGcPt62AbgzQbJUpAYqzaZDG+4xIjlqoKXBlQ9PQKNl7TbQ2OPuFs+iF
         H4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227687; x=1724832487;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sINodkC7Y1ctXOGbKrRfSqe60Nv0l+9VaUpQQmw/4U=;
        b=X/iqmUUPm8ldy+5oLOzhOVgr0p6XgMx62DqI+sAjM4v4ic2qTDDLV4AMGK/u/Arcgv
         /I//wDM+LsygUCj/1XRQeZu0tZqURvabob8J8nrnTWdv5jE2luxBEgq2n2ppnMwWqZn3
         arv+6rY8WaLyJCeUqp4uLDacEKeVw30I6J1apVXcxbQoDW+WToqexDF2nrNQawrYPMmr
         bHgQJX1TdDoFyUiU4mYP6OjEY9OPcIE2Ftd0LYrHGzDCU2+NyXjmxj5bMz9cSiY2Lx9K
         BMBhpdHNpCEoj6UWToTNkz5Q3eUCgdlGg/Rqqyhlz103zMc68fg95iMap8/00ewsPA5A
         bAHg==
X-Gm-Message-State: AOJu0Ywcw/M+hHxaPHqg7mZztsa1Hc6xxQE53obZNIZmGvZd0RbtolPt
	wUue31YlWX+7LziItLQMdDNrV7P21TDQ6maAcKDv8XppQtcJsL2xFFlLBeEdm1M=
X-Google-Smtp-Source: AGHT+IF6xzk0sT5zAQNk8s1FkSbZIXJRg239VoW0BWobspQRahzV670tZ6pv21uFiuCLbtGMmCZXrw==
X-Received: by 2002:adf:b309:0:b0:371:938c:6f50 with SMTP id ffacd0b85a97d-372fddb92acmr662955f8f.16.1724227687218;
        Wed, 21 Aug 2024 01:08:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd8dc63f89sm451073a12.78.2024.08.21.01.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 01:08:06 -0700 (PDT)
Message-ID: <4d281726-0156-4b56-aa7a-399d8fb1c4da@suse.com>
Date: Wed, 21 Aug 2024 17:38:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: out of space (>865 GB free), filesystem remounts read-only - how
 to recover?
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <f11daee5026d303e673d480f3f812b15@wpkg.org>
 <6b17f157-49c3-4874-898f-68541b2dce0a@gmx.com>
 <6505eaf6b2bdaefa835944c7617d2725@wpkg.org>
 <ef2bec82-8ae1-493e-8f56-5aca164db8bd@suse.com>
 <1084e651c874e828ba117c58e1d2211e@wpkg.org>
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
In-Reply-To: <1084e651c874e828ba117c58e1d2211e@wpkg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/21 17:35, Tomasz Chmielewski 写道:
> On 2024-08-21 09:59, Qu Wenruo wrote:
> 
>>> System,RAID1: Size:8.00MiB, Used:2.30MiB (28.71%)
>>>     /dev/sde1       8.00MiB
>>>     /dev/sdf1       8.00MiB
>>>
>>> Unallocated:
>>>     /dev/sdc1       1.00MiB
>>>     /dev/sdd1       1.00MiB
>>>     /dev/sde1       1.00MiB
>>>     /dev/sdf1       1.00MiB
>>
>> At least one good news is, all your four devices are usage are very 
>> balanced.
>>>     /dev/loop0    100.00GiB
>>
>> You just need to add another device to fulfill the RAID1 requirement.
> 
> So, for example, one more loop device of 100 GB?

Yep.

Thanks,
Qu
> 
> 
>> Then you will still need to remove enough data to get at least 1GiB 
>> for two devices, then you can go balance data to free some space for 
>> your metadata.
> 
> 
> Tomasz

