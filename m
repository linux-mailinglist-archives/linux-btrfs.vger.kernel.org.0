Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E118D4AA8F4
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 14:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355661AbiBENCD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 08:02:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:52505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346507AbiBENCC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Feb 2022 08:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644066112;
        bh=2DJb864FQNRfVm15qRnrxjmfz0c3svUW92QapqkvjDs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Tq4h0qHQ/JCFbkS+T1JSRzSspEpgFLVWHdVCbz91Uj3/kgSXndEBLnwoywiq3TSbC
         yNzHBOnEzJXDrXb2R5M5NvVLmPLmAD7CoO4/ZbKhFLltwy8Z+4a6ShSorloHW19+qk
         uh7KQPDAQG4I9TUCdI6vjFpNh5dPIkvAe8dF7seA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1mC55240rz-0154RU; Sat, 05
 Feb 2022 14:01:52 +0100
Message-ID: <27f44938-e58b-8566-0359-ef0260bd9b84@gmx.com>
Date:   Sat, 5 Feb 2022 21:01:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] btrfs: tree-checker: check item_size for dev_item
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <20220205123520.77B3.409509F4@e16-tech.com>
 <ee4h36eo.fsf@damenly.su> <20220205203028.4F35.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220205203028.4F35.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IGpY2Vwjr4XwWjZ13hlPOdnSUL6/80P7Fnqw3/6FGK6BupwIreT
 9WfJfENJZVnSqkAscdugxXtlnilZHOFcZUV8rhnjBugjv2uewizlThzd4tckSEGN5oAwsa6
 O/bKnNtIm9cZzJ9t7VcuaP7VpVscZUcOrAm9IbTy9N9tJQ3blDSTmbxlTV5/1LL44Q46bBe
 +yuJ70mgdPj6Gu23Gu0KQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nArEj0EkZTg=:tMfYHJavIVOG3AbmMDxOq/
 Meos3RzyZ+HsUUAQXsSDUvh8tLEv76YEEmjkk5y1EBDEwRaEGOqVv6nSoYw8ZSAqYQckT+FDs
 WLDXZ25+Mtq3QqOihGlZw+PEDvaOL1EVQhx2WxL/Rq7V3/p4t+z8DTYoNw1z+zhR5NGsxrN+x
 1m/qv8TudlM7MKNnZ/9M13ueNxnxkkTod92o4jisufmKFskm8M60vSj0E2AVQBqdFNhns37oO
 InOY8FdVF5/GesZSPWsSyPbCqbI9VmJVYTRwXpEF4+st2jWP9vdR2thJeHXWDRvj7As7aiuQi
 SbzW77FUWVMPHhZ711cHgEg85xKUvGrY0OxyNgm72zX0uOz3ZjGv6/i3XFyj/ly8NMNBQqC1E
 liM4THIqW8dBOip4rlZ6GTy7jdysLnpC7tvUH2UlOSfSI6Cgs+wxF0G4GneQG1ZpW0CjHppV1
 jXH6NBp5WbcYVo7UwO3Zkpt4/SVo1X8jyNGegKovQNCAJZwxZ7s7zsVheKe33+c+yy/RGjIfC
 3JMur2YIww4zKPePYBM/sQGaoEC4O35gbGXMS14aM22FNpPcJ1TYj/axVoOqLDncA//r0KHL9
 fSc3ZnG3CRMuAhrso2Rxp/5UV0OxDzF4XZf+F06bbHmz9zBGQui4GCLGE29p3pfHI/TA5mAUh
 RN0eFgtVATWK6W6ylWVyTzVJFuEchvYmES2kUklDPF4KWMMmCk0RgNecWrlpf6LKuH9y+cgwX
 1zF7U0O/eYeA2/3iSgoBVxQfibF29+sGybnVEVncbJTNMQZiTcxUfbln6Q0WL7C6Rx3pRWoLN
 sdBYuP9l0LLr0NBIIm5N2OvfGZrU4iEAPX9iweG8X3mhcbsMBC3JYTbz+ytvujO720JTbO7yY
 0sVT0aR8mUDnNuQnqLNaO+ChgDHdrK6SLF0ACfifUYg9A23gsv8Bw4c23eX6i2ePzOaWf4SEZ
 jimgwy0nQY0vtySwsU6RlJy3dtb7twJ0cyJYICzlEx3gCk6NsiYHm5yYqxUqH6nX5ZyTRNoIZ
 N17KJhtEWl0bG/5uaNpdU3rwbNS5mUNDh2fDmfRJAL5D9vXUsAqPLgYy4avEmgtNFBDJXqgqw
 19esHOJLdYKAhM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/5 20:30, Wang Yugui wrote:
> Hi,
>
>>>> A btrfs filesystem failed to boot with this patch.
>>>>
>>>> corrupt leaf: root=3D3 block=3D1081344 slot=3D0 devid=3D1 invalid ite=
m
>>>> size: has 0 expect 98
>>>>
>>>> Any way to fix it online?
>>>
>>> This btrfs filesystem is created by centos 7.9 installer (btrfs
>>> 4.9?)
>>> about 1 years ago.  and then mainly writen by kernel
>>> 5.4/5.10/5.15.
>>>
>> Yes, btrfs-progs v4.9 and v3.10 based kernel.
>> I created a btrfs and it looks fine.
>> Could please provide output of
>> btrfs inspect-internal dump-tree $device -t 3
>> ?
>> You can trim it if the content is too long only leaf 1081344 is needed.
>
> Hi,
>
> # btrfs filesystem show /
> Label: 'OS_T640'  uuid: 73dcce98-8f6b-4ec8-bfac-fa7c7c87409d
>          Total devices 10 FS bytes used 5.53TiB
>          devid    1 size 799.00GiB used 332.01GiB path /dev/sda2
>          devid    2 size 1.75TiB used 741.00GiB path /dev/sdg1
>          devid    3 size 1.75TiB used 745.00GiB path /dev/sdj1
>          devid    4 size 1.75TiB used 740.00GiB path /dev/sdi1
>          devid    5 size 1.75TiB used 745.00GiB path /dev/sdd1
>          devid    6 size 1.75TiB used 480.00GiB path /dev/sde1
>          devid    7 size 1.75TiB used 480.00GiB path /dev/sdh1
>          devid    8 size 1.75TiB used 479.00GiB path /dev/sdc1
>          devid    9 size 1.75TiB used 480.00GiB path /dev/sdb1
>          devid   10 size 1.75TiB used 479.00GiB path /dev/sdf1
>
> #btrfs inspect-internal dump-tree /dev/sda2 -t 3 > 3.txt
>
> and then 3.txt is zipped as  this attachment file(3.zip)

Full dmesg of the boot failure please.

The dump-tree shows the device item is completely sane, it has size 98,
not the value (0) reported from tree-checker.

Thus I don't know why tree-checker is reporting this problem.

Thanks,
Qu
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/02/05
>
>
