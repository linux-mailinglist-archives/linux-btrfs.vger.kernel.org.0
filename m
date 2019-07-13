Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61B7679D9
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGMLGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 07:06:54 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:44825 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 07:06:53 -0400
Received: by mail-lj1-f172.google.com with SMTP id k18so11719310ljc.11
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2019 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E94RNSmliZ7fw6LMr2oMcTkznm7GMWDVru8EautKiDQ=;
        b=SezTPLT8xCaqBH2oo7ex3inKr7/3QU+Cis0UsGu7+x/h79u6GF4RO72nIFR/N6X4B8
         10rAXn3oVm0CcgucTUb/fanBrL/fZQm2aWA0Zm3FFz4D5b2bdKxMz9ofmM3tWkFcE8aO
         ER/FIQZptF/G3PGgznXFNAbIqEWyTFB7Zuuo/wQQAJPNRZmkjLU1mmIoW0T76H5Jk5Yy
         WR6AmjXFygQ6CWOnfATaQt238Z9usanZWy/e0zmALgAVAoIrsV4+pjDq9Vf0WCQikgh+
         jIJCj6VAeQ7g4ao9dBisdaE2btA3QXnTRWF0B5DksWleYvow4kDheG2sIbhZlwd/7pAK
         tW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E94RNSmliZ7fw6LMr2oMcTkznm7GMWDVru8EautKiDQ=;
        b=o7UVCwjBG6zGuiJaSWUIP7/di4YSCo7jw04/SoqIToDw6LepglhuJ40MVcSt9I/RTM
         hcuESE72nHif3J2eyMbgRRXR9Xzg1TwDKFBXrFpVj34A+hxta/fJ4O1Xby5yt242DKMA
         E+D9+zAwojdFVssEdaP4DhGR5yVxy15G/I1/jAnDnhrOzhWzD8+nmwWYJCFeuYtVOMEN
         fhH3L2cJZeF486Oum7XoyHkZ0CjPEM2BhEcDcAqqr7ve2g6aNXXTdZvrbBB397JYP22X
         H2+ZWezvUm7sGvqK7ubXYMJWlfccLmaFl68+A6YPA3wU8EFWitgPqPcBukZ3lAwJR4Gm
         vZzA==
X-Gm-Message-State: APjAAAV6EaXBDwpblkqHeL+AwBs/JABDymVRpb/MoTJba0RNun4Wl7Jd
        ZfprNfvcFG7iP7GNgO4xiqD4UaZT7jE=
X-Google-Smtp-Source: APXvYqy1oK0ouy/3AKlNEZNWUXKAzLLmOx+loLVLKLl8+qw8F8t1232Ta1ZERUZ1Z76/JibfW2eXPQ==
X-Received: by 2002:a2e:968e:: with SMTP id q14mr8080514lji.195.1563016010825;
        Sat, 13 Jul 2019 04:06:50 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id r24sm2145218ljb.72.2019.07.13.04.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 04:06:48 -0700 (PDT)
Subject: Re: Should nossd mount option be used for an HDD detected as
 non-rotational?
To:     "R. Schwartz" <schwrtz@protonmail.ch>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <htetrjLP1jLMK9WTasfT2e5ZdkY1yV0iY3PHjVEDqCKIZ8d2VwdRTBRezsUAxzKawi_lsxBi5HYfOlvyByGPBwswTCKXSt_lbhRCAmQZ2Qg=@protonmail.ch>
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
Message-ID: <9c872fcc-18a2-0936-f950-f1a74806da73@gmail.com>
Date:   Sat, 13 Jul 2019 14:06:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <htetrjLP1jLMK9WTasfT2e5ZdkY1yV0iY3PHjVEDqCKIZ8d2VwdRTBRezsUAxzKawi_lsxBi5HYfOlvyByGPBwswTCKXSt_lbhRCAmQZ2Qg=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

13.07.2019 12:22, R. Schwartz пишет:
> My HDD (one partition, BTRFS) reports itself as non-rational:
> 
>     $ cat /sys/class/block/sda/queue/rotational
>     0
> 
> According to btrfs(5), by default, BTRFS detects this value and turns on
> SSD optimizations for the HDD. Naturally, I'm puzzled...
> 
> My question is: should I use the nossd mount option for the HDD?
> 
> Following is more details about this HDD.
> 
> It's a recent Western Digital Blue 2TB HDD, model WD20EZAZ. Given its
> cache size is a rather large 256MB, some people say it's likely an SMR
> (shingled magnetic record) HDD.
> 
> Since Host-Managed and Host-Aware SMR HDDs support the `REPORT_ZONES`
> ATA/SCSI command, I ran this test using `sg3_utils`:
> 
>     # sg_rep_zones -R /dev/sda
>     Report zones command not supported
>     sg_rep_zones failed: Illegal request, Invalid opcode
> 
> Therefore, _if_ it's SMR, it must be Drive-Managed SMR.
> 
> So is there a good reason why the HDD reports itself as non-rotational?

kernel sets non-rotational flag according to Medium Rotation Rate field
in Block Device Characteristics VPD page (0xb1). What

sg_vpd -p bdc /dev/xxx

says?

> Does it have to do with SMR?
> 
> Additioanlly, the HDD is connected through a SATA to USB connector. I
> original suspected it was an issue with the connector, but I tested with
> other HDDs with the same connector and they all report as rotational.
> 

