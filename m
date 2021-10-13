Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D116342C28D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhJMOQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 10:16:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40722 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbhJMOQl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:16:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ADAE0223D2;
        Wed, 13 Oct 2021 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634134477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cn9YCBLn3Fjk7Mb74eQE1lIPvYvQcIBNe7N2/bWW/qc=;
        b=p5zDggBggTHG/rhjVoJU6zdxN255pt96OHjuX//GiU0xN/1zPvsvEu28z0awVO1HaPfJIO
        P7wWIrS1heARyjm1ykq+LG4GCFMmTKB0q2IxWSrz5V+wWjPOHhusJ23wPoZ4ulqsaolrID
        tLRxUeXH/z1oQ4qMPp49Vu/wd/cB2x0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A5EC13CEC;
        Wed, 13 Oct 2021 14:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K7WVCc3pZmGsSQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Oct 2021 14:14:37 +0000
Subject: Re: [PATCH v2] btrfs: zoned: use greedy gc for auto reclaim
To:     dsterba@suse.cz, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <75b42490e41e7c7bf49c07c76fb93764a726c621.1634035992.git.johannes.thumshirn@wdc.com>
 <3d5b7f4e-646b-8430-6970-e287ebbb7719@suse.com>
 <20211013135226.GG9286@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f0a7ea80-0cd6-1eed-fea2-3c7b95de38cb@suse.com>
Date:   Wed, 13 Oct 2021 17:14:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013135226.GG9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.10.21 г. 16:52, David Sterba wrote:
> On Tue, Oct 12, 2021 at 04:56:01PM +0300, Nikolay Borisov wrote:
>> On 12.10.21 г. 15:37, Johannes Thumshirn wrote:
>>> Currently auto reclaim of unusable zones reclaims the block-groups in the
>>> order they have been added to the reclaim list.
>>>
>>> Change this to a greedy algorithm by sorting the list so we have the
>>> block-groups with the least amount of valid bytes reclaimed first.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> ---
>>> Changes since v1:
>>> -  Changed list_sort() comparator to 'boolean' style
>>>
>>> Changes since RFC:
>>> - Updated the patch description
>>> - Don't sort the list under the spin_lock (David)
>>
>> <snip>
>>
>>
>>> @@ -1510,17 +1528,20 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>>  	}
>>>  
>>>  	spin_lock(&fs_info->unused_bgs_lock);
>>> -	while (!list_empty(&fs_info->reclaim_bgs)) {
>>> +	list_splice_init(&fs_info->reclaim_bgs, &reclaim_list);
>>> +	spin_unlock(&fs_info->unused_bgs_lock);
>>> +
>>> +	list_sort(NULL, &reclaim_list, reclaim_bgs_cmp);
>>> +	while (!list_empty(&reclaim_list)) {
>>
>> Nit: Now that you've switched to a local reclaim_list you can convert
>> the while to a list_for_each_entry_safe, since it's guaranteed that new
>> entries can't be added while you are iterating the list, which is
>> generally the reason why a while() is preferred to one of the iteration
>> helpers.
> 
> Like the following? I'll fold it in if yes:

Yes

