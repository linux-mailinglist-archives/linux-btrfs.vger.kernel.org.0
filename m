Return-Path: <linux-btrfs+bounces-4409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE9E8A93ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FC1281BF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D78F3D984;
	Thu, 18 Apr 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MTvVhat6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C110A0E
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424970; cv=none; b=VpqkURGcuGExYGyndmnlsx5KyHLeIN5rLAk1lrT8bD+xiPmpdz5UcM0618r96QKAeqyUyJeFjAsCZDoNrD62x+Vc/QFtQdbraiVqwBHPg+l1BAf3TR02+PC/zGcbKsIndw4TECXYzEmsISRdbphhsPzObjAYMjy25rHNVRQ18dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424970; c=relaxed/simple;
	bh=o/pTv5el/hQEx3orz0yvbldltKzQeab7MfeSreWtVF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAk2xx/+sObIDnKnhbik702F0b+k0sBPhkf8IgVb1VfHeyh20XshQn1654HmgNTamFD7isHVze21RXB1iQBncG7pypv5u4CrSTaLuzD+ymZOY5PiJPmzQgg729kr6KCKQAYN5u7AstmsIOUJxO9eY2+zSXCuYG3XV/8MYX/U3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MTvVhat6; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso7283311fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 00:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713424965; x=1714029765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Vd8GrCW/T3TEVrhsBk5dZV3rGew6QXg2eysnc1aDeA=;
        b=MTvVhat62o+F5HjDa3+HuaT2hwxdajAyYi8Lbj6fRNz09tjxVV9Jk/IfB9kBsyXMCN
         IzjFgwuM97rpWGMigr6OvXL6znyV5UfNF+VwxGa+V4CpD8r3PcmJ10VA8q0Zx/xPNsW4
         3mLiL255SHo5Fy7NNP0UiBcS5QKV4yKMp9PzqTbxM/r8vaFrpBNynioWpgI6fwftONat
         4/Dmws8o1GzfBDQHwvAE7OGrbDAwW+S4Ww+TDHsmSzAx4V2bZsYB9/Hb6Lb28114sx/+
         daHE7ECogQDEcjvXmI/tmQLo1+NWfxx5S8jaWdwnK2Ht9TpIU1OJtRnJlAlG7KkpInPg
         3evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424965; x=1714029765;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Vd8GrCW/T3TEVrhsBk5dZV3rGew6QXg2eysnc1aDeA=;
        b=RzXJsfzM24CKaFO67EAa9As+L2+b8ylUsZQ9dzvBw/9EEU5kaE6/EtRKEPR719eUG/
         7G1spz/K7m8xQQDmJVBl7C4U+lfMFCTUiPFUDS6KwR22c8/5TI85FfOmSoxXGSDjm6DG
         UOJMvbdDaiWjy78QBipj/PFlNn5C6ORwDJUjuNGT1r69QlgXIqcrWetVQNAsLl41XMs+
         ZIbmIkmxYzu6xzYCacxMotH9NVcoRlVN+gXcbh8psvtN8ziSybNctCe2VKiCpoOk5zca
         kYFge2Ee+qymkXaztgG/DaAyRel2czbeJNBAFfFWDVIuRutpL3v1fxu6HH+db7OZpwF3
         i8Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU8t+k30ZGSA2XMc62WR4Rn7NNrYq/t5hTpksyCfYgcmE4ElyG20ynOviPnaBZ8grAnaLRLU4pI4rQ06v46Z4vHq5zBlYWPaqbkoqQ=
X-Gm-Message-State: AOJu0YzXDjs4fNo82JayKLS5zC0mJ5/oDB3rXDkm9+Jo8ahrh83UWgQp
	PxaVQISvURwm+xoCx63bUaA8RO4qvvqsX3AteQqoVSIdz7ghEvUCJKCPTS8GspY=
X-Google-Smtp-Source: AGHT+IELU8+DViFH8rc5LOxgE3CnM08yerBmU3kZy09PXM2wZN1uytgKG3c2Vw4Zqdtpg5/5nHrKWQ==
X-Received: by 2002:a05:651c:230c:b0:2d6:c726:ee64 with SMTP id bi12-20020a05651c230c00b002d6c726ee64mr1234447ljb.13.1713424965118;
        Thu, 18 Apr 2024 00:22:45 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id b9-20020a63a109000000b005f77b2c207dsm771525pgf.12.2024.04.18.00.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 00:22:44 -0700 (PDT)
Message-ID: <b2818f72-0158-4caf-9687-9d0ca4672a03@suse.com>
Date: Thu, 18 Apr 2024 16:52:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: report filemap_fdata<write|wait>_range error
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <80c3c9ccb6e7ea366d88f0e5b2798f5bbd3b381c.1713234880.git.anand.jain@oracle.com>
 <1556267cd2fd5f2d560a50b4b169ec4d58c95221.1713334462.git.anand.jain@oracle.com>
 <041bef79-743b-4726-adee-9c0ddf332e6b@gmx.com>
 <d3a646ed-ce67-4380-82f9-920fcbec5300@oracle.com>
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
In-Reply-To: <d3a646ed-ce67-4380-82f9-920fcbec5300@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/18 16:48, Anand Jain 写道:
> 
> 
> On 4/18/24 14:30, Qu Wenruo wrote:
>>
>>
>> 在 2024/4/18 15:44, Anand Jain 写道:
>>> In the function btrfs_write_marked_extents() and in 
>>> __btrfs_wait_marked_extents()
>>> return the actual error if when filemap_fdata<write|wait>_range() fails.
>>>
>>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Looks fine for the patch, although I have a small question.
>>
>> If we failed to write some metadata extents, we break out, meaning there
>> would be dirty metadata still hanging there.
>>
>> Would it be a problem?
>>
> 
> I had the exact same question, but what I discovered is that the
> error originated here will lead to our handle errors and to readonly
> state. So it should be fine.

Yep, I know we would mark the fs error, but would things like 
close_ctree() report other warnings as we still have dirty pages for 
metadata inode?

Thanks,
Qu

> Further, if submit layer write/wait is
> failing there is nothing much we can do as of now. However, in the
> long run we probably should provide an option to fail-safe.
> 
> Thanks, Anand
> 
>> Thanks,
>> Qu
>>> ---
>>> v2: add __btrfs_wait_marked_extents() as well.
>>>
>>>   fs/btrfs/transaction.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>>> index 3e3bcc5f64c6..8c3b3cda1390 100644
>>> --- a/fs/btrfs/transaction.c
>>> +++ b/fs/btrfs/transaction.c
>>> @@ -1156,6 +1156,8 @@ int btrfs_write_marked_extents(struct 
>>> btrfs_fs_info *fs_info,
>>>           else if (wait_writeback)
>>>               werr = filemap_fdatawait_range(mapping, start, end);
>>>           free_extent_state(cached_state);
>>> +        if (werr)
>>> +            break;
>>>           cached_state = NULL;
>>>           cond_resched();
>>>           start = end + 1;
>>> @@ -1198,6 +1200,8 @@ static int __btrfs_wait_marked_extents(struct 
>>> btrfs_fs_info *fs_info,
>>>           if (err)
>>>               werr = err;
>>>           free_extent_state(cached_state);
>>> +        if (werr)
>>> +            break;
>>>           cached_state = NULL;
>>>           cond_resched();
>>>           start = end + 1;
> 

