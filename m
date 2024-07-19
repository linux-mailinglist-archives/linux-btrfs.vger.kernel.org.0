Return-Path: <linux-btrfs+bounces-6574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE30937454
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 09:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CDF1C21CFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C075914C;
	Fri, 19 Jul 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q39pyaJU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A94F606
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373649; cv=none; b=Jq3dTnpgtDyur9ddjDF5/qzgMTITexHxfCg8jYKnA3X26JbqwD6UPUY3dPwWCLWedk7QGhYiYp3UhEcUxPmIJYgfipzQbg0LZLF+M9cGyREDkPqVQevfOYCdDJaqdLntGo5BF+ralH8Olkig7u2HwlztbwPzZrFdpSdmVcARuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373649; c=relaxed/simple;
	bh=eCmR8lUAfCCn2MuOQwZ40d+wELOAr5Gr72sIDWSszl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ap08ZP4bOHHVcNVIv1gveHQX+3Zww2cK0YTAuicbYbZ9h58nOksC1bXpor/8RWlcdl3nN4QofVFbwwjqOHfeB3XaBJfe1KaggFEJhy2lZNLF6HQKb+6uo8zlvz6eJ0kqjwQ3h8zdOaZit95Hb2FMwfTgOWbfUeh1YHk1wKn5l7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q39pyaJU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eefe705510so18768391fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 00:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721373645; x=1721978445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vLumQuQVUp0KLxed0yiOvpO+methGIgwTW1TKENKErM=;
        b=Q39pyaJUiAvxgReTAnwou2O1i2r/1LWXvvoh+H+9WnZ9q3HB5r4SYvDfIL5WGnhPBo
         QsUa81vAmMS1r8RQ+bj4BCPIXbDSPavyyJevglUArLI5qKRv0mPeu+bS2fMAFE0IBPt4
         wHw+3Lvr5ukkRbI5rMI93W4kxTSgj0L9JztgyDIxtUXTz7RjMG07cLmLh6OlarUW68ay
         WEtiE+e0Y3tkSPM1vAaKs4rQTt0XBzhv+HUa08C5fzgv2ag/AdKVkDXd02xBc0JtJwUP
         cnvhLTrmX08iUjhukxzCR8rjPBpxmCW/pr2bxAqeLicKPoZ7Q1RgQMAlPhkjDm21pw+l
         NTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721373645; x=1721978445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLumQuQVUp0KLxed0yiOvpO+methGIgwTW1TKENKErM=;
        b=qlB5DLHc/CcLh9n277vR3wIttjmqri6F3ukOBAak/aN290Tt/lNBJB31anaWw9Q/4r
         3GmYu5jczttZgneYiA/UVcVaDPvz1xTyeDZ7tUUsYrP4UPSvybWCp7UjkauSiiS8wcbu
         O4wxy7ZgqW1sxV0G9FwpvscFwiMaHdgmOVwT8E/rtjhWXzXCJO0KGhtrTHyfnxSzNFll
         5D9M9+0TVtN2/UwBJ7rGyGpXMWq187VRWFCsnv+AudXOz+ULfv7mU2AzL+5QuNsBQ0sd
         0/C35vAZC8qSX14gAX1MYtjbbHfhVWJu94pjn8FQTTbwBw8DoljEUxcCf5r8nscILQAD
         AbIQ==
X-Gm-Message-State: AOJu0YwJR41HjaoA2OKPrXv3mjbjh8saulVn8rCvEOrlFFZ5x/pgTIFS
	4Dj+jSfVziY6m1uGb3Wus6V83DrfyQ9yk+fNXVSAWPyMcwcRH3iVEIAyWlQ1rveH++LiH/w1Qd/
	r
X-Google-Smtp-Source: AGHT+IEVCj1F7K9/r2FGc/llLP4swJG1AUHhiztgC38YjwfvKKsnVumjy3scTtWsFsbygGm3nG6iBg==
X-Received: by 2002:a2e:8750:0:b0:2ee:dae6:6cda with SMTP id 38308e7fff4ca-2ef05d42e74mr31368921fa.43.1721373645332;
        Fri, 19 Jul 2024 00:20:45 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d26918sm7509125ad.229.2024.07.19.00.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 00:20:44 -0700 (PDT)
Message-ID: <78c6787c-0ddb-4c9a-b235-323f6133941a@suse.com>
Date: Fri, 19 Jul 2024 16:50:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] btrfs: always uses root memcgroup for
 filemap_add_folio()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-btrfs@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>
References: <cover.1721363035.git.wqu@suse.com>
 <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>
 <ZpoQ_28XHCUO9_TT@tiehlicka> <99334ebf-583a-4295-be52-118c253d5fca@gmx.com>
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
In-Reply-To: <99334ebf-583a-4295-be52-118c253d5fca@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/19 16:46, Qu Wenruo 写道:
> 
> 
> 在 2024/7/19 16:38, Michal Hocko 写道:
>> On Fri 19-07-24 14:19:05, Qu Wenruo wrote:
>> [...]
>>> @@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct 
>>> extent_buffer *eb, int i,
>>>       ASSERT(eb->folios[i]);
>>>
>>>   retry:
>>> +    /*
>>> +     * Btree inode is a btrfs internal inode, and not exposed to any
>>> +     * user.
>>> +     * Furthermore we do not want any cgroup limits on this inode.
>>> +     * So we always use root_mem_cgroup as our active memcg when 
>>> attaching
>>> +     * the folios.
>>> +     */
>>> +    old_memcg = set_active_memcg(root_mem_cgroup);
>>>       ret = filemap_add_folio(mapping, eb->folios[i], index + i,
>>>                   GFP_NOFS | __GFP_NOFAIL);
>>> +    set_active_memcg(old_memcg);
>>
>> I do not think this will compile with CONFIG_MEMCG=n
> 
> My bad.
> 
> I'll fix it from the btrfs part so that @root_mem_cgroup would be
> changed to NULL for the CONFIG_MEMCG=n case.
> 
> Meanwhile, can we just define root_mem_cgroup as NULL globally?

Of course, I mean for the CONFIG_MEMCG=n case.

Thanks,
Qu

> That looks more reasonable to me, and if that's fine I can send out an
> extra patch just for that.
> 
> Thanks,
> Qu
> 
>>
>>>       if (!ret)
>>>           goto finish;
>>>
>>> -- 
>>> 2.45.2
>>

