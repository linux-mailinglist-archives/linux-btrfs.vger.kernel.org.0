Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073482EF003
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 10:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbhAHJr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 04:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHJrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jan 2021 04:47:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D6EC0612F5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jan 2021 01:46:45 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o10so10597738lfl.13
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jan 2021 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RXvhl2KcDnMjmzvjCLk3ZCMmCNgNf+p3oZcUkDpB9bY=;
        b=KnU4ljtYi0fZq/ANP3pLiYH37bcHXIlQ6GRA4CDPgoelCNX4nPcuToBurx+T9s5S/A
         BfmsHQ46mOuLgU0Wu/uyrQuBWqYs3bcH1anIFOlJTkIcgWcmXxN8InxWrAEoEnhVP3E4
         /imNE5DfzZC7xfn4VEBGY2eVxpAPdQH1HzL4otY7ZUm7m4Z/bWnVZk1xXl6CnO/lqp4u
         9cfxUm7QNUOVCPrtSIzEXHbFSKuyNBZ9y2/+EQGXGcPsiG1prIy5BVKOOFEGn/C6Jcbw
         kUnK8FzlzttQ/4LOxKKvXFKNkKhscZSQUprEgaHy1qHxpE4o0lFQx3v0k84kwxpc8mhq
         QdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXvhl2KcDnMjmzvjCLk3ZCMmCNgNf+p3oZcUkDpB9bY=;
        b=IbyS3m22ryL8l8haXby7zhTE5BCS5O1aQzFMJx/2cV0X+LZbgfanzUM2P79NOOUxt+
         tknS8wdp/sOyhI16E4X/k8AU/N/5mIpuDWDNuRdnwiM+K/DNPAAko/+G8nhKGlyg17oj
         o0b2CtlH4U1amJ256KDoZtemSsz3CelwUVsxdufcPKjJzbzcnfobHNM+nEL7lafsrtGd
         wQBXOxMvGhYlf7uy2HiNZ9YTaKUQ/7fL1Wy5RLEnfdMuz5f/zyqhRex6RdH2FyBAP7Xl
         d3TEs77B2UpQljg1e9qNxg9olUw7AWefmKTJv5HXnBXkOGI71Ybg6RGBjjouEZivJJ4X
         7qxg==
X-Gm-Message-State: AOAM530H30+i1rWekmlt2Piso0CbvEHngF2UK2eRY5iRaazbDJsACKNf
        0ciVMDMYUv5KFyQHbX15Bw0fT1YKyrI=
X-Google-Smtp-Source: ABdhPJytQTmi14JAY5M0Ar5u+ptU44VJgx1dsslH330KHHuhgYqqWrn/3D/yvs4sdWkV/oHqZ7wAEw==
X-Received: by 2002:a19:4191:: with SMTP id o139mr1295458lfa.224.1610099203590;
        Fri, 08 Jan 2021 01:46:43 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id s20sm1810747lfc.26.2021.01.08.01.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 01:46:43 -0800 (PST)
Subject: Re: should btrfs reserve some space for root, so a normal user can't
 cause "no space left" problems?
To:     Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
References: <e0efe804fd52b0838bf69b01f6e7a784@mail.eclipso.de>
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
Message-ID: <13fe8169-2740-95ca-09ca-efe0391dde4c@gmail.com>
Date:   Fri, 8 Jan 2021 12:46:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e0efe804fd52b0838bf69b01f6e7a784@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

08.01.2021 10:56, Cedric.dewijs@eclipso.eu пишет:
> I have done a test where I filled up an entire btrfs raid 1 filesystem as a normal user. Then I simulated a failing drive. it turned out I was unable to replace the drive, as raid1 need free space on both drives. See this mail for details [1]

As explained in this mail, you did not "replace" drive, you added new
drive. This is different operation.

> 
> I can understand the technical reasoning behind the requirement of both drives having some free space. But why does btrfs by default allow a normal, non root user to completely fill up the drive? Maybe it's a good idea to reserve some blocks on the filesystem that are only available for the root user, much like ext4 does that (via tune2fs [-m reserved_blocks_percent] and [-r reserved_blocks_count])
> 
> [1] https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg92550.html
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 

