Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4B41587B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbhIWGxt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 02:53:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbhIWGxs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 02:53:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 122B8220FF;
        Thu, 23 Sep 2021 06:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632379937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e25/NDMdJkqctpfIRvdUgG6Jji3n9dFstOzlSakQ/CI=;
        b=hv9rO8HGX49ITXK3wBYbpfok8MxLJMjZAQ21xuQHtmzIjoA+r32oyEZko+MID8iIrYQbOh
        7XHnThq8aQ+cmAQ7VFQXjLLy/VHkLUXMNmxsL1e631JI6bEo57/QEYxP0NCWDM7qgqDJpW
        bYjjA2N9snzPNnHqOFhy9rUyy7xV6C0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D379F13DBB;
        Thu, 23 Sep 2021 06:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mGj1MCAkTGHeaQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Sep 2021 06:52:16 +0000
Subject: Re: [PATCH v6 3/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1632179897.git.anand.jain@oracle.com>
 <ec3ecca596bf5d9de5e152942a277ab48915f0cf.1632179897.git.anand.jain@oracle.com>
 <840713c4-48ef-b4e6-91e3-f92158448b7c@suse.com>
 <0ee297d9-84f7-7450-48c4-2703b14ef697@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <45f5dfee-3cb5-8645-a0b4-3f0dcb14dce5@suse.com>
Date:   Thu, 23 Sep 2021 09:52:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0ee297d9-84f7-7450-48c4-2703b14ef697@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.09.21 г. 14:41, Anand Jain wrote:

<snip>

>>> @@ -2419,7 +2414,23 @@ static int btrfs_prepare_sprout(struct
>>> btrfs_fs_info *fs_info)
>>>       INIT_LIST_HEAD(&seed_devices->devices);
>>>       INIT_LIST_HEAD(&seed_devices->alloc_list);
>>>   -    mutex_lock(&fs_devices->device_list_mutex);
>>> +    *seed_devices_ret = seed_devices;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * Splice seed devices into the sprout fs_devices.
>>> + * Generate a new fsid for the sprouted readwrite btrfs.
>>> + */
>>> +static void btrfs_splice_sprout(struct btrfs_fs_info *fs_info,
>>> +                struct btrfs_fs_devices *seed_devices)
>>> +{
>>
>> This function is missing a lockdep_assert_held annotation and it depends
>> on the device_list_mutex being held.
> 
>  You mean
>     lockdep_assert_held(&device_list_mutex);
>  and not
>     lockdep_assert_held(&uuid_mutex);
>  right?

I meant that the new function - btrfs_splice_sprout doesn't have any
lockdep annotation, and based on the old code it depends on
device_list_mutex being locked. This is based on the following hunk in
btrfs_init_new_device:

+	mutex_lock(&fs_devices->device_list_mutex);
+	if (seeding_dev) {
+		btrfs_splice_sprout(fs_info, seed_devices);

The way I understand this is btrfs_splice_sprout indeed requires
device_list_mutex being locked, no?

> 
>> However looking at the resulting code it doesn't look good, because
>> btrfs_splice_sporut suggests you simply add the seed device to a bunch
>> of places, yet looking at the function's body it's evident it actually
>> finishes some parts of the initialization, changes the uuid of the
>> fs_devices. I'm not convinced it really makes the code better or at the
>> very least the 'splice_sprout' needs to be changed, because splicing is
>> a minot part of what this function really does.
> 
> The purpose of the split of btrfs_prepare_sprout() was to use a common
> device_list_mutex. So I tend to avoid any other changes, but I think I
> will do it now based on the comments.
> 
> Thanks, Anand
>>
>>
>> <snip>
>>
> 
