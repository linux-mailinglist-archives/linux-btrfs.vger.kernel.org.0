Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9261D3C19E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 05:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391014AbfFKDj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 23:39:57 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41648 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391010AbfFKDj5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 23:39:57 -0400
Received: by mail-lj1-f174.google.com with SMTP id s21so10052381lji.8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 20:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n7KXo1lH8+e9ApWnkLYlDSBJQnaNbvy1qhpJqBhl9Xs=;
        b=FT1dxbpSUYdiwbv1QqhWc2XxHIEtOgcAei1Oq4eeg99/fvLtwS3ozJj7ulQPxpurl1
         VwqB9glyj43T3GOujiyPLdFAos1DkQmDejPf7bhv8jIkrdEG5nNyFNsJyvk2L/EWTRTc
         RlKNLMJ3YfIaiwNYxzn9Tf86zyR/rNiDXhwsjzQTlI6qdzPvnPDd37UtmjkZMwJrNn/g
         AuobNDou4CI3j9eDetGyOvYveWc5YfsY8YQ1PRdHacZ9gjnkcWZ41kfNUwBAfPD4Q8i0
         HnsBQJKJ2vCrs7hJknOsgwj3Hmg5Iw8yoHbQ6cuzIA9Ooz/CTllkaAT12T6wPbvzU7zz
         1AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n7KXo1lH8+e9ApWnkLYlDSBJQnaNbvy1qhpJqBhl9Xs=;
        b=nsj6d3nIMyEg8AYFA5Fk/W+ZwyCPJQ+le60ZXPJ/e1rph31xaTuzovD4PmYOxMQBud
         8BzsGJYfneMFq2IICub/PbCPeb75FDjfl1r0eEWUXY6hkGSFOImoHbMwNAQi9X69zfT2
         rY8aMAnC2qO7+7scf+S8NTWocKdJTOo5yN5uJSb2gbnscX36RtjykZ1jOxso6z5jmum3
         DXIdF4mqZ4y8RFGgCl3ex3FZjd5I5l2jCIkS1OYVwi7uYgjEgT4cTEbUepB9Fvt6kZyh
         qUbPNVpl4apcUevmlpZqV8/HqmcTA9LM3u4VVrIRFukV/O53ahaSECt6jMf4ox4emUEm
         DiZQ==
X-Gm-Message-State: APjAAAV7tG7xF//QTPZE+BW+kO5ZniukWA+qQhhbRyh9T6oacEg2oOCA
        0qn2NavVTxlclJlvAfgrRLMnvWl4060=
X-Google-Smtp-Source: APXvYqzritqr8qU79kjAbOlPXZky2U2tIG8m4r9rA1CmxL1CEMU345X97lEDkOHyl9+Mub2jYTthag==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr10061697ljj.122.1560224394826;
        Mon, 10 Jun 2019 20:39:54 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-211.nat.spd-mgts.ru. [109.252.90.211])
        by smtp.gmail.com with ESMTPSA id w1sm2846107ljm.81.2019.06.10.20.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 20:39:54 -0700 (PDT)
Subject: Re: Issues with btrfs send/receive with parents
To:     Chris Murphy <lists@colorremedies.com>,
        Eric Mesa <eric@ericmesa.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com>
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
Message-ID: <9d9f4b67-57c1-2003-8e15-52e8460c3c9d@gmail.com>
Date:   Tue, 11 Jun 2019 06:39:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

11.06.2019 4:10, Chris Murphy пишет:
> 
> It's most useful if you show exact commands because actually it's not
> always obvious to everyone what the logic should be and the error
> handling doesn't always stop a user from doing something that doesn't
> make a lot of sense. We need to know the name of the rw subvolume; the
> command to snapshot it; the full send/receive command for that first
> snapshot; the command for a subsequent snapshot; and the command to
> incrementally send/receive it.
> 
> 

And the actual output of each command, not description what user thinks
has happened.

