Return-Path: <linux-btrfs+bounces-3623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1F688CEFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66B2B22A2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877E12AAF8;
	Tue, 26 Mar 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PXbN+5qb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FB1EF1D
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485038; cv=none; b=gPkrOA2prFD+iA5tQOn6QgSohAG2W5ctj3Wx+xlyXPZLtCimoa+Wzy/p+OdF46WkdOn1sS963Wo3UahrFBVT4V2vPPk+nESh+jsZp4l+m41/M7bFvOstRPjCutRPfGfXEJeEkZxiq5HZj4UJz+Firri39sN/DKM3tk/Wj6NBnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485038; c=relaxed/simple;
	bh=9yYiJxdQlPqo0eLA1FMjKbMJCEp/JzxmA1HBLLXsiKc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g0NgM/tSVck+tl/6xjMkYnXhQTdrGJhCMnWVdSbi34kz/s9nWFQkPn+U6nuqgdZF6HAP0kT851qCI/KrQosMzHc+JtbZR5HQlVQ9PP/vn64zPIK8pHqeHDIy6GWuU8Zp3q56bCqe8cSTT8kNoGA6+rIXR3BmUlz8A0DjENP8zgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PXbN+5qb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ddd1624beso127188f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711485034; x=1712089834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QWBXCWRzagZ/ApSDtpOUedwGlOJ0X9aE+f59fU36DUk=;
        b=PXbN+5qbglFUUIjcqpXh/t99ARj1cqN9irvYVyM8xAMbRBh1Pm5bUVERPJufkVNhXM
         qPBkWoKk/nhYucVHccAFYz4jL5EXVSfPyaGYo+XBc74UnvXkSD9HjA6t99TEfPebD1XP
         Z51NjYK/IPMlL3eET9ypiDjQwQa9dhOmeUuGQ43AXRTGKBaUNxc2+ZCaSwNK6pmuHQv8
         xlh79W/rGvBVNm1knAhmURV6RcHjbma63lWgC1EFow3DEXhMaQ2JtlhdOWNM2TppZXx0
         KmkMWLchxCNLNCoSErlBxBAtOrB77ylOFYNn3GKX90+TJ3L/VjNBlOa8DbkbJzCNkkKJ
         qtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485034; x=1712089834;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWBXCWRzagZ/ApSDtpOUedwGlOJ0X9aE+f59fU36DUk=;
        b=o00sGrm6MY95I4QhetQRCBjlS+m7JZK0ILzQXxnh9v7AcCezB8tB1kBKXorUS7ab/L
         qJNtdrqbkmJRgH/ETJpmOQt9nS++8vIT6w3FYztNtsDCoF8NIcazAUU9BYsYyYp/7i6J
         OTyZfeCpFwnGy7686xy9mN0uiSyiyXZnP3UMTswnU9ytdGUEIu0T+3ce+MaDuqH9YgVW
         131gJZmDVvV3+7DTYqamVejW3zKw20rh1QEyvWKuWZ/OcnJ47sa/rK9QBuDmgXBykdQK
         elWLImRAEEHSDwB11xyuDDSqQXCEmla8K4Qv92ptwU7LryWj81Bcc6oyauX1tLSrswUu
         mlyQ==
X-Gm-Message-State: AOJu0YxKxz/j0VD9k/aLQ3SQlqlcXGnEmvLPciw5wj7Tao8dP8QfGbDM
	yP2WuiicVdI9fj5YNHE9dp0yNcOCJMNw0EgnQ9wFj3y5CEErvHPV9bh1GABO/hs=
X-Google-Smtp-Source: AGHT+IF8RXlQah+Vjjm8/S3vU9UUKDKZhZjUSlpXGgwOMEdCuqRWLXARGM5mFt7j0R8PiO7qkRFoGA==
X-Received: by 2002:a05:6000:1376:b0:341:ab6c:71e4 with SMTP id q22-20020a056000137600b00341ab6c71e4mr2542104wrz.19.1711485034140;
        Tue, 26 Mar 2024 13:30:34 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id z189-20020a6265c6000000b006e71e3d1172sm6672696pfb.101.2024.03.26.13.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:30:33 -0700 (PDT)
Message-ID: <32c3c2fc-3f76-40e2-b876-36370f4aed85@suse.com>
Date: Wed, 27 Mar 2024 07:00:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
From: Qu Wenruo <wqu@suse.com>
To: Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
 <20240301125631.GK2604@twin.jikos.cz>
 <20240326202349.GA1575630@zen.localdomain>
 <bafb239d-5c78-451d-b981-8d79aa3c1200@suse.com>
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
In-Reply-To: <bafb239d-5c78-451d-b981-8d79aa3c1200@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 06:57, Qu Wenruo 写道:
> 
> 
> 在 2024/3/27 06:53, Boris Burkov 写道:
>> On Fri, Mar 01, 2024 at 01:56:31PM +0100, David Sterba wrote:
>>> On Tue, Feb 27, 2024 at 02:41:16PM +1030, Qu Wenruo wrote:
>>>> [BUG]
>>>> With the latest kernel patch to reject invalid qgroupids in
>>>> btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
>>>> subvolume snapshot" can lead to the following output:
>>>>
>>>>   # mkfs.btrfs -O quota -f $dev
>>>>   # mount $dev $mnt
>>>>   # btrfs subvolume create -i 2/0 $mnt/subv1
>>>>   Create subvolume '/mnt/btrfs/subv1'
>>>>   ERROR: cannot create subvolume: No such file or directory
>>>>
>>>> The "btrfs subvolume" command output the first line, seemingly to
>>>> indicate a successful subvolume creation, then followed by an error
>>>> message.
>>>>
>>>> This can be a little confusing on whether if the subvolume is 
>>>> created or
>>>> not.
>>>>
>>>> [FIX]
>>>> Fix the output by only outputting the regular line if the ioctl
>>>> succeeded.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Added to devel, thanks.
>>
>> This patch breaks every test that creates snapshots or subvolumes and
>> expects the output in the outfile.
>>
>> That's because it did:
>> s/Create a snapshot/Create snapshot/
>>
>> Please run the tests when making changes! This failed on btrfs/001, so
>> it would have taken 1 second to see.
> 
> Wrong patch to blame?
> 
> The message is kept the same in the patch:
> 
> -        pr_verbose(LOG_DEFAULT,
> -               "Create a readonly snapshot of '%s' in '%s/%s'\n",
> -               subvol, dstdir, newname);
> -        pr_verbose(LOG_DEFAULT,
> -               "Create a snapshot of '%s' in '%s/%s'\n",
> -               subvol, dstdir, newname);
> 
> +        pr_verbose(LOG_DEFAULT,
> +               "Create a readonly snapshot of '%s' in '%s/%s'\n",
> +               subvol, dstdir, newname);
> +        pr_verbose(LOG_DEFAULT,
> +               "Create a snapshot of '%s' in '%s/%s'\n",
> +               subvol, dstdir, newname);
> 
> Thanks,
> Qu

OK, David seems to changed the output line when merging the patch...

That's something out of my reach.

Thanks,
Qu

