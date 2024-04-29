Return-Path: <linux-btrfs+bounces-4645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5738B65BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E425C1F22662
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93E194C8A;
	Mon, 29 Apr 2024 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S+8JFZXJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98969194C7A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429767; cv=none; b=L2zQcr9I1DF/hCuCB9gbgvoch/4fNgzAiJTW8IdBbNP9A6YbfjkybPXF9tC7nvlEz80sISNpU29Xe+qJqerQboGcZ1/rMbITw+VNq156Tai253aRFDRst9bEXdKwnNZX5j7k4V8y/UyAm6vFP1V1iDblAdDoVWFZqyNxx8tTNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429767; c=relaxed/simple;
	bh=uoZFgw2KtOLQh77eCuxijMYDSWaRyS+Cc4YXEmd4PSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diMzr0oTDuDZ0x4TcPcb+vp+EQIYnOm4QtvKTfCgExq6Xw2JganXK+KAI/ggKYBfr/iZ/ujwIPQB+WQI08yi5k5MfW7I5imsX3V2842cldR1lLX10Cnru9x6XiiemGAdD3P/SQyxjKPDxkJXg2C2Zi0r1+e6yIW/CSNo1C+gLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S+8JFZXJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so12661841fa.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714429763; x=1715034563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd7cdwE2QiT8NF57naSj6tU12MFL03a9rfZv/c5f8q4=;
        b=S+8JFZXJ6ebKjP7fjzZvhsFji366WNTt1WTwNREni6tlBAxB76LpqlsCjgC56krIav
         mnrHgO6NKtosBoIAakU5pV0dGo5XajUWQgPCwImAXRyR1QidHbZqu4jKQBUGgOzPshAp
         FMcIrE28Kf98oEi/Qd/6IF4cbqTgoBLm4HIQCGJfZYh268QHUlvlHgT86mQBd1nDz9e4
         Tl7h9yGpQLhUx1ALSRzroYRhkxChWgydSwuwiVnEp9JsFvdnPDrainMXtdiF9Xi+s8j+
         FGpD4/SztvSSYw7EfE5Z80TscapV0pgzcjQ1GRrn1yd9kaqfsq+eX1DoYoWsxBVmu3de
         yCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429763; x=1715034563;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd7cdwE2QiT8NF57naSj6tU12MFL03a9rfZv/c5f8q4=;
        b=a2Z/hIg9KZNHDsjIEuQnovw37LKC8LZYKhkQRhAN7k5b7DOk6duQWSvjeGUyV7ezof
         kSLHctLO4sFI8VcyWkCVGoH+rG0qC1A+G/J0cJn5g8rQWwxjGvrJDMSsetUL/6MmF1DO
         JQC49ruF89fjIx7FLFWYHE3wum4oa/9UhF08s6s9cFPw+QJ96ozKIgN++pMKFJyCH+MN
         KSchOkFSy7cSXHne1E+DL1sZXNlbmG1Q0URogDj+akd3b/FKQzQzWw5TwWxT6TycbvG9
         i/Xyow/B/OaPZvmIWzEuwIT04opRJU5F0erVK4KUh3Tl0Tw7C+RK4ImasZMOLh/+2HKl
         jpVw==
X-Gm-Message-State: AOJu0Yzg/Vu+55dqLBFSaQN/UKigxD9SJ+6zj1VDWmuC+NXoCZyJ7fME
	maCK4ytB58EQBtlo51dgYxRos2JXMjyfb9OUk8O720IS37ELKplEf6qSTQhL59o=
X-Google-Smtp-Source: AGHT+IGHh9ooQbpWid71S39BUjs/F1JIXDktZds/Uj/MmwhJ1Zgjsi7PXUIoT78U6QGZJdO4BetioQ==
X-Received: by 2002:a2e:a789:0:b0:2e0:9ab7:22af with SMTP id c9-20020a2ea789000000b002e09ab722afmr2239456ljf.53.1714429762707;
        Mon, 29 Apr 2024 15:29:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id f25-20020a056a000b1900b006ed97aa7975sm19798621pfu.111.2024.04.29.15.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 15:29:22 -0700 (PDT)
Message-ID: <5dc104ea-7dbb-41a5-b170-5beba73ce583@suse.com>
Date: Tue, 30 Apr 2024 07:59:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: slightly loose the requirement for qgroup
 removal
To: Boris Burkov <boris@bur.io>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1713519718.git.wqu@suse.com>
 <3fa525bceeec6096ddd131da98036e07b9947c9c.1713519718.git.wqu@suse.com>
 <20240429124741.GA21573@zen.localdomain>
 <d817e2ba-799c-4c88-b5b6-98b8e7233687@gmx.com>
 <20240429221956.GA36465@zen.localdomain>
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
In-Reply-To: <20240429221956.GA36465@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/30 07:49, Boris Burkov 写道:
> On Tue, Apr 30, 2024 at 07:30:58AM +0930, Qu Wenruo wrote:
[...]
>>
>> I'm totally fine to do it conditional, although I'd also like to get
>> feedback on dropping the numbers from parent qgroup (so we can do it for
>> both qgroup and squota).
>>
>> Would the auto drop for parent numbers be a solution?
> 
> It's a good question. It never occurred to me until this discussion
> today.
> 
> Thinking out loud, squotas as a feature is already "comfortable" with
> unaccounted space. If you enable it on a live FS, all the extents that
> already exist are unaccounted, so there is no objection on that front.
> 
> I think from a container isolation perspective, the current behavior
> makes more sense than auto dropping from the parent on subvol delete to
> allow cleaning up the qgroup.
> 
> Suppose we create a container wrapping parent qgroup with ID 1/100. To
> enforce a limit on the container customer, we set some limit on 1/100.
> Then we create a container subvol and put 0/svid0 into 1/100. The
> customer gets to do stuff in the subvol. They are a fancy customer and
> create a subvol svid1, snapshot it svid2, and delete svid1.
> 
> svid1 and svid2 are created in the subvol of id svid0, so auto-inheritance
> ensured that 1/100 was the parent of 0/svid1 and 0/svid2, but now
> deleting svid1 frees all that customer usage from 1/100 and allows the
> customer to escape the limit. This is obviously quite undesirable, and
> wouldn't require a particularly malicious customer to hit.

OK, got your point. Thanks for the detailed explanation, and I can not 
come up with any alternative so far.

So I'll make the qgroup drop to have an extra condition for squota, so 
that a squota qgroup can only be dropped when:

1) The subvolume is fully dropped
    The same one for both regular qgroup and squota

2) The number are all zero
    This would be squota specific one.

So that the numbers would still be correct while regular qgroup can 
still handle auto-deletion for inconsistent case.

Thanks,
Qu

> 
> Boris
> 
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Boris
>>>
>>>> +	key.objectid = qgroup->qgroupid;
>>>> +	key.type = BTRFS_ROOT_ITEM_KEY;
>>>> +	key.offset = -1ULL;
>>>> +	path = btrfs_alloc_path();
>>>> +	if (!path)
>>>> +		return false;
>>>> +
>>>> +	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
>>>> +	btrfs_free_path(path);
>>>> +	if (ret > 0)
>>>> +		return true;
>>>> +	return false;
>>>>    }
>>>>
>>>>    int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>>>> @@ -1764,7 +1789,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>>>>    		goto out;
>>>>    	}
>>>>
>>>> -	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
>>>> +	if (!can_delete_qgroup(fs_info, qgroup)) {
>>>>    		ret = -EBUSY;
>>>>    		goto out;
>>>>    	}
>>>> @@ -1789,6 +1814,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>>>>    	}
>>>>
>>>>    	spin_lock(&fs_info->qgroup_lock);
>>>> +	/*
>>>> +	 * Warn on reserved space. The subvolume should has no child nor
>>>> +	 * corresponding subvolume.
>>>> +	 * Thus its reserved space should all be zero, no matter if qgroup
>>>> +	 * is consistent or the mode.
>>>> +	 */
>>>> +	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
>>>> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
>>>> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
>>>> +	/*
>>>> +	 * The same for rfer/excl numbers, but that's only if our qgroup is
>>>> +	 * consistent and if it's in regular qgroup mode.
>>>> +	 * For simple mode it's not as accurate thus we can hit non-zero values
>>>> +	 * very frequently.
>>>> +	 */
>>>> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
>>>> +	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
>>>> +		if (WARN_ON(qgroup->rfer || qgroup->excl ||
>>>> +			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
>>>> +			btrfs_warn_rl(fs_info,
>>>> +"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
>>>> +				      btrfs_qgroup_level(qgroup->qgroupid),
>>>> +				      btrfs_qgroup_subvolid(qgroup->qgroupid),
>>>> +				      qgroup->rfer,
>>>> +				      qgroup->rfer_cmpr,
>>>> +				      qgroup->excl,
>>>> +				      qgroup->excl_cmpr);
>>>> +			qgroup_mark_inconsistent(fs_info);
>>>> +		}
>>>> +	}
>>>
>>> If you go ahead with making it conditional, I would fold this warning
>>> into the check logic. Either way is fine, of course.
>>>
>>>>    	del_qgroup_rb(fs_info, qgroupid);
>>>>    	spin_unlock(&fs_info->qgroup_lock);
>>>>
>>>> --
>>>> 2.44.0
>>>>
>>>

