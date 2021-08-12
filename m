Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8A3EA10E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 10:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhHLIyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 04:54:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58692 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhHLIyY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 04:54:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 334EA1FF29;
        Thu, 12 Aug 2021 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628758439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBvewoExDNOAOdAvu6gO4F3LmkrxEM9cSzV91Rn08Gg=;
        b=G2oRgZHHl8r0uv07/VupB7MqcwoqOmNj8PSaq5h1ivIuo8OnANXJnbUvRmlVqaz4QvGPY7
        Zv48eOm1eSuZcLGXVTr8Yy5dXAcxYGzop37bC7kuHUiypcax99b/KEcw1jcUmR68U4lGNr
        hrgkiF2Ugyex3W9S9xJKaL5XPJfuy90=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 022FD13846;
        Thu, 12 Aug 2021 08:53:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id tPXLOabhFGFwEgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 12 Aug 2021 08:53:58 +0000
Subject: Re: [PATCH] btrfs-progs: Improve error handling while loading log
 root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210812081617.20811-1-nborisov@suse.com>
 <32ec4339-35cf-78cf-5f86-97a0f52c98c0@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <dd469e37-df9a-8730-b674-79dd50294f00@suse.com>
Date:   Thu, 12 Aug 2021 11:53:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <32ec4339-35cf-78cf-5f86-97a0f52c98c0@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.08.21 г. 11:51, Qu Wenruo wrote:
> 
> 
> On 2021/8/12 下午4:16, Nikolay Borisov wrote:
>> read_tree_block can return an error due to a variety of reason,
>> currently its return value is not being checked when loading the
>> log root's node but is directly used in a call to
>> extent_buffer_uptodate. This can lead to a crash if read_tree_block
>> errored out, since the node won't be a pointer but an error value cast
>> to a pointer.
>>
>> Fix this by properly checking the return value of read_tree_block before
>> utilising the value for anything else.
>> ---
>>   kernel-shared/disk-io.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
>> index cc635152c46d..4b5436254671 100644
>> --- a/kernel-shared/disk-io.c
>> +++ b/kernel-shared/disk-io.c
>> @@ -629,15 +629,14 @@ static int find_and_setup_log_root(struct
>> btrfs_root *tree_root,
>>
>>       log_root->node = read_tree_block(fs_info, blocknr,
>>                        btrfs_super_generation(disk_super) + 1);
>> -
>> -    fs_info->log_root_tree = log_root;
>> -
>> -    if (!extent_buffer_uptodate(log_root->node)) {
>> -        free_extent_buffer(log_root->node);
>> +    if (IS_ERR(log_root->node) ||
>> !extent_buffer_uptodate(log_root->node)) {
> 
> extent_buffer_uptodate() already has check for IS_ERROR().
> 
> Thus the existing check is already good.
> 
>> +        if (!IS_ERR(log_root->node))
>> +            free_extent_buffer(log_root->node);
> 
> The same for free_extent_buffer();

You are right, so indeed it's not an issue but this is somewhat hidden.
So this patch can be ignored.
> 
> Thanks,
> Qu
>>           free(log_root);
>>           fs_info->log_root_tree = NULL;
>>           return -EIO;
>>       }
>> +    fs_info->log_root_tree = log_root;
>>
>>       return 0;
>>   }
>>
> 
