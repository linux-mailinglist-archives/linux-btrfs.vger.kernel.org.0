Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D2A3DD244
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhHBItw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 04:49:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53328 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhHBItt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 04:49:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56E101FF4D;
        Mon,  2 Aug 2021 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627894179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/5+n1VtzoMcNwtSw+iH4koAjaiFnW1neYBMyX7GpFQ=;
        b=YibU0aDe5YudVJ+Yx4SL1/KJzAsxAgIEAM8gNHBHkaxTs16j6H2T6TdT4X54KAH/t51ygO
        PWAerjc1khu+1whfT6Rz6FrWAluXBF1OXHefIf0qkY9WizAJWs0kb4NE/c/5YbUf3IUpTi
        SkTZIIJl1bflw+qCr+k/2ncKDAFrcF8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 25C2413882;
        Mon,  2 Aug 2021 08:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id frDaBqOxB2HoEAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 02 Aug 2021 08:49:39 +0000
Subject: Re: [PATCH 2/2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210802065447.178726-1-wqu@suse.com>
 <20210802065447.178726-3-wqu@suse.com>
 <594df624-3895-8787-9058-a00dba01c0cc@suse.com>
 <5e516629-05f1-7750-1f0d-34cd73e8b52f@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7953dbaf-7b7a-2279-0ac0-63bb51a51f1d@suse.com>
Date:   Mon, 2 Aug 2021 11:49:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5e516629-05f1-7750-1f0d-34cd73e8b52f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.08.21 г. 11:03, Qu Wenruo wrote:
> 
> 
> On 2021/8/2 下午3:53, Nikolay Borisov wrote:
>>
>>
>> On 2.08.21 г. 9:54, Qu Wenruo wrote:
>>> The BUG_ON() in btrfs_csum_one_bio() means we're trying to submit a bio
>>> while we don't have ordered extent for it at all.
>>>
>>> Normally this won't happen and is indeed a code logical error.
>>>
>>> But previous fix has already shown another possibility that, some call
>>> sites don't handle error properly and submit the write bio after its
>>> ordered extent has already been cleaned up.
>>>
>>> This patch will add an extra safe net by replacing the BUG_ON() to
>>> proper error handling.
>>>
>>> And even if some day we hit a regression that we're submitting bio
>>> without an ordered extent, we will return error and the pages will be
>>> marked Error, and being caught properly.
>>
>> Would this hamper debugability? I.e it will result in some writes
>> failing with an error, right?
> 
> Yes, it will make such corner case way more silent than before.
> 
> But IMHO the existing BUG_ON() is also overkilled.
> 
> Maybe converting it to WARN_ON() would be a good middle land?

If this can occur only due to code bugs I'd prefer to leave it as a
BUG_ON. Ideally this should only trigger on developer machines when
testing code changes.

> 
> Thanks,
> Qu
> 
>>
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/file-item.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>>> index 2673c6ba7a4e..25205b9dad69 100644
>>> --- a/fs/btrfs/file-item.c
>>> +++ b/fs/btrfs/file-item.c
>>> @@ -665,7 +665,19 @@ blk_status_t btrfs_csum_one_bio(struct
>>> btrfs_inode *inode, struct bio *bio,
>>>
>>>           if (!ordered) {
>>>               ordered = btrfs_lookup_ordered_extent(inode, offset);
>>> -            BUG_ON(!ordered); /* Logic error */
>>> +            /*
>>> +             * No ordered extent mostly means the OE has been
>>> +             * removed (mostly for error handling). Normally for
>>> +             * such case we should not flush_write_bio(), but
>>> +             * end_write_bio().
>>> +             *
>>> +             * But an extra safe net will never hurt. Just error
>>> +             * out.
>>> +             */
>>> +            if (unlikely(!ordered)) {
>>> +                kvfree(sums);
>>> +                return BLK_STS_IOERR;
>>> +            }
>>>           }
>>>
>>>           nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
>>>
> 
