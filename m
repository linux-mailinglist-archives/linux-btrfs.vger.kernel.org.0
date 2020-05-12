Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060441CEAAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 04:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgELCRj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 22:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgELCRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 22:17:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8507C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 19:17:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z72so11910616wmc.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 19:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hRmJXbuzkGcCrdu8KAwFI6qHfdszl4qD4WYwqraG2z0=;
        b=VIitxErxLKdBOLlWGaiPxcLZM+E5n0gQHNRHSPD4XX+YM731im82t20ZrrUN3kKq0g
         6LqFyfqTdSc3zntHBGgctTeuDwkT0vesXLWLkAcHCTT5TwoylE22eE07gpSCj5V5v9W3
         HCj6V+4bWsOOKvFtbTo8R/l7WKFultG10syMg8QVqxj93s1HUKdslV3YiH0WMzt6Czy2
         G4DsxO+J5qayGPQ08YrC77vhJL3GYqgWM3pMIQtb7/AkhY8KoGT3C2OI+Gf5YPML5NX1
         DNtXFeWmXGw7htODBonE5JFmSYYS6aeu+zBy7PVVMEbZCV6Krq9vOSGFuNASMzoMlNqA
         3y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hRmJXbuzkGcCrdu8KAwFI6qHfdszl4qD4WYwqraG2z0=;
        b=sha2YXeOTMmDx/KarfLjOyeKl3T+AakfmCwJvLcwe0Jrj9X7etk44Ah8ebnXkZGLpA
         25D29KTP0MRdPFTWWMjska+Gxqs9oe32zaVtdJGZ924EAQwkwb2evCLZpYFgNWC6X4HB
         zfJmpsm7nITK90b00WIo31r7/xu/UPolqESYtGeEfqT5iU7moeS70skF3DW0IUNqSmw/
         s9m+348FAT+F9I9MQB6lgkmElXjM+rUXL3jkPm1UEABxs527LGJT9ZJt8rrlM4DnjQIi
         tQ3YZZSJx12FXoTpOir9cNnowALup23dX3SNfQB4zothbUXda86PVTi82S90MG85g3sv
         Q1XA==
X-Gm-Message-State: AGi0PuZB/vlSvVVl/Hlgj2jIRcNgd8a3D2rY9pqfdI72uXxRKiMbo9ah
        svqKiWkMJ+rFA0a4w8ZI3D8=
X-Google-Smtp-Source: APiQypKs8nhB5uDDjnDLk3p63BU66VCfxVnEnoa1W4mTtibU+4b6cgX1t+OZUAKNnFeL0B3RDkRv6w==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr24470711wma.16.1589249857517;
        Mon, 11 May 2020 19:17:37 -0700 (PDT)
Received: from [192.168.1.230] ([151.36.33.249])
        by smtp.gmail.com with ESMTPSA id g187sm137836wmf.30.2020.05.11.19.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 19:17:37 -0700 (PDT)
Subject: Re: Western Digital Red's SMR and btrfs?
To:     Phil Karn <karn@ka9q.net>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
 <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
 <20200511050635.GT10769@hungrycats.org>
 <bb237d74-49ab-27e0-0286-5bdd880dd2cb@ka9q.net>
 <69847faf-5fb3-9eac-b819-373a0f814044@gmail.com>
 <9bbad15c-1bd1-e91a-ae50-bb1e643c19e2@ka9q.net>
From:   Alberto Bursi <bobafetthotmail@gmail.com>
Message-ID: <3dec5806-d5fd-686d-b086-a93361491b30@gmail.com>
Date:   Tue, 12 May 2020 04:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9bbad15c-1bd1-e91a-ae50-bb1e643c19e2@ka9q.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/05/20 00:42, Phil Karn wrote:
> On 5/11/20 14:13, Alberto Bursi wrote:
>>
>> Afaik drive-managed SMR drives (i.e. all drives that disguise
>> themselves as non-SMR) are acting like a SSD, writing in empty "zones"
>> first and then running garbage collection later to consolidate the
>> data. TRIM is used for the same reasons SSDs also use it.
>> This is the way they are working around the performance penalty of
>> SMR, as it's the same limitation NAND flash also has (you can write
>> only a full cell at a time).
>>
>> See here for example
>> https://support-en.wd.com/app/answers/detail/a_id/25185
>>
>> -Alberto
> 
> Right, I understand that (some?) SMR drives support TRIM for the same
> reason that SSDs do (well, a very similar reason). My question was
> whether there'd be any reason for a NON-SMR drive to support TRIM, or if
> TRIM support necessarily implies shingled recording. I didn't know
> shingled recording was in any general purpose 2.5" spinning laptop
> drives like mine, and there's no mention of SMR in the HGST manual.
> 
> Phil
> 
> 
> 


Afaik there is no good reason for a normal hard drive to have TRIM 
support, as normal drives don't need to care about garbage collection, 
they can just overwrite freely.

I would say that TRIM implies either SMR or flash cache of some kind. 
Lack of TRIM isn't a guarantee though, some SMR drives (identified by 
their performance when benchmarked) were not reporting TRIM support.

It seems all three HDD manufacturers (WD, Toshiba and Seagate) just lied 
to everyone about the use of SMR in their drives for years and this was 
only discovered when this went into NAS-oriented drives that 
(unsurprisingly) blew up RAID arrays.

I would not trust the manual or official info from the pre-debacle 
period that much.

-Alberto
