Return-Path: <linux-btrfs+bounces-3622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E90F88CEE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC00326A0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE413E3FC;
	Tue, 26 Mar 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C+0mtxtL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266D13E3F6
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484879; cv=none; b=d/ebLM04bBVC1FrXuQSqFRVi0hnawAYK+FYZkvz8C44ZelJhVqbN2r/ThF2L0qaGJtvuWlZ/VuZrt4jYzd3xU8byNOAe2nQKCKNx8e85ha8H3lz+u+BDKDBbzBt3zZt9c89WplEdPEWAT5c8kYc9e8I+PQFDvhzoYxy4E5pECkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484879; c=relaxed/simple;
	bh=kSgM35gNr0gjriNWrDFzdoYK0XN/xbRf6EjVT09qNIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fli4idBZ5aQNCc/7OEyk1MdzTp0CpN6k/mW6HwfEITxF2ddGG805F5lgRjkFJY82pS3pm8MXSaKrfILSGfuihp5vx03WXBaHd9XmNQMQ+kgjr6YzwGuk4qDIvVOpNubNfjrhyOTdLmRzH0p4OcNmou8LSy596ZqcnQZGF9Jb7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C+0mtxtL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so132266f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711484875; x=1712089675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HAbFKQ41cf59OhU1G44xV3mLQv3wUEgsWgtwEAk2Zds=;
        b=C+0mtxtLpWWyiBUgaF7TKk4gDoaSzYNJ3Lp7O7It7VgCf38K+9QECiTCK8L6zgM6z7
         iTE+wwGXoV29waAKx/dAWnSHp2OiN5FzWcO22XsltsbTeSbjJi6IDX5Y8AFc6zjN9cRh
         w21+F3oMOHQU88SahVotydIf9DE3yYpda8uvQ2aiH3ZA4U4XYoOAfZpnowIIEYGic7YA
         Sx+ovAgBtiL1QVzyiHPcMNYWthKEMF95YTxVad6iac6MW6FuTmojxfkbLh38sDtXtr1T
         r+3BvgPESGVwfz5MiYJBYkOPepgLfUJnC53ECN4RaoFqUhoc3qpZolgVd6QLjjccjQI7
         qARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484875; x=1712089675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAbFKQ41cf59OhU1G44xV3mLQv3wUEgsWgtwEAk2Zds=;
        b=PlWbAo2atLT38A6/kCUgfZFXqAtJJc6pbWtiphudmmBvBSwCHz13z+H0jPxxjTJUuT
         YBQ+OTGspG/9fIHobcrX6fkshX+7i6Jbr73fRdd7VlBwWhebaXcE9yAFhk5uQj5e4ZVY
         HJ2wcvUJZs6k2OdbGRCnHpuZ7gEj3svmmA8yRJIp3fqH+NNoxgA1YkAFy17gkiJuwVOh
         gKQw+fqFGqCLpF16tNmBtwgsQ4vXiVyk7rJ3H5uarmWBmNkwBBJtSqk0bf4WzOzauSVF
         WcYbDX4YX7J8mS5V2etKDDydBW8MRrYY0YJ5ZWRsiO8DPhCDcrQtfGw8xF8rjx8VRepX
         PsWQ==
X-Gm-Message-State: AOJu0Yx4GKpqwuLEIHQcO9j4XP4+eJtCC/ZPal/hmXgcrsO+geNMtUjr
	A20ryCAuh3PURcqn/1ENZVTydO8AbBzDeIe/MzULzE76cSoZOehJXyarLUhLjEw=
X-Google-Smtp-Source: AGHT+IEotxvMHwVRcmWYiv5H+qJ2gNoD605LE9hGTF5fK1yR+l7L0LK5Ki1ZLh1eUnhAQTPGEgLuDw==
X-Received: by 2002:a5d:6b82:0:b0:33e:c6c4:43bb with SMTP id n2-20020a5d6b82000000b0033ec6c443bbmr2518618wrx.6.1711484875528;
        Tue, 26 Mar 2024 13:27:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id si13-20020a17090b528d00b0029fe0b8859fsm1556109pjb.1.2024.03.26.13.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:27:54 -0700 (PDT)
Message-ID: <bafb239d-5c78-451d-b981-8d79aa3c1200@suse.com>
Date: Wed, 27 Mar 2024 06:57:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: subvolume: output the prompt line only when
 the ioctl succeeded
To: Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
References: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
 <20240301125631.GK2604@twin.jikos.cz>
 <20240326202349.GA1575630@zen.localdomain>
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
In-Reply-To: <20240326202349.GA1575630@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 06:53, Boris Burkov 写道:
> On Fri, Mar 01, 2024 at 01:56:31PM +0100, David Sterba wrote:
>> On Tue, Feb 27, 2024 at 02:41:16PM +1030, Qu Wenruo wrote:
>>> [BUG]
>>> With the latest kernel patch to reject invalid qgroupids in
>>> btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
>>> subvolume snapshot" can lead to the following output:
>>>
>>>   # mkfs.btrfs -O quota -f $dev
>>>   # mount $dev $mnt
>>>   # btrfs subvolume create -i 2/0 $mnt/subv1
>>>   Create subvolume '/mnt/btrfs/subv1'
>>>   ERROR: cannot create subvolume: No such file or directory
>>>
>>> The "btrfs subvolume" command output the first line, seemingly to
>>> indicate a successful subvolume creation, then followed by an error
>>> message.
>>>
>>> This can be a little confusing on whether if the subvolume is created or
>>> not.
>>>
>>> [FIX]
>>> Fix the output by only outputting the regular line if the ioctl
>>> succeeded.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Added to devel, thanks.
> 
> This patch breaks every test that creates snapshots or subvolumes and
> expects the output in the outfile.
> 
> That's because it did:
> s/Create a snapshot/Create snapshot/
> 
> Please run the tests when making changes! This failed on btrfs/001, so
> it would have taken 1 second to see.

Wrong patch to blame?

The message is kept the same in the patch:

-		pr_verbose(LOG_DEFAULT,
-			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
-			   subvol, dstdir, newname);
-		pr_verbose(LOG_DEFAULT,
-			   "Create a snapshot of '%s' in '%s/%s'\n",
-			   subvol, dstdir, newname);

+		pr_verbose(LOG_DEFAULT,
+			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);
+		pr_verbose(LOG_DEFAULT,
+			   "Create a snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);

Thanks,
Qu

