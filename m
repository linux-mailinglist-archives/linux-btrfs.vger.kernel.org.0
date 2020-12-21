Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247172E0013
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 19:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgLUSk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 13:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgLUSky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 13:40:54 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E913C0611CA
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 10:40:27 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s26so26010083lfc.8
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 10:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dvP38E8BTxqvNMuVc5kok0zae9+jnLWLCVF97skXr0I=;
        b=mL14ydlKU1Y+FxcSmVTV0Hf6gljuwT0bQLaAmN0jKro/wb979LlewGTVRLsctl8M+1
         eVCjYGxh/VxFh1LjOS9udd6OQ3UaxbRGpvBJ6sx/vYk37U8fdhvU0Bp7GiV2WkmhYyFy
         /Q20BJyeWXFoNKs5JRKxu2bXEv2WJJmDWOGJUmuiJOpeKDWNp0iFlQ3uXWrvhougiMOO
         fiBMZup3SOGfDHzKV6JiDDyx08YKvQ283lIPay84cTfQOPTVdJS9Gfyn0fuxZTUJA/pa
         t8/JxksW30K+QFcMKabXw77TEk9PIprcMQNPVwv9RvEaFpSTYQKREXmC0MeVstPNm3vZ
         ux/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dvP38E8BTxqvNMuVc5kok0zae9+jnLWLCVF97skXr0I=;
        b=l/H9tj8/QKDsHuyW7MHIPeqFqjFsRfB3k3W8JHUs6Ic83oCb/oUUaeBJnkumtmvgr4
         J7xiBVmO0QkMkZU7qT3/1qRW5c2rIN2vpoAtC5vfcYkar4vUe8sW1GG6IzRw7yr4TtCE
         SlODq+MhtQgP79wu5aeW12uJrX+kN3bxZTmKZhTY4JsFadi9FNhdkUaguodC3QOc+PxG
         mnajLxNj8+RaxigW9HDpnAW29mbPIhxoOydhkQuSHTOV7P9BVOzZ6RCCrJfiGmTZllLp
         yf+OL7xFw3GfgW8/0JxWmowwtJEF0icpppo0wwhddDQ58NzyvuSZeM6s3fRgwTSmsn6b
         rDCg==
X-Gm-Message-State: AOAM533xkYPNDquuP9V0G+YE0i5LbENblE32UaXPzzmT/UzWgAMapZND
        7hrzio+LwH5mmmh9DkeyFU8u2QZzrO7+HA==
X-Google-Smtp-Source: ABdhPJwRaSiZf1Z7uyhsqMs+E5DMeSRcaZ/LMs62Y3CDDYnAI9vKt15PzVeDZ7FhDll9UH6oLjaDzA==
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr8193204ljc.411.1608576025568;
        Mon, 21 Dec 2020 10:40:25 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id 10sm2170541lfh.208.2020.12.21.10.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:40:25 -0800 (PST)
Subject: Re: AW: WG: How to properly setup for snapshots
To:     Claudius Ellsel <claudius.ellsel@live.de>,
        Roman Mamedov <rm@romanrm.net>,
        Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <20201221223701.0845e9ad@natsu>
 <3d45b062-a004-277e-db8b-6826c6b342bb@gmail.com>
 <AM9P191MB1650526777331A5E93DAADD3E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
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
Message-ID: <8b6c458b-5fab-2209-9d5a-d40f55de5c00@gmail.com>
Date:   Mon, 21 Dec 2020 21:40:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AM9P191MB1650526777331A5E93DAADD3E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

21.12.2020 21:35, Claudius Ellsel пишет:
> I was aware that snapshots are basically subvolumes. Currently I am looking for an easy way to achieve what I want. I currently just want to be able to create manual snapshots

btrfs subvolume snapshot / /snapshot

> and an easy way to restore stuff on file level.

cp /snapshot/sub/dir/file /sub/dir/file

> For that (including the management of snapshots), snapper seems to be the best way, as btrfs does not offer such features (in an easy way) out of the box afaict.

Yes, btrfs does not reimplement cron in kernel space.

> 
> Unfortunately the documentation for snapper is also not nice, I just had a closer look again. The best I could find was the Arch wiki but that also starts right away with how to create a config (without telling whether that is even needed for basic usage).
> 
> Ultimately I'd like to have a btrfs Wiki entry for snapshots and am willing to help with it.
> 
> Von: Andrei Borzenkov <arvidjaar@gmail.com>
> Gesendet: Montag, 21. Dezember 2020 19:26
> An: Roman Mamedov <rm@romanrm.net>; Remi Gauvin <remi@georgianit.com>
> Cc: Claudius Ellsel <claudius.ellsel@live.de>; linux-btrfs <linux-btrfs@vger.kernel.org>
> Betreff: Re: WG: How to properly setup for snapshots 
>  
> 21.12.2020 20:37, Roman Mamedov пишет:
>> On Mon, 21 Dec 2020 12:05:37 -0500
>> Remi Gauvin <remi@georgianit.com> wrote:
>>
>>> I suggest making a new Read/Write subvolume to put your snapshots into
>>>
>>> btrfs subvolume create .my_snapshots
>>> btrfs subvolume snapshot -r /mnt_point /mnt_point/.my_snapshots/snapshot1
>>
>> It sounds like this could plant a misconception right from the get go.
>>
>> You don't really put snapshot* "into" a subvolume. Subvolumes do not actually
>> contain other subvolumes, since making a snapshot of the "parent" won't
>> include any content of the subvolumes with pathnames below it.
>>
>> As such there's no benefit in storing snapshots "inside" a subvolume. There's
> 
> Having dedicated subvolume containing snapshots makes it easy to switch
> your root between subvolumes (either for roll back or transactional
> updates or whatever) and retain access to snapshots by simply mounting
> containing subvolume. Having them in subdirectory of your (root)
> subvolume means you can no more remove this subvolume without also
> destroying snapshots before, so you are stuck with it.
> 
> So it makes all sort of sense to think in advance and prepare dedicated
> subvolume for this purpose.
> 
>> not much of the "inside". Might as well just create a regular directory for
>> that -- and with less potential for confusion.
>>
>> * - keep in mind that "snapshot" and "subvolume" mean the same thing in Btrfs,
>>      the only difference being that "snapshot"-subvolume started its life as
>>      being a full copy(-on-write) of some other subvolume.
>>

