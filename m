Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64392DED9B
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Dec 2020 07:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgLSGwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Dec 2020 01:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgLSGwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Dec 2020 01:52:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313CC06138C
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 22:51:42 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so11187248lfg.10
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHh3AGKNUHGuxNBZIXl3F3lpRLpN0fkGHPtMG0h1E/Q=;
        b=CGZXxwnqvixvF/JfDlD/6y4awLzxnX9MxrDUFM3hXrsXQaw5M+mMG0ynofcfBP3gwh
         d2ky9udeH/1G33z7EVt6nLwx9r9xw2FzupLb08Zm8DZ9tlL1mjOKESN2jWUrMtZa4ee2
         dX57uXD+3NDBfdgHtXmk2+8s/BLClQmfm1f/Vlh9AnwMdL18hDrRQf0dXa4kAz70N/9Q
         /lu1O6sH0AJfBe7m0lR/8AUelaqNzAZVuIgqZ5fd5OhPJGGE5eDi94H9V3QM93bo91ja
         cqpxhMV4Hlm4IENZoqc1a+5bQdtf7W/wWqw3E3CbU2CztG27XfESoTXUVPQzpZ72nBpR
         hGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHh3AGKNUHGuxNBZIXl3F3lpRLpN0fkGHPtMG0h1E/Q=;
        b=QSwPv0LNbZWIIOOyqPZeRhCna2ijTR9ilQsWwP03xSlJ7mfp4gWW35VPnVfZXzrGbD
         ZT9NwBB6K5smGaZE0EXiDUjByeVbIjNpgyBHqs5i9mS/M+jv1IF8OpNEaVTNA4uc9ne2
         dBNd+doWMp4sOncTQSFel8uC8eQvv9xoph7c0XTUDSysy1NMGsVNLLRQoShR3Jw3Njeb
         Gf1UY2XZCJ6bbtKURNgeo4i5s7Sx7xnWCmTDVPMjP16mEhSFXpjtGlYOA3te7Akw4tTC
         q9fPkl3E5QAh/QGotYxx3+Jkr2AlOH59cUy8X4boePRIC8BCn81BQyEPw7kq2mdFQ7nY
         2HuQ==
X-Gm-Message-State: AOAM531zVGrA+9VISyaBfPSKWg1/FP0p6vzxbr0dN/sKxYNbdl5ThP1h
        y4byABOpUQGGNNt1/fsCJSrinKrxrs8=
X-Google-Smtp-Source: ABdhPJzHnoFEU70eQVJ7GWOsq9ZY21psPQOT8+EGCMRlJYPic7k453F+aGeuDWh6HuaQnjEF4GARQw==
X-Received: by 2002:a05:651c:130b:: with SMTP id u11mr3067579lja.118.1608360701014;
        Fri, 18 Dec 2020 22:51:41 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id e9sm1187340lfc.253.2020.12.18.22.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 22:51:40 -0800 (PST)
Subject: Re: what determines what /dev/ is mounted?
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQiaAvNGKUiz28jBiw67rSJWp+Ei2uGet2F=xyaziu0nQ@mail.gmail.com>
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
Message-ID: <e6821f22-8bd6-a827-2ddd-7d45e0d3d6f1@gmail.com>
Date:   Sat, 19 Dec 2020 09:51:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQiaAvNGKUiz28jBiw67rSJWp+Ei2uGet2F=xyaziu0nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

19.12.2020 00:42, Chris Murphy пишет:
> When I have a 2-device btrfs:
> 
> devid 1 = /dev/vdb1
> devid 2 = /dev/vdc1
> 
> Regardless of the mount command, df and /proc/mounts shows /dev/vdb1 is mounted.
> 
> If I flip the backing assignments in qemu, such that:
> 
> devid 2 = /dev/vdb1
> devid 1 = /dev/vdc1
> 
> Now, /dev/vdc1 is shown as mounted by df and /proc/mounts.
> 
> But this isn't scientific. Is there a predictable logic? Is it always
> the lowest devid?
> 

It is the lowest devid which is present (ignoring "missing" devices).
