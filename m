Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2E1E3835
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgE0F13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 01:27:29 -0400
Received: from sefru.de ([176.9.70.71]:58968 "EHLO sefru.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0F13 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 01:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bxx5.de;
        s=dkim2016; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:Cc:References:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=R4k9eQeU2pVqBqYgncgQEXf+97vxNwgeQDDFOtTGdic=; b=OOKCY6D728SKbsZRF8esINMtBX
        wpLpTy0eRrLyCN+/nAo/Dqm3pNtd3qm3gN4N8s8nlpVeAuTWd1xXxGr5+FiaHaTG6iBvU0S19gWD0
        jwZ0ReVu/Wq+4gbTogMDG9xDSjrMn4YaBcEe6nPkpwkxFgnjss9pGIn5rNn/CA3VDLX2Cib3UaKFi
        Yq0oEFt2xrlTEwE/YKW6+NYZP4Yp7zGqCG/1J2O2CwdtTEINCTZFj4II0RdrIWAeDY1bCaFVZa5U3
        pHtTIju2cmLnUXP1hz03iIX3E9Hds6Yx8a5svrE3qIfXtQVjsuJg04E+1m0DwK/z+lB69zwxHLxyl
        JpiLe1LA==;
From:   Michael Thomas <mt@bxx5.de>
Subject: Re: Any news about rescue data from a raid5 in the last years?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <41c53dd1-b553-bc2e-115d-b227f97c43c2@merkens.info>
 <20200527044737.GF10769@hungrycats.org>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <14dad11b-571c-cfec-78ae-b41d69e50622@merkens.info>
Date:   Wed, 27 May 2020 07:27:24 +0200
MIME-Version: 1.0
In-Reply-To: <20200527044737.GF10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for your answer!

On 27.05.2020 06:47, Zygo Blaxell wrote:
> On Tue, May 26, 2020 at 04:44:25AM +0200, Michael Thomas wrote:
>> Hey,
>>
>> I just wanted to ask if it's maybe possible to restore data from an old,
>> failed, raid5 btrfs fs. There are some files on it which I lost lately and
>> before I format the drives I wanted to give it another shot after some (6?)
>> years.
>> I'm not sure what I tried before, but there are 3 drives there, was 4 before
>> but 1 died (and this seems to be the problem of the disaster).
>> I tried to add 1 new, but that didn't worked.
>> So, there are 3 devices and as far as I understand, there are still no good
>> tools to rescue data from them, are they? btrfs restore and other seems only
>> compatible with 1 drive.
>>
>> But maybe someone can give me a hint what I can try before giving up.
>>
>> If I try to mount:
>> mount -o degraded,subvol=data,ro,device=/dev/mapper/sdb,device=/dev/mapper/sdd,device=/dev/mapper/sde
>> /dev/mapper/sde /mnt/test
>>
>> dmesg give this errors:
>> BTRFS warning (device dm-4): suspicious: generation < chunk_root_generation:
>> 176279 < 176413
>> BTRFS info (device dm-4): allowing degraded mounts
>> BTRFS info (device dm-4): disk space caching is enabled
>> BTRFS warning (device dm-4): devid 4 uuid
>> 16490fb1-df5e-4c81-9c07-4f799d0fc132 is missing
>> BTRFS warning (device dm-4): devid 5 uuid
>> 36436209-c0d4-4a5e-9176-d44c94cb4b39 is missing
> 
> That's 2 missing disks.  Assuming that is accurate (were there 5 in
> total?), it is not likely recoverable with raid5.

No, there was a raid5 with 4 disks, 1 failed and I tried to replace it 
with another one. It failed at the placement process, so that may the 
reason why there are 2 missing disks?

> raid5 tolerates only one disk failure--two or more failures, and you'll
> only be able to get 64K contiguous chunks of data without any idea
> what files they belong to.
> 
> If the messages are _not_ accurate, you might have a corrupted superblock
> on one of the disks that is making 'btrfs dev scan' fail.  If you can
> identify which disk that is, 'btrfs rescue super-recover' might help
> (though it sounds like you already tried and it didn't).
> 
>> BTRFS critical (device dm-4): corrupt leaf: block=1095416938496 slot=151
>> extent bytenr=1095389085696 len=16384 invalid generation, have 176581 expect
>> (0, 176280]
>> BTRFS error (device dm-4): block=1095416938496 read time tree block
>> corruption detected
> 
> You may have more luck with kernel 4.19, which is a LTS kernel without
> the read time tree block corruption detector; however, that won't be able
> to read past the corrupted tree block, it will only let you mount the
> filesystem to try to salvage other data.

Tried it with the last 4.19 kernel, even there it's not mounted :(

[  230.267404] BTRFS warning (device dm-2): suspicious: generation < 
chunk_root_generation: 176279 < 176413
[  230.267407] BTRFS info (device dm-2): allowing degraded mounts
[  230.267412] BTRFS info (device dm-2): disk space caching is enabled
[  230.269808] BTRFS warning (device dm-2): devid 4 uuid 
16490fb1-df5e-4c81-9c07-4f799d0fc132 is missing
[  230.269810] BTRFS warning (device dm-2): devid 5 uuid 
36436209-c0d4-4a5e-9176-d44c94cb4b39 is missing
[  230.282425] BTRFS error (device dm-2): parent transid verify failed 
on 1095416938496 wanted 176276 found 176581
[  230.282792] BTRFS error (device dm-2): parent transid verify failed 
on 1095416938496 wanted 176276 found 176581
[  230.282797] BTRFS warning (device dm-2): failed to read root 
(objectid=4): -5
[  230.283441] BTRFS error (device dm-2): open_ctree failed

Any advices to help with this?
A btrfs restore or anything like this for raid5 would be really great =/

>> BTRFS critical (device dm-4): corrupt leaf: block=1095416938496 slot=151
>> extent bytenr=1095389085696 len=16384 invalid generation, have 176581 expect
>> (0, 176280]
>> BTRFS error (device dm-4): block=1095416938496 read time tree block
>> corruption detected
>> BTRFS warning (device dm-4): failed to read root (objectid=4): -5
>> BTRFS error (device dm-4): open_ctree failed
>>
>> (usebackuproot changed nothing and super-recover prints "All supers are
>> valid, no need to recover")
>>
>> Do you have any hint, advice to get (some of) this data back?
>>
>>
>> Best,
>> Michael
