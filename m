Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7967548ADCF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbiAKMtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 07:49:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39988 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbiAKMtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 07:49:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E573C21119;
        Tue, 11 Jan 2022 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641905349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZuhvXGurX8+Kvsi4ZjyPT+VkPQAd0MLfXjKvyEKEu0=;
        b=iFu6DSSJnA6vusTrYqA0qfT3yGQIYX5UPBvurlkjwEbefB+rDINxqjk6ORUbei1WqrjwzN
        dmHhJ8bWs8FAQ7HkK1weJMZIdK8oGiE3VSSEp7ZOU2dPEh5JK41t1xUEAZdaGk2EbbYDQS
        2s+68tFX0jXfAPcz5YbAC98BS+2/oo8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9257713DDA;
        Tue, 11 Jan 2022 12:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NPS5IMV83WF+MAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 11 Jan 2022 12:49:09 +0000
Subject: Re: [External] : Re: [PATCH v4 2/4] btrfs: redeclare
 btrfs_stale_devices arg1 to dev_t
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
 <df5e06aa-5ed4-0df2-9210-ea8d19069cba@suse.com>
 <5656e466-7950-2dd0-11f0-2dadcc191f7c@oracle.com>
 <8050ed8f-200c-5adb-34e6-012100b2e913@suse.com>
 <b7ea8da6-91e4-2af3-333c-dea16af756ec@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <935ddfdf-b79c-b424-6e7d-74286834cd29@suse.com>
Date:   Tue, 11 Jan 2022 14:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b7ea8da6-91e4-2af3-333c-dea16af756ec@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.01.22 г. 14:36, Anand Jain wrote:
> 
> 
> On 11/01/2022 16:30, Nikolay Borisov wrote:
>>
>>
>> On 11.01.22 г. 6:51, Anand Jain wrote:
>>>
>>>>> @@ -604,14 +599,14 @@ static int btrfs_free_stale_devices(const char
>>>>> *path,
>>>>>                         &fs_devices->devices, dev_list) {
>>>>>                if (skip_device && skip_device == device)
>>>>>                    continue;
>>>>> -            if (path && !device->name)
>>>>> +            if (devt && !device->name)
>>>>
>>>> This check is now rendered obsolete since ->name is used iff we have
>>>> passed a patch to match against it, but since your series removes the
>>>> path altogether having device->name becomes obsolete, hence it can be
>>>> removed.
>>>
>>> We have it to check for the missing device. Device->name == '\0' is one
>>> of the ways coded to identify a missing device. It helps to fail early
>>> instead of failing inside device_matched() at lookup_bdev().
>>
>> In this case shouldn't the check be just for if (!device->name) rather
>> than also checking for the presence of devt? Also a comment is warranted
>> that we are skipping missing devices.
> 
> I think you missed the point that %devt is an argument there? It implies
> and frees the device with that matching %devt.
> IMO it is straightforward that if %devt present then skips the devices
> without a name.
> I will add the comment.

Precisely, how is devt related to the name of the device? Before your
patch the path argument was directly related but now ?

> 
> Thanks, Anand
> 
