Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9161424
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2019 07:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfGGF1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jul 2019 01:27:11 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33779 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGGF1K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Jul 2019 01:27:10 -0400
Received: by mail-lf1-f47.google.com with SMTP id x3so2793123lfc.0
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jul 2019 22:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4tfuzWM7/p7ssvUdvxGDc1SsWpcMDJF8VHNxlyWAjC8=;
        b=QtdO50qv1XjTihEe9Uu4iRzvcx8qXOve4VPxLZSMnBoLv/h64Ea6UBWWkaktKPHdKg
         jYyU2pbhJH3UeZRGnWpC3FWABuimnLxwx2mmZIEiY+0MuoaAL77Jfb3DgLO8BnLmzNHo
         qAkfC154vmcv/E6lvVnkUoQDGnKGaMaXCUjfvhiKpSRmRqTHpIA4pj61v9gNDWzBPmyO
         u6HDOhcRh93fjC1onrtdVqtLvMP26HQ2lBLn6S+/7fPyGXU6DrDuidMFRf7T9PquB7vq
         PyLdOWeNBIt5xEWD97quBTOx2mdE6SSCMWLpJFYeM051C8LEB1ouCumbwRa2n4q2ubE8
         NuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4tfuzWM7/p7ssvUdvxGDc1SsWpcMDJF8VHNxlyWAjC8=;
        b=UOUolkVL55f279m4r2+/h/kOEyfmgGS4tIklVAsCOSyJwNCwjiWTyw+ltLuL78CNnC
         EQ4+1gXkN3XsYsUra/npa8pvVrtT3KWSnTwABS9oaH7psieZmmh8O3nnCMp1vFpfROlM
         8DyxsUlrr98rJ9zQWo/4R0yWHFmr0O6NDWtiOfD6q5tV3XGRrbXrobJ+fkfICosRejmy
         mrxyiNsCbVDAemZt3qsDmANakSZ4oxNjWO+I5bbaoLAoXxdXW6JA5MdqQwRgEwoqJnyM
         ZkNLqWfVPuPh0JsnOICcoOis4SKa5RbzaO5Juokdtdj7QcGT8dled1JWF1aUl81S1NN9
         pUNA==
X-Gm-Message-State: APjAAAUMw6oGyB6B0pxPB60CA5fb1rN8qPa6rPy6Nyd85Gi/VDm02vEF
        aDvgdf3D/0meWrFzWp5mi2jo6LqO
X-Google-Smtp-Source: APXvYqwN2D6uHQulBvxCnvgbZ6EMfZr3Hjs/qa+12dgW//CkmQ0/cWu3DMh06H3fNL4imLx2evsCrQ==
X-Received: by 2002:ac2:43bb:: with SMTP id t27mr5597611lfl.187.1562477228396;
        Sat, 06 Jul 2019 22:27:08 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-59.nat.spd-mgts.ru. [109.252.55.59])
        by smtp.gmail.com with ESMTPSA id r68sm1262306lff.52.2019.07.06.22.27.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 22:27:07 -0700 (PDT)
Subject: Re: find snapshot parent?
To:     linux-btrfs@vger.kernel.org
References: <20190706155353.GA13656@tik.uni-stuttgart.de>
 <1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
 <20190706204339.GB13656@tik.uni-stuttgart.de>
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
Message-ID: <8a75b6b5-1eba-b3ef-99f5-849f40e65d12@gmail.com>
Date:   Sun, 7 Jul 2019 08:27:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190706204339.GB13656@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

06.07.2019 23:43, Ulli Horlacher пишет:
> On Sat 2019-07-06 (19:57), Nikolay Borisov wrote:
> 
>>> And how can I see whether /test/tmp/xx/ss1 is a snapshot at all?
>>> Do all snapshots have a "Parent UUID" and regular subvolumes not?
>>
>> Indeed, only snapshots have a Parent UUID.
> 
> Not all:
> 
> root@xerus:/test# btrfs subvolume snapshot -r /test /test/ss1
> Create a readonly snapshot of '/test' in '/test/ss1'
> 
> root@xerus:/test# btrfs subvolume show /test/ss1
> /test/ss1
>         Name:                   ss1
>         UUID:                   02bd07bc-0bab-3442-96be-40790e1ba9be
>         Parent UUID:            -
>         Received UUID:          -
>         Creation time:          2019-07-06 22:37:37 +0200
>         Subvolume ID:           1036
>         Generation:             9824
>         Gen at creation:        9824
>         Parent ID:              5
>         Top level ID:           5
>         Flags:                  readonly
>         Snapshot(s):
> 
> root@xerus:/test# btrfs subvolume show /test
> /test is toplevel subvolume
> 

Which is one more reason to not use btrfs top level directly.
