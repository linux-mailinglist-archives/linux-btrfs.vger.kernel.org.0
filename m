Return-Path: <linux-btrfs+bounces-19604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79192CB029F
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66B7B300A9F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46C2D837E;
	Tue,  9 Dec 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5+mI1xJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B822C21DB
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765289068; cv=none; b=j3tWlLmm8uZeTmcm4jtwbthhyINs5AEJn/pQmbgMfetfsFctc9Pl/bgD8rAS8udi/5hWqFwDlndbOJG5awSCFkDqefSvprYVkAirnM3ugFNEr1/VbzUOsN9rWQ6RlroDK8q/+13SwccDQm8Exd34YNUo1uXU2D8lcQQpvuxAXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765289068; c=relaxed/simple;
	bh=In6vIVbrHIbzMFNYOsPHmGxH3Y1BYAluK2RIf5SopJU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KC0R2RTux/H6RlvqNL5TjoxjY2GhhmsX1PSOTn3a62oNPlaIA/YrnN05NKlPaXyGfxAWRSy7mCqg84t0NxscnOVB1tyQyR0xK/HVCt43J8LbQgH67Psb0w9LWwN1dl0ElhneplHxXZIts9YxT4kjBiA+i1F1lxz5sxiW0CzOmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5+mI1xJ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-297e2736308so8878985ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Dec 2025 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765289066; x=1765893866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZtyDNKTlASKpKO9ls7zRyijKFf/ObxHuhknX9J4dSo=;
        b=T5+mI1xJeUCOzKrH+M6Zg2mwEsQ8Cn7BxlSu/wdM9SNwB0Yi2SYxCzfIJrb3ZOzAUW
         Rta/td40+rPnwXhCNFg1HeH1O/181wVkp+uoZHoR2M4eTzIVDQM+O2wtBmSj2PDby/Ij
         M7MLpQEeGaur29QZkO+7Ozr48uXXCnWJLu/F6hrzbHulXfgl4Ig6zmWGlQe3Fn44/+wL
         sfM52ENIbyBg/+1EAICOzQlT4VvqN067NtcNhCjBqKbXFLRZXjuKvaEiYaHOcZAT3DTD
         r50HahLjjvfe0AAIdHdCTMfuEgfmBBiIBqLF7AVuA3lh3Lbd9BecjJDBXU6Lzwj0MF9h
         klLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765289066; x=1765893866;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZtyDNKTlASKpKO9ls7zRyijKFf/ObxHuhknX9J4dSo=;
        b=f7u+tUuX4C5WnNEdXHfkpO3NgaCy5PcuWE9CR9JKGSdJMsK8AqqcyeFGT1SAlDtz4B
         qpXRYT/vOV8+J+kFqa1kW73epKxzeIq2/XUyp/cusIQJCAJkyNQ7+i3crlavyeYrpucA
         63LGm93kd/u333Z8ywk6kDBEknxnHDtg74Z8h2Vp9tHGTQr/mcvndgX1eH/gxCoR3IzT
         WdeY8Pq7sLDMKN14glLaW9fiXZA/a2gIX/VWLKzIwNbBJgF5Lhkkz677kOqmC5S0i99C
         rKbmRTc8ngyJtGq5ed2UPIjZn1toe9ex5PAtoX0IM9WpfMnHG95BsZZ/aMBcAKl7yQZr
         jCNQ==
X-Gm-Message-State: AOJu0YykpQixXa+eBQVvx/0Lz5kKZ6hi4W3RAK99aSmrWvfGGOJAzxD5
	yyewXecYK2r141UCBnypl64YqA5blN5R2ji5lMl499/IlerTNTJ4ObnhccrGO30x3lMF3w==
X-Gm-Gg: AY/fxX7mA+5LSeoKxP7p3DGzNUZ1zn48q/0FJzQQq0yNjcW2UJ7V4mPEfDWjq1LrU76
	Jy/yIKIclRFnf4Pn58H+vSrurkwVUGo4I3ZdquVtzswKphzzzyMQomq48e1aZ+L2jdykZkh8ZUu
	J1g+pJOK/2dbbG/0VhgfQTZN2C06CmkFdC7uNXWqTBGZMckd9QIJJ6GJHenxjriRNehLSqBhIaX
	vAKOoLUZawfp/1q2J0CFCnLA6nYmtAJ5UzLhHNpb3x+9Nee00bn4HmCs+UJBnbdsvn99R0/p/3w
	yq4elPbiPSis60HMKkhmaSNDlLLFuQ/+ymjC0vuTrBlqj9I7FjuOZXmMxOsj2mmAOLflFpPFyiO
	LTiJIrrl19Gfw5NZAxics4YwLgYqBFdu3w2H+sHFv0ze2Ug1skFFjCUYl7AUAJ1Gvogl1Uv91Cr
	8IXqDUFDUSY3J5z9qymXvv4H/z
X-Google-Smtp-Source: AGHT+IGeM0AIYHjAaZ+wwTFjYOtvxl/8HJjDSX6AdDcslfP2+E5P6tET3nfTrYVqPs55/VBTAmTAwA==
X-Received: by 2002:a17:902:d4c5:b0:297:f3a7:9305 with SMTP id d9443c01a7336-29e96a0c25cmr19366135ad.6.1765289066328;
        Tue, 09 Dec 2025 06:04:26 -0800 (PST)
Received: from [192.168.1.13] ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae33c2e2sm155176905ad.0.2025.12.09.06.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 06:04:25 -0800 (PST)
Message-ID: <c719a2f4-34ff-41ba-814d-104a8cffc464@gmail.com>
Date: Tue, 9 Dec 2025 22:04:20 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
From: Sun Yangkai <sunk67188@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20251209033747.31010-1-sunk67188@gmail.com>
 <20251209033747.31010-5-sunk67188@gmail.com>
 <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
 <ab342845-48b0-40d5-a26f-a49f81a6cf77@gmail.com>
Content-Language: en-US
In-Reply-To: <ab342845-48b0-40d5-a26f-a49f81a6cf77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/12/9 21:57, Sun Yangkai 写道:
> 
> 
> 在 2025/12/9 20:05, Filipe Manana 写道:
>> On Tue, Dec 9, 2025 at 3:38 AM Sun YangKai <sunk67188@gmail.com> wrote:
>>>
>>> There's a common parttern in callers of btrfs_prev_leaf:
>>> p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).
>>>
>>> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
>>> valid slot and cleanup its over complex logic.
>>>
>>> Reading and comparing keys in btrfs_prev_leaf() is unnecessary because
>>> when got a ret>0 from btrfs_search_slot(), slots[0] points to where we
>>> should insert the key.
>>
>> Hell no! path->slots[0] can end up pointing to the original key, which is what
>> should be the location for the computed previous key, and the
>> comments there explain how that can happen.
>>
>>> So just slots[0]-- is enough to get the previous
>>> item.
>>
>> All that logic in btrfs_prev_leaf() is necessary.
>>
>> We release the path and then do a btrfs_search_slot() for the computed
>> previous key, but after the release and before the search, the
>> structure of the tree may have changed, keys moved between leaves, new
>> keys added, previous keys removed, and so on.
>>
>> I left all such cases commented in detail in btrfs_prev_leaf() for a reason...
>>
>> Removing that logic is just wrong and there's no explanation here for it.
>>
>> Thanks.
>>
> 
> Oh, after go deeper into git history, I think I got your point.
> 
> I guess you mean:
> 
> 1) check the key at p->slots[0] is lower than original key(or <= calculated
Sorry, I mean the key at p->nodes[0] with slot==0 here
> previous key) to make sure we're in a previous leaf;
> 2) before 1), we should check that if p is pointing to the original key, we
> should `p->slots[0]--;` so we'll not return the original item.
> 
> I think now I totally get your point. And I still think my way is more simple
> and clear because we don't bother comparing keys and only need to deal with two
> different cases when we got ret==1 from btrfs_search_slot():
> 
> 1) when p->slots[0] == 0, we're searching the lowest key in the whole tree. So
> there's no prev leaf. Just return 1;
> 2) when p->slots[0] != 0, p is pointing to the original item, or other item if
> the original one was removed. But this doesn't matter because after
> p->slots[0]--, we'll get what we want: an item with a key lower than the
> original one(of course also lower than the computed previous key). We get what
> we want, return 0.
> 
> I hope I've make myself clear.
> 
> Thanks.



