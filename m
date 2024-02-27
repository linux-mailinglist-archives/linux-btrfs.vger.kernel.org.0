Return-Path: <linux-btrfs+bounces-2832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F68688A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 06:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA532284989
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E352F8D;
	Tue, 27 Feb 2024 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VZF29J/4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4F1AACE
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709011905; cv=none; b=A4AJOzg7gbYAHt7PmWF+tYp9/BU2nprJwXXl3YlQIoXp4lyo2LlpqIhVtyqqf+BRi9/rCIAmstOwmOFrJ0ALKrb53bt+Q9fxtlpmmsfE+E0zcJEQgvoBdvhuJzqlUyi5uisOpZuGWf+58kb68LGarqZch3xF9VuC1hEnwWT8n0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709011905; c=relaxed/simple;
	bh=YSuhdgFJJQgUtxisXuJTsExRhWlpEGyIPU6KU9XH5lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RTjN7renp6Zc86sseXkUD9RlK5NbR/Ox5wEVPmgJ1te9XAXwgd1M4gRqOTDPgPM6164CjwoMCqhMPh2o8eco5aGkdN/c4euSJJWPYSBZrCXB98g1UHSs7L5U5gNgCTOv5EPecGFmOLMSUeopUfttXiM0NqK8LxsUwFIlCbAIXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VZF29J/4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so5788947e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 21:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709011900; x=1709616700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBO8I4MYbGlW3OBw6vMzpzqHrdekrD6LSElaN6avQGw=;
        b=VZF29J/4pZn1C18wsYxBDG5FF5p3y36DFYx2cApVVLoUumz/vqMYWR2QtulwPecQiP
         +BvXLd7TdSqmcj+tHZWNLGreUcz6ezgiNbSQ78BADMMBFqKYRckVnDZEfVB6SNshJWMD
         2w7PZN1c56GcVwOj+usz73zVLqKD1J8IATx4cLQMV6gM0rKg1WnoBR0TAVl2J4Eb0JqX
         GD3wQUeNbDDNYRyF3I7NPviF6A+8k/XLsKiRiO4RJVuk7IJUOl+UqXbFFGmlK+o1Ce7u
         neJVxfzNjyUgdjbnxiIJKr4T7kGZYBIXkHI7DzJAEeAiar3Mn7+vdhrc0x3uQ8gDTY7k
         X+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709011900; x=1709616700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBO8I4MYbGlW3OBw6vMzpzqHrdekrD6LSElaN6avQGw=;
        b=dJNfb/zepKF6BzO+a+3+GngOeHOoYyB1zaN1K/J1pztEli5dYKKQRw4QXRH7gPWKb/
         w73omZYHyhGjtfyqNdnH9kofSuSRGvZU1h67CQgTygJpGPYiqIxhPN/pb9d8bD31QZWl
         Vwom6a1Ol4xbgem2ARPF6mVkejgDd6j7MyX4lUVOSd0/+vbEzCyoz+OB9Jltg76PEz/W
         Qnpuh/lMTeW4GVPcuqX+c1T7VUMB0l7qRyiq/q7sQ2IR4qE2qaifnIHXqyj1z2kU+x+m
         GsBUfhdCzk5KGfax1J9KmxHgvcAzYJJ2vsQtuwjfN9u0P8vW0URSiOUSDM0sY39MFfcP
         PxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWY/Hsj6RQsqrGNoVWg5e2GaVigGBsS8kbM5IeW5POrWoRH+v9GbXXazgxq80UakJyig2Q4hOQcw85olcIk393XQaCMEb/Key4qzI=
X-Gm-Message-State: AOJu0YxAQKH+eJcBwUUuLSRYTaChDZKpYMG3QlwyMywtZwnj5gf1el3S
	fZqgzRWQ+m14nKWYOZ6ToTwRv37o9xiZ6np6yf6ETULGHgn+/l/3PXukHSZ2MnQkLeRpn72h0N/
	dD9A=
X-Google-Smtp-Source: AGHT+IEw2dJ9+fzJz3PrdTmT5a2BB2aovEv6Khois0T9JeYCzv7yrAj3EfOhmIJSVKhqfS2tgD0nvA==
X-Received: by 2002:a19:ca51:0:b0:513:790:7695 with SMTP id h17-20020a19ca51000000b0051307907695mr300557lfj.40.1709011900594;
        Mon, 26 Feb 2024 21:31:40 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090ad15400b00299101c1341sm5485754pjw.18.2024.02.26.21.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 21:31:40 -0800 (PST)
Message-ID: <86a7ec99-cbe6-428d-83e6-bdf0841164d0@suse.com>
Date: Tue, 27 Feb 2024 16:01:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
Content-Language: en-US
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs@vger.kernel.org
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
 <425BE5D91F8099A5+e6a0c36f-3b56-4b3a-9459-6e2cc0918019@bupt.moe>
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
In-Reply-To: <425BE5D91F8099A5+e6a0c36f-3b56-4b3a-9459-6e2cc0918019@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/27 15:29, HAN Yuwei 写道:
>> [BUG]
>> With the latest kernel patch to reject invalid qgroupids in
>> btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
>> subvolume snapshot" can lead to the following output:
>>
>>   # mkfs.btrfs -O quota -f $dev
>>   # mount $dev $mnt
>>   # btrfs subvolume create -i 2/0 $mnt/subv1
>>   Create subvolume '/mnt/btrfs/subv1'
>>   ERROR: cannot create subvolume: No such file or directory
>>
>> The "btrfs subvolume" command output the first line, seemingly to
>> indicate a successful subvolume creation, then followed by an error
>> message.
>>
>> This can be a little confusing on whether if the subvolume is created or
>> not.
>>
>> [FIX]
>> Fix the output by only outputting the regular line if the ioctl
>> succeeded.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   cmds/subvolume.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
>> index 00c5eacfa694..1549adaca642 100644
>> --- a/cmds/subvolume.c
>> +++ b/cmds/subvolume.c
>> @@ -229,7 +229,6 @@ static int create_one_subvolume(const char *dst, 
>> struct btrfs_qgroup_inherit *in
>>           goto out;
>>       }
>> -    pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, 
>> newname);
>>       if (inherit) {
>>           struct btrfs_ioctl_vol_args_v2    args;
>> @@ -253,6 +252,7 @@ static int create_one_subvolume(const char *dst, 
>> struct btrfs_qgroup_inherit *in
>>           error("cannot create subvolume: %m");
>>           goto out;
>>       }
>> +    pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, 
>> newname);
> 
> 
> How about saying "Created subvolume %s/%s" ?

Sounds pretty reasonable, would go that way in the next update.

Thanks,
Qu
> 
> 
>>   out:
>>       close(fddst);
>> @@ -754,16 +754,8 @@ static int cmd_subvolume_snapshot(const struct 
>> cmd_struct *cmd, int argc, char *
>>       if (fd < 0)
>>           goto out;
>> -    if (readonly) {
>> +    if (readonly)
>>           args.flags |= BTRFS_SUBVOL_RDONLY;
>> -        pr_verbose(LOG_DEFAULT,
>> -               "Create a readonly snapshot of '%s' in '%s/%s'\n",
>> -               subvol, dstdir, newname);
>> -    } else {
>> -        pr_verbose(LOG_DEFAULT,
>> -               "Create a snapshot of '%s' in '%s/%s'\n",
>> -               subvol, dstdir, newname);
>> -    }
>>       args.fd = fd;
>>       if (inherit) {
>> @@ -784,6 +776,15 @@ static int cmd_subvolume_snapshot(const struct 
>> cmd_struct *cmd, int argc, char *
>>       retval = 0;    /* success */
>> +    if (readonly)
>> +        pr_verbose(LOG_DEFAULT,
>> +               "Create a readonly snapshot of '%s' in '%s/%s'\n",
>> +               subvol, dstdir, newname);
>> +    else
>> +        pr_verbose(LOG_DEFAULT,
>> +               "Create a snapshot of '%s' in '%s/%s'\n",
>> +               subvol, dstdir, newname);
>> +
>>   out:
>>       close(fddst);
>>       close(fd);

