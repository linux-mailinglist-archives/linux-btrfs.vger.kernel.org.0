Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92D2DFFB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 19:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgLUS0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgLUS0n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 13:26:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6DDC061285
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 10:26:03 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b26so16447291lff.9
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4fk7rcOnis1ZKOIwKAvPCa8vyyMRy3+Co+1gGfWO7aw=;
        b=ZA1b7fwi16R36Erayz7ru/vqztWDencvq0w4YEsyGAr3/XgKa7pdXpGG2Z+x7pcrd7
         R/ZQJ2BBgHdLdAh5nEfKxbFw9P/C1NL0z+ixZDMwKDazY6WHyXLOdCVwAZSoh0J4BCmJ
         GlSI7OkadP3DLsdnM/GS5t58bvIAKqpYV3Z9XeTWKwXsW7vB3KIpLRJukrCj4NTJbmuh
         hAZ7lCGX0MQYqbNisg/pygxnLrmaXHBNIInT94TvixwMl1GCw0bxvc8m7t5mk7RQGGiA
         Bz6kFd2Ch4OxsWbqMAaTKWghknw7CyQj1HhT2e3Ly1DE92zSulmIMi4AW/WvxdGrN2h8
         wsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4fk7rcOnis1ZKOIwKAvPCa8vyyMRy3+Co+1gGfWO7aw=;
        b=PGYyqK/bdWtqyRfCUSIhHQ2HmU9iWWQlKZ3XPte4x2eJr9PPm+R0y92BacW5cbvpq3
         +t3A8fuWqvIQYgBJooE4431OIdqR95m2MdUgiBAj9xYnxkC8sx+ymRSVtdFexPYREIKj
         BkiclxGQ+4bhYjnTxGJ7ZwfB1JdDTNcmpYnihAbh7Kk7i5AElo8fHMxtzp+4wJlesO2q
         CKJMdpXFRuN9i21sM0Y0mJV3scb+Gl0zke9n8DvGRm53NhaNN9bjY0hWoNc5PX1WnCbl
         g54F/kzDGnNzespIeFjJyCNeZnyr3ybH2kJ+gUc883u0ZZ2mvqR5Xf7AxNs5bMMZPsHY
         pJjw==
X-Gm-Message-State: AOAM532uj7V9QCu5Ms9hboZGfGKKX+2ZQHiBj2OyyEZtvpx8PVSHv5EG
        auqB8Q+lS2v1IiF6BPyCQlnJAy2kzR3U/w==
X-Google-Smtp-Source: ABdhPJzwqwhbI7PzqUmFIgDS3/dNGFC7LOCvyTg1Bs9KpFBmJiuch/Zwe21935IBlLQaNN93cNfpDw==
X-Received: by 2002:a05:6512:786:: with SMTP id x6mr6810526lfr.643.1608575161661;
        Mon, 21 Dec 2020 10:26:01 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id a11sm2170336lfl.22.2020.12.21.10.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:26:01 -0800 (PST)
Subject: Re: WG: How to properly setup for snapshots
To:     Roman Mamedov <rm@romanrm.net>, Remi Gauvin <remi@georgianit.com>
Cc:     Claudius Ellsel <claudius.ellsel@live.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <20201221223701.0845e9ad@natsu>
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
Message-ID: <3d45b062-a004-277e-db8b-6826c6b342bb@gmail.com>
Date:   Mon, 21 Dec 2020 21:26:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221223701.0845e9ad@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

21.12.2020 20:37, Roman Mamedov пишет:
> On Mon, 21 Dec 2020 12:05:37 -0500
> Remi Gauvin <remi@georgianit.com> wrote:
> 
>> I suggest making a new Read/Write subvolume to put your snapshots into
>>
>> btrfs subvolume create .my_snapshots
>> btrfs subvolume snapshot -r /mnt_point /mnt_point/.my_snapshots/snapshot1
> 
> It sounds like this could plant a misconception right from the get go.
> 
> You don't really put snapshot* "into" a subvolume. Subvolumes do not actually
> contain other subvolumes, since making a snapshot of the "parent" won't
> include any content of the subvolumes with pathnames below it.
> 
> As such there's no benefit in storing snapshots "inside" a subvolume. There's

Having dedicated subvolume containing snapshots makes it easy to switch
your root between subvolumes (either for roll back or transactional
updates or whatever) and retain access to snapshots by simply mounting
containing subvolume. Having them in subdirectory of your (root)
subvolume means you can no more remove this subvolume without also
destroying snapshots before, so you are stuck with it.

So it makes all sort of sense to think in advance and prepare dedicated
subvolume for this purpose.

> not much of the "inside". Might as well just create a regular directory for
> that -- and with less potential for confusion.
> 
> * - keep in mind that "snapshot" and "subvolume" mean the same thing in Btrfs,
>     the only difference being that "snapshot"-subvolume started its life as
>     being a full copy(-on-write) of some other subvolume.
> 

