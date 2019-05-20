Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091D8232A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 13:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfETLek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 07:34:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35234 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731934AbfETLek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 07:34:40 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so22534010ith.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=St3bXyZfQy0p+QkVPKrZnJL/h9Gao7/ZvB+i/WGHTis=;
        b=ORecR7hEx7ZL66f4FgYNPizP3S/zFO1SZKOCKiczrHVqA7KqDHEygQTKT5weEScnoX
         bw7gIXL2/Z3pbzAKnFePNmmaGsrPhR12rE3prCev5CGsTSPYvmFT/zGM0toxCubF1dEm
         CeR5OXqqLmbfBpN6gEANbLB6Rsrm1woJjyL/CgaFBJZDRhrtRROHG0xq8N/BUrcpcNJZ
         8XLUSawF4EJ4Qq8SYKFnduBAHd9cEPgQKD6meax0lOYOod8woez7AxKOsf2TAej0XR72
         cy3WZK4IYjy8+d1cd/BlhGC72hFVthKJSkhXQkrVGSfNr16P9jCMlUCbfQBIG03qC8+L
         /5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=St3bXyZfQy0p+QkVPKrZnJL/h9Gao7/ZvB+i/WGHTis=;
        b=qVEuMhCjFDOXb02llWEuWgnbgT94DaweYjoa7YdX4YKtT5UFk6s/HqSeEy+W1gdZ+b
         7FQ5jKhPs9+wH4j6Mj/akaLqzsOhagccZwyDSGJBDOm4DuWEXptkf5X4gvWbXY608k2h
         yT8AtdOS5bAhYpASDnu5Ih21RKc5BhJXwyEww1DG4UCWDqz/jIgowooVdbz1nvwY3yFJ
         yhIHBAHrTN4OAvVV/CY6CukVRV5t8mjqLPsgbZRVnfSzNLni9Xvt2z5cK6nAubR1XIOt
         RRulEg80RzkxltlB9NAyIotAs1JerpH8t8lz1HTRMuQetLdt47n6NnXahlHIV55/rEXz
         gC1g==
X-Gm-Message-State: APjAAAUQZU8FHNMZqvPWLdWPQ2acOSFqCKeFYCkOXEoJV7II05DRKmYZ
        OHmQo3eOqAFGtLHgdnNl3qZwo4y/6jI=
X-Google-Smtp-Source: APXvYqw6xkGvRq1hFQY3oWexq4FcgqE047gKoSt1VxbcS3X+h3lJbC0ct4wXNy7NteBxUwx66pL+aQ==
X-Received: by 2002:a05:6638:350:: with SMTP id x16mr5808681jap.95.1558352079115;
        Mon, 20 May 2019 04:34:39 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id b81sm4450174itc.33.2019.05.20.04.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:34:38 -0700 (PDT)
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Adam Borowski <kilobyte@angband.pl>
Cc:     Diego Calleja <diegocg@gmail.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz> <2947276.sp5yYTaRCK@archlinux>
 <20190517190703.GA6723@x250> <20190518003808.GA17312@angband.pl>
 <20190520074750.GC4985@x250>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <6b6f85cd-ec77-a39f-8afa-2c0f093d77ec@gmail.com>
Date:   Mon, 20 May 2019 07:34:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520074750.GC4985@x250>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-20 03:47, Johannes Thumshirn wrote:
> On Sat, May 18, 2019 at 02:38:08AM +0200, Adam Borowski wrote:
>> On Fri, May 17, 2019 at 09:07:03PM +0200, Johannes Thumshirn wrote:
>>> On Fri, May 17, 2019 at 08:36:23PM +0200, Diego Calleja wrote:
>>>> If btrfs needs an algorithm with good performance/security ratio, I would
>>>> suggest considering BLAKE2 [1]. It is based in the BLAKE algorithm that made
>>>> to the final round in the SHA3 competition, it is considered pretty secure
>>>> (above SHA2 at least), and it was designed to take advantage of modern CPU
>>>> features and be as fast as possible - it even beats SHA1 in that regard. It is
>>>> not currently in the kernel but Wireguard uses it and will add an
>>>> implementation when it's merged (but Wireguard doesn't use the crypto layer
>>>> for some reason...)
>>>
>>> SHA3 is on my list of other candidates to look at for a performance
>>> evaluation. As for BLAKE2 I haven't done too much research on it and I'm not a
>>> cryptographer so I have to trust FIPS et al.
>>
>> "Trust FIPS" is the main problem here.  Until recently, FIPS certification
>> required implementing this nice random generator:
>>      https://en.wikipedia.org/wiki/Dual_EC_DRBG
>>
>> Thus, a good part of people are reluctant to use hash functions chosen by
>> NIST (and published as FIPS).
> 
> I know, but please also understand that there are applications which do
> require FIPS certified algorithms.
Those would also be cryptographic applications, which BTRFS is not.  If 
you're in one of those situations and need to have cryptographic 
verification of files on the system, you need to be using either IMA, 
dm-verity, or dm-integrity.
