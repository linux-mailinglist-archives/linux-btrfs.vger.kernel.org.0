Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B92E23D055
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgHEQ7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Aug 2020 12:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgHEQ4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Aug 2020 12:56:45 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166BC001FC7
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Aug 2020 08:45:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bs17so14131096edb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Aug 2020 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u68CKktGzu9b45plJfLsUFMPhpqFVRwtC9NWIuJW3/s=;
        b=IInbeIcwFzE8G2Vm9EKQTCpgrPJW3TzErt898FqmzIcHf8jcvYypY6vOo7KHZizvOH
         4Cg6B2ks3fbGZGe0ejVNu5TX3LgyGTbV5zoyj/qQTMoT5eGjuvo7nhjivrRXsSe8h9a8
         NmwYnZUG5SLuJJIXrwugu6cSf4xkk3kFW4c/1O1R3sBtlRTIQdCdKLYxa7+79CD+xU9w
         uLZtFRNDDWA9bMtMjwoMueeZDBeFZHqNp6bseupBCoWqt0qPsPdPqSzjknxOEtDeRpvn
         DffDayPw/S8qAlr9SJeA8SFoBpfgVcnkeBstcdN8JfBs2xIsklvxAmzKFy69juoFFcnq
         U8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u68CKktGzu9b45plJfLsUFMPhpqFVRwtC9NWIuJW3/s=;
        b=k25f0hHuKVzeICG1X09R0YFY6RmSk3dtavI34E/N3F73rzr8MU9FEssOiiXrebjQRO
         3I6SZnAndmRwZYOuGCyuwFisQNpm/OjHPUT9TRDXq9OIGlz91E1AVIfsyP0Z4qaIfdEz
         7pdwObWsyoaWjq6Yku6EfNJRfQNydW07+KeJepZr7zdbpDDbv9bsyaO4NCfJApYZwV8H
         NX/sERsAnDSkOsrcKd9cXLYFwLopJzt39ni6PwF9uYdClXoNP5xfiTHCDRBTDRLB4sje
         ISKqcEh345n93PFztMIrAdG1ispXvwLvSJTn+cL6FCIufsS9I8+2bisVcxa61XGKuCHn
         UqBw==
X-Gm-Message-State: AOAM532mFwW8mLULFn3uDLqik3pfadNrzVRkyek2n4PTN7eamVNp2rtv
        0q2r1wWt/4YgQh3HUfq4h08kELzdKNSwJtlKQm2KiSYjKUqOwXEN4gSGUjO6sB1bVNwpJcRAki4
        SuzqLwK5gv8Wi4j+ZSOCtY8DclPI=
X-Google-Smtp-Source: ABdhPJwJQ6MtNQsFNv3atpK+XTSrieY1ZIsoM4UtMoR8wQ5GUENyIvfD0S9m9Y8pqWHChylaNwqerQ==
X-Received: by 2002:a05:6402:304b:: with SMTP id bu11mr3313257edb.106.1596642303473;
        Wed, 05 Aug 2020 08:45:03 -0700 (PDT)
Received: from [192.168.0.142] ([62.218.42.35])
        by smtp.gmail.com with ESMTPSA id q19sm1803937ejo.93.2020.08.05.08.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 08:45:02 -0700 (PDT)
Subject: Re: Troubles removing missing device from RAID 6
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <23712d34-1787-058d-b49a-6b3e78969920@liland.com>
 <20200721005724.GK10769@hungrycats.org>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <30788d0d-8713-b770-c2b1-93dd4e9e85fe@liland.com>
Date:   Wed, 5 Aug 2020 17:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721005724.GK10769@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/21/20 2:57 AM, Zygo Blaxell wrote:
> On Sun, Jul 19, 2020 at 04:13:29PM +0200, Edmund Urbani wrote:
>> Hello everyone,
>>
>> after having RMA'd a faulty HDD from my RAID6 and having received the
>> replacement, I added the new disk to the filesystem. At that point the
>> missing device was still listed and I went ahead to remove it like so:
>>
>> btrfs device delete missing /mnt/shared/
>>
>> After a few hours that command aborted with an I/O error and the logs
>> revealed this problem:
>>
>> [284564.279190] BTRFS info (device sda1): relocating block group
>> 51490279391232 flags data|raid6
>> [284572.319649] btrfs_print_data_csum_error: 75 callbacks suppressed
>> [284572.319656] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386727936 csum 0x791e44cc expected csum 0xbd1725d0 mirror 2
>> [284572.320165] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386732032 csum 0xec5f6097 expected csum 0x9114b5fa mirror 2
>> [284572.320211] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386736128 csum 0x4d2fa4b9 expected csum 0xf8a923f9 mirror 2
>> [284572.320225] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386740224 csum 0xcad08362 expected csum 0xa9361ed3 mirror 2
>> [284572.320266] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386744320 csum 0x469ac192 expected csum 0xb1e94692 mirror 2
>> [284572.320279] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386748416 csum 0x69759c1f expected csum 0xb3b9aa86 mirror 2
>> [284572.320290] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386752512 csum 0xd3a7c5d5 expected csum 0xd351862f mirror 2
>> [284572.320465] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386756608 csum 0x1264af83 expected csum 0x3a2c0ed5 mirror 2
>> [284572.320480] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386760704 csum 0x260a13ef expected csum 0xb3b4aec0 mirror 2
>> [284572.320492] BTRFS warning (device sda1): csum failed root -9 ino 433=
 off
>> 386764800 csum 0x6b615cd9 expected csum 0x99eaf560 mirror 2
>>
>> I ran a long SMART self-test on the drives in the array which found no
>> problem.
> You are hitting a few of the known bugs in btrfs raid5/6.  See
>
> 	https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.or=
g/
>
> TL;DR don't expect anything to work right until 'btrfs replace' is done.
>
>> Currently I am running scrub to attempt and fix the block group.
> Scrub can only correct errors that exist on the disk, so scrub has no
> effect here.  Wait until 'btrfs replace' is done, then scrub the other
> disks in the array.
>
> btrfs raid6 has broken read code for degraded mode.  The errors above
> all originate from trees inside the kernel (root -9 isn't a normal
> on-disk root).  Those errors don't exist on disk.  The errors are
> triggered repeatably by on-disk structures, so the errors will _appear_
> to be persistent (i.e.  if you try to balance the same block group twice
> it will usually fail at the same spot); however, the on-disk structures
> are valid, and should not produce an error if the kernel code was correct=
,
> or if the missing disk is replaced.
>
>> scrub status:
>>
>> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 9c3c3f8d-a601-4bd3-8871-d068dd500a15
>>
>> Scrub started:=C2=A0=C2=A0=C2=A0 Fri Jul 17 07:52:06 2020
>> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runn=
ing
>> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14:47:07
>> Time left:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 202:05:46
>> ETA:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Tue Jul 28 00:07:36 2020
>> Total to scrub:=C2=A0=C2=A0 16.80TiB
>> Bytes scrubbed:=C2=A0=C2=A0 1.14TiB
>> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 22.56MiB/s
>> Error summary:=C2=A0=C2=A0=C2=A0 read=3D295132162
>>  =C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>  =C2=A0 Uncorrectable:=C2=A0 295132162
>>  =C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0
>>
>> device stats:
>>
>> Label: none=C2=A0 uuid: 9c3c3f8d-a601-4bd3-8871-d068dd500a15
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 5 FS bytes use=
d 16.80TiB
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 si=
ze 9.09TiB used 8.76TiB path /dev/sda1
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 si=
ze 9.09TiB used 8.76TiB path /dev/sdb1
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 si=
ze 9.09TiB used 8.74TiB path /dev/sdd1
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 si=
ze 9.09TiB used 498.53GiB path /dev/sdc1
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *** Some devices missing
>>
>> Is there anything else I can do to try and specifically fix that one blo=
ck
>> group rather than scrubbing the entire filesytem? Also, is it "normal" t=
hat
>> scrub stats would show a huge number of "uncorrectable" errors when a de=
vice
>> is missing or should I be worried about that?
> There might be a few dozen KB of uncorrectable data after the 'btrfs
> replace' is done, depending on how messy the original disk failure was.
>
> You may want to zero the dev stats once the btrfs replace is done,
> as the stats collected during degraded mode will be mostly garbage.
>
>> Kind regards,
>>  =C2=A0Edmund
>>
Scrub failed while I was gone on vacation. Thankfully the filesystem is sti=
ll up=20
and running "fine" in degraded mode. I ordered another drive to try and rep=
lace=20
the missing one properly this time around.


PS: Sorry about the other redundant thread I created. Somehow missed this r=
eply=20
yesterday.


--=20
Auch Liland ist in der Krise f=C3=BCr Sie da! #WirBleibenZuhause und liefer=
n=20
Ihnen trotzdem weiterhin hohe Qualit=C3=A4t und besten Service.=C2=A0
Unser Support=20
<mailto:support@liland.com> steht weiterhin wie gewohnt zur Verf=C3=BCgung.
Ihr=20
Team LILAND
*
*
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463=20
220111
Tel: +49 89 458 15 940
office@Liland.com
https://Liland.com=20
<https://Liland.com>=C2=A0
 <https://twitter.com/lilandit>=C2=A0=20
<https://www.instagram.com/liland_com/>=C2=A0=20
<https://www.facebook.com/LilandIT/>

Copyright =C2=A9 2020 Liland IT GmbH=C2=A0


Diese Mail enthaelt vertrauliche und/oder rechtlich geschuetzte=C2=A0
Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat sind oder diese Email=20
irrtuemlich=C2=A0erhalten haben, informieren Sie bitte sofort den Absender =
und=20
vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte=
=20
Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This email may contain=20
confidential and/or privileged information.=C2=A0
If you are not the intended=20
recipient (or have received this email in=C2=A0error) please notify the sen=
der=20
immediately and destroy this email. Any=C2=A0unauthorised copying, disclosu=
re or=20
distribution of the material in this=C2=A0email is strictly forbidden.
