Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC547588BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 00:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGRWwN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jul 2023 18:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjGRWwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jul 2023 18:52:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D99413E
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689720682; x=1690325482; i=quwenruo.btrfs@gmx.com;
 bh=ibXMICGoVLw4mAweHMF9N9vUtOl7RkJBPbnwvbhna0U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YykwN1vRwsYXGyfDcUhLdBWdFiHLMNoJjyDoQGzguVHQm4GepwzRm+ytwCeNMj9oVbCni7i
 T6T1kZio9R5Yev1SKLm9c3N/R7dmYUuG1VJHF+DH05qAZ+ylPX3uEsTsx/3fpmgdmI20yh1Ly
 KhrYF2CnEo06z049r+/8K8FoyOEtYbRHCkJ9BXKikxk72iGgeY8BxqBxkbQWw8Cyp6MlhW2U2
 pAJthNH4iJ127N9MDo8+bl31SJuKpMJGrk0qMtCWvJmg1gtesrdhGaJFYhyvmMeqzdW5pVrhZ
 rzmQu0zk67yJEmJjvtOHzJy+kR7J5d4KzYyT/eTx795dfXEuJhpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1qIJ2S3ixx-007yh6; Wed, 19
 Jul 2023 00:51:22 +0200
Message-ID: <cd0ab358-9b77-24c1-264b-76ac2351a205@gmx.com>
Date:   Wed, 19 Jul 2023 06:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/8] btrfs: preparation patches for the incoming
 metadata folio conversion
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1689418958.git.wqu@suse.com>
 <20230718160108.GQ20457@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230718160108.GQ20457@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NaTwbjiw8Wz48VTn9oNrHG1CK/4D4ef80AHOtnGHAtzGv7cuX2h
 IQTKFFM1kECBqn3gWbTOBd32v5RWfI1Xce8eSltGF4sc/Nk1TAFD+ejNX2Dyocwy10wvOsL
 V/2e9Aw7d84+KLBkENDY+dzp9y433jsXrmUDdnsfP0wPUHrYkElWrKKj6qDU7JodStAw6Xp
 fIqwDWXoy3vkI+emZUoFg==
UI-OutboundReport: notjunk:1;M01:P0:yfJfGfn3YQw=;Oj6gP39d2NzP8cZjfIr8d7Be9BX
 n02fVp/cTzHUZnmROmgqhHwHnrt/qauJVrySuesSzTpiatjyh7xJjriL7uy/Xl+JgGCGgFLJ9
 Ue5VwHvHf5n+kfKw59wUNUnbrt4TpwtN14lesNHe+fVUw+CIrf704JREcE/KkbJrgiPdHBzAi
 Ztk90E07adgQ1hrez2VeNXrIYcTJUW5eZA+z/wfVg9KEHeXDC9HlWDJ5xBc8ryv2x7PGOwXPn
 meYOc9SIiaedzwjm8oBOsyRtIY8QXylLy6b6YQH/op/5ha1XgtxlFRvXF0dQLHtCB+TzU38u0
 liWT/RM3X7FxjXJd18Rmo0blbW64/KdBxJjJlmgow0fGCabq0YfUSD4mx9/M6B7TQFoMBqD4R
 14QVnBNYK5XKCV6IJ69Q2UO4bwXFSraAo+lHPr9lnwg1xwo41m5vXqMd5K/mLIrWxZX96H88F
 wH9vTZvkpgrbkc9vM/gsRbSV9m038aTrIKBjjx0qHVxcrJzFgTkUpFSRfTwewNUzmeyzSEpjK
 c+Nm9oqL2HRu/B9rUAgv7pMEhl9oRN2rdSWobZkYqMd80db8H47CEJThmIkuLCQU4FsU2IuaB
 clgS7VHtV+Rc0VOiUZrRo1UAhemEc9oVqBqo0lYsfyJVeiaODR1Qy91/HBxL0FWi7F2V3gyjH
 IFcNOEhQFmPi9IqV0WxnSm+Bedy+tOn0Xxcya9lu3wVf+EtBn200XERblv1qE/MkwvwpcphjD
 c3jGqq9UXxsQB4DRyZPvh1W5YmCstEt6yRozgLq8xUS7Tv+OFr1AOu3npjbxljz/0u5X299Ye
 2urCZBr/U5p9n5ACukzS6bkwKhc/Zf25FsS9qNwYkRAqhPYfGcUwvnsNhM6lbjyDOgkuZPb24
 SckOHPvXpSd+diDXSqnWlRHopBrDQotxoQYZiWZV18Il02U8Vj7+Id3DTfCasPNEUvWoCUBR4
 mmp6RDwvjCmYztInSwMHI2YaGzc=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/19 00:01, David Sterba wrote:
> On Sat, Jul 15, 2023 at 07:08:26PM +0800, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers
>>
>> v3:
>> - Fix an undefined behavior bug in memcpy_extent_buffer()
>>    Unlike the name, memcpy_extent_buffer() needs to handle overlapping
>>    ranges, thus it calls copy_pages() which do overlap checks and switc=
h
>>    to memmove() when needed.
>>
>>    Here we introduce __write_extent_buffer() which allows us to switch
>>    to go memmove() if needed.
>>
>> - Also refactor memmove_extent_buffer()
>>    Since we have __write_extent_buffer() which can go memmove(), it's
>>    not hard to refactor memmove_extent_buffer().
>>
>>    But there is still a pitfall that we have to handle double page
>>    boundaries as the old behavior, explained in the last patch.
>>
>> - Add selftests on extent buffer memory operations
>>    I have failed too many times refactoring memmove_extent_buffer(), th=
e
>>    wasted time should be a memorial for my stupidity.
>
> Seems that v3 has proceeded up to btrfs/143 that prints a lot test
> output errors and following tests fails too. It's on top of misc-next so
> it could be caused by some other recent patch. I'll do another round, if
> this patchset turns out to be ok I'll add it to misc-next.

btrfs/143 has a known (?) regression that dm devices are not properly
cleaned up, causing all later tests to fail (as scratch device is taken
by the dm device, all later mkfs would fail).

I notice that is fixed recently in upstream for-next branch, you may
want to update/rebase your fstests.

Thanks,
Qu
