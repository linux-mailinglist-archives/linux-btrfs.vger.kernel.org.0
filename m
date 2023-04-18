Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B76E5A36
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDRHQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 03:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDRHQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 03:16:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6A3C1F
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 00:16:11 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1pvW8b38kz-00Syoh; Tue, 18
 Apr 2023 09:16:05 +0200
Message-ID: <6fc3db31-cb9f-de32-cd4d-1d9d63270ba7@gmx.com>
Date:   Tue, 18 Apr 2023 15:16:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: output affected files when relocation failed
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
 <9bb5f4ea-717b-2365-652a-01b130452118@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9bb5f4ea-717b-2365-652a-01b130452118@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Lal+iFZClRlDo8n7eZzdlhtb2ogWQZurx6dhAC71whb9FIyU3nr
 neX81XnPk0EEOFtH5y09YZsvkanipzaqaHtKXpEgW+nS5Ku/H21hQxGCgoOI60oSOElh/bk
 ZysQ6a/803tuDBIEMh3Yey0i22kIiHy7oSeFx1DWxd+p/SvYyTr1Yuaz6o4y08fUXtyDRfK
 s9DLEBRldPLOtBavrG8Hg==
UI-OutboundReport: notjunk:1;M01:P0:jEF2sSH9IaY=;lGfeZSULn3TcvSpPVZk6dyx8e00
 9WLirvAbcbdJEUugiYOxm+b0fFtvFyenJVz3d8Pjn6sz/JIqrPrFN8qFZuTJu2qCGKdlK+F3B
 ddj8/bYLybnL2G4QrSGCghv/QjQbZXhkx4zr6oqnTfQQvAgDV8InwJXhYE0Em9PhIvWTnleic
 YaI6dP+9C0gLfL10UN6VgAwWvITqu9YCojUjTMueFnoLDghszAETjehPlXF6s9GgqWQJBPdul
 Y3cpnT+4pslhlVxngN0DX2YHws0RjLGN9+0L/M3NT3wB2QcI433AxQM2G28PL37guthYOVems
 fVPQ9NDpCBKCLLI/uPgidVlj8oqJpyX2mYytUvQ3r+aQW6zOzr0HPckX7ZvVUjo07+wTZWgsm
 KohV38LropshShn4tNf4pSwLme9t0sgtZBrBA0EUHruCHjpbSHWTkWkDuPkliKB2829gPwUZJ
 vAwVchhdfcUAGIw+5emRLWnganrweaA5KIgSkpH0Cc76lKAXXq7Qp+QJUV93blgjuiUYUDTpO
 T9J6ycqPylHVXrGf2pVTOl4Qe/8ji5oz0fGsRPiT53UQOQvriN2jDBaIxH3y6nzz3c6uo5If3
 s8sQRjxhMM6RzFG9zGAcf9tMCAXLTMty92H+KaqghILL5Kv/Z9E3d4DQC+d/TKCycFhwl+hyL
 6SBQv9KDyhXnA2/Yy41zo71zE7XJ3lVPZ7PxArKt0Efl0JK2OFuQ+rGW4FkzJn6ktfc6Hgad+
 lnnUGPEuSjZjarcXO7eRix9siH9ALYUtnYXIlkZt9AGNDXPa+k7xo9zBCYFq24EvPWlnkOrdK
 wFFhr4CbUmivkaVWF4HRbCzSm6qur6gegapyuoA+/yJfOtZCL0mI6iEWK6GqyhdLjYnL+nTM2
 h+DLsZ6wKVgxDM1F+zKmmKCgwCgScmpd1UKv5RvEk7X0yZ3tcxSEwxhcD76RLFTeFGHCL4gZz
 gzcyP+bebEnQd0tfweRZLyR828A=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 12:31, Anand Jain wrote:
> On 18/4/23 09:15, Qu Wenruo wrote:
>> [PROBLEM]
>> When relocation failed (mostly due to checksum mismatch), we only got
>> very cryptic error messages like
>>
>>    BTRFS info (device dm-4): relocating block group 13631488 flags data
>>    BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 csum 
>> 0x373e1ae3 expected csum 0x98757625 mirror 1
>>    BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 
>> 0, rd 0, flush 0, corrupt 1, gen 0
>>    BTRFS info (device dm-4): balance: ended with status: -5
>>
>> The end user has to decrypt the above messages and use various tools to
>> locate the affected files and find a way to fix the problem (mostly
>> deleting the file).
>>
>> This is not an easy work even for experienced developer, not to mention
>> the end users.
>>
>> [SCRUB IS DOING BETTER]
>> By contrast, scrub is providing much better error messages:
>>
>>   BTRFS error (device dm-4): unable to fixup (regular) error at 
>> logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>>   BTRFS warning (device dm-4): checksum error at logical 13631488 on 
>> dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, 
>> offset 0, length 4096, links 1 (path: file)
>>   BTRFS info (device dm-4): scrub: finished on devid 1 with status: 0
>>
>> Which provides the affected files directly to the end user.
>>
>> [IMPROVEMENT]
>> Instead of the generic data checksum error messages, which is not doing
>> a good job for data reloc inodes, this patch introduce a scrub like
>> backref walking based solution.
>>
>> When a sector failed its checksum for data reloc inode, we go the
>> following workflow:
>>
>> - Get the real logical bytenr
>>    For data reloc inode, the file offset is the offset inside the block
>>    group.
>>    Thus the real logical bytenr is @file_off + @block_group->start.
>>
>> - Do an extent type check
>>    If it's tree blocks it's much easier to handle, just go through
>>    all the tree block backref.
>>
>> - Do a backref walk and inode path resolution for data extents
>>    This is mostly the same as scrub.
>>    But unfortunately we can not reuse the same function as the output
>>    format is different.
>>
>> Now the new output would be more user friendly:
>>
>>   BTRFS info (device dm-4): relocating block group 13631488 flags data
>>   BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 
>> logical 13631488 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>>   BTRFS warning (device dm-4): checksum error at logical 13631488 
>> mirror 1, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 
>> 0, rd 0, flush 0, corrupt 2, gen 0
>>   BTRFS info (device dm-4): balance: ended with status: -5
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> LGTM
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> However, a nit as below.
> 
>> +        btrfs_warn_rl(fs_info,
>> +"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected 
>> csum " CSUM_FMT " mirror %d",
>                                  ^ %llu

Nope, that's intentional.

Try to put -9 into that %llu output, and see which is easier to read, -9 
or 18446744073709551607.

Thanks,
Qu
>> +            inode->root->root_key.objectid, btrfs_ino(inode), file_off,
>> +            CSUM_FMT_VALUE(csum_size, csum),
>> +            CSUM_FMT_VALUE(csum_size, csum_expected),
>> +            mirror_num);
>> +        return;
>> +    }
>> +
>> +    logical += file_off;
>> +    btrfs_warn_rl(fs_info,
>> +"csum failed root %lld ino %llu off %llu logical %llu csum " CSUM_FMT 
>> " expected csum " CSUM_FMT " mirror %d",
>> +            inode->root->root_key.objectid,
>> +            btrfs_ino(inode), file_off, logical,
>> +            CSUM_FMT_VALUE(csum_size, csum),
>> +            CSUM_FMT_VALUE(csum_size, csum_expected),
>> +            mirror_num);
>> +
> 
