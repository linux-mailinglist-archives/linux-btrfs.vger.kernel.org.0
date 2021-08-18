Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E73EFC37
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhHRGVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:21:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55036 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbhHRGVf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:21:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 102FA20058;
        Wed, 18 Aug 2021 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629267658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5pjesruMvWfXe/1yxKixUPBHRrGJ/LroB4HENNmUM+g=;
        b=D6WZRCHXvfwBA9wbC/4rbZZ5ZtDMkPS1SYgEJEHUpfWNr5MqGlI40s//iaXwBtkASsktd7
        yolO7pJKMmY0AqkAj+5jGvNiLZFvjYNE1R0O/cMdz2ZceJrK7nP03tjUxl8nImw8Msp+mL
        E4LJ2SGREKweONBdhssGJg1DpvBFaWQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C83CE13357;
        Wed, 18 Aug 2021 06:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZnlWLcmmHGG0cAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 18 Aug 2021 06:20:57 +0000
Subject: Re: [PATCH] btrfs: update comment for fs_devices::seed_list in
 btrfs_rm_device
To:     Anand Jain <anand.jain@oracle.com>, Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <20210818041548.5692-1-l@damenly.su>
 <ce1a0cc1-b616-36e3-8c58-4edde5f924cf@oracle.com>
 <a8f575fc-2741-6379-5b89-62353a54cc8f@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <548ca0ec-4a57-3d20-cfa9-39521560feb7@suse.com>
Date:   Wed, 18 Aug 2021 09:20:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a8f575fc-2741-6379-5b89-62353a54cc8f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.08.21 г. 9:13, Anand Jain wrote:
> 
> 
> On 18/08/2021 12:25, Anand Jain wrote:
>> On 18/08/2021 12:15, Su Yue wrote:
>>> Update it since commit 944d3f9fac61 ("btrfs: switch seed device to
>>> list api") did conversion from fs_devices::seed to
>>> fs_devices::seed_list.
>>>
>>> Signed-off-by: Su Yue <l@damenly.su>
>>
> 
> 
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
>  Ah. No. I have remove my RB...
>>
>>> ---
>>>   fs/btrfs/volumes.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 70f94b75f25a..fcc2fede9ffc 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -2203,7 +2203,7 @@ int btrfs_rm_device(struct btrfs_fs_info
>>> *fs_info, const char *device_path,
>>>       /*
>>>        * In normal cases the cur_devices == fs_devices. But in case
>>>        * of deleting a seed device, the cur_devices should point to
>>> -     * its own fs_devices listed under the fs_devices->seed.
>>> +     * its own fs_devices listed under the fs_devices->seed_list.
> 
> 
> fs_devices->seed is correct.
> 
> 222 struct btrfs_fs_devices {
> ::
> 257         struct btrfs_fs_devices *seed;

You are clearly looking at the wrong tree since seed got removed exactly
in the cited patch above.
> 
> Thanks, Anand
> 
> 
>>>        */
>>>       cur_devices = device->fs_devices;
>>>       mutex_lock(&fs_devices->device_list_mutex);
>>>
>>
> 
