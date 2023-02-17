Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9E69A4FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 06:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBQFDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 00:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBQFDh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 00:03:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0074E5FC
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 21:03:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6DWi-1pV5ps0xwW-006dF0; Fri, 17
 Feb 2023 06:03:33 +0100
Message-ID: <0a9aba30-0037-4947-c619-a877b473cd47@gmx.com>
Date:   Fri, 17 Feb 2023 13:03:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1675743217.git.wqu@suse.com>
 <63c3c509ec42d83e8038b33e2f21e036c591fe0b.1675743217.git.wqu@suse.com>
 <20230215200209.GV28288@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 2/4] btrfs: small improvement for btrfs_io_context
 structure
In-Reply-To: <20230215200209.GV28288@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sz0GQ4tCnrQ+b6Nes/EomZRnhocaB3jh66RPdiO8HPl/NuoOhwT
 FE89Z8OAqrLFeeeiAXACCLdwghbiF35+o7GGv6c2mcjS8saLJfSN8nHrBs6JlzZDQLwlGvj
 pM97PTsaq1dP9FF3rWgA00cMZGp72Uy3u7vLdQU7jJI4QtC+mkTwh/eAZzkk8c1qlL4e7AM
 14wywVhzLUhi42g/AlYcA==
UI-OutboundReport: notjunk:1;M01:P0:69l87UL/SY0=;OJnUDZ4OsyrUIZInHhUOiB4TXV6
 s5guKIjXMI3uEaQusAqv+p8AN0SptCNLtMKNTzHfO8dK/W9RLdh1Z6Lz8I6yOdCJOccmKnn/f
 NAJh3Cbg/G+hCmRwdpA/wWMfAhkSH+gnPqE79iKptONTJbwrGZAcSgH016T2Sge8b09/Xh4zu
 tWeMflRxftYurFPHLTSwOIQ3pfBsEmszSCy1X7aX7g9kff+idS+sySE6ATjr6OqX5iBamjpJ5
 TJvU0rXTJup8iRZhaYRcm8jJi4qcce++IUVT8x7WqNcRq1Pe/3nIccmfk5gM1/eZN20I5IFUp
 cfSKVJREV06+Pvi6f778dMH03gU1CilSQgQekngiRz1zFCeRroD3vO5pPboiHcCuCxG29gi08
 UhJjN5rRYgXsFGkEK6APWgcceWHoi2TqYXF/614X/hwP2sJNlhnvTEv+l734JfIfXTgfZ8V9k
 VFb/op0+tg98T44Y+0thQjvUrRKjDqo2ODPAhSga/a5VM1I8oMMKYmrKTbVFwtqhi6fY6dYqT
 nfkaAnp5jM4ecJxCEJJZ4kEDpK8Va4fpguFTPJZCrpAbZcKiFj7xh1EwDiPbPZHaWQoU8J3l8
 9Awm5aVD6reWRFUMEl/VmSyj5nH67s9cnm6kfJ88H7RIBHrZAE/syXbwoAX/4RZMEoN+BMph+
 QjAQQwwXp+jQaRVCTs9s2M2cs5Dq3ET9WU9haEQXN5aa86NmGz2tdu+OhZvoH0mTYHZXAl972
 pRF7FYaVo1uKErty+1wUBOT9L2RyCgtuZrJhnr0S8lLeCHq0QJF/qzBl6SQvnYMxTUGOFXhBT
 GQSzu/Ya3rOCGRbnpMQ8id9mchUNesR1epSGjovyCFwvNbG5SLjnJ+InVc2LhMxyWDkvlRyD+
 jOyFJMu6ZDlGvILONryotPUr/fCiOSvJv8Y/r+ox6DG96gb94rnhlJgFGds6R4wc2yx7Vu5O3
 Jq6qwlka8drvT7vqfU0eLxnsJ8Y=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/16 04:02, David Sterba wrote:
> On Tue, Feb 07, 2023 at 12:26:13PM +0800, Qu Wenruo wrote:
>> That structure is our ultimate objective for all __btrfs_map_block()
>> related functions.
>>
>> We have some hard to understand members, like tgtdev_map, but without
>> any comments.
>>
>> This patch will improve the situation by:
>>
>> - Add extra comments for num_stripes, mirror_num, num_tgtdevs and
>>    tgtdev_map[]
>>    Especially for the last two members, add a dedicated (thus very long)
>>    comments for them, with example to explain it.
>>
>> - Shrink those int members to u16.
>>    In fact our on-disk format is only using u16 for num_stripes, thus
>>    no need to go int at all.
> 
> Note that u16 is maybe good for space saving in structures but otherwise
> it's a type that's a bit clumsy for CPU to handle. Int for passing it
> around does not require masking or other sorts of conversions when
> there's arithmetic done. This can be cleaned up later with close
> inspection of the effects, so far we have u16 for fs_info::csum_type or
> some item lengths.

I'm not sure if the extra masking for CPU is a big deal.

If the compiler choose to do extra padding and not saving much space, 
I'll still stick to u16.

 From my recent learning on Rust, one of the best practice is the strong 
size limits on their variables.
For a lot of usages, we shouldn't really need to 32bit values, and in 
that case, I strongly prefer narrower variables.

If there is a better way to let compiler do 32bit operations while still 
do a u16 size limits, I'm pretty happy to follow.

Otherwise I think the extra CPU time (if any) is still worthy for a more 
explicit size limit.


BTW, I'll refresh this series along with its dependency patchset "btrfs: 
reduce div64 calls for __btrfs_map_block() and its variants".
As I guess you didn't apply the dependency first because quite some 
conflicts related to HCH's io_geometry cleanup series.

And I'll use patches from for-next branches to keep all your fixes.

Thanks,
Qu
