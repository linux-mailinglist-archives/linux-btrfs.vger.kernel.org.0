Return-Path: <linux-btrfs+bounces-5100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90058C98F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 08:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA0281333
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A417571;
	Mon, 20 May 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SEDBd0iW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00168C06
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716186494; cv=none; b=lSQr6WUy0hWmxWDN62f/OThfBl/saiTKeaXZxSrr34ulAFnNN8uTXlBJ1rkfbKU9vpj/eI6XsZtWlylIrpXydz8q87EzhJPmf75sTtMbsniz/11NyJhGBlxPYqUPlZLhCaz1gwuANVjwGRDDVpkuxhJDHdZ/NjbYw/LbZoOZQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716186494; c=relaxed/simple;
	bh=3q2AIriNCxi852ZGILFpR2Zm5a2v5wnU2R9CT7hKYsU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tWCciW7KjHyt0goDKssukCZBvJvOf9MIPyZqFvD9en3FzZondicJstYQ/tmuRjL0Bna/JGSkPXTErRlF7NtNbP7zVEcmfDgAXnYeWJM+tO+s7EaM/CP5Pimj7l7UAuyNuAXBFwxoZkR1ICXgbCOBtzwD+8IobGlxQsFbfK5/h7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SEDBd0iW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so1097280f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716186490; x=1716791290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fv+XFOJ77il9YF4hp2aiEgnWz+/P8aeqPTnMMLKW1Vs=;
        b=SEDBd0iWX1bmxVwcEnTYuHf44s/hMnQ53Ts6XVpmjcbUPXBvGiwUiQ91ej/8bKXlSw
         y89ESV+4jiuhWW0F4UWIBl46vzMsVdrOOHOzm7ZaRgi7l93O+6TC89VDLTiO1xBVUuIc
         HgI4dQteEphx1svuM1bpRJeXz0cV1LqQUoP1hHnG58r5v2QTX0RkK5a488Gp8vcAL8AI
         tnCveP9aD5UtGkUZtZwmQNplKrIIUGi6VqUaYouPHzlQVWX6Fcp7blbuV4aTJZJi/wqT
         ZjM+GEG+1L4DJMruwrEsS5AMaDi1wKwi6nJcA/U3gQ+0Yw7jqDoHLcvh8Cu1iV9E9KdU
         CxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716186490; x=1716791290;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv+XFOJ77il9YF4hp2aiEgnWz+/P8aeqPTnMMLKW1Vs=;
        b=r6zCpsPAluYxJMlj9ywACBJztnxQNHV3VCCRGur5FDlHh2NKKCP+lApoqL1ZNJWOqq
         NWgy4STMBSSw5yA4ETSvXOCURYsABceZQIOKUi91i/Iw0ki1xl085PQTOBIRMQKjwoIb
         pade7r2hbTL2rv5cuBAUnZ5Ht34R0372dHz2NJPMfbn5T6HsucykT5UsW2KYIz1BaciZ
         qZyFvgy6VA+mKUy2u1q+8UNQhKze7zka/lIzByto6ihu9iulgs+pGKQA4brHyi93Ov85
         sLv4cJqu5UOWyDnlHEcLFunpCMNs5FGjQ5SX6+UrG/x6FMB63jD2YCONaWM9YOBX6mDe
         id7w==
X-Gm-Message-State: AOJu0Ywrg0Mn8+VDyQhuKC4DKNLwptX1EOoJz3uG4Dh43xvQCGkQlZRO
	xMt70NZs5xYkrOzvlaRrEJvXwEUYFYmQy9moN06YzEOEN9f6ZQ1s6Y5tH2u2jxmzw4lQuAazdNN
	8
X-Google-Smtp-Source: AGHT+IF0fE1Yw9r68x+2vWjezxkfDUXlByCWW49R46HePxDSz1OB6RLOKp3GxuRaauP9B5ABpHoq5g==
X-Received: by 2002:adf:ebc8:0:b0:351:d9a1:4f1 with SMTP id ffacd0b85a97d-354b9068e46mr4206123f8f.32.1716186490125;
        Sun, 19 May 2024 23:28:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fce9680csm15800775ad.222.2024.05.19.23.28.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 23:28:09 -0700 (PDT)
Message-ID: <e50756fa-f062-4786-9eaf-402c9f263b08@suse.com>
Date: Mon, 20 May 2024 15:58:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not clear page dirty at
 extent_write_cache_pages()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <868d6dec9ccac2f7cb320668b5bf4d53887a4eb6.1716175411.git.wqu@suse.com>
 <d1e442ad-ca7d-46e6-a68b-34908d25b44e@suse.com>
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
In-Reply-To: <d1e442ad-ca7d-46e6-a68b-34908d25b44e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/20 15:34, Qu Wenruo 写道:
> 
> 
> 在 2024/5/20 13:00, Qu Wenruo 写道:
>> [PROBLEM]
>> Currently we call folio_clear_dirty_for_io() for the locked dirty folio
>> inside extent_write_cache_pages().
>>
>> However this call is not really subpage aware, it's from the older days
>> where one page can only have one sector.
>>
>> But with nowadays subpage support, we can have multiple sectors inside
>> one page, thus if we clear the whole page dirty flag, it would make the
>> subpage and page dirty flags desynchronize.
>>
>> Thankfully this is not a big deal as our current subpage routine always
>> call __extent_writepage_io() for all the subpage dirty ranges, thus it
>> would ensure there is no subpage range dirty left.
>>
>> [FIX]
>> So here we just drop the folio_clear_dirty_for_io() call, and let
>> __extent_writepage_io() and extent_clear_unlock_delalloc() (which is for
>> compression path) to handle the dirty page and subapge clearing.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Please drop the patch.
> 
> Weirdly with this one, generic/027 would hang on locking the page...

More weirdly, this only happens for aarch64 subpage cases...

> 
> Thanks,
> Qu
>> ---
>> This patch is independent from the subpage zoned fixes, thus it can be
>> applied either before or after the subpage zoned fixes.
>> ---
>>   fs/btrfs/extent_io.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 7275bd919a3e..a8fc0fcfa69f 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2231,8 +2231,7 @@ static int extent_write_cache_pages(struct 
>> address_space *mapping,
>>                   folio_wait_writeback(folio);
>>               }
>> -            if (folio_test_writeback(folio) ||
>> -                !folio_clear_dirty_for_io(folio)) {
>> +            if (folio_test_writeback(folio)) {
>>                   folio_unlock(folio);
>>                   continue;
>>               }
> 

