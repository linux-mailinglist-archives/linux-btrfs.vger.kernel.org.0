Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2AB7B6963
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJCMsk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 3 Oct 2023 08:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJCMsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 08:48:39 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD2BB3;
        Tue,  3 Oct 2023 05:48:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id CBD1F186375F;
        Tue,  3 Oct 2023 15:48:34 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ocIQr9C3wiQj; Tue,  3 Oct 2023 15:48:34 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 7D3471867983;
        Tue,  3 Oct 2023 15:48:34 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4m9gmqCtRmgR; Tue,  3 Oct 2023 15:48:34 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.103])
        by mail.astralinux.ru (Postfix) with ESMTPS id 1D9B518669E3;
        Tue,  3 Oct 2023 15:48:33 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
        by new-mail.astralinux.ru (Postfix) with ESMTPA id 4S0HgP3HqqzhXXG;
        Tue,  3 Oct 2023 15:48:33 +0300 (MSK)
Message-ID: <422765f7-20a8-4fc0-8768-59c806332275@astralinux.ru>
Date:   Tue, 3 Oct 2023 15:48:11 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH 5.10] btrfs: fix region size in count_bitmap_extents
Content-Language: ru
From:   =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCb0Y7QsdC40LzQvtCy0LA=?= 
        <abelova@astralinux.ru>
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
References: <20230914094555.25657-1-abelova@astralinux.ru>
 <798207fe-35ea-46b4-9e52-73efcbb061de@astralinux.ru>
In-Reply-To: <798207fe-35ea-46b4-9e52-73efcbb061de@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


03/10/23 15:39, Anastasia Belova пишет:
>
> 14/09/23 12:45, Anastasia Belova пишет:
>> count_bitmap_extents was deleted in version 5.11, but
>> there is possible mistake in versions 5.6-5.10.
>>
>> Region size should be calculated by subtracting
>> the end from the beginning.
> Do I understand correctly that bytes should decrease and
> (rs - re) is always negative and should be replaced by (re - rs)?
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: dfb79ddb130e ("btrfs: track discardable extents for async discard")
>> Signed-off-by: Anastasia Belova<abelova@astralinux.ru>
>> ---
>>   fs/btrfs/free-space-cache.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>> index 4989c60b1df9..a34e266a0969 100644
>> --- a/fs/btrfs/free-space-cache.c
>> +++ b/fs/btrfs/free-space-cache.c
>> @@ -1930,7 +1930,7 @@ static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
>>   
>>   	bitmap_for_each_set_region(bitmap_info->bitmap, rs, re, 0,
>>   				   BITS_PER_BITMAP) {
>> -		bytes -= (rs - re) * ctl->unit;
>> +		bytes -= (re - rs) * ctl->unit;
>>   		count++;
>>   
>>   		if (!bytes)
> Anastasia
Sorry for sending html accidentally
