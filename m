Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2209918710C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgCPRWb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 13:22:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35707 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbgCPRWa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 13:22:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id 5so7656966lfr.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Mar 2020 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=an9Lvp0zrNHkIQC60tkrtW7k+vWRq4HnzbvwDutEAUg=;
        b=psnS6pSAdWsFs+fin6Iadx22bbirBfAR+Fz8uQIByyhhIj+rQwGeBFlisbprxfP2Yw
         1UT9CHwhz8RknP7ktIZ5Q8d/M1u5zQt3ALRFlXrG5qJZfTEhTBZRjHkU2C1VxoiobNYh
         pSOuyZY7xTszUM7oWke7t35eC12z5T/Y42QkYf0o0JBw28+UvHia64Hxcv55ZMNH9er3
         a2UC/2YhON45VKg3Bi9RkgSJUQeP2N3B44CC5kMcTmrB6xWeJG+lMTuWpYeGfcQeWEjy
         tW7l+G+jytrmuBDgfxI1KbK9r/WbvyZheLGEjVmM6lpTnunDSku6K1O7i/7JiysdPwCk
         FGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=an9Lvp0zrNHkIQC60tkrtW7k+vWRq4HnzbvwDutEAUg=;
        b=CIx6ZTcSLey0eorgxIC9OB1ko7yHzHHD8SaeQv2NmxcY0Lsn1rNCedIGgX6sBDWKsM
         1OcSYqFiRP0qSmb0v4zARop1b0SG846BPIaF6ZWMGXSwrCD4YP5VpFyq0sw8PkJJ/9G+
         ZqNKUkdTIM4DLgWWfNwj073Ymh+OQzfts4XjJRGjbU7wJWVyHnj9ZUBM7byDP6l8pFXr
         7kN9hJXCVdZQ0DS/tMwY+c/hytRft6Xaxq8+9+I8AZHYxUYaY0vyk0FKQyN8h611+qga
         /SitzLLmY1cacF5kx0UiG93izVLZ7J1VfxFTro1f4FObcmWQxPWM5UotixYYvKjfC79Z
         vyhg==
X-Gm-Message-State: ANhLgQ3kJQsgda4B9fiPt4zNKh1IzfCXDHGZXLzAudgrQrZ0/Q5y7IO2
        v4O15SRAQYyTEqhs/FO33TLG7PoqnI4=
X-Google-Smtp-Source: ADFU+vvqoRHsKGvEH/TeaNne6ozTwsbFKAcptQFhL/8VWm99qyNdVKF3pLZeeo9sLUC39RBEdeuFKA==
X-Received: by 2002:a05:6512:1041:: with SMTP id c1mr291447lfb.14.1584379348563;
        Mon, 16 Mar 2020 10:22:28 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:bdf6:4017:e487:57c7:edb6? ([2a00:1370:812d:bdf6:4017:e487:57c7:edb6])
        by smtp.gmail.com with ESMTPSA id h14sm367067lfc.24.2020.03.16.10.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 10:22:27 -0700 (PDT)
Subject: Re: the free space cache file is invalid, skip it
To:     Hendrik Friedel <hendrik@friedels.name>, waxhead@dirtcellar.net,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <emfc09a7c5-74d2-4f64-92cc-9a8cffa964e1@ryzen>
 <f2e7a222-0f92-a905-bd9c-6a8d1a5a0cd1@dirtcellar.net>
 <em643b0c79-ce6a-4c14-90e6-d5e15bfffebf@ryzen>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
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
Message-ID: <15870980-cd6c-a7b4-e2ec-3e16a71295f1@gmail.com>
Date:   Mon, 16 Mar 2020 20:22:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <em643b0c79-ce6a-4c14-90e6-d5e15bfffebf@ryzen>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

16.03.2020 09:59, Hendrik Friedel пишет:
> 
> My last knowledge was, that one should not use btrfs check unless asked
> to by a developer.


One should not use btrfs check in *repair* mode without being reasonably
sure it won't do more harm; and verifying that repairing is possible
usually involves developers. Otherwise btrfs check is read-only by
default and should not damge your system. Whether its output is useful
to non-developers is another question :)
