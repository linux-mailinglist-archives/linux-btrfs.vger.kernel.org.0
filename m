Return-Path: <linux-btrfs+bounces-2845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC186A1CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 22:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C488B22D14
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 21:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAD514F965;
	Tue, 27 Feb 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FPU7pdgx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7B2D60B
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070172; cv=none; b=JQaRB/0OsRo46JOJ40rCJByffNRQZGonloMOmRX3xpdgQ58OO7riYpSjCWuyuoSVmgZBP3cEsg1D+GAbuit/9PbMaEuuO+ycL++AISHdqeuY3sQeQV5diTwT6qeBgI9V0m7R6xGLBkdo86fSJExka56So6RnyBNjtQAgmWCyoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070172; c=relaxed/simple;
	bh=/4aSucbDC7ml3pLS8ChIMllPkc3G3Jsf3zBNoiGeE1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPB77HogewA8IsJeg6/XlJzmiS0B1mUTk2c1t+zghMcyYfHKOrpkshZsPP9Wht56mtKzKuCCLwNq9/dVAcIkuUf01Z0BLsJmfzcXFNkJX5OQQq8EyTwBXUAHVTrypnYluzP+a4nlP+M33B+ar1dkDKNTkLogcqeqau4sAtu/3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FPU7pdgx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so14965811fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 13:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709070168; x=1709674968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nw03J+crl8W360KBTuBXor0RClKjAd4mXIoFReELNuo=;
        b=FPU7pdgxA7816dKkcyhXjIon6DFCJKYvYywa3Es1OYCTEyWBobHLGlXnITwFiPpaJL
         yWUr1NJ9CqZQBSCdiLof88cF7lRtoErGZfOm+F6d0sjFk4+cXa5nxnUtCV6dAoNHkX8z
         kCg5HY8Qdymr8T37HQf4nRPAvMWtzsapfmDrtTUQM3moW+fcWpjegryGyzm7ei2Tnf81
         c/otNmyhVEUS/eQyPkYodnetk/IXsA9zgZM0cEQsgsvhloV0RF4wMmPdhIBEGAg/jpLx
         dT0DuM9x3At4u6bHP8LvaCvRTBHT2VoSORAzGVDGSrSOKFWanVofixOGYYCGlQF0ffZN
         SCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709070168; x=1709674968;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw03J+crl8W360KBTuBXor0RClKjAd4mXIoFReELNuo=;
        b=r1wkxVOsQZ7e5KRiAbv9hW7i2qJF3awdwcPhpi1umA8CmTcFbDdb92XLsZFGUzC3f7
         Xf16CYm1vuidkMPE6ZSN4EPMeIiuOW2wQs9rVZi1gC33HQ3IcC5vtPUt7jO5Q+RxleMf
         hCHe9zRRLpvs/Ts72WR/+ZSRId83LIcJIr9oSgRjC/O49blrliEqJ/s3yPyetlt7N/m+
         csJQhtyk5WkOm+/fEf7SVrKIhNiUwHiWrHV6aRspXd84jFQOSMy1sFLLc9LOiJEY5NA/
         R85G+gUfafoIPNoDzv2bvArS+54qzL+f9Lbhq19vziQKH0q+t/NTCdS5ZfKXPwEM50Ra
         t8aQ==
X-Gm-Message-State: AOJu0Yw2HmMaJtQPtxDIk7o+Z9ZJDzIyIHn8A0Y5xBdfdudEf0/Q43e3
	/0hc2H/QwhadJuiCj8M1nEC6wewPwsquFMwp9kG4bI9BDEMYdXe8vnS0IWnNDqY=
X-Google-Smtp-Source: AGHT+IElVEcUz1YMEU14R45oLqhO3AcBJh0W4ho0FLafzI7PqqcgJRH5n76UapQu8iE90lXzh/SobA==
X-Received: by 2002:a2e:300d:0:b0:2d2:3129:3d93 with SMTP id w13-20020a2e300d000000b002d231293d93mr6876036ljw.51.1709070168460;
        Tue, 27 Feb 2024 13:42:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id jw8-20020a056a00928800b006e4e4c80e3fsm5869968pfb.29.2024.02.27.13.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 13:42:47 -0800 (PST)
Message-ID: <9a369da3-c062-49e4-b3dd-27d621a09318@suse.com>
Date: Wed, 28 Feb 2024 08:12:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] btrfs: defrag: prepare defrag for larger data
 folio size
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1706068026.git.wqu@suse.com>
 <5708df27430cdeaf472266b5c13dc8c4315f539c.1706068026.git.wqu@suse.com>
 <Zc5y0IRJdqjmstvp@casper.infradead.org>
 <fedffe54-abfe-4ef7-a66e-a5a60bb59576@gmx.com>
 <Zd5U_bSQabhuc4iv@casper.infradead.org>
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
In-Reply-To: <Zd5U_bSQabhuc4iv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/28 08:02, Matthew Wilcox 写道:
> On Fri, Feb 16, 2024 at 09:37:01AM +1030, Qu Wenruo wrote:
>> 在 2024/2/16 06:53, Matthew Wilcox 写道:
>>> On Wed, Jan 24, 2024 at 02:29:08PM +1030, Qu Wenruo wrote:
>>>> Although we have migrated defrag to use the folio interface, we can
>>>> still further enhance it for the future larger data folio size.
>>>
>>> This patch is wrong.  Please drop it.
>>>
>>>>    {
>>>>    	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>>>>    	struct extent_changeset *data_reserved = NULL;
>>>>    	const u64 start = target->start;
>>>>    	const u64 len = target->len;
>>>> -	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
>>>> -	unsigned long start_index = start >> PAGE_SHIFT;
>>>> +	unsigned long last_index = (start + len - 1) >> fs_info->folio_shift;
>>>> +	unsigned long start_index = start >> fs_info->folio_shift;
>>>
>>> indices are always in multiples of PAGE_SIZE.
>>
>> So is the fs_info->folio_shift. It would always be >= PAGE_SHIFT.
> 
> No, you don't understand.  folio->index * PAGE_SIZE == byte offset of folio
> in the file.  What you've done here breaks that.

Oh, I see it now.

Then it's all my bad. We should still go PAGE_SHIFT/PAGE_SIZE for filemap.

In that case, the series should be dropped.

Thanks for pointing this out,
Qu
> 
>>>>    	unsigned long first_index = folios[0]->index;
>>>
>>> ... so if you've shifted a file position by some "folio_shift" and then
>>> subtracted it from folio->index, you have garbage.
>>
>> For the future larger folio support, all folio would be in the size of
>> sectorsize.
> 
> Yes, folios are always an integer multiple of sector size.  But their
> _index_ is expressed as a multiple of the page size.
> 

