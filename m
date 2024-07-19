Return-Path: <linux-btrfs+bounces-6564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791BB93719D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 02:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BE71C20C2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756C15CB;
	Fri, 19 Jul 2024 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BrOXLgRj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB64ECC
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350000; cv=none; b=bpIsflPO2KNodQ7SNMmlJXKam/6CI9jD58oxkbrcLxJQChUtTRQZa0BBU+kAwHT6oDfWcZfjqdyUFChY1aPQb/5HHQBo7TA5C11ffVj0cavYrOUQYwjqx7It4SQaiFSfpvtl9LfvT5Thjnz336qf5s3z4k+l9Mgzh+lFmXwy82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350000; c=relaxed/simple;
	bh=RIf2a/Jck8URB+ODymztXG4gsrSfpihPo1U8NJs+t0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMxpHMBum7R7pIdcKT7iuZu0kXTU7k5uI1ZjDlXE6rQiK6WHoQ84bzL6gV0GNSmHt+XjK0krf47+zLwfRiXH9E1SQPhBj3ngGtSupv1FEKy2pA38hf9aQgzs6U7bCJ8EeZF6z+Bkv3+qBWhXF6rMerbsrn5kfWvt88ZRfeIzUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BrOXLgRj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36799fb93baso287118f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 17:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721349996; x=1721954796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b/0Rs9LYVCzkOPV0snOEhvhRpdzCR4C4QDQcI4+9TKU=;
        b=BrOXLgRjgeM5a+cqi7Cc+sZ0Wi9yqMtpd8juqST62eWSL9CXSgFnGiMSCG/sbHsaba
         ya/I+/yDs/97Gsb3sijlGxmB7vHC0IIN3CjVvyEhhrPYHlXVi/9BY8XTXdjn3xq1VIyl
         3ZFT3bzNtqb8Zpfd0OphNlDS2y4lfv8QBZQP4ODCftEJvyo8y7HrLVz9SOl9SuXg6YYx
         R/XOHw2R+uJDxO3IGmu39kpd6skvKbioI7ORNlUkEIlV1P1oAD/NGLgQ3n2Xxbua11By
         jAG99sCC3Xb4NrnlHrMnGogn3Atmw7IJQJdlfUxc425UL4BeCUnDF9ZOwVd8/UO0aFdy
         Hdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721349996; x=1721954796;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/0Rs9LYVCzkOPV0snOEhvhRpdzCR4C4QDQcI4+9TKU=;
        b=hD3WgLc0mhJaKGnBPMB5Gs5QN1LmXTJ2W+A32nyxUZ+7ARU8MLHz1AWTSfAdJBhk/U
         y6DljuSrUVOvgtOlHsPhN+abbTQZYZqhYX71fA6zQvYldf6t732suqYksMD7muNnFrdl
         15DBKtRaJx+O/TBIuYxlL2/qW0pnM1Km1Gph47DA3ajm32qAgTAZitISGgVl0/SxhpCS
         yM2++0O4u7gdJ7rJTdhFzO0rTJVfLPDK8rN6S2a4UFkIUEdSIXTr1MQwOUb8j1cSQcIZ
         dQtxbg9R2oYLvOHPEtAM52R4gGqyXt9N6Ax+/OvLX2zb2n5Kle7Ef7a3CJ/fd+lA8QzI
         s8/A==
X-Gm-Message-State: AOJu0Ywx9hyiohtkFT8M2v9aikVMD8ntBQqyQmUPPP/swstwMsGiirge
	iSHrpbaFImp/SAPr4WdlCmg9YTBhhgLG51jDaqToGH5C21mFmfumRSugOnLzT/I=
X-Google-Smtp-Source: AGHT+IGorkQZtznZEYsaTtwSRC9wDCmSMh+2+iIUDyG7PkdRo+Q0XAmCQXN5rx6ZAEG50mxn+KvIug==
X-Received: by 2002:adf:e58c:0:b0:367:8a2f:a6dc with SMTP id ffacd0b85a97d-368316f9cc7mr4449857f8f.44.1721349996401;
        Thu, 18 Jul 2024 17:46:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d41428sm1867755ad.236.2024.07.18.17.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:46:35 -0700 (PDT)
Message-ID: <ed30dbb1-20e0-4c53-a457-c1c4be80355d@suse.com>
Date: Fri, 19 Jul 2024 10:16:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs-progs: fix the filename sanitization of
 btrfs-image
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1720415116.git.wqu@suse.com>
 <b92f8d33-ff5d-4aa1-93a8-97f26f466320@suse.com>
 <20240718154703.GI8022@twin.jikos.cz>
 <87d78bde-b5aa-44bb-926d-a4eabd710c84@gmx.com>
 <20240718225524.GJ8022@suse.cz>
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
In-Reply-To: <20240718225524.GJ8022@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/19 08:25, David Sterba 写道:
> On Fri, Jul 19, 2024 at 08:08:30AM +0930, Qu Wenruo wrote:
>> 在 2024/7/19 01:17, David Sterba 写道:
>>> On Mon, Jul 15, 2024 at 07:39:32AM +0930, Qu Wenruo wrote:
>>>> Ping?
>>>>
>>>> Any update on this?
>>>
>>> Tracked as https://github.com/kdave/btrfs-progs/pull/837
>>
>> Just to mention, since the github review system is working now, do you
>> prefer me to still send the updated patches to the ML?
>> I'm mostly using the ML as a way to track the work...
> 
> You don't need to send it to the mailinglist if there's a PR, for
> tracking purposes it's ok to send it. It would be good to keep
> dicsussion at one place but I think this won't be common or we'll
> manage.

Got it. Would mention the PR URL in the future cover letters, so 
discussion would still happen there.

Thanks,
Qu

