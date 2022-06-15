Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88454C835
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346723AbiFOMOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347698AbiFOMOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 08:14:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0B3C484
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 05:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655295265;
        bh=NB452umcHcmSOe95gRy/gO+W4H2tmBAnV86+bzKBENU=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=HquwJnhFx0JcBkfE7nAQzWFJW+oDVH3i3jjbds0nMbofSdk8d2MzbeLMdeBuoQuuC
         CHkDPc1O/vaz7zsaczLJUQZvvemRxZhuw5QWYKv8jyvIUUmaxmfgVJDhbCkZgfQohZ
         jPexZjZ+6c0v701lHpENE2NdVRYpNAFjFsxX9F9g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mplbx-1nMNSv2Vor-00qA8b; Wed, 15
 Jun 2022 14:14:25 +0200
Message-ID: <ea6b543f-149f-b61e-779b-6f1355a85b40@gmx.com>
Date:   Wed, 15 Jun 2022 20:14:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <5c6e45e599134cf203b76956d314b28835211990.1654751908.git.wqu@suse.com>
 <20220615115547.GT20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: don't trust any cached sector in
 __raid56_parity_recover()
In-Reply-To: <20220615115547.GT20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0LPqTm7APmQCaCe7kLOPH8Dc6cslAbwlrBVoAtc8sObkgfvJYDm
 0humsHWsmEGbBsLJlCYQetNsuVk+/uHXCPmcKAszpyb7G8bIyt0GNfIzl2gpymi2p/k+/WF
 AM+vK5YK9MqIejjexUIZLDtXVZc7BrS0oKmILU94UtU6h/ShcoicyVHCjCLyONozKfuFkpW
 tY4R57OPUFHKBm1Y88mfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a7a5kad7ZIM=:XT7b5wRIVZ0oMAtEzHBROx
 5N2snPbTUHzOfT2wsZDsWDZqoyF58nPYi1x+G+gbS3tc808OMZRV3se83XIOk30TCGabDLzPL
 zGVlZ2/Y7E2CoDJYzBXpt/Eb4//oCp+9x0bzCEIw/NVtr1oX2pmq8f+Acsc/zspMmXgt0c8BJ
 pM8oPIvYzHWv6Wxz5NJKWoffcuC7xJQiiF9pBpu4jGLMy55VC/nJKjIc8A5oXzVb52DCO6d08
 g7q9/yjcCQ3yHbv3Q6bO0HVp/lOXZW7F6UHz2uYiDzW7l4GIZEwsicQewB5+aCyWXcbuOsZrX
 mR1jcCYSt0vWa2sq+J5zdpEeujlklzcHMmIZbWeNCWqjZAEWSpPJouVn8vj6MaBvLZvJ/I7q9
 j5eMfEPXt01Oqr88RuBZFG7CCHZumoIETbBZyYXTLaI3ndsfiImUJSvSeO3f664VWl2Z1SaO8
 av31HHveYUS79rft1kvOa0HKanK6Socs+W1kTprs3C73UpMjzp0RLAc2UKIeY5+A7QuzECjIm
 7uaxNNfSCj6nhGDv/QgB5AQDUJH/5o+LWkfKY/nkw8Ys8w93OiKA6XzM3vNEU0nbYC0SqjZHf
 vdAAl0dsvVtw2ETeCXGgtO2K/AEjRZQJ28HWzKbGUBg6XqcG0Nqon/Xz4/g3HAFkqKDgFzGTB
 sIvJUnFaJgaVWBoQ2ZkT0aZiTW+mRCQxN0NCBJUN8wSwnYMSQUIfXPLuKncobB5yR2wWbZiT4
 My5QWYcNANBNc/9NuhT29rV98MfaB8BmpMyuL6xjAeKgKFIrrO0UZ7aga1sBO1UbstoLVBaNU
 Vp4yXd2DHABxlPQD3NCizqI/j9rywRYmFQJn9TswmXif97cA8ZtB07ZfqRRfbAdyoXapfxffT
 QoXYavwMTbJqcxdpbyq6fBZdMqJ0E29UuKX0h1N+qw0kq6KdSDTsJ7XwajJOMoCCAl9avms3j
 MhK/TQMk5lCpfkBxQzljzd6KoBKkPkVoejtfVtgWqn5DpSBsDCL/vx7KQfBjjYQG6tAwdmIJz
 7+o1BkWXFflZrddYlnqNyNcSkZq0bDTEc2iz7c498mdInQl1i+84tg5WG+Wg0Yh8x0xoAhwkF
 n8cWuBLKB9due4EWNf6h/JQPKWaRznXTBnTVyPzM0Ld3MiQsU2OpRaHVA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/15 19:55, David Sterba wrote:
> On Thu, Jun 09, 2022 at 01:18:44PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a small workload which will always fail with recent kernel:
>> (A simplified version from btrfs/125 test case)
>>
>>    mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>>    mount $dev1 $mnt
>>    xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>>    sync
>>    umount $mnt
>>    btrfs dev scan -u $dev3
>>    mount -o degraded $dev1 $mnt
>>    xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>>    umount $mnt
>>    btrfs dev scan
>>    mount $dev1 $mnt
>>    btrfs balance start --full-balance $mnt
>>    umount $mnt
>>
>> The failure is always failed to read some tree blocks:
>>
>>   BTRFS info (device dm-4): relocating block group 217710592 flags data=
|raid5
>>   BTRFS error (device dm-4): parent transid verify failed on 38993920 w=
anted 9 found 7
>>   BTRFS error (device dm-4): parent transid verify failed on 38993920 w=
anted 9 found 7
>>   ...
>>
>> [CAUSE]
>> With the recently added debug output, we can see all RAID56 operations
>> related to full stripe 38928384:
>>
>>   23256.118349: raid56_read_partial: full_stripe=3D38928384 devid=3D2 t=
ype=3DDATA1 offset=3D0 opf=3D0x0 physical=3D9502720 len=3D65536
>>   23256.118547: raid56_read_partial: full_stripe=3D38928384 devid=3D3 t=
ype=3DDATA2 offset=3D16384 opf=3D0x0 physical=3D9519104 len=3D16384
>>   23256.118562: raid56_read_partial: full_stripe=3D38928384 devid=3D3 t=
ype=3DDATA2 offset=3D49152 opf=3D0x0 physical=3D9551872 len=3D16384
>>   23256.118704: raid56_write_stripe: full_stripe=3D38928384 devid=3D3 t=
ype=3DDATA2 offset=3D0 opf=3D0x1 physical=3D9502720 len=3D16384
>>   23256.118867: raid56_write_stripe: full_stripe=3D38928384 devid=3D3 t=
ype=3DDATA2 offset=3D32768 opf=3D0x1 physical=3D9535488 len=3D16384
>>   23256.118887: raid56_write_stripe: full_stripe=3D38928384 devid=3D1 t=
ype=3DPQ1 offset=3D0 opf=3D0x1 physical=3D30474240 len=3D16384
>>   23256.118902: raid56_write_stripe: full_stripe=3D38928384 devid=3D1 t=
ype=3DPQ1 offset=3D32768 opf=3D0x1 physical=3D30507008 len=3D16384
>>   23256.121894: raid56_write_stripe: full_stripe=3D38928384 devid=3D3 t=
ype=3DDATA2 offset=3D49152 opf=3D0x1 physical=3D9551872 len=3D16384
>>   23256.121907: raid56_write_stripe: full_stripe=3D38928384 devid=3D1 t=
ype=3DPQ1 offset=3D49152 opf=3D0x1 physical=3D30523392 len=3D16384
>>   23256.272185: raid56_parity_recover: full stripe=3D38928384 eb=3D3901=
0304 mirror=3D2
>>   23256.272335: raid56_parity_recover: full stripe=3D38928384 eb=3D3901=
0304 mirror=3D2
>>   23256.272446: raid56_parity_recover: full stripe=3D38928384 eb=3D3901=
0304 mirror=3D2
>>
>> Before we enter raid56_parity_recover(), we have triggered some metadat=
a
>> write for the full stripe 38928384, this leads to us to read all the
>> sectors from disk.
>>
>> Furthermore, btrfs raid56 write will cache its calculated P/Q sectors t=
o
>> avoid unnecessary read.
>>
>> This means, for that full stripe, after any partial write, we will have
>> stale data, along with P/Q calculated using that stale data.
>>
>> Thankfully due to patch "btrfs: only write the sectors in the vertical =
stripe
>> which has data stripes" we haven't submitted all the corrupted P/Q to d=
isk.
>>
>> When we really need to recover certain range, aka in
>> raid56_parity_recover(), we will use the cached rbio, along with its
>> cached sectors (the full stripe is all cached).
>>
>> This explains why we have no event raid56_scrub_read_recover()
>> triggered.
>>
>> Since we have the cached P/Q which is calculated using the stale data,
>> the recovered one will just be stale.
>>
>> In our particular test case, it will always return the same incorrect
>> metadata, thus causing the same error message "parent transid verify
>> failed on 39010304 wanted 9 found 7" again and again.
>>
>> [BTRFS DESTRUCTIVE RMW PROBLEM]
>>
>> Test case btrfs/125 (and above workload) always has its trouble with
>> the destructive read-modify-write (RMW) cycle:
>>
>>          0       32K     64K
>> Data1:  | Good  | Good  |
>> Data2:  | Bad   | Bad   |
>> Parity: | Good  | Good  |
>>
>> In above case, if we trigger any write into Data1, we will use the bad
>> data in Data2 to re-generate parity, killing the only chance to recover=
y
>> Data2, thus Data2 is lost forever.
>>
>> This destructive RMW cycle is not specific to btrfs RAID56, but there
>> are some btrfs specific behaviors making the case even worse:
>>
>> - Btrfs will cache sectors for unrelated vertical stripes.
>>
>>    In above example, if we're only writing into 0~32K range, btrfs will
>>    still read data range (32K ~ 64K) of Data1, and (64K~128K) of Data2.
>>    This behavior is to cache sectors for later update.
>>
>>    Incidentally commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio()
>>    subpage compatible") has a bug which makes RAID56 to never trust the
>>    cached sectors, thus slightly improve the situation for recovery.
>>
>>    Unfortunately, follow up fix "btrfs: update stripe_sectors::uptodate=
 in
>>    steal_rbio" will revert the behavior back to the old one.
>>
>> - Btrfs raid56 partial write will update all P/Q sectors and cache them
>>
>>    This means, even if data at (64K ~ 96K) of Data2 is free space, and
>>    only (96K ~ 128K) of Data2 is really stale data.
>>    And we write into that (96K ~ 128K), we will update all the parity
>>    sectors for the full stripe.
>>
>>    This unnecessary behavior will completely kill the chance of recover=
y.
>>
>>    Thankfully, an unrelated optimization "btrfs: only write the sectors
>>    in the vertical stripe which has data stripes" will prevent
>>    submitting the write bio for untouched vertical sectors.
>>
>>    That optimization will keep the on-disk P/Q untouched for a chance f=
or
>>    later recovery.
>>
>> [FIX]
>> Although we have no good way to completely fix the destructive RMW
>> (unless we go full scrub for each partial write), we can still limit th=
e
>> damage.
>>
>> With patch "btrfs: only write the sectors in the vertical stripe which
>> has data stripes" now we won't really submit the P/Q of unrelated
>> vertical stripes, so the on-disk P/Q should still be fine.
>>
>> Now we really need to do is just drop all the cached sectors when doing
>> recovery.
>>
>> By this, we have a chance to read the original P/Q from disk, and have =
a
>> chance to recover the stale data, while still keep the cache to speed u=
p
>> regular write path.
>>
>> In fact, just dropping all the cache for recovery path is good enough t=
o
>> allow the test case btrfs/125 along with the small script to pass
>> reliably.
>>
>> The lack of metadata write after the degraded mount, and forced metadat=
a
>> COW is saving us this time.
>>
>> So this patch will fix the behavior by not trust any cache in
>> __raid56_parity_recover(), to solve the problem while still keep the
>> cache useful.
>>
>> But please remind that, this test pass DOES NOT mean we have solved the
>> destructive RMW problem, we just do better damage control a little
>> better.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Update the commit message to explain all involved patches better
>>    There are 3 patches (one in upstream, two in misc-next) involved for
>>    the case.
>
> I have hard time finding which patches are that, this should be
> mentioned like a bullet list of subjects or commits if known.

OK, I can extra the needed patches like this:

Dependency:

- btrfs: only write the sectors in the vertical stripe
   which has data stripes

Related (more like fixes):
- d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage compatible")
- btrfs: update stripe_sectors::uptodate in steal_rbio

For the related ones, they are all touching the cached sectors.
They are not dependency, more like fixes: tag. (But not direct fixes).

Do I need to update the commit message in v3?

Thanks,
Qu
