Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6722F082B
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhAJPjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 10:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbhAJPjQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 10:39:16 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3DEC061794
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 07:38:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v67so6008155lfa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oAcLaNVJTJBnqpgMhIvtj3rusLo/C8g3ZcWWSCdusSw=;
        b=TKHEAnu2k9A5tP6KwSCm1369kHgWeLP9yOTWkn4gdluVJTBLjrN6Q+zirwuAS+irMH
         7QWFNP/YRIUGb1o4QntIkopa1k9EbhM4tC2xqmUbNYRkRjyXlXTec1AUqDtV+pVbn3Kk
         q3wPZtRMGSkBfouX/C6KhkE6gmMONoIAawcRrCYn/cMWMTmIkGDCMiT0xztz0lY1Xamn
         ZZeh+h9y4bM4MkUX/GYcwOfbm2fNLp9p9aj2zDOWyDY64VmEo7HMzai8LxTKiZ37xgTB
         5EBlMYUzKBUaGzPpz2D1OAn05lqyA1r0cDLy7Wqp+/NLxq6hBWv8XZwlRWDWsqShv/ng
         kFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oAcLaNVJTJBnqpgMhIvtj3rusLo/C8g3ZcWWSCdusSw=;
        b=BLDJG4CzyLTg8Z4AF2cqkdVqYxDgYT5k8L2vU1Aq+r5OcVEzyCkmX8/sFOzJXIUpI5
         zCBoz7X7bvNiLg1uffyXdtWNvHA04U46NycGYLULTEXoQvLzV76bjmGE2wZC8fymwucb
         CjfWF3EUiED+q3yJIQT240YSKnhDnbtzk8xvuh61btLcGfH7tCT1qXHCvGYSQ/EyRAa6
         8IPbORmHqWWB5n1h91SQra0lDsMDhN2wcMnOb4npm6yP6vObBAe8NUVjRGiimDUpn7OW
         Iv0o998TyKlEooePprzIng6IR55MoWzadMAYTdWLwLcC8yDVDKSIULkUgH4WtTECCbvG
         U2cg==
X-Gm-Message-State: AOAM533CjdHw/jmnb+k3qdp95dtFeqOiYekaLkaNNAsnBYIj/VCwuZno
        GMgMtxC6Sc62Y5e6GTZKl2nL2b7oH84=
X-Google-Smtp-Source: ABdhPJxc3Y9j2aZgb7Y8qBWlgfcTChoQyYSlXIPM5k/o40GEf0+cX0PUuw0OH4SMBaU4Sbwlc3ZTpg==
X-Received: by 2002:a19:cc05:: with SMTP id c5mr5283322lfg.393.1610293114269;
        Sun, 10 Jan 2021 07:38:34 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id v7sm2984952ljk.60.2021.01.10.07.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 07:38:33 -0800 (PST)
Subject: Re: cloning a btrfs drive with send and receive: clone is bigger than
 the original?
To:     Hugo Mills <hugo@carfax.org.uk>, Graham Cobb <g.btrfs@cobb.uk.net>,
        Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
References: <55cef4872380243c9422595700686b79@mail.eclipso.de>
 <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
 <b709a56556c3adfc9ff352f2a51db3a3@mail.eclipso.de>
 <067af02fb023de04276f14aa6f26ae8e@mail.eclipso.de>
 <8344b57d-9a2a-f4e9-59cb-42d6a7fa0600@cobb.uk.net>
 <20210110132112.GA1374@savella.carfax.org.uk>
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
Message-ID: <7de05d01-662d-f05f-cba8-a2524a088673@gmail.com>
Date:   Sun, 10 Jan 2021 18:38:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210110132112.GA1374@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

10.01.2021 16:21, Hugo Mills пишет:
> On Sun, Jan 10, 2021 at 01:06:44PM +0000, Graham Cobb wrote:
>> On 10/01/2021 07:41, Cedric.dewijs@eclipso.eu wrote:
>>> I've tested some more.
>>>
>>> Repeatedly sending the difference between two consecutive snapshots creates a structure on the target drive where all the snapshots share data. So 10 snapshots of 10 files of 100MB takes up 1GB, as expected.
>>>
>>> Repeatedly sending the difference between the first snapshot and each next snapshot creates a structure on the target drive where the snapshots are independent, so they don't share any data. How can that be avoided?
>>
>> If you send a snapshot B with a parent A, any files not present in A
>> will be created in the copy of B. The fact that you already happen to
>> have a copy of the files somewhere else on the target is not known to
>> either the sender or the receiver - how would it be?
>>
>> If you want the send process to take into account *other* snapshots that
>> have previously been sent, you need to tell send to also use those
>> snapshots as clone sources. That is what the -c option is for.
> 
>    And even then, it won't spot files that are identical but which
> don't share extents.
> 

It won't with "btrfs send -p" as well.

>> Alternatively, use a deduper on the destination after the receive has
>> finished and let it work out what can be shared.
> 
>    This is a viable approach.
> 
>    Hugo.
> 

