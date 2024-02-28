Return-Path: <linux-btrfs+bounces-2881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1936786BB1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 23:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46F328B04E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 22:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83472917;
	Wed, 28 Feb 2024 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ATBM0gBA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AC363
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160979; cv=none; b=S5kvGzI9KRSkgmJPYxVjmDjPO9cf1j1Y+MM/xAbn1iCtdr0qkoiDR0ucgdEVFdJsIuG3dQ7dsWVVKquH78CCc3eKEqCAeb8PzFE07FpvDWKTR7rqqtCJG3AD+jf3HvPKzq/E1jp5CIxvXRoZY+Y3EPg+u6rWfv00pZwJiGexgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160979; c=relaxed/simple;
	bh=pWmaikzDdFCj0T016/wIhTWMdTp0FXfAUq7R9LsblNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF5Wq7EDp+7g6FH2JY2VwGhEYSMnE64gmg5WG6OiVtw6OUxBWD0Qt0euigrYt+a+7o0RRWqI3VQZlUeu6IE133UfDVXPX/5IRyikibbnnjSs5ttMsWQEl4fpL+tyGCaKteaSBDT4Tos4UAPNAYPn0gIZPQtIOISajgFCJyvl9nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ATBM0gBA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5101cd91017so223918e87.2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709160975; x=1709765775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atyp4jLs+S9Nx+oJ0JTQGnSGrC+UYESuCfEpjxTsOn0=;
        b=ATBM0gBALUUiT6YWxMzhndQ7xPwLMv03CCHhSL4oT0hRg9jNHa0cseDnkf7BGDlC1+
         79BKuyxPnP6Ma5XA5uBFpktw3Z2xoRxJaK9dLr26R46Qiz+GjcolD2oMU+KE4km4xI3y
         FXzVoJawCHV7x6pyy9Fp6jN1QdLcXO3D+el+69w6S2wCoxtA+a20w1HSj/aUXjdTEFfX
         5dloA458BwbmOCUM1d4RSh5mbPatfrzMbC2OhtyyQbfCPT8i4d49Bz0c+SSYpXsMtUt7
         JjD1FdJtqE2xk0iOzdxmWFREoSaE2erzNf8AYYOIkGusw4EKnlFtOm/ARG8HvjYQznQx
         8M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160975; x=1709765775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atyp4jLs+S9Nx+oJ0JTQGnSGrC+UYESuCfEpjxTsOn0=;
        b=kjz+9TufrRGTtkhP6JgfqE25A+3pr30mcWq23ghYLhbdkZkt+Cqeq+ozFhyJFKJ7xt
         tKd30z8vJzEOFrx/QW6Sf5VlwDuf5Pqy3M4GeK/lr0pM9XNHWN11XXplOsNgwz/5SdWj
         pDdn8+KHR7taKM3xZB/Wvv8K7BhiFRaR1jDgiobrKScbH3shZVnFIDTAugr82Otkb8K/
         WZ8GyuZXVQCgrGOYDpJYuAe3X/vG1KM1+ze17a0Ru7PqCd6qu+MhMqnBgq5T5OfZ3lwJ
         Agpva94Qe35ydz1+H/NSu5smV12fUKvXyzh4fJgCBV8STVn+h7mIl/87u0TT7BfehNG0
         ESvg==
X-Gm-Message-State: AOJu0Yz5BrNYzt3jket7D4G76mehTCCuPOOGE7TOsuOccLShskY+K3mI
	+Ab79xvIu61WsRTWQs3Sa5vu77CPkQks4HArl9LQaVezgAFJaGtMW6S9Iyq92zI=
X-Google-Smtp-Source: AGHT+IGsBjG0zpKobZvPBa6cMNZpzbo/mLOzaTSHP48axMP1cr1NIQzVE3XBITroFnPG/HQ+WZMAog==
X-Received: by 2002:ac2:5327:0:b0:512:ed25:a464 with SMTP id f7-20020ac25327000000b00512ed25a464mr187711lfh.5.1709160974971;
        Wed, 28 Feb 2024 14:56:14 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id p6-20020a170903248600b001dba739d15bsm3829151plw.76.2024.02.28.14.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:56:14 -0800 (PST)
Message-ID: <6a2730df-44eb-4076-930b-73f75a238ed4@suse.com>
Date: Thu, 29 Feb 2024 09:26:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: allow quick inherit if a snapshot if
 created and added to the same parent
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <5dea98d4f3749f895402164c3cba61b176ff3b2e.1708919464.git.wqu@suse.com>
 <20240228140142.GK17966@twin.jikos.cz>
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
In-Reply-To: <20240228140142.GK17966@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/29 00:31, David Sterba 写道:
> On Mon, Feb 26, 2024 at 02:21:13PM +1030, Qu Wenruo wrote:
>> Currently "btrfs subvolume snapshot -i <qgroupid>" would always mark the
>> qgroup inconsistent.
>>
>> This can be annoying if the fs has a lot of snapshots, and needs qgroup
>> to get the accounting for the amount of bytes it can free for each
>> snapshot.
>>
>> Although we have the new simple quote as a solution, there is also a
>> case where we can skip the full scan, if all the following conditions
>> are met:
>>
>> - The source subvolume belongs to a higher level parent qgroup
>> - The parent qgroup already owns all its bytes exclusively
>> - The new snapshot is also added to the same parent qgroup
>>
>> In that case, we only need to add nodesize to the parent qgroup and
>> avoid a full rescan.
> 
> Sounds reasonable and safe.
>>
>> This patch would add the extra quick accounting update for such inherit.
> 
> "Add th extra ..."
> 
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
>>   fs/btrfs/qgroup.c | 74 ++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 67 insertions(+), 7 deletions(-)
>>
>> +static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
>> +					 u64 srcid, u64 parentid)
>> +{
>> +	struct btrfs_qgroup *src;
>> +	struct btrfs_qgroup *parent;
>> +	struct btrfs_qgroup_list *list;
>> +	int nr_parents = 0;
>> +
>> +	src = find_qgroup_rb(fs_info, srcid);
>> +	if (!src)
>> +		return -ENOENT;
>> +	parent = find_qgroup_rb(fs_info, parentid);
>> +	if (!parent)
>> +		return -ENOENT;
>> +
>> +	list_for_each_entry(list, &src->groups, next_group) {
>> +		/* The parent is not the same, quick update not possible. */
>> +		if (list->group->qgroupid != parentid)
>> +			return 1;
>> +		nr_parents++;
>> +	}
>> +	/*
>> +	 * The source has multiple parents, do not bother it and require a
>> +	 * full rescan.
>> +	 */
>> +	if (nr_parents != 1)
>> +		return 1;
> 
> You can put the check to the list_for_each above so it does not continue
> once it's known that there are more parent qgroups.

Let me check if I can do a single line check to make sure a list only 
contains one entry.

Thanks,
Qu

