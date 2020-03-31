Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE70199C90
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgCaRKE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 13:10:04 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39572 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCaRKE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 13:10:04 -0400
Received: by mail-lf1-f48.google.com with SMTP id h6so12183986lfp.6
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Mar 2020 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uJkH/7LKL7xgMU1Vt1FBaoumaRoCcRpJ52BDLJ5kk1Y=;
        b=cg9BpFv22b4vML91j2A/E8vQWzvYccCoQUWIvE6T+yi6RdA+n8LuLi0V0JJXJlitmu
         EfAWaUFpuHG2Pid5dh1liHSoHm9VkGX5HNOjO5R68ZXDUt2fbiExvJ+4zBG8oJpPznOh
         XtIGYMPXhWulr5q4xJVRy67EG1dczPm0n6S6G0Zru2Rz0HiPaV4Hbw+CaEiLLncFfs2v
         Z+ruq3mH5iViuPvhX9j2rLw3X1SefovbE3o9K8zUPQq1tttvPI045MZ21YaGL6Ci3/dD
         qCBN7C8KfcWc/TMdKkvZviJIrTBXJWPhTVfyrQcDHcd98AsADxgJFAbnSwIupuhyljz5
         znZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uJkH/7LKL7xgMU1Vt1FBaoumaRoCcRpJ52BDLJ5kk1Y=;
        b=VxdWUrTzyT8PtlNfo0ntoZHO6ABgz+PpxPy/KEfD7GRo038l1hV5Upz3bSO5D98/94
         lTFYooN9mPuBb/bpdVJ2WaA46YbTB1N/x3y/bS8YIsFzQAZA4CzVZMd9mt1lkH1pOBHr
         NlTH5TS/hbOdv60kFlbxwABSyVGX+FdXtI/oAKC6kqDzwh/7mRkFn1pDtZ7eIkfZn2Iw
         zI8Y/ZKFlU0Xb0HrOaEZejI+QKlq8TH/zn64b+ifaadGfrXAY6YHU5HywBVXv97OW9RY
         6FoXMUIE+5RrWpLnOCRDKQZZ1FjJpdBtqBwTuOD0JpkEkOYAlBe+rQ90Fn4Jh8N+7Li3
         MV4w==
X-Gm-Message-State: AGi0PuZTOkKkgf7xNmealfEHRA4GlMA6HQiTW/Qq4tcIzKcuddkGI3v8
        3lILotDXk6q1Awm3pa/HGLO/boSj
X-Google-Smtp-Source: APiQypKE4dqhellElwwue1MGxEjd91RzkU0u/3acEncQZKZJM5yvxR5p4x3692MZs3orW3qr7Sh/hQ==
X-Received: by 2002:a05:6512:2e4:: with SMTP id m4mr12312064lfq.202.1585674601620;
        Tue, 31 Mar 2020 10:10:01 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed? ([2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed])
        by smtp.gmail.com with ESMTPSA id 8sm9061818lfk.64.2020.03.31.10.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 10:10:00 -0700 (PDT)
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
To:     Eli V <eliventer@gmail.com>, Paul Jones <paul@pauljones.id.au>
Cc:     Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
 <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
 <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
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
Message-ID: <2ff672d4-875b-5242-96d6-1e248e2aa57a@gmail.com>
Date:   Tue, 31 Mar 2020 20:09:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

31.03.2020 20:01, Eli V пишет:
> 
> Another option is to put the 12TB drives in an mdadm RAID, and then
> use the mdadm raid & the ssd for btrfs RAID1 metadata, with SINGLE
> data on the the array.

How do you restrict specific device for metadata only?

> Currently, this will make roughly half of the
> meta data lookups run at SSD speed, but there is a pending patch to
> allow all the metadata reads to go to the SSD. This option is, of
> course, only useful for speeding up metadata operations. It can make
> large btrfs filesystems feel much more responsive in interactive use
> however.
> 

