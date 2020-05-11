Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1F1CE735
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgEKVNX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725355AbgEKVNW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 17:13:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D986C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 14:13:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so12772034wrn.6
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U8lkxcGKrltF3s3ae46o9XlcrLri/MDdEouf42qfz2E=;
        b=gzEGXWSNSuFpEtETmHDL+kBoz7Ax312sKPF3+g+UMa9emk8yE4H1qt0extTnRZJBlS
         M5UqZHemKo7H/OGZgL/Xel3qCK3h0UKDkifaLIypAHj6kvST4QQrzYnQEyYhhe7IB+kQ
         cY+G+PSB5EcgPPA0RD8EmznMkLt+h7Basy/JS9deicIvllyecfN1tTmDMh0NTlZ4fTc6
         prV4v21fHbsNlOOHcIPWfPN1hrIMggdQs1phXTkTBxDpIPil80qOR8TC16cKNKdhF32C
         m9D8bvvPfZlp3S5oCtxM+KuL4yR49KXhsqh36cq790zLBQeZdQyW2TPvRXOQzj+YDsK+
         SVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U8lkxcGKrltF3s3ae46o9XlcrLri/MDdEouf42qfz2E=;
        b=LlpdIRI9icswBVctckYyq5ne+R9ndpt+RV3hQghGJyzW9kYzzm7GD3JbkdS7+2lJQ5
         kV9iZJNr5Kb/tjRmz2N56oa3WfQBgz0M3IvwRqKdxuCUJl1afYL1T9UVdAD0gZS4dH72
         4quT6oLndCO8OOx4fjS+6iradHGJRZ6JS7XDsYcAq3eGPVAV5j2kw4gB1ZZVaYIy4xZV
         O5OsyxMAaI1949I5BKl/y2Dy4c5ScdUkY9ljQWOlQkDvxY1tmSyTAB4RxysxyF1rWSz0
         W0NVx+BgjEbn3beiSZBVxQEMK/Rxav5WFsmDloeJMR0mHZzysgnLsgKD1QVoPkUAvt9V
         WITQ==
X-Gm-Message-State: AGi0PuaOIHnOQzBHYIfS8Z9uDQ8afqQBFM88tFTHWjGgusWHrazsPwvA
        AoiH12+EV0DRoFoUCMmSrEEOXYY7
X-Google-Smtp-Source: APiQypJ5zyk81f0t+nqnRL39X3yd95yK6YDdxuSqVXb6k26QWpQ55r9Qu414E2vo9E9HdW5zJV4svg==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr22000189wrs.358.1589231601374;
        Mon, 11 May 2020 14:13:21 -0700 (PDT)
Received: from [192.168.1.230] ([151.36.26.23])
        by smtp.gmail.com with ESMTPSA id s11sm19106401wrp.79.2020.05.11.14.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 14:13:20 -0700 (PDT)
Subject: Re: Western Digital Red's SMR and btrfs?
To:     Phil Karn <karn@ka9q.net>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
 <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
 <20200511050635.GT10769@hungrycats.org>
 <bb237d74-49ab-27e0-0286-5bdd880dd2cb@ka9q.net>
From:   Alberto Bursi <bobafetthotmail@gmail.com>
Message-ID: <69847faf-5fb3-9eac-b819-373a0f814044@gmail.com>
Date:   Mon, 11 May 2020 23:13:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bb237d74-49ab-27e0-0286-5bdd880dd2cb@ka9q.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/05/20 22:35, Phil Karn wrote:
> On 5/10/20 22:06, Zygo Blaxell wrote:
>>
>> The exceptions would be data extents that are explicitly deleted
>> (TRIM command), and it looks like a sequential overwrite at the _end_
>> of a zone (i.e. starting in the middle on a sector boundary and writing
> 
> 
> Do these SMR drives generally support TRIM? What other spinning drives
> support it?
> 
> I was surprised to recently discover a spinning drive that supports
> TRIM. It's a HGST Z5K1 2.5" 5400 RPM 1TB OEM drive I pulled from an ASUS
> laptop to replace with a SSD. TRIM support is verified by hdparm and by
> running the fstrim command. There's nothing in the literature about this
> being a hybrid drive.
> 
> Doesn't seem likely, but could it be shingled?
> 
> Phil
> 
> 
> 

Afaik drive-managed SMR drives (i.e. all drives that disguise themselves 
as non-SMR) are acting like a SSD, writing in empty "zones" first and 
then running garbage collection later to consolidate the data. TRIM is 
used for the same reasons SSDs also use it.
This is the way they are working around the performance penalty of SMR, 
as it's the same limitation NAND flash also has (you can write only a 
full cell at a time).

See here for example https://support-en.wd.com/app/answers/detail/a_id/25185

-Alberto
