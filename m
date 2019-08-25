Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623B49C221
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2019 07:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfHYFfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Aug 2019 01:35:06 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:40789 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfHYFfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 01:35:05 -0400
Received: by mail-lf1-f49.google.com with SMTP id b17so9922511lff.7
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OchR9ag14k9E3pyXwiToeje2oHANj01XNju7jjKD8To=;
        b=hdpWTKZBKhorAQTcAC5klirr9gnS2amb3kvZfddfqGoikL0IMjhezki+sOn+khFvOb
         BDnQ56kZWAOKM/FdPePqlB2cjSeqJyEcy1rxyHleTd8vjKAQroTyFHH8IoxHsm5LEApf
         yw77HlpwVqwI28CgtOPjqu9N3MYzQHY8Cih/WAlVRpk8OHPIG1zTtZpTTIClx/lKbN6A
         YAQYufXlOADcB/ARWXsxoqDeHjH+8edwH9pb8zZfQsmeNQs2JUFrwkrISEKxNJutB/oA
         29HOe9YKhrF22biyuvrlCyPQUpO8wSkKXZUSYYp46qAflDHDPuTDmoopbDt9EvlysyiO
         k8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OchR9ag14k9E3pyXwiToeje2oHANj01XNju7jjKD8To=;
        b=oih7V/ZIGAsT6msSqcQGP6iokhJXJNjoMxxsERlS21EtW39wqyZgNG4Wi34vWVePDO
         JKX/5JIj2HWBT6kZoKrEwXYeJTemWSB0FGhDNRykGPwwCdybYCL8RMbJUTX+GZ+58Fmo
         27BWXWSvH6TF6RRqTiNs7hnhwHf0C6zoFS91HQXPm+YHQfbBNQbwOW5gRQbf/77pErLg
         5Y1vwLexE5hAE1Gsh0vSh1QYrWAYw6VYMNrzSdMUQtgzAKwOU/Q3UISbRnOCz83sk08W
         16EL9/jfGv19Z5aZ8C6WtnL0ji4VxNQRMlB/ybFzBHII62cPSCrlIxxCRfDRYndBgjS0
         iuJQ==
X-Gm-Message-State: APjAAAUadtEGrkOkFn+f8g88x0D6yYzslEQX+qke0+3WVZIwTgydhPNl
        Jjt6G3FgLVlK+NdBIaCbgKi8/KKu
X-Google-Smtp-Source: APXvYqzOoKuMSmEmYvACq8svL2d5RbHs0ZTXsUxTN+BDk0NyqdcwtusCSWSMX6KQYUYEBmXeavBGbA==
X-Received: by 2002:a19:8c14:: with SMTP id o20mr532590lfd.158.1566711303734;
        Sat, 24 Aug 2019 22:35:03 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-20.nat.spd-mgts.ru. [109.252.55.20])
        by smtp.gmail.com with ESMTPSA id 2sm1428975lfr.76.2019.08.24.22.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 22:35:02 -0700 (PDT)
Subject: Re: swap and hibernation files
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
References: <CAJCQCtR6_1cbOMOgKzBLMyL2EQMLqRP+eGfETfT40MTxoyG7pA@mail.gmail.com>
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
Message-ID: <18f3bf67-dfa5-3bb6-0ee2-124242cf1f3c@gmail.com>
Date:   Sun, 25 Aug 2019 08:35:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR6_1cbOMOgKzBLMyL2EQMLqRP+eGfETfT40MTxoyG7pA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

23.08.2019 22:46, Chris Murphy пишет:
> Found this:
> https://github.com/systemd/systemd/issues/11939#issuecomment-471684411
> 
> Is it possible to support hibernation with swapfiles with this new
> interface? My understanding is that's only a feature of uswsusp, near
> as I can tell.
> 

This is directly supported by kernel, see resume_offset= kernel
parameter. The problem on btrfs is to compute physical on-disk location
of swap file because standard interface used by systemd returns virtual
location in btrfs address space.

> Advantage is it can mean the space reservation for hibernation and
> swap files can be made dynamically as needed rather than making a
> large 1:1 RAM to swap partition that maybe isn't needed or desired
> based on the use case and workload. Instead of making these decisions
> in advance at installation time, make them on demand. Plus, people
> sometimes add memory and a previously created hibernation partition
> will now be sized incorrectly.
> 
> Mostly I'm just curious if it's possible as part of already planned work.
> 

This is already supported by systemd if you compute disk location
manually. See PR linked from the issue you mentioned.

Whether systemd should explicitly support btrfs special case is probably
better discussed on systemd list.
