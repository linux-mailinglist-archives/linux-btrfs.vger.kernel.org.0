Return-Path: <linux-btrfs+bounces-5511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7E8FF77D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 00:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B8D284C1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2913C812;
	Thu,  6 Jun 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q/r2hCdM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9F4F5EC
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711497; cv=none; b=dNNs4LB1NoUi0Tq4FEVMeQXBFHSXqJLlLHRVIFqMSwL3ZYK2xRuumeFmp9K6TC+B2axF3tqUaU7K8mHZsDq6fJwNwBWTXy7BTmBdsGitCAl9BaFpFcqR2Y9twYl95u7kGSwfIlq3RPdJpk7JNiEY15IZycPrUe56R8i9avu7eeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711497; c=relaxed/simple;
	bh=1M34sIClIxdXbDQ0ZJ2WD7svtjBqwm1E5JAaMGjuJnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moplGS3S41JsVH7tTnkRdWEApwWVLOrnlg0U22Z7fR8HI44mDTX3On3pbL0pCc1biGjxrLSvjvBas/d8vcsIvipkn9qMLRyDaDdC+Cmak4+gVpGG2Rr2rKwVjwlsZeInBlOZt5F3bJ8Mi5Orwil3P4C5wOSM5jeW7bOQqgKZ2Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q/r2hCdM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ea9386cde0so18257291fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717711493; x=1718316293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V3fnNMIUsewHwTGsj+FdtgF4zM+V+zyraBxlCPQlCvc=;
        b=Q/r2hCdMgRp2uz64diViufjLB+1HhJhxk0w+fhaxnMv7s/erJ3R0sNNBcHUgZ/Uxiq
         fDXPsKj980bYCPeR44ew0tAYGs5gYhks2t7dURvHa18RzM77ia1shCPkJh+Mr5IxXCjs
         Cfvooa0MOyFsgN0VhmFZt4ZHufpHAxZrHEmB2JKD0rNuSfoBFVFybBcc2LCmBr843e6S
         LCz/E+am7xXMvh7WHHEgyl4Rlsu6N6fIzAcA1qLKg9DGJWuoM5TMN07GEd8WY9OIbXVv
         8fB+sCsjMPd271QzZahYS8aKTxEvK4oDH+saXGOmpVuePG7EGZHf2J82m3WyP0+9r5en
         K6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717711493; x=1718316293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3fnNMIUsewHwTGsj+FdtgF4zM+V+zyraBxlCPQlCvc=;
        b=KnsvprQqRbzQB9m02OYBOf1Cx6c2sEso7dzPC3LhnXoxTkv6thjIV/OHUGKAWrXBiq
         sa1bcyBu++6PDoXbEw01GZ2r7wmYfgWh21lRa1uFBrnhaM2Rbblb7lJ+jnICovX/O1Rx
         H3mTTU0x8M9udGMUrYrxi8jYwfenu6eWmyUuOXXYqeFi8ot+bvzNsX1GSaWaad7f6N7i
         9klqm0G1Z5K1YBwer7hUCjoBTF9z5MMT87OaiKvlqy/srsz3H92kssz1Oat4/I0YxiPJ
         XGQ7BFwYtn/0KZIA2n4IqNUavu4bEeVh7msczx2dEY+cV95P6PmERL93HQe7PzhSqvBx
         +6zg==
X-Gm-Message-State: AOJu0YyHx9GXZ8TsWJPQanmfmyWcRGGH1Kwa4ytNGqvqY/VWNcUb6nzL
	WMhEb1a0xW24vVoh5ET0mZARB9RiIWwQYfSfU7n4M5W8jbEc9Nd5plCJbE05NE0=
X-Google-Smtp-Source: AGHT+IE2JHwy//As4OKCrvH+aUbUA3wqpKEZwq1KE+tKy/t17AW7cjvcg6CbCC4xlKBEuAM6sPLx8w==
X-Received: by 2002:a2e:8e32:0:b0:2e3:93c2:4239 with SMTP id 38308e7fff4ca-2eadce32bd6mr5268261fa.21.1717711493012;
        Thu, 06 Jun 2024 15:04:53 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806ccf77sm4216154a91.51.2024.06.06.15.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:04:52 -0700 (PDT)
Message-ID: <b0d99324-0e1f-453a-800d-e1967a87a997@suse.com>
Date: Fri, 7 Jun 2024 07:34:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: qgroup: use xarray to track dirty extents in
 transaction.
To: JunChao Sun <sunjunchao2870@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
References: <20240603113650.279782-1-sunjunchao2870@gmail.com>
 <0610a1b0-78a6-4c1f-9188-69b587c8146f@gmx.com>
 <CAHB1NajCcMA_VeBndEd2HMB=wbrX4iLYZGpb_jyw7mcd0Pyhwg@mail.gmail.com>
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
In-Reply-To: <CAHB1NajCcMA_VeBndEd2HMB=wbrX4iLYZGpb_jyw7mcd0Pyhwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/6 21:32, JunChao Sun 写道:
[...]
>>> We have qgroup_mark_inconsistent(), which would skip future accounting.
> 
> Yeh. I saw this function. But it sets the
> BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING flag, which will skip some
> accounting.
> Do you mean that there's no need to account for this inconsistent state?

Yes, since the numbers are no longer correct, there is no more need to 
do the accounting.
That would save a lot of CPU and IO.

Thanks,
Qu

