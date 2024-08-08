Return-Path: <linux-btrfs+bounces-7058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 269BD94C755
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 01:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CE1B24047
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989815FA92;
	Thu,  8 Aug 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="brfBwCe3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB521474A5
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159404; cv=none; b=n6oTttlhl9ddqiXbrQLHr9Gf+q5l88xCDsidLVmyWM664ExVV5UOLtCVbviK1zvtJUp84DzOznFTplOi0TEi3UqSdbEfaBVAJ8KD4cRnmjfmOtpWBEEnBxuneB+X2dqi9PySm89vaVYIYEkZx2ex6erzYgz2o3QcFJ2wLZSWmK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159404; c=relaxed/simple;
	bh=X3tEV/qgD+jqp4eXPyhkMrSMAAeeLlNe1RLw+vOSuiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J7fFp+hXE+vRGK+d95x57GPqUxrdAeuyYi0lA6m9J7sXyTieLULJewDnUMJiGHhlpkv9hbebrZJH28Rrt6CmjcyrmvQXULVJmCWBqzMHxuQEs6cMQWA+5ynmx4gd0YX3Xw8tKA4AbQhe7j5NK6h5VKTNC9h/ZSnbO31Rs01bj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=brfBwCe3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso16183601fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723159399; x=1723764199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H7m0vla5ChBPqHYVhA934vX0qk6tQZ5UCLb7N2EI5jY=;
        b=brfBwCe3d+DNfpko8UkoLnvjKrZUw6tXhjljVz5vG9pw6N1Izwp9+pEosQzn9pPn7R
         lUC9oACVLRoaKpBifk0iKtQGoaDs3MlAeYRZA9YeZyu5KR4gpJ8W5O+O3BIU+XuhSpHr
         irVCi4m6PflfgdyvqsJ3l7NK/tL50CYX7+v7rmpOpNFm3PLRzryMH23s/hSIB12JJ4MA
         m8Zq8FLxQ+zW8rCOfw1rnMfzltnRgxpbLwYu5NMkpRrC//3C6+40X1/BWQv4fmRZKTSr
         HjA+3i/5JBFPP7cdaUmbp4JdLeyBHETHfc14O4j4HKyUrrZuVQjPQdqXsWx7Cwc4tleC
         Qu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723159399; x=1723764199;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7m0vla5ChBPqHYVhA934vX0qk6tQZ5UCLb7N2EI5jY=;
        b=hruDrNUs1SA3MmkhfwDC7wlsQNcpYrTuY2ddrosT+OYuxzPOlAOAO76X8Yca4BzXzI
         gI8MMI8M/2gz9F6Wnq22xmspzJgfv/mq80yAW/olGQiNVzj6nqwychUv0QFUVtZe2lwe
         /+LWDyLipajmhh4hdJSVX30aKV/KAB3R03iJv1rAjUKa8QdXWmIXwPT6pkX5DxmGjMnW
         lR1EgQZOZmtfePHF0ZPcKW9tA5lWrkd8dveHOBnun6WBsVhRkScxSGCPwwP/dwMB+3tp
         n3u+/e3sBOK5N+BKp5q7ARwuDRadgFWUd3mLTMGZkyGuc1t8+tv2lib6/lvM1iRXhtp1
         5r/A==
X-Forwarded-Encrypted: i=1; AJvYcCXerGGCAFDis0PXqFDAFJvaBdvm/sEqYaLz28Kki1EQqcfj2/EJ+eh3LyMvprX2JGq7dX9N5uZs5ae+FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdfcQnldpzOutggYloBBwHpj3rSEKbDo8OgUV6YpBsEQPO7nN
	wgTO8FBHexYEDZhlevVUTy8Cd28PRPhn9t/MMGcaURObJFBNxymWm+Qm3DRXC8pfuvyt1GxcAtt
	V
X-Google-Smtp-Source: AGHT+IHVulRMjqqyMeUM2FV9k+mDkA+p5HaA9qaSoslsC9SPu047RDghz2HYGlKCTCJkPmIuCS0ONg==
X-Received: by 2002:a05:651c:1541:b0:2ef:296d:1dda with SMTP id 38308e7fff4ca-2f19de22369mr27173251fa.1.1723159398133;
        Thu, 08 Aug 2024 16:23:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3adaac6sm4059107a91.24.2024.08.08.16.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 16:23:17 -0700 (PDT)
Message-ID: <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
Date: Fri, 9 Aug 2024 08:53:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Andre KALOUGUINE <andre.kalouguine@ensta-paris.fr>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
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
In-Reply-To: <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/9 08:37, Andre KALOUGUINE 写道:
> Hi,
> 
> Thanks for the lightning fast reply
> 
> On 8/9/24 12:28 AM, Qu Wenruo wrote:
>> Mind to share the model of the NVME device?
> It's an SK Hynix P41, 2TB.

Then I guess you may want to disable discard, and move to fstrim 
routine, just to be extra safe.

>> And I guess you didn't do anything dangerous like "nobarrier" mount
>> option for the fs?
> 
> No.
> 
> I roughly followed this configuration: 
> https://github.com/egara/arch-btrfs-installation except I used 
> systemd-boot.
> 
>> Furthermore, the error message doesn't show which tree is causing the
>> problem, which I hope it's not some critical trees.
>>
>> So you can always try "-o rescue=all,ro" mount first to see if btrfs can
>> still access the critical subvolume trees.
> 
> It gives the same error (with a small modification):
> 
> BTRFS error (device nvme1n1p3): bad tree block start, mirror 1 want 
> 211658031104 have 0
> 
> becomes
> 
> BTRFS error (device nvme1n1p3: state C): bad tree block start, mirror 1 
> want 211658031104 have 0
> 
> And same thing also for mirror 2.

So it's the corruption of a critical subvolume tree.
I guess it's fs tree.

Then it's pretty hard to salvage.
"btrfs-restore" is your last chance.

Thanks,
Qu
> 
> Thanks again.
> 
> Best regards,
> 
> Andre
> 
> 

