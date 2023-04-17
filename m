Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E606E54CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 00:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDQWxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 18:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDQWxK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 18:53:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD22D63
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 15:53:09 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fIQ-1piVJ51Das-007HYA; Tue, 18
 Apr 2023 00:53:05 +0200
Message-ID: <eeb858e7-1b50-f448-08fc-58d2d256e905@gmx.com>
Date:   Tue, 18 Apr 2023 06:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: dev-replace: error out if we have unrepaired
 metadata error during
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <4db115f8781fbf68f30ca82a431cdd931767638d.1680765987.git.wqu@suse.com>
 <20230417221133.GN19619@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230417221133.GN19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TfIkfjs3H+4E7THALfbE29hdgARZhUqGvm7KaBP+kISqHuqkhF4
 JnqbJhrx6V/V2Hf+RD5BJJHfqmzx/eEUSeoPgYPsvGAyK/zgzUIbCbLLe+M45HirqUG56cp
 9r0z7Awxa9mUSmCMsXPGw2m7AsuX5bXMES6/zXAXsWB+IL8H1jWtxeUYByAdSGvnLI05dfW
 edNw+N50+6GufPcesnNfw==
UI-OutboundReport: notjunk:1;M01:P0:0qpcde2TBbo=;Hw60cYAbH1HUQ5g9eE/h0KeMIUE
 93PVKxCbupFNCDksAeIUQyP49vFmUvYwWTEo2DgplHhog+16Dg55x3zLH7azbDlUJ8hCwmJUt
 SPq2nR51prS1767DrPQi8WXSUEXNcpmYGOvawgiirQZkoVYTC37uLvT38lqCWdkGhQKpHRz7E
 sPqUfwjW4P4toOkR+AKKO9WZ980FvWwNBp+fhMzkPJSs9uiNv1FRMbr1c/FPfk5iudmfBHbQ1
 ofnFXu+8gr3paE31fS3L0McrR0QNHxdBlIO/VTrTlNvWtDiX7qWoVrphGqa2hUJ4xHCb4wEXv
 yBan6weWorJlbt/GZiFEv78DUBk7lIh9s5BIz6fSyoNzvf9YqBlX2JAOxcPAE+8GU91fhf/8c
 jTqgHRs0Y7daihF/EXgjm78o05UX2qF09Ivt/FI/HBWFf9t0fBaEnn2U1m2PhHLTBON81jk1P
 AA3aslYk2UrGlp1K/yO03OpGTwEiDO41JWB1FXk3s2cXU2dLzVcTheVXwesAfu7ydZlz4OI5t
 I0m0OmisZrXvxDHgNRCNPBMP3U/6RG5x+Waba5TsRuGMn2GV/dOGshb/VEzOI/7owPyg4SgQ+
 imnSkrJI/l9edmV/vtEMNKFwO0W9uB94OzJ5SrxXHmi/EZpANYDiGBrR95SIAoOYDp4Dl77C2
 Ms7lHANSC4l9jOqEPC9hEC0DA+qfgak8PBujHXbxLs7Yky4AO/sDLDuju1zVqOiVxwqGKTQsb
 RCmGioRDYZ2MwPD5XmLnkByD0CFgvvycVRf0oR7GuMeJVq8JdMuTc0uRkTc5BKVDMBYPb2DsD
 0NmzR+eTbglZSUyByIN9f2ujvB73BsDZcZ2g0vGwrOMsxFQ1ElkrUijgPiHbST3Ho7tpKO8lH
 RQW2nxgEspRi4Lo9t6umOY1aWp+YDUb+pf7baBFJllpEtOEOmkHHIW8CGEy42U5OqlocKhcQz
 1pRKhmrOYGb/AqLFoKWOJV10nzw=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 06:11, David Sterba wrote:
> On Thu, Apr 06, 2023 at 03:26:29PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Even before the scrub rework, if we have some corrupted metadata failed
>> to be repaired during replace, we still continue replace and let it
>> finish just as there is nothing wrong:
>>
>>   BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 started
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 0 has bad csum, has 0x00000000 want 0xade80ca1
>>   BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
>>   BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
>>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad bytenr, has 0 want 5578752
>>   BTRFS error (device dm-4): unable to fixup (regular) error at logical 5578752 on dev /dev/mapper/test-scratch1
>>   BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 finished
>>
>> This can lead to unexpected problems for the result fs.
>>
>> [CAUSE]
>> Btrfs reuses scrub code path for dev-replace to iterate all dev extents.
>>
>> But unlike scrub, dev-replace doesn't really bother to check the scrub
>> progress, which records all the errors found during replace.
>>
>> And even if we checks the progress, we can not really determine which
>> errors are minor, which are critical just by the plain numbers.
>> (remember we don't treat metadata/data checksum error differently).
>>
>> This behavior is there from the very beginning.
>>
>> [FIX]
>> Instead of continue the replace, just error out if we hit an unrepaired
>> metadata sector.
>>
>> Now the dev-replace would be rejected with -EIO, to inform the user.
>> Although it also means, the fs has some metadata error which can not be
>> repaired, the user would be super upset anyway.
>>
>> The new dmesg would look like this:
>>
>>   BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 started
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
>>   BTRFS error (device dm-4): unable to fixup (regular) error at logical 5570560 on dev /dev/mapper/test-scratch1 physical 5570560
>>   BTRFS warning (device dm-4): header error at logical 5570560 on dev /dev/mapper/test-scratch1, physical 5570560: metadata leaf (level 0) in tree 5
>>   BTRFS warning (device dm-4): header error at logical 5570560 on dev /dev/mapper/test-scratch1, physical 5570560: metadata leaf (level 0) in tree 5
>>   BTRFS error (device dm-4): stripe 5570560 has unrepaired metadata sector at 5578752
>>   BTRFS error (device dm-4): btrfs_scrub_dev(/dev/mapper/test-scratch1, 1, /dev/mapper/test-scratch2) failed -5
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Where is this patch supposed to be applied? I tried the 6.3 base and
> misc-next but both have several conflicts.

It is based on misc-next of the time, which has all the scrub rework.

I'll refresh the patch soon.

Thanks,
Qu

> The other scrub patches
> https://lore.kernel.org/linux-btrfs/cover.1681364951.git.wqu@suse.com/
> also don't apply either separately or on top of this patch.
