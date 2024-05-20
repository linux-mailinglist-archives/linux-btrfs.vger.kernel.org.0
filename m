Return-Path: <linux-btrfs+bounces-5132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE98CA4DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 01:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD1B1F2175D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2E4CE04;
	Mon, 20 May 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RS0dG17e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DD3E49D
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246247; cv=none; b=u98S4I9pCatBqWn8U+7CZAC6b+CJ+cxcTHDxeyZiCN8H69Al+sTo6rqwVN5wJo/fu5axhPVVD6g3+0hi9RyHxbK5GNGrPYdpFWoAbwcdlDupJxGmMCN/9+JhctAUE9paB4VLSlL68mH2sq2OZUX9uD06XnKMl9IrmeMGjA/vDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246247; c=relaxed/simple;
	bh=iGMHAlHectWiqEZipJpVIIXmjZzQHiSZDC5LTRVjb0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S02eV8egeRJ4/NbaxULOhfigLSZ4cf+Vo7ObMUGH7FilwXbklaVKfWeE1IWV3gZRJbaPpPB++crjzuhAeRSQ2hNIksym5ipPnHDyIWijtgKX7Q7CSsfZ4Gf+uBw0+fT4Xy6vVjuU85PUl2o5/hyPvUqNIIpNoHRFBTknbmgSK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RS0dG17e; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e72b8931caso14326081fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716246243; x=1716851043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzbm6e20xV8DQzvD5HiJQ/rYrr9xwWaWoV03qMkbgAA=;
        b=RS0dG17e68pYISCXgQ5uqJb/HJTABAZM1Ofv8s7ZyYgLE7KC7NcdKQ70Mze30VfwId
         8P740eKgdwpk6c/oB9h5ASoiNW8OWnkUDzQCzyiiyixJ70E20JG+cSICQ8AerFR2mpFQ
         SvCRKUOzD/rk8XT5sH7y99qrg29Kj4JaHf4uwCmC6eQXoSSWx8UeSKWubq91xA0MaGFs
         /MxyYrsolMKWhmLtnGo8+3wtCBK4EbVCEf43RB1tGuDmiCGaP5y6u3gitctaNT5qg9Fp
         9ryMevHCfWyZBfVi/lc0zMG74eRDagVJOiC7ZlJ3uFH6sYcMJYE0q90Ii2J6ZyIsXxQf
         z3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716246243; x=1716851043;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzbm6e20xV8DQzvD5HiJQ/rYrr9xwWaWoV03qMkbgAA=;
        b=GwMZNYLJUSUfpuWNnp2MrQkOCXgzRo+sXmmsLVxNRbduT8Dedf97q/faDSQ0NRDkY0
         2lIsbeb4Im8yBs05TO/abHDVDr1PNWRIts0D2qhB3FyPmU1Bu+LE+hD5GP690V3R2bU8
         SpudEXKK4hoJcWRgEtCfMIF7Of09+IGRzaUwtG6j4HADbpvY7tQ9ZfVz0oEnKtoiICbB
         cgLB1D6ziienkA3ukQLa2Wo1+tzfUQSStOsu5NWQDkiK4aAM20dJ2gJtzkpVUdUKOYXT
         o/4qfiOOmOF1VX0f/O0VBBp/N09AuD1dB9/oEa56yfb+vETjjFPNHgGqdJSe53yWjmgc
         Eeiw==
X-Gm-Message-State: AOJu0YwrfJJ7SI/jCx+co7wsYav8rbPnJlFVOCrlAkFiqcxnRK2lR2G9
	cYiGgZgz8bW44StV7uLb7aS4YPBIhNOhVkiRFVR4e+ahZxt1xhxCyXM2ddXJ6lxaicnMIdr3r+M
	P
X-Google-Smtp-Source: AGHT+IGwm5DhnVGVYaG0PPR3/M++otHIgQd1p6zzxZF+WbmgmlWryoX9TnxLU8XS1W3NA3IIlWXS/w==
X-Received: by 2002:a2e:7c02:0:b0:2e1:a767:a80a with SMTP id 38308e7fff4ca-2e5204cc8ddmr194377361fa.38.1716246243262;
        Mon, 20 May 2024 16:04:03 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c138c04sm208801955ad.267.2024.05.20.16.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 16:04:02 -0700 (PDT)
Message-ID: <298e832e-349a-4914-81c3-f276b6cbc290@suse.com>
Date: Tue, 21 May 2024 08:33:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] btrfs: automatically remove the subvolume qgroup
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1715064550.git.wqu@suse.com>
 <90a4ae6ae4be63ef4df3d020707fb7b1ae004634.1715064550.git.wqu@suse.com>
 <20240520225051.GB1820897@zen.localdomain>
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
In-Reply-To: <20240520225051.GB1820897@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/21 08:20, Boris Burkov 写道:
[...]
>> +	/*
>> +	 * It's squota and the subvolume still has numbers needed
>> +	 * for future accounting, in this case we can not delete.
>> +	 * Just skip it.
>> +	 */
> 
> Maybe throw in an ASSERT or WARN or whatever you think is best checking
> for squota mode, if we are sure this shouldn't happen for normal qgroup?

Sounds good.

Would add an ASSERT() for making sure it's squota mode.

Thanks,
Qu

> 
>> +	if (ret == -EBUSY)
>> +		ret = 0;
>> +	return ret;
>> +}
>> +
>>   int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>>   		       struct btrfs_qgroup_limit *limit)
>>   {
>> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
>> index 706640be0ec2..3f93856a02e1 100644
>> --- a/fs/btrfs/qgroup.h
>> +++ b/fs/btrfs/qgroup.h
>> @@ -327,6 +327,8 @@ int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
>>   			      u64 dst);
>>   int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
>>   int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
>> +int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info,
>> +					   u64 subvolid);
>>   int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>>   		       struct btrfs_qgroup_limit *limit);
>>   int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info);
>> -- 
>> 2.45.0
>>

