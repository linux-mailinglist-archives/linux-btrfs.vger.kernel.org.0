Return-Path: <linux-btrfs+bounces-5702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5939906738
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 10:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0141C213CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3313F001;
	Thu, 13 Jun 2024 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YGwhODsM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48D13E038
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267995; cv=none; b=nFAqRTZgfbnzh+qc/tnuOIhtnD/gllU7jzH8p6cRHAXgGUw6dXjWHHsq7vDPNVclIIyq7PLJom/0K60G/aRN9emUQiIMdmUDZ7E5dI/n9yM0snB/Y0fub/+wgJB8FjtEDDmtyPQp2hK0RiRmimmNbR8CKtMnx1A8ajcSIC+MqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267995; c=relaxed/simple;
	bh=4Wptr7xanTi/1qo+s2AIExTqg4nqGAhCWZK73nknmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=katyZynyDLTBZc0hQQhiUmvYjBP5BIWhYhBPXqmX0PPZSF5RX9PXuAgGrLSUiSngAVhIfa+mmnYvPlpGpyAgWutwvrmstoVEPxrdpzSQ57CTSI5Fen71FAHHFEC/KUWM/eCbefnXe7grWNvTPQl5hXSLcGeewQ5uEAaO0NCq9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YGwhODsM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebed33cbafso7782251fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718267991; x=1718872791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=18K1ly295RSLEDmo2uIxLcN2ht9kfJ+ZAOd5mvSDxZU=;
        b=YGwhODsMq3eKMKe2BOm5b5IAFz2VOWZyIeJ9YTEBIUztb8igYTQhZdw24wsz4zIu8o
         mCTXLgqlqHJzy9G4oTcOVXvtnKyyc9HfAYZjNWanIMCGzVu6VUruSXJP9TI9qW3aGeez
         vKN5nO+1ZGkSlcNS8FzDM+jeHmG5Eip/iVWJ99V0oaUu/foomUf8fX7jq3+BOcfyXLQd
         5gDrIqYmwv+GNhDWXzYi76ayyeqVDj3P4h4dyGEyaocH3kkYB9RMaM/sjMOpF2cQPgWH
         qAG9+MB9SJRkV0opBdzbAIw7Xf6m2dLjZR57aBCJ+mhQcLMjLu5jKTA94ark/Q4kAXfC
         2o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267991; x=1718872791;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18K1ly295RSLEDmo2uIxLcN2ht9kfJ+ZAOd5mvSDxZU=;
        b=Buq9Huy4voGA6lJ8WWWiYfmkF9vH4Ce5CAmmNRIpUzGsWI3VORyDevzgyYF1q7tjZ7
         WhJbjXdM9FdFOYCsU0zg3BOJpscZQVHLozTUSemYAzDV6sUYW43DgQrSraxIGHNvUrwh
         GyLAqPHP7ULiCkG7I7/A23oHSvkEjtJG6f3D8cBZVdjOyg5vfvgEIF0pwWXTTLAjF5ij
         EpzeZbjQfH3PVxrae+Pisih+uQRYESp8YEaiZGwnyIRrWLG1OCS0+8TrcOSOfU+J2zrw
         3JoUxgoH21ujyamWg70Pju3CzVq5NOVtUqvoahDW0PWTVzcqFDT1R+juQ82rjsNN5hUx
         U0lw==
X-Gm-Message-State: AOJu0YxLAjedFpl8qOk8byv3BRDCvcP+tMcuPXwU7Bgf4/t9O9vcVZng
	/wP1ePZ0d/ZhPWWtRC3z59Z0tjmvLjfS88SnhcTfm0vbJzP/pmchXDrrhzdYZRs/E1EO6pfxILR
	V
X-Google-Smtp-Source: AGHT+IEWyC6lydiIvBQ1z76H44CwYOtjpimgB/nXPrnGPkO/gWWyFk8st3cZEgWDnhZ2X2o/rnlUwQ==
X-Received: by 2002:a2e:b606:0:b0:2ec:176:4ef with SMTP id 38308e7fff4ca-2ec0176064bmr15658451fa.46.1718267990710;
        Thu, 13 Jun 2024 01:39:50 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75d1d40sm3329477a91.9.2024.06.13.01.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:39:50 -0700 (PDT)
Message-ID: <45911acf-3035-4e6c-9f33-5704eae31014@suse.com>
Date: Thu, 13 Jun 2024 18:09:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs-progs: move RST feature back to experimental
To: HAN Yuwei <hrx@bupt.moe>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1718238120.git.wqu@suse.com>
 <3E9580E891A06375+d6a5f369-32e8-467c-a230-82298a979d10@bupt.moe>
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
In-Reply-To: <3E9580E891A06375+d6a5f369-32e8-467c-a230-82298a979d10@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/13 17:17, HAN Yuwei 写道:
>> This patchset would hide RST feature back behind experimental builds for
>> mkfs, and completely disable rst for convert, so end users won't and
>> can't enable RST by accident.
> How about introduce a option named like "--experimental" to enable these 
> feature?

Well, that's exactly what we (at least me) want, to make it harder for 
end uers to reach it.

For you, with your advanced subpage and zoned setup, compiling 
btrfs-progs should only be a small hassle, and you only need to do it once.

Thanks,
Qu
> 
> It can work perfectly and don't need me to re-compiling another 
> btrfs-progs.
> 
> HAN Yuwei
> 

