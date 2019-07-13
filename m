Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655A567ACD
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfGMPIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 11:08:35 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:39382 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfGMPIf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 11:08:35 -0400
Received: by mail-lf1-f41.google.com with SMTP id v85so8286227lfa.6
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2019 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EYCEUoXhUG9ZsJ5HyPJ68lHrX+29DI3DrGgXjF4mT1Y=;
        b=F1sgu1/v11Iux+18EeYM1skFBuASng7MwETJVicM9uuH9L0KPC+TFG6fzAsR7aGAQR
         Kr8NACaFelTKAE4qDz8Veqi/xAOeLlnvRkVRHGe9xQh93oW/kP4UIdlH1yuNxkOsBx5c
         Dp02JTQztJe5Hb684AgXVra2HhUVaB1iIfvl0ngF4ImnGrr+k32CU0J6ecddLCApJRom
         xc1KvG9hOcUfJU0XY6unOgqvhHxsBTjWNFh8JP7i+R2rvsEysu7/r7NJzPYac6XkFnxw
         kPqveb/EgnUL8vAZH4RQx4tdocZhixiyBPm4SEZr/Gm3dmfzflBnQNUGp1YzhjgEmoSZ
         w8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EYCEUoXhUG9ZsJ5HyPJ68lHrX+29DI3DrGgXjF4mT1Y=;
        b=V+B0uD6/RngT8nPQxTFVtdVh4lSOALcx3lE0d0so1aRaUSewi/PaObq1vKXC5GNa6P
         uMVMzE3uaBeqPBTeEoQXk73D5lkFfM88HE1dwPCM5lupn8YsnKHYzwTtDgSqEw65yicZ
         T1S3XVE73EG7H9mubyvqiZpMvFm0ThCKGc4NK3OyGxLwWkC4Pepg1VzIWw60/baObkUS
         AiXOfRRCOAlElVwQKqezJGYtdZFNhYhWIifEiFxdryokN1ue5/TiQ3MlZfN9KdaL486b
         gD5suBpYHYovG4wGU2MzXdiw3aI2yepITXXT08tqjG14yOErD7oP00McpXq63VveMHLP
         4wCw==
X-Gm-Message-State: APjAAAV22Lj8UaDerz83DrcxdNRnAiRDxKXu6qixXrlvPbAKK1UUk8/d
        pYDz2+D8vEQKZsWzypd16L4f1Pxg
X-Google-Smtp-Source: APXvYqzPKwdYM5weg7FqCx634WeKTyhTGJZfdNmzQRTX0nB7ALmVY8EVXWVqkW+iixvW2Qo0tdq5EA==
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr6644625lfp.99.1563030512566;
        Sat, 13 Jul 2019 08:08:32 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id h22sm2034767ljj.105.2019.07.13.08.08.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 08:08:31 -0700 (PDT)
Subject: Re: find subvolume directories
To:     linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
 <20190713082759.GB16856@tik.uni-stuttgart.de>
 <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
 <20190713112832.GA30696@tik.uni-stuttgart.de>
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
Message-ID: <5c596c6b-94cc-998b-6992-adcd15128178@gmail.com>
Date:   Sat, 13 Jul 2019 18:08:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190713112832.GA30696@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

13.07.2019 14:28, Ulli Horlacher пишет:
> On Sat 2019-07-13 (14:10), Andrei Borzenkov wrote:
> 
>>>> It is entirely up to the user who creates it how subvolumes are named and
>>>> structured. You can well have /foo, /bar, /baz mounted as /, /var and
>>>> /home.
>>>
>>> And how can I find them in my mounted filesystem?
>>> THIS is my problem.
>>
>> I am not sure what problem you are trying to solve
> 
> I want a list of all subvolumes directories (which I can access with UNIX
> tools like cd and ls or btrfs subvolume ...).
> 
> 
>> but you can use list of current mounts to build path to each subvolume
>> (as long as it is either below one of mounted subvolumes or explicitly
>> mounted).
> 
> Is there an easy/standard way to do this?
> 
> 

Not that I'm aware of.
