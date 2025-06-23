Return-Path: <linux-btrfs+bounces-14881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC3AE50BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 23:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400263A67A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 21:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C82223714;
	Mon, 23 Jun 2025 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NYEOUJhA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB21EFFA6
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714038; cv=none; b=Jr+POS0wIywxjn09ANsYtVnr1GYWzooZ/PIYjuKS3KY+ynmvOm/3UESqhPth7QS6HgvqZ9nheVjdFdXZrw8u0oVbckITC2vvxydloYORuSK7GZKf6YQVEhp9jMm3iDJPi419yoVuB5PNEPVVxoaC78JXhbcMYbFQBvomIuLXsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714038; c=relaxed/simple;
	bh=eojVyf51lCMr6X/KGg1Dv1pYQCpoJkl5y+x5ZEFLpaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn2JjEy6ZtrUZDj3zFl8LXvp7CHhq9WH2u8oT8Wz7Y/wtHv0c7B6y7JKj9rSZCPZSV9LivF8FIH39KpmlJCkeKARTtuNzdYS5za/5y7H/5c4pinxDKtlUqVTjRQ+s8upUSwSvgKN1SpNNN2LW8b++xw0suIivua67tBuzt7gd1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NYEOUJhA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so24705395e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750714035; x=1751318835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pl9KI7ryh/VZawz+A0Uduzqzq99xzC5nMAwv8kVqcc0=;
        b=NYEOUJhA2/goE14zirnN9cKrl63Gi/IhbZXEWd4GSbfYjQEbdQDdtKEfWQRqKt2G6h
         2/FJKl+QqqK2qQkPxTu4AAlohU9ZLiFpo2WWFplppI12xqR0/Qkc3mEexrx1MPW+PisZ
         uitb8vYxCg2Tf517/LI7KRHtseun/64rkSC2fueImFtIqtgNr/ES4gWJkHvRF9K436Bi
         uWieSZsbaSVR1nhODUxFP+tSkm2FzzheyUPyv4JJMppSXPstdWp3FYF7byiOQXXZyCkA
         2tc7Pgzc68KiiBGfJ0KMtpmJ9G1i+SYCE1nEHZsmVXLWnja6odXSXjicknsxSp1KORRJ
         MUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750714035; x=1751318835;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl9KI7ryh/VZawz+A0Uduzqzq99xzC5nMAwv8kVqcc0=;
        b=oalSZLrI8TlmzQntfbIPefIBYel5rg0DQt3JQflcbySfizJdKTt1Yt2+7EirVcSPMz
         xhp91qgHi/VWlbcpt8JRoDu6FrZXueDRlyWaGdxecypoIxA4ToaJR1SrIJB5LVyyzo+m
         6wWRp9mBzE+l7W8WgsNfuh0mEa/1E01In5e+VajoJmMCej9FW2CSZ5PDANH84VXk2l5Y
         thuHGhbAe93cSuLmu3qKa2TN0JORcvGpff1uBfV0sqL3Bf0nm2kjT3fiwAHnj3j3tIcI
         QWlZ7BGEGtPwKz23syP+OWmju50IwLTdIa/KXTVYW2jbUflUZMzDT3y/v2pCyWHB0pSh
         5k4w==
X-Forwarded-Encrypted: i=1; AJvYcCW67Zp6Y5WPFhXJThyxPTlxkc1jpDP+LCcoSRdCnWIDp/jH3uuGo5eJcAo9QkYV01WZZoTbcWYoLZPfMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/+JOhTJ/fKatNlntOIV7U9aGtU8PJFF3D2VdgeZ7OxPsj9/3
	l9LU+Z4D0m+pao+/D4yKnjg9pn9ws8hccknrAu/iMsog1o0W2CNy824Tp2Ba4+okpFw=
X-Gm-Gg: ASbGnctycWkyM4h5harML4/suAGL8ohK1hIZBudYyq2pDxGDDaGWmj6oHaGy16cfcQX
	5rgmyQ3C2zlME4/I6ulinIRQnTQ3aLHLP3outyIjQkqjsxmfijBAkAddNsZAG4BdoXcXjx9v4GL
	EMYUiAWpQFia4/3EyQH2Qx3IOQFMn8gwP4xEnlhwoYSApt8DKv2VjcVdiyRcAT3CPANgT7PKSW+
	k9nvzhUTcoG5dwPtpPKAvYVQTkogLYyBvJMx29O5/mVycsYb9ebQwRAycgxFTm+3zcwstRUfYYY
	5s46WMPYSEPaCDM6tmwzBtvhK5KWpKCAzGv9ZfH2iuexDar/lIQ1N8qL9BMky75rq9ppyKIVlcw
	mwFkocD2a8dYcGw==
X-Google-Smtp-Source: AGHT+IHmW2bhlLlZ6PcUusRW5kY5vqWdneeiUygzKjknQ4gUeDZ61JeZVBOQbcwWD3dXleNJ+h4waw==
X-Received: by 2002:a05:6000:210a:b0:3a5:39ee:2619 with SMTP id ffacd0b85a97d-3a6d12df3ddmr8200550f8f.47.1750714034413;
        Mon, 23 Jun 2025 14:27:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8854943sm86508b3a.138.2025.06.23.14.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 14:27:13 -0700 (PDT)
Message-ID: <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
Date: Tue, 24 Jun 2025 06:57:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
To: Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
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
In-Reply-To: <aFldWPte-CK2PKSM@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/23 23:27, Christoph Hellwig 写道:
> On Mon, Jun 23, 2025 at 12:56:28PM +0200, Christian Brauner wrote:
>>          void (*shutdown)(struct super_block *sb);
>> +       void (*drop_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
>>   };
>>
>> You might want to drop a block device independent of whether the device
>> was somehow lost. So I find that a bit more flexible.
> 
> Drop is weird word for what is happening here, and if it wasn't for the
> context in this thread I'd expect it to be about refcounting in Linux.
> 
> When the VFS/libfs does an upcall into the file system to notify it
> that a device is gone that's pretty much a device loss.  I'm not married
> to the exact name, but drop seems like a pretty bad choice.

What about a more common used term, mark_dead()?

It's already used in blk_holder_ops, and I'd say it's more 
straighforward to me, compared to shutdown()/goingdown().

Thanks,
Qu

