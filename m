Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782F4F67F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 09:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKJIEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 03:04:05 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45070 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfKJIEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 03:04:05 -0500
Received: by mail-lf1-f50.google.com with SMTP id v8so7507247lfa.12
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2019 00:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJiQw7rQ14jnBMJz0bj8OsKRVp63ZjHuh9bH0GhZ0RU=;
        b=U4qq0ZZMvs5Afzd82i19Dlut+9ETFzWHQpIV5GbjvYrT/ud3MYcZTgaUpqPZhlMRFJ
         9XV1X6sx3rb0zeyTK0qUuLJDmkvuEDrfvygUYIeFknreLq9Igrhp9IP69RacTKykRgxW
         oft0tzYa0ZVPq3MBa8Ix0Z+FNXby3M5zxTqp4ZuDuLlMJsu+nObUowA9m5Cw3M4Qz3p1
         fUUplENLKgIL4y93H2mCWe1gAJDF6Z7otlJnDTJSvEt6/OSt4eeuLVnuol11xn9air0o
         IfCqILV4Jedy/VVm97dqUtZ5/lT33KJGkvM9qMbWGYahb6LCPxREIp4EgsNor0cG0BMo
         vLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MJiQw7rQ14jnBMJz0bj8OsKRVp63ZjHuh9bH0GhZ0RU=;
        b=jfKtqtHPHIGFIOQM6e3QP2Upeb6uB5TQuMazer5yUdIsGVDXrZ27ZcswRQuGBdS1Bq
         Ncf1BbgNdpW4K5fVQouXSUMOYS6PxMFzB1HCAEfDL2+WrtEk0MZNFPxolCWTFFQNrX/F
         XNGw0gI4bCN3PnvVOQ5BEgd2Ajr0z7c3QUM3xSj5bKRbaBZtFBfYAw0Gn9I94zpWcZG2
         GDygTuO7m1BNiVmyTQjKm79S+my1lR3QIe1lhjZhTL1VDWLsaycxvIMXtjA86Ex5EvXq
         1UAYCZ/m/PBHVKPt2+zpOzU7Ssg7X0Qrk/AR5ItOQk/VRIOT97GXZYI2kvkbEyDSu24y
         X8Lg==
X-Gm-Message-State: APjAAAWEuxE9otTAHtGlon0Ruiab7DUJ6pU4vV1s7FqkxnExZ+QBm+yu
        usdn3u6pXJ3E6gEuipZgtN4GyVzk
X-Google-Smtp-Source: APXvYqxVUu9kvD2ka0hJKVacY5u97AET2FVFDwIF203ZKUmz51Y5fAAOgmwbKZBkd5XfBE4K2wR8tA==
X-Received: by 2002:a19:c50f:: with SMTP id w15mr12361506lfe.14.1573373042880;
        Sun, 10 Nov 2019 00:04:02 -0800 (PST)
Received: from [192.168.1.6] ([109.252.90.228])
        by smtp.gmail.com with ESMTPSA id y18sm6275395lja.12.2019.11.10.00.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 00:04:02 -0800 (PST)
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
To:     Timothy Pearson <tpearson@raptorengineering.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
 <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com>
 <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com>
 <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com>
 <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com>
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
Message-ID: <08aced90-6dac-646a-a3c3-445eaf1e9fbb@gmail.com>
Date:   Sun, 10 Nov 2019 11:04:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

10.11.2019 10:18, Timothy Pearson пишет:
>>>
>>> Do the described symptoms (what little we know of them at this point) line up
>>> with the issues fixed by https://patchwork.kernel.org/patch/11141559/ ?  Right
>>> now we're hoping that this particular issue was fixed by that series, but if
>>> not we might consider increasing backup frequency to nightly for this
>>> particular array and seeing if it happens again.
>>
>> That fix is already in v5.3, thus I don't think that's the case.
>>
>> Thanks,
>> Qu
> 
> Looking more carefully, the server in question had been booted on 5.3-rc3 somehow.  It's possible that this was because earlier versions were showing driver problems with the other hardware, but somehow this machine was running 5.3-rc3 and the patch was created *after* rc3 release.

The patch apparently was added in 5.3 final so way after rc3.
