Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58B69DC98
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 06:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfH0E0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 00:26:06 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42332 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0E0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 00:26:06 -0400
Received: by mail-lj1-f172.google.com with SMTP id l14so17105052ljj.9
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 21:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OX5xjS1clh5MBGDT1UUqTF7uVvX+S4S3C5iBbLAytHE=;
        b=EERbPYqv6tzEh2sdkJHD6AuIEpIjjiCQh6Ok22al7NwjyOO34tUNPlLGKgDBnLIdcr
         T1zRPJokS3CLZJEWzoP+SV5mk0xi7yd33FYmMi2lpqP1OaMGalDDXg94QNrORnqKMiy5
         7Cb733GaPKmpqb0w5ydJ0++cDcBDzPnHGa8v2FDhBg1me+WHv9+vQOaeEjP5Nb4dHK45
         1u9bPvN0p8f4rOdjR259Lrb3MvdOd7O3fiFZ+1Hyu7DoTXFXXa9QlXg7gmYR8Wvf0ajV
         g+Y2al9EIvSZ9Na53UvkyyOQuMObcHfcMl51dzHZcHVTSP7EBpVZx4NijdOuvNxAVWjx
         Fiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OX5xjS1clh5MBGDT1UUqTF7uVvX+S4S3C5iBbLAytHE=;
        b=CMRa2dXQ2qigxjlcIIOZuYMs8gwadKdW5/2QKV/pcEkKRqujzb0miqcDtdA110Q3wC
         WiRiv9B2rdevuWfpbjjrI+H1Hf98KASmkm81VE7TUnQhUreQ/SJA2i//5H8EPJd0uPO2
         xkndKyP8S8WtfOw12GvJKgXtr/1IZF4+ENxukdP5d0Y2kgAXO5twgq4phUd8LcEFVLZk
         RPAgNFL22pLHYP3hq+VYICCQTGWa4butb3s2Wei7RbEJ5ghTLTe3Nr7egPpUYaNa7NXK
         vVnXuUcWqS1f//0Fhw4G6LBjm7RFDu7+l3CiTAIW8Jehhq9C8qcOYVB50zM8cd/oLZKg
         uNAA==
X-Gm-Message-State: APjAAAXPVqZiEEcEdFdbLAN38VJzc1yGJdoPqWwrXPiOO94Fs72DTH4x
        QtPpSLoPq/+jEhwTOukrxzvudNzjYk8=
X-Google-Smtp-Source: APXvYqxa0Su+JZtQraoOULy5troNXXGvSTjIhNNx4t6FLU3CTi6O6vDJyqyXSjElhI9ev6YxCWr0pg==
X-Received: by 2002:a2e:a313:: with SMTP id l19mr12634563lje.32.1566879963331;
        Mon, 26 Aug 2019 21:26:03 -0700 (PDT)
Received: from [192.168.1.6] ([109.252.55.20])
        by smtp.gmail.com with ESMTPSA id o17sm2546288ljd.9.2019.08.26.21.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 21:26:01 -0700 (PDT)
Subject: Re: shared extents, but no snapshots or reflinks
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRij3ENFW3Gam+-JThg8LhewdpHKzJSfgcR-OPnvrSL=Q@mail.gmail.com>
 <CAJCQCtQZ-BH3vHaV6canyi+HA_Q2Ny_QryKFLtddyR7YME4dzQ@mail.gmail.com>
 <c5a80940-463b-ee5f-6c70-e13156c8e1ec@gmail.com>
 <CAJCQCtR0EwJ05GEB_C8EpqyXTztAoGj_G0BrWGGsdpQarhoOYA@mail.gmail.com>
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
Message-ID: <24aef5b0-7da9-ae22-a8c8-18f71b6cbd0f@gmail.com>
Date:   Tue, 27 Aug 2019 07:26:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR0EwJ05GEB_C8EpqyXTztAoGj_G0BrWGGsdpQarhoOYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

27.08.2019 2:35, Chris Murphy пишет:
> On Sun, Aug 25, 2019 at 2:14 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> 23.08.2019 6:19, Chris Murphy пишет:
>>> On Thu, Aug 22, 2019 at 8:38 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>>
>>>> There have previously been snapshots, typically prior to doing system
>>>> updates. Is this an example of extents being pinned due to snapshots,
>>>> and then extents updated and are now "stuck"? I'm kinda surprised, in
>>>> that I'd expect most programs, especially RPM, are writing out new
>>>> files entirely, then deleting obsolete files, then renaming. But...
>>>> this suggests something is doing partial overwrites of file extents
>>>> rather than replacements.
>>>
>>> It's databases. Databases are updating their files with block
>>> overwrites, btrfs COWs them. And if there's a snapshot that exists
>>> while COW happens, partial extents get pinned. This affects the
>>> firefox database files, and also RPM's. It's a small effect on my
>>> system, but it's a curious issue in particular if the files were much
>>> larger.
>>>
>>>
>>
>> What exactly "pinned" means, why it happens and when it goes away?
> 
> Pinned by a snapshot, which seems to have prevented stale extents in a file
> from being deleted (expected) but then upon subsequence deletion of the
> snapshot, those pinned extents are not released. And yet several
> database like files have "shared" extents reported by
> filefrag -v.
> 
> The file must be completely replaced (cp, then rm, then mv)
> 
> 
>> Comparing situation with and without shared extents - when you simply
>> delete snapshot, it disappears:
>>
>>
>>
>> -       item 12 key (257 ROOT_ITEM 7) itemoff 13188 itemsize 439
>> -               generation 7 root_dirid 256 bytenr 30670848 level 0 refs 1
>> -               lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x1(RDONLY)
>> -               uuid 5357e159-c577-d34b-8e0e-815767568a89
>> -               parent_uuid 1dfec531-ef6e-4d2e-a93b-2a4e4c0e4682
>> -               ctransid 6 otransid 7 stransid 0 rtransid 0
>> -               ctime 1566719522.371361184 (2019-08-25 10:52:02)
>> -               otime 1566719541.289249684 (2019-08-25 10:52:21)
>> -               drop key (0 UNKNOWN.0 0) level 0
>> -       item 13 key (257 ROOT_BACKREF 5) itemoff 13166 itemsize 22
>> -               root backref key dirid 258 sequence 2 name snap
>>
>>
>> but when there was shared extent (caused by partial overwrite) it is stuck:
>>
>> -       item 12 key (257 ROOT_ITEM 7) itemoff 13188 itemsize 439
>> -               generation 7 root_dirid 256 bytenr 30670848 level 0 refs 1
>> -               lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x1(RDONLY)
>> +       item 11 key (257 ROOT_ITEM 7) itemoff 13210 itemsize 439
>> +               generation 7 root_dirid 256 bytenr 30670848 level 0 refs 0
>> +               lastsnap 7 byte_limit 0 bytes_used 16384 flags
>> 0x1000000000001(RDONLY)
>>
>>
>> Now the undecoded flag is
>>
>> /*
>>  * Internal in-memory flag that a subvolume has been marked for deletion but
>>  * still visible as a directory
>>  */
>> #define BTRFS_ROOT_SUBVOL_DEAD          (1ULL << 48)
>>
>> but it does not agree with comment - this flag is not "in memory", it is
>> persistent (output above is from inspect-internal after filesystem is
>> unmounted).
>>
>> So when this dead subvolume is going to be removed? This can cause quite
>> real memory leak if it is stuck as long as original extent reference
>> remains.
> 
> I didn't have any stale subvolumes only marked for deletion, they were
> long gone (hours).
> 

Yes, it disappeared after some time here too, but in my case file
extents were no more shown as "shared" after that. This is using kernel
5.2.8.

Of course space was still wasted. So actually I am not sure if there is
any real difference except display issue.

I wonder if btrfs can reuse those unused parts of extents that are left
after overwriting them.
