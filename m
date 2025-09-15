Return-Path: <linux-btrfs+bounces-16845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF9B58857
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 01:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9AC165E07
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D882D839E;
	Mon, 15 Sep 2025 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yi7ppJiF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82D229B36
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979460; cv=none; b=Xla8ZjLbH5SWd94x7ukJv5gh6r2eh9fOjPZMjyQyC6MuFDGNQbsD0Tc5p/4jo/X1Ta4g41qmRo15+2dM1AmREi6QcSO+lua7jw3mBw4A1RF5lFBwaSVpLxrA1sYjxs0C/lG8SbTb+A32vwhaU1TtSPnjlSOpsv1oBWpJgCuZGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979460; c=relaxed/simple;
	bh=Yz/xRhusz15MLHbH5tDhWyC8TxpVMqbxfYHGo9bFPPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kNwq/p5s8E8cMMWLPknvQWHWGzOWTZta6GTE06ii4HXl9lZZlUWAtRSH6IyQ/OZHTubXwdvq+N6LcSmgS40uWinwaC7xWPTPVf6zBhUhjTCFl5P1duOrT+hSprgSRwGlZ79uJoOBr7pZMfkf8HT8G7FwBtgAB0jOYQRvnuCddMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yi7ppJiF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ebe8dc13a3so658806f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757979456; x=1758584256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=blOsmaTE7EamUBcJVU0gS7Lk19ZLC8+GIUisHFqCyjI=;
        b=Yi7ppJiFuvP9N1iITN1CikaGm2W/3KNmk2xBWr888lEE/g8xkmRfhO91kk7BTWP0wR
         ZXKmeEeZjNsG9AQCUudPAxhKotVLdOtz+ZmCK6ADR0pY+fwAmN5VBzrgusD6d16LcYiI
         UW0klYBqOzmdVx6jQJ5kMndIrDH2HPQB7DdUO+5OnXtkmmWLutx8YYhwjuYQ/PTOWPdL
         fljKWRTBBqxJOZTh5Tf6y5Ti8LTraxJ+6I74NuI3RJRuPuqb8UAeKxBRDoY6SoW/MoM2
         qWZRN3wp2niCiWU4vmAJzuSK7xaW4sTKtVHmC4fa+gqhsnBQ2fvehV2IR6xvgSF9vUqi
         kdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757979456; x=1758584256;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blOsmaTE7EamUBcJVU0gS7Lk19ZLC8+GIUisHFqCyjI=;
        b=pKwBjNPmNlk3aUWFvgPUOaguxyljijYfos9sNctrHlfj+JPEcoyeBeT21EXGSdMRMg
         9e7P22OqD5fkD93PriYf653JPqcluZ29DBs+UcNpdCmf18fd94OtSvvKLskFluU+LWck
         HWHQp4JcaI7nHRsd+x5f8yGqkJuis58qwf3ISdbQSC/G7JA+fzYWLECXBTZMuIogbdJn
         /EhlaNDBGRJyRn1CeitV0QkDNNsKz6ismCVe2b6iseIbal90n+407EhUMO7lsxDIKSj2
         F7FQ7bVjSK5aQ6m4OdbMhpOkj4TX5oE1zORXB18sk/2Sp3aRqnEe2OydqRFc1pb0BBpH
         L/6A==
X-Forwarded-Encrypted: i=1; AJvYcCXHWD2DmoXlbWKzAeoYarrkY5Hsjjxv+oybTJd3MMxk7ltjQkNDp40B/NTWtn1cXSqJO+7WVD+B/DEGjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVdipqDkrV80p92om0INaMRgsj+YTz9qBY0X9yMVaM5X0RwTQ
	za8VUJjp2COivK16qk8Dln+xtKT+wzWE18dYHnpu61G+YqnP353Jgo1DwF1Iv4QcvfJjO71ei9P
	qt/eLBf4=
X-Gm-Gg: ASbGnctH/zmR4TCr7tHqXkuaukMaELQg7YogXpUBnTFSzYxXCtwYdhShHZ4K0vev7E9
	oQgVmFFx8YPNhgefxi7OMD72+Gzd6iD44yAnihIZ/wVpz+cVv8UOFp+A19huR8P05K1XePkyqic
	ixnaah+d2kY3KYZKRNdLczYlgh8ylLmSfxlV1GgPnsYOBlhZMV1VgqYSrm7BBnhAJwxnZu+hH4d
	U0WApV3svaHsCvfPgRYEarcJ3vhHH5iicSPaKeP63glVowhCQiDfBE9vEn7KxqTCwh8T9HlNO6H
	vKT05IF3pWqSdqZDQggnDTZ0s1+v3Cdggao0Zb5ZNtIb+DX9MVcfAbHVpn4R3fF2rZRFqPc3DSf
	zWj5ToUofkvjWow3Yx/UslUpt4cqKa2HTtVPkK8LFhhyOqfYF1os=
X-Google-Smtp-Source: AGHT+IGYD9BHolmQsFwfI3vssldHhN1M5tki+xuB0GA00buEZPOM3wlQkvkfhZ/h9AY84/8fN7zGRQ==
X-Received: by 2002:a05:6000:438a:b0:3e7:5f26:f1e8 with SMTP id ffacd0b85a97d-3e7657897dcmr12576180f8f.5.1757979455626;
        Mon, 15 Sep 2025 16:37:35 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa50sm16405109a91.6.2025.09.15.16.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 16:37:35 -0700 (PDT)
Message-ID: <3e4242b6-7348-44d6-9346-e95095a3a070@suse.com>
Date: Tue, 16 Sep 2025 09:07:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.17rc5: btrfs scrub, Freezing user space processes failed
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
 <dcb5d446-adaa-4a6c-b212-619d286d01ad@app.fastmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <dcb5d446-adaa-4a6c-b212-619d286d01ad@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/16 08:46, Chris Murphy 写道:
> The storage stack may be relevant: USB flash drive -> dm-crypt -> Btrfs

And for your original report of no response, the problem is since btrfs 
is blocking the suspension, there should be no extra reason why the 
system hangs.

Unless there are other corner cases like the USB device is powered off.

If you can reproduce the bug, please catch the dying message using 
something like netconsole.

> 
> Darrick Wong notes that in https://elixir.bootlin.com/linux/v6.15/source/fs/btrfs/ioctl.c#L3159
> 
> btrfs_ioctl_scrub calls mnt_want_write_file for the duration of the scrub, and mnt_want_write_file takes SB_FREEZE_WRITE and holds that all the way to the end,  which means you can't fsfreeze the filesystem

Yes, that's already a known problem and both David and I were working on 
this in the past:

https://lore.kernel.org/linux-btrfs/9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com/

https://lore.kernel.org/linux-btrfs/20250708132540.28285-1-dsterba@suse.com/


My solution is to cancel scrub which is the simplest solution.
David's solution is pause scrub/balance using extra callbacks and a more 
complex mechanism.

Thanks,
Qu

> 
> So how did this ever work? Folks do use btrfsmaintenance with scrub and trim timers, and a laptop can sleep at any time. We can't inhibit this indefinitely.
> 
> Perhaps scrub and balance can be paused if pm suspend/hibernate is requested? Just make it a non-factor.
> 
> Chris Murphy
> 


