Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0536F4D8D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 01:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEBXVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 19:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEBXVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 19:21:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B01FF9
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 16:21:04 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1Obh-1qMofH2BNz-012nHR; Wed, 03
 May 2023 01:21:01 +0200
Message-ID: <b97abccc-435c-8994-2ab4-2c9ecb796f66@gmx.com>
Date:   Wed, 3 May 2023 07:20:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
 <20230502155410.GH8111@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: output affected files when relocation failed
In-Reply-To: <20230502155410.GH8111@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1FCKsQK4c7njQi1JUIJj8wIsK9jThmyjJRyc3c8FEoKkSyDIZ9H
 qdcFyMvxugr42bhl3ioG/cn//TlMszXvTGaCqEJZGS1YPrHU7l+ai4UVpD+7tmj7Sn5KKx2
 H3qM2ev0JPjbTik6keZTgaOs7JmtDYkgqi3RMPERHNMyPgTI+t/RrVzy1BJTmzb1r5ltvs8
 Kv+UMkXazXoWhA4PDqjLg==
UI-OutboundReport: notjunk:1;M01:P0:LJun9YdkgTA=;rwoSktpx2ClPvRfCdFNzdt0insv
 Z02BK41244akej31iMOEGRa3RFOqaMA43D7/maGINFcWyBd9ESu8i2qtU/zztR39oTXoC969R
 JkiiBKQUkdnuaHll4KYQgSyi9Xj94D6riVCXHo18rUu9ZXFooxGVoKx4Lff1X7ssW74PPYzZO
 SKwGQU/RUfyC4GoAygL5+i97S/pQRcDWS5H2ugdQGh7NGM52H8V6mVYAhDVDMr1QFq4dd5SKs
 AGW9qMNSFyz9e8sxMFteFIYntjUIeUK+bQDR2leZS7msh0FwqBX6DkYHe/7+VpYhQPWcJ9+uI
 pl/4GnQNfRwj/J23reMX0DUjtZj0sITDGNJJZy52EeIG+8MIO9DDiIDCqT8moGKylj3I59S8z
 +KjGJtuiNwjexJXuBB+IS47zLX9pw/XNbbTrM1pZfWRSVppqJWFitgEh1CxEgWYDz0RCEN9YI
 rrVgsOSCm+AVT35GwkmH7CBnOvKG2PKfMLHQBGtwdGi2bQvgX+KDlc6owR6lBI/qa/wSinjtg
 /cj7bez+AObS0/NUCIVLJJIx5/IQm7kQdYlRnl7m65xi06+FFAz2PjSPGFRPz0YZaEHujarvy
 URS3d2ZQoeX9RBsf4ybcb2e3QGLsvJnGgzwzfEM1EE9d5NJhNCfXrTrXivHHH4BiAMAz/+hR1
 +jlySd+mh9TizUOaHyvTETiIoj/ELs9fEhBIgrfYJ3amEuTSLWIqyJFEqFU0gUfQ5IXMazzah
 G+gbI/vkUEBH5RsE2wg4g0tszOGhC9/li2jp32+KrUOTbdnwmi8c7QCI0bTBPlErx2VI1tDh7
 YU0n2rp7MHFZabqlMGaJqcYe6KYMiVa24CpE2nlb370Jm3pZvveZr77mCFEUg6LmG/sFYVXOD
 r7u0AMuj6Xo1DqszwqxH1NZak/j4YQ/qI/l/tODq/G6y3S7+/ke8qqwAqXVZHYTUo4aAb21l+
 sngS1dAz2SSrHVtR9HnbPsL152w=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/2 23:54, David Sterba wrote:
> On Tue, Apr 18, 2023 at 09:15:46AM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> When relocation failed (mostly due to checksum mismatch), we only got
>> very cryptic error messages like
>>
>>    BTRFS info (device dm-4): relocating block group 13631488 flags data
>>    BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>>    BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>    BTRFS info (device dm-4): balance: ended with status: -5
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
>>   BTRFS error (device dm-4): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>>   BTRFS warning (device dm-4): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>>   BTRFS info (device dm-4): scrub: finished on devid 1 with status: 0
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
>>    For data reloc inode, the file offset is the offset inside the block
>>    group.
>>    Thus the real logical bytenr is @file_off + @block_group->start.
>>
>> - Do an extent type check
>>    If it's tree blocks it's much easier to handle, just go through
>>    all the tree block backref.
>>
>> - Do a backref walk and inode path resolution for data extents
>>    This is mostly the same as scrub.
>>    But unfortunately we can not reuse the same function as the output
>>    format is different.
> 
> We should try to unify the messages eventually.

I'm afraid you would be disappointed on unified messages, because scrub 
and balance still have some difference.

Current scrub code is still more aware about the device it's working on, 
unlike pure mirror number based balance, but it's working towards to the 
pure mirror number based one.

Maybe we can make the dev/physical output optional just for scrub?

>>
>> Now the new output would be more user friendly:
>>
>>   BTRFS info (device dm-4): relocating block group 13631488 flags data
>>   BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 logical 13631488 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>>   BTRFS warning (device dm-4): checksum error at logical 13631488 mirror 1, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>   BTRFS info (device dm-4): balance: ended with status: -5
> 
> This seems ok, scrub already does that so it's adding the missing
> information, though the filenames in syslog may not be wanted due to
> security/privacy reasons.

Maybe it's the time for us to consider some alternative filesystem error 
reporting infrastructure?
Like the one EXT4 is using?

All the remaining comments would be addressed.

Thanks,
Qu
