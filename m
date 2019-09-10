Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10ACAAF092
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437037AbfIJRju (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 13:39:50 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:34380 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436916AbfIJRju (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 13:39:50 -0400
Received: by mail-lj1-f181.google.com with SMTP id h2so10813707ljk.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d8ZRbBY4bC73mbSjScCOXrCe8vsJ7Lt1O5dt6e4i7wU=;
        b=X+UnXNzlEMIbMK+ZsfLyBaWz5/6pkLxp3xpu4jt6cVmha1dbnuGH+dTdrEQDRjcnES
         uboV9qGiewnXwQZPMHT9mtElaXhoL1NTOrC5FrYNwo3E7VNHVWx0544xa2/C8MzeqxBa
         LwykMJsYOX58t3BbeqjvfdMyEV6p1n0nGUepP8F/c/XNXbODfL/ya32/HEJfV3OPqjkF
         JaL5PYot65lGx5MDQ58TPu6nqk0mONaiupH63W9CSkeHMzkNB7YIfveHi8NcWG86y3h1
         +9ZS1I/vylRkMEqdoYSsobXqJIeMW1eclpkM2LwOIFOEaptAcOHGhfI1KtQyuf/vQILl
         pESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d8ZRbBY4bC73mbSjScCOXrCe8vsJ7Lt1O5dt6e4i7wU=;
        b=VuFHJg4BT4jXHFlo3FGvuMjg9NYfXvHcJmYYhhsnSk6HTNXyqRJC8g+LD2FC9JvAEG
         xH4O3uz0h3VKv0XJR9izjlAp5hTfUc4ylPKQxXz8u8CMvuz6Y/58h4RDKfTNlsa3Gx88
         /On+v+8DnsgiZgvKlluy2gRuBtITiJA+yPWGzdtqmR3/Wsl3JnPj0QRPssdQ6skhexiT
         ON5ek4/BT+XUla/Hxsud6q2PrSFA6NUrjaXOYF6cO9vOcqnHQGFz5JyTa5etrRvv9+MU
         PBCtKpA1tPyqJcSRDb85sE0JE+pto/mMsdSR+1kVW+OGYI71j7pN2aJcQsOQSsnjbS/D
         wq9g==
X-Gm-Message-State: APjAAAWZ8wi3/hI1JoY+9Vkn2w9xFrY+7F4/i2ggzGsCSnZZb6Lvb3Ld
        mITi26VvpZ/4aG4KI0ce5IrD12KFOAc=
X-Google-Smtp-Source: APXvYqzDSBtly9ScR6xGp7RmoCJJJljO4nwbMZHrnf+NVsiHCnEiDiEX2xo1ybd27te0zV/1+d13/g==
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr13231660ljq.128.1568137187043;
        Tue, 10 Sep 2019 10:39:47 -0700 (PDT)
Received: from [192.168.1.5] (109-252-54-49.nat.spd-mgts.ru. [109.252.54.49])
        by smtp.gmail.com with ESMTPSA id u25sm4354984lfm.64.2019.09.10.10.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 10:39:46 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <083a7b76-3c30-f311-1e23-606050cfc412@gmx.com>
 <20190909131108.Horde.64FzJYflQ6j0CbjYFLqBEz0@server53.web-hosting.com>
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
Message-ID: <610e9567-2f17-c7c3-01aa-0e1215be44d0@gmail.com>
Date:   Tue, 10 Sep 2019 20:39:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909131108.Horde.64FzJYflQ6j0CbjYFLqBEz0@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

09.09.2019 20:11, webmaster@zedlx.com пишет:
...
>>
>> Forgot to mention this part.
>>
>> If your primary objective is to migrate your data to another device
>> online (mounted, without unmount any of the fs).
> 
> This is not the primary objective. The primary objective is to produce a
> full, online, easy-to-use, robust backup. But let's say we need to do
> migration...
>>
>> Then I could say, you can still add a new device, then remove the old
>> device to do that.
> 
> If the source filesystem already uses RAID1, then, yes, you could do it,

You could do it with any profile.

> but it would be too slow, it would need a lot of user intervention, so
> many commands typed, so many ways to do it wrong, to make a mistake.
> 

It requires exactly two commands - one to add new device, another to
remove old device.

> Too cumbersome. Too wastefull of time and resources.
> 

Do you mean your imaginary full backup will not read full filesystem?
Otherwise how can it take less time and resources?

>> That would be even more efficient than LVM (not thin provisioned one),
>> as we only move used space.
> 
> In fact, you can do this kind of full-online-backup with the help of
> mdadm RAID, or some other RAID solution. It can already be done, no need
> to add 'btrfs backup'.
> 
> But, again, to cumbersome, too inflexible, too many problems, and, the
> user would have to setup a downgraded mdadm RAID in front and run with a
> degraded mdadm RAID all the time (since btrfs RAID would be actually
> protecting the data).
> 
>> If your objective is to create a full copy as backup, then I'd say my
>> new patchset of btrfs-image data dump may be your best choice.
> 
> It should be mountable. It should be performed online. Never heard of
> btrfs-image, i need the docs to see whether this btrfs-image is good
> enough.
> 
>> The only down side is, you need to at least mount the source fs to RO
>> mode.
> 
> No. That's not really an online backup. Not good enough.
> 
>> The true on-line backup is not that easy, especially any write can screw
>> up your backup process, so it must be done unmounted.
> 
> Nope, I disagree.
> 
> First, there is the RAID1-alike solution, which is easy to perform (just
> send all new writes to both source and destination). It's the same thing
> that mdadm RAID1 would do (like I mentioned a few paragraphs above).
> But, this solution may have a performance concern, when the destination
> drive is too slow.
> 
> Fortunately, with btrfs, an online backup is easier tha usual. To
> produce a frozen snapshot of the entire filesystem, just create a
> read-only snapshot of every subvolume (this is not 100% consistent, I
> know, but it is good enough).
> 
> But I'm just repeating myself, I already wrote this in the first email.
> 
> So, in conclusion I disagree that true on-line backup is not easy.
> 
>> Even btrfs send handles this by forcing the source subvolume to be RO,
>> so I can't find an easy solution to address that.
> 
> This is a digression, but I would say that you first make a temporary RO
> snapshot of the source subvolume, then use 'btrfs send' on the temporary
> snapshot, then delete the temporary snapshot.
> 
> Oh, my.
> 
> 

