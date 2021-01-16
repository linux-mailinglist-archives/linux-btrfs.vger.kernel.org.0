Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723C42F8E41
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbhAPRWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 12:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbhAPRWA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 12:22:00 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3278C061573
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 09:21:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x20so17877984lfe.12
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 09:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YeaTqlKoDgY/Ufo4TkEnww6RYuTJ6cs13JlIz93Zv3w=;
        b=ITNyXBJSzz0P17YXoGXRpO2enSOGRFZ4y6Y18ytNNzpX2bESRH8pja/BStwJigsGHk
         6XCdWQlMJKQO8Y8t3JrqgJRb8fnl3WnouVvisz31d7XyEzp/k73a+RRjLmBha4ju6Y2V
         Gy4v2C0+EvcicxIIK3SLsan9bEwsZRCcn3pXn4yLANnmn7G2Prh204f1yzgeGHLjXcPF
         cVJdYO5l9nlY3+vJkih3lKG9nkZLW9LIziDP7yC+1Y7dVZup+t70C36QK4WxEjNEmNF2
         KfPoMD5LbflvnxbQkdkFb+UevJ5FibYtO4w/pkSUrDu5R9jZE/CuuDK7vfxa1MSMMVnX
         +gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YeaTqlKoDgY/Ufo4TkEnww6RYuTJ6cs13JlIz93Zv3w=;
        b=LbQxcSyXE25t9eBqBaeGi1JRXeGlHTfyqPDr9v380WfcYbMwXQd8mQQ4iKE9T3UTro
         7dGw7zTrMQhoIED3Y0z/st7kAQx0y9fRGfbiXVHwFNRRPs5eQZYiT7I2LckwrdDcwxYs
         u7MSJJWCLUSCaLCtLpiCoBM/nl2q6aIoBghSXgZ5t43MzkqBG9KNZkofoks4nwpCVAfq
         Jl5R4neVjuZIkMfQ1daepzYXFmLVgHmBsLlS050o36z2gET1TmCeIhYE0HiPIm1FveGz
         NrmETOw1IJyn8+2voQu8IzC+fe8pB02hyx0EJozsWIL10eFduXw8So8HJKOPfmDgza7i
         BQJQ==
X-Gm-Message-State: AOAM533Wrs1mIUQ6TAo80zEOc+Nz2itrLYVi8JzR81RnQNx2tKx5qy5u
        fo5Ho+NwR0zyBpzjoJYnYXAZ7IdHMIY=
X-Google-Smtp-Source: ABdhPJy1MLcp/SGHsiI24V3XohhAzaejOY8cKqSGbF2fZvTx6NVan0PqTjxom7NAl/1JWoOg4FBr8w==
X-Received: by 2002:ac2:430a:: with SMTP id l10mr8464428lfh.22.1610817678143;
        Sat, 16 Jan 2021 09:21:18 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id t14sm1322344lfl.216.2021.01.16.09.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 09:21:17 -0800 (PST)
Subject: Re: Why do we need these mount options?
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        waxhead <waxhead@dirtcellar.net>, linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz> <20210115035448.GD31381@hungrycats.org>
 <94a65b16-3a23-6862-9de6-169620302308@gmail.com>
 <20210116151933.GA374963@angband.pl>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <af37a93c-65d3-1213-73cf-1463679d815a@gmail.com>
Date:   Sat, 16 Jan 2021 20:21:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210116151933.GA374963@angband.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

16.01.2021 18:19, Adam Borowski пишет:
> On Sat, Jan 16, 2021 at 10:39:51AM +0300, Andrei Borzenkov wrote:
>> 15.01.2021 06:54, Zygo Blaxell пишет:
>>> On the other hand, I'm in favor of deprecating the whole discard option
>>> and going with fstrim instead.  discard in its current form tends to
>>> increase write wear rather than decrease it, especially on metadata-heavy
>>> workloads.  discard is roughly equivalent to running fstrim thousands
>>> of times a day, which is clearly bad for many (most?  all?) SSDs.
>>
>> My (probably naive) understanding so far was that trim on SSD marks
>> areas as "unused" which means SSD need to copy less residual data from
>> erase block when reusing it. Assuming TRIM unit is (significantly)
>> smaller than erase block.
>>
>> I would appreciate if you elaborate how trim results in more write on SSD?
> 
> The areas are not only marked as unused, but also zeroed.  To keep the
> zeroing semantic, every discard must be persisted, thus requiring a write
> to the SSD's metadata (not btrfs metadata) area.
> 

There is no requirement that TRIM did it. If device sets RZAT SUPPORTED
bit, it should return zeroes for trimmed range, but there is no need to
physically zero anything - simply return zeroes for areas marked as
unallocated. Discard must be persisted in allocation table, but then
every write must be persisted in allocation table anyway.

Moreover, to actually zero on TRIM either trim request must be issued
for the full erase block or device must perform garbage collection.

Do you have any links that show that discards increase write load on
physical media? I am really curious.
