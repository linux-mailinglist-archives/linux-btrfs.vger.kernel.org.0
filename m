Return-Path: <linux-btrfs+bounces-18872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B44C4F65C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 19:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DD84202F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A563A1D15;
	Tue, 11 Nov 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyapcc2u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66028468D
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884863; cv=none; b=kateOT9DcnRZNBAQawauDmSWzC4lUDnTEteVqPMfNPhJo3U9uSckiuW+xr3mLwX9z3CErYonU9+3x2tAnxbB4hJxPCWitgJzWwxCS7TFqxblJukwyrcsQtoEXZd58ju93fxgdm4Es7uPnjS3lano3wh8CaqUO7XD/xYkKr1wi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884863; c=relaxed/simple;
	bh=pSNsDEgBBcwi/hZtr0DaCrWk1QoK/zlAkLqeQJurnQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PXo2Es1DxSFugpttPJVvYilZk9ePx9ttBL0jxL29azDjaxfDN6WLwJtwXXFjCmded8sHOUujlyRObFFkEQzi6mb7KIHXFnuWMJqAND451xL6TStOFH7iS4RjzxIKQyB5zyLIxWcAvg0mKJJPbSGA48n+3g+K7J7PcFZbr838Ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyapcc2u; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a415a22ecso374321fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762884859; x=1763489659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNtBXAC025YrMqs/Gm7VEFeqkIkY9IFaHUhw/TUUSaE=;
        b=jyapcc2uYJU9u2vGiMlo2uM6miFMN9DrTkjgwnjZCLm1OdOizWa0SUCGj16TocvocS
         6bK0PkqpmipVc80O9GSn2v/xq9x/NaNEmy2Mbl3VQFIprxI3I4SKnePjRJU6oHH3InOL
         610LIPwpkn1ZALVgKPg1FKhfd25eU/DOwV4CZGmD34bd8AHIiatbdr8n4HvxjVYsmtO4
         WeL1yemxpnNRpAUDn2/0qbbSw7IEg6+GiiUlxVXtAyWw2XeL7YsWU3GVKHu8JQv/nf15
         35UNUQn4NuUN3bU//q/uYRmaBJxQl5XXAsje9IW7QU7eP8m7tnQ6ydcPP/kBrluLcG5y
         jMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884859; x=1763489659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNtBXAC025YrMqs/Gm7VEFeqkIkY9IFaHUhw/TUUSaE=;
        b=ur64r/523e2xSMFs1CChwfQrHG5OIwp91U1LnYITfuG7NXLP8g9Gux6nS5RspunKl9
         ckJ9hL3Ox7f+qYKEs1oHxjlnyGtvG3PlV0S9DMNLYGgC/cKg35xAhd+S54KqNANRQf8O
         oQmFSRYMHodBVQRqRwBaT0bJu0uSPWhPS5/NK/0rcw28mQORKVqEdmVioljHQhIcKOj5
         maYkyzrwkRTFZ6AIzXbOoasjL/FgN/FCV/glPuzfeF6Zz6JJUvtFac0UNz6TchfzrBYC
         apVQcH11bJ7yplIv16lB1Mjvn3QgzCzykMU/FQCBA4J6TrGZhcklQn/auwMTI035tmnU
         BjoA==
X-Forwarded-Encrypted: i=1; AJvYcCW6dd8NOra37hNeB0YwaKMnFUWEf8cABFxmiapBBbJqG6Gg4Ur6188Y4uE1ESdgM3CfJV7eYohXtaI6vA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SaQSlifVS3BPIsdvx3mPpQjUisCukAXH7LhTbO/4IHwKhH5k
	ZJhR8C0gSVTdKCs9FhFvwL0QB3wxYsJVc5o+Ui00NZkoC7QeTusptQAZ
X-Gm-Gg: ASbGncvW7miY0mBCH+mplReDVsDYQJAMloizB5Bw0bAvEkPM0kdiFjvN06epXP5mX0t
	ljdVDI6wlkG/Pae9muRxI1lmJntEvr0s3TM0fH+5VKuq3pAIQjKovTooNTTdKscVaf0j1vd5uuv
	ufGt9370dVJJVfIoik+JuI2rJTc10efhx0Fso/uaq5mTpDtbkKpEw5NqDKc86mlesgBEcXQKbNB
	TnA8xY7w66VHuVOeEoMLOvdfZdoiOHqcq1cYVkfltWU25sTjk4sbvJzH0U3tOf884YgA9vBGXFI
	n56bCnNj50gQEqOskI4tAiIfI4L/TNa9EW4wpYWPyzIbIpl7dgoShCbCRi8lQ3S6agmxUavmNsE
	+LfwtSAE06v0a2ODMFI77ucId7wWLAEb7xIS60iklSll8b6MGU0PtbFx0teVBFkhxt+5dE0S/p2
	Vl9zQXNYeuGLbMRmy7SG640f35zvx2AZOcK1+/XFiMbXK4HUk4NxQoSMg=
X-Google-Smtp-Source: AGHT+IEaB3r9Z02U055FSBKW5eCZpPBe0WnxDv0mb3Zbwlt/ruF8MywwdjWmDPI/tE19w+XgulZMwQ==
X-Received: by 2002:a2e:888c:0:b0:364:c083:2fec with SMTP id 38308e7fff4ca-37b8c65310fmr384431fa.7.1762884859046;
        Tue, 11 Nov 2025 10:14:19 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3b0f:8291:a9:f7fd:75c9? ([2a00:1370:8180:3b0f:8291:a9:f7fd:75c9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0ee523sm44097801fa.42.2025.11.11.10.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:14:18 -0800 (PST)
Message-ID: <58c1929c-5e61-4a8e-adf4-c86f9966a472@gmail.com>
Date: Tue, 11 Nov 2025 21:14:17 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RAID1 vs RAID10
To: Nicholas D Steeves <nsteeves@gmail.com>, linux-btrfs@vger.kernel.org
References: <20251020122115.GA1461277@tik.uni-stuttgart.de>
 <CAA91j0Wfg2uZptchB-aeaB44C+=igPMP-mZg6ovidmLs_dW4hg@mail.gmail.com>
 <87cy5txoit.fsf@gmail.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <87cy5txoit.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

08.11.2025 05:10, Nicholas D Steeves wrote:
> Andrei Borzenkov <arvidjaar@gmail.com> writes:
> 
>> On Mon, Oct 20, 2025 at 3:23 PM Ulli Horlacher
>> <framstag@rus.uni-stuttgart.de> wrote:
>>>
>>>
>>> I have just discovered, that RAID1 is possible with more than 2 devices:
>>>
>>> https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html#profiles
>>>
>>> What is the difference to RAID10?
>>>
>>
>> In RAID1 each chunk (copy) is located on a single disk. In RAID10 each
>> chunk (copy) is striped across multiple disks.
>>
>> https://lore.kernel.org/linux-btrfs/87v8qokryt.fsf@vps.thesusis.net/T/
> 
> Does the RAID10 profile still have equivalent read-speed to RAID1
> profile on recent (>=6.12) kernels?  Last I looked into it both were
> still limited to the speed of a single-device.
> 

This is true for any single stream IO pattern unless it is using very 
large blocks.

To parallelize the single stream IO the stripe width (stripe element 
size, strip size) needs to be small enough. OTOH it will kill sequential 
IO.


