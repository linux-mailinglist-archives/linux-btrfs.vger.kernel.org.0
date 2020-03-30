Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9763319740C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 07:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgC3Fq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 01:46:28 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40976 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3Fq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 01:46:28 -0400
Received: by mail-lf1-f54.google.com with SMTP id z23so13086222lfh.8
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MI231/Wm7j9ZHcooU1cuyI9AWUvM/mLf9NWba8GlJQk=;
        b=pWylv5xngSHlP61NpMvBCQVVjz1i+XxwgzoUw3IfEXPtHPRNDU0f3TTu1ZS7C/8TVD
         iMx1HKQpM+c1nynJNhnqebWdzD8RmT/UEctfMEYAUUniJNAj19Gbal5bLBySbsK2OzUJ
         yy6R5r95En1W9TyI9pTIXKc/9d2xJqHj3An7L7T+CuPRJbMNJGsQVdXe/6Kfb2XHQ0oT
         IIYVPKO22ziJfIXKcFcGBdaG6h4j+6vA40eecwKNIxucMLJQDj+YtQrdl2X6tP+hYBe1
         jIg1X7NvhOBIBM+4VIyccRTcBHTsYTdLE35yuxde+rFpjmwYm3iZ/lvgeSfMiakOkANb
         UIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MI231/Wm7j9ZHcooU1cuyI9AWUvM/mLf9NWba8GlJQk=;
        b=PuX4sIeMyeXV4yM/cJAS3BiiOit8pzIZ689QNo7eVO1rQGpB5/zfM94/M3Hh107N6G
         E71M0qg8CFP5XMdLilwVsUVDLvhwSaSGo8ETeBsXt3SGVOr8Esdr3THTeN6wNSS30a1q
         aP78tzxuxd+Iy2Uzz+ibebVk1skO5bK9ebUHsF9x98U/UEjHk8pnkGXpvmLHgKgXRG11
         kW1Ayz3hfczmUnkWdXjg1BTXmz4MnnSNhYOLXMthq9ciNvCCghJeGXZojtK5SlcKUabE
         3178TrjYJKzn/BwxHDw2st7Il2wf1Xdz1yHu9MSjY4eEGLG1HsewUIBpgZjJjc/FDHfp
         c5YA==
X-Gm-Message-State: AGi0PuYm1Qe70R05B7AgsaKDJeFLfFP0u5JEltyhynZpc2EvVbGTCAE+
        rlEyg4VHWtAtllYlldUhUrIkXTQC
X-Google-Smtp-Source: APiQypJlb3U3f8t/IJ7psmd4By6xow6n0zQNzpceTsobG+Sq8F01FRItq2Bo+gr9oR8ScOEbHeXAvQ==
X-Received: by 2002:ac2:414f:: with SMTP id c15mr2161785lfi.2.1585547185907;
        Sun, 29 Mar 2020 22:46:25 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed? ([2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed])
        by smtp.gmail.com with ESMTPSA id 4sm6296172lja.56.2020.03.29.22.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 22:46:25 -0700 (PDT)
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
To:     Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
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
Message-ID: <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
Date:   Mon, 30 Mar 2020 08:46:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.03.2020 01:30, Victor Hooi пишет:
> Hi,
> 
> I have a small 12-bay SuperMicro server I'm using as a local NAS, with
> FreeNAS/ZFS.
> 
> Each drive is a 12TB HDD.
> 
> I'm in the process of moving it to Linux - and I thought this might be
> a good chance to try out BTRFS again =).
> 
> (I'd previously tried BTRFS many years a go, and hit some issues -
> it's possible this may have been made worse by my inexperience with
> BTRFS at the time - e.g.
> https://www.spinics.net/lists/linux-btrfs/msg04240.html)
> 
> Anyhow - currently the server has a 750GB Intel Optane drive, that
> we're using as a ZLOG/SIL drive:
> 

Do you mean ZIL/SLOG? ZIL == ZFS Intent Log, SLOG == SSD Log.

> https://www.ixsystems.com/community/threads/how-best-to-use-960gb-optane-in-freenas-build.75798/#post-527264
> 
> My question is - what's the equivalent in BTRFS-land?
> 

Not on btrfs level. I guess using bcache on top of btrfs may achieve
some similar effects.

> Or what is the best way to use an ultra-fast Intel Optane drive to
> accelerate reads/writes on a BTRFS array?
> 


ZIL is *write* intent log, it does not directly accelerates reads. ZFS
supports SSD as second-level read cache, but as far as I remember it is
physically separate from ZIL.
