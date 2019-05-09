Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0111852C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 08:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEIGN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 02:13:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34997 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEIGN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 May 2019 02:13:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id m20so967835lji.2
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2019 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVgcvXiOiG4swDOuHENNcHXvaeqYZnpwy/us6vg00h0=;
        b=b8nVkdzczaN2/Z6plrj5tNV6BBkXsIBUKZ7Syt5LUFDypnui7+aK7omgCuyuODOg7J
         oKS2Z1s6Hqy0j4hRyrUa50QTvqr+Z/PI10OZdP6ygi2fhXBaddk/jSOlrrUZK7TPv18y
         ElJ66HCHJ90nwxUkrKC/J8Hh0YQshO13xJRTgj9QZxm14mqPxHhaWAhaFoh6O4aXimWe
         9ZAVVEH01F5MvngCceuOJ4/qn0NBPa6aNoraipkJ52n/7JRMvQ0bq5YhDBgNrp3RpPlG
         fCoPOBWZYbzMnO3UMpupLFih1MhRerD64yG0WpkK+nWGlXb8MyXwL6OVQxXwmieWIrTm
         9XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WVgcvXiOiG4swDOuHENNcHXvaeqYZnpwy/us6vg00h0=;
        b=j0lYoyrlt6zNJ+BBkjoa+w2CcTxA8ugfWBmS4FVWQU0XJq/j10cdMunObI16mEQDFG
         N82xoKquDcdkual73vF2nWHKp1MYrNyXnU8ot9riRLqiZcKWQa8vlSZnU+D5pW2ixCgZ
         zpmrZj5cODDz2GGeWVDYOfUVgyjflksA8cnd1WZCGbKFUjoZAQgdLblD+7eiwaZFpm1K
         wFjZUcBUTQP31Ax/4zx5Lf3nD/766+aeT95BfCJpwk6gd4kWMT1GBNRnXSDPVtXl3Mlq
         hVEmxprXZvSruubY+Z7IPsya6QVlm0LVtwzg7Q8aLtCAfcBBuqY3Smv5EnPTjPGwYMdi
         PmTg==
X-Gm-Message-State: APjAAAVaJlBozXTEsAl5KLen/cpSjpOfjjNOZUT465eupgfnHg9N6KAA
        HUcIDCcdX9ezS2LFD9cwzqjnMGVUSf8=
X-Google-Smtp-Source: APXvYqzfemGosys3FzlcmHcP2J4zaVgx2ify++KM6I/yErrQm0trfDhpPANfknheWPPQBiPFZYcB2Q==
X-Received: by 2002:a2e:206:: with SMTP id 6mr975808ljc.59.1557382403516;
        Wed, 08 May 2019 23:13:23 -0700 (PDT)
Received: from [192.168.1.5] ([109.252.90.232])
        by smtp.gmail.com with ESMTPSA id j27sm183930lfk.97.2019.05.08.23.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 23:13:22 -0700 (PDT)
Subject: Re: Hibernation into swap file
To:     Maksim Fomin <maxim@fomin.one>,
        Chris Murphy <lists@colorremedies.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
 <596643ce-64f8-121f-3319-676e58d700e7@gmail.com>
 <CAJCQCtTsSRAHR-zwPq6GgmiCjDjE2MV-QekNUdQ2mWMAzVU89A@mail.gmail.com>
 <BbXmRr84cUaKIXCRo64oHylITD5VfRS5r1IeI3r2kNC-6gMrgJTyTU8MriZHfFwCilQBXXUNfQ3G3dcFxLs6FyP1KnjkcCsmVh3xZmAdR9Q=@fomin.one>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <60258f5c-e78e-da10-fa19-29038803e160@gmail.com>
Date:   Thu, 9 May 2019 09:13:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BbXmRr84cUaKIXCRo64oHylITD5VfRS5r1IeI3r2kNC-6gMrgJTyTU8MriZHfFwCilQBXXUNfQ3G3dcFxLs6FyP1KnjkcCsmVh3xZmAdR9Q=@fomin.one>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

06.05.2019 21:25, Maksim Fomin пишет:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Monday, 6 May 2019 г., 8:40, Chris Murphy <lists@colorremedies.com> wrote:
> 
>> On Sun, May 5, 2019 at 3:09 AM Andrei Borzenkov arvidjaar@gmail.com wrote:
>>
>>> 05.05.2019 10:50, Maksim Fomin пишет:
>>>
>>>> Good day.
>>>> Since 5.0 btrfs supports swap files. Does it support hibernation into
>>>> a swap file?
>>>> With kernel version 5.0.10 (archlinux) and btrfs-progs 4.20.2
>>>> (unlikely to be relevant, but still) when I try to hibernate with
>>>> systemctl or by directly manipulating '/sys/power/resume' and
>>>> '/sys/power/resume_offset', the kernel logs:
>>>> PM: Cannot find swap device, try swapon -a PM: Cannot get swap
>>>> writer
>>>
>>> How exactly do you compute resume_offset? What are exact commands you
>>> ise to initiate hibernation? systemctl will likely not work anyway as
>>> systemd is using FIEMAP which returns logical offset of file extents in
>>> btrfs address space, not physical offset on containing device. You will
>>> need to jump from extent vaddr to device offset manually.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/power/swsusp-and-swap-files.txt?h=v5.0.13
>>
>> This says the resume_offset= is an "offset, in <PAGE_SIZE> units,
>> from the beginning of the partition which holds the swap file"
>>
>> Use filefrag (uses FIEMAP) to get the virtual address, multiply by
>> 4KIB to get bytes, and plug that into
>>
>> btrfs-map-logical -l vaddrbyte <dev>
>>
>> The physical number returned is also in bytes. Normally to get LBA
>> you'd divide by 512 (for anything other than a 4Kn drive), but if I
>> understand the kernel document correctly, it needs to be in x86_64
>> page size, so divide by 4096 instead.
>>
>>
>>
>> Chris Murphy
> 
> Thanks everybody for clarification! After several attempts to create 1-extent file it appears that btrfs can do this only for files around 500-600 MiB which is low for my practical needs. If swap file is increased to 1-1.5 GiB, then there is non-contigous extents problem.

Swap files (also used for hibernation) are not required to be contiguous.

> 
> In any case, since swap file can be (with high probability) moved across filesystem, then 1) offset configuration cannot be stored (should be reconfigured for each hibernation) and 2) there is risk that kernel writes directly to disk at wrong place and will corrupt the filesystem. I don't like this feature.

I think we need to allow at least some amount of trust to developers and
expect that this feature would not be released if it had such an obvious
problem.

Of course bug happens and it surely needs wider testing.

> 
> Best regards,
> Maksim Fomin
> 

