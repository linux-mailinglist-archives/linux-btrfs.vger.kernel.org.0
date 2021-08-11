Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116D03E89B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 07:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhHKFWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 01:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhHKFWc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 01:22:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45CC061765
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 22:22:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so2711154pjl.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 22:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j1O4wIErcvCmgm7VwQUUawmCP0iB+1J2JZ6tqjzhPuY=;
        b=Bqq29N9Q4MIJgYm/MaOgk5k9GSnGiL5143DH25AhSvPsKp/OmgqapBZ54pKiJOKHmb
         PYK58IIbzZ40NWCBAKnVmnTD3Z73iGMolO8Hf5fGdA11+ku5KEvgJ42FT0tnB6eTTO0K
         xsflcplSTJ9kK/cSFIYXuYz4iuNm20uLJIXzYxlb15SVOufeKARVC64YZTCGW/Hz0Vuv
         fO27lH33ZlyJMmiz5de3sAAvCjwUowR5ON60SIwV7AZyW0IoKZVUqXboEFhVJ60Lcl68
         M3C8q++M6eNg7WzjgnhoOr9gDrHLHe3A+votqdOgOcUcQGiCVpCTF1flNGMaV3GGqHeX
         nSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j1O4wIErcvCmgm7VwQUUawmCP0iB+1J2JZ6tqjzhPuY=;
        b=lczq+dkEwapign0OqtOQLd65cg8FY3WEwaitVqPGs78owLO0YancdGRSwKaKR3njOn
         rdJD8FlHE/t7L/42K9oQhGdHba+vlXcSUBC1oHH+8f9ExF6BEOxO5fCzbcMb9wU3SbuR
         ewknGJ6DuXNinLBVl88cJC0r4FyMUhkVw6NKW25RaHnNIYfbDENj33MDlxL4P5Xt/d7C
         w/hNM41M+fKBLcCOXKCJyWkwOPsN5z4oAd4gErMcnRpjrX2g+sHtBviEWk9tkOrR2jGD
         tPPvK06MvoC+8flDVyZsuI3ZgQezpUHoAcWqfZuG9UE4HebVfx/NACgod0aY4uY1hJG/
         pAPw==
X-Gm-Message-State: AOAM5334rNS619J2Tb0RPai5V+NiIJ1E1Z8A9nGvuuRwFfLlcJz3aiN5
        sEEW6B+m0fJhiWH8qD1XQN4=
X-Google-Smtp-Source: ABdhPJwPUxfQWS0FUGus+ok8F0jmJ76BjRFRCksC3lDxPklsSBzR13JPdElrnaUBl2ANh6rSv6XXiA==
X-Received: by 2002:a17:902:70c2:b029:12d:4d0b:6f22 with SMTP id l2-20020a17090270c2b029012d4d0b6f22mr2806678plt.32.1628659328660;
        Tue, 10 Aug 2021 22:22:08 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id mr18sm23760482pjb.39.2021.08.10.22.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 22:22:07 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
Date:   Tue, 10 Aug 2021 22:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/21 16:54, Qu Wenruo wrote:
>
>
> On 2021/8/11 上午7:21, Konstantin Svist wrote:
>> On 8/10/21 15:24, Qu Wenruo wrote:
>>>
>>> On 2021/8/11 上午12:12, Konstantin Svist wrote:
>>>>
>>>>>> I don't know how to do that (corrupt the extent tree)
>>>>>
>>>>> There is the more detailed version:
>>>>> https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf597299a@gmx.com/
>>>>>
>>>>>
>>>>
>>>>
>>>> So, here's what I get:
>>>>
>>>>
>>>> # btrfs ins dump-tree -t root /dev/sdb3 |grep -A5 'item 0 key
>>>> (EXTENT_TREE'
>>>>
>>>>       item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
>>>>           generation 166932 root_dirid 0 bytenr 786939904 level 2
>>>> refs 1
>>>>           lastsnap 0 byte_limit 0 bytes_used 50708480 flags 0x0(none)
>>>>           uuid 00000000-0000-0000-0000-000000000000
>>>>           drop key (0 UNKNOWN.0 0) level 0
>>>>       item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
>>>>
>>>>
>>>> # btrfs-map-logical -l 786939904 /dev/sdb3
>>>>
>>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>>>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>>>> bad tree block 952483840, bytenr mismatch, want=952483840, have=0
>>>> ERROR: failed to read block groups: Input/output error
>>>> Open ctree failed
>>>>
>>>>
>>>>
>>>> Sooooo.. now what..?
>>>>
>>> With v5.11 or newer kernel, mount it with "-o rescue=all,ro".
>>
>>
>> Sorry, I guess that wasn't clear: that error above is what I get while
>> trying to corrupt the extent tree as per your guide.
>
> Oh, that btrfs-map-logical is requiring unnecessary trees to continue.
>
> Can you re-compile btrfs-progs with the attached patch?
> Then the re-compiled btrfs-map-logical should work without problem.



Awesome, that worked to map the sector & mount the partition.. but I
still can't access subvol_root, where the recent data is:

[root@fry ~]# mount -oro,rescue=all /dev/sdb3 /mnt/
[root@fry ~]# ll /mnt/
ls: cannot access '/mnt/subvol_root': Input/output error
total 0
d?????????? ? ?    ?     ?            ? subvol_root
drwxr-xr-x. 1 root root 12 Mar 18 20:55 subvol_snapshots


dmesg:

[532051.071515] BTRFS info (device sdb3): enabling all of the rescue options
[532051.071521] BTRFS info (device sdb3): ignoring data csums
[532051.071523] BTRFS info (device sdb3): ignoring bad roots
[532051.071524] BTRFS info (device sdb3): disabling log replay at mount time
[532051.071526] BTRFS info (device sdb3): disk space caching is enabled
[532051.071528] BTRFS info (device sdb3): has skinny extents
[532051.077018] BTRFS warning (device sdb3): sdb3 checksum verify failed
on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6 level 2
[532051.077710] BTRFS warning (device sdb3): sdb3 checksum verify failed
on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6 level 2
[532052.705324] BTRFS error (device sdb3): bad tree block start, want
920748032 have 0
[532052.705934] BTRFS error (device sdb3): bad tree block start, want
920748032 have 0

