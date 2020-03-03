Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD61769E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 02:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCCBOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 20:14:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43662 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCBOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 20:14:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id v22so1597226qtp.10
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 17:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IIynpudYJdTKGdqOJvco5BSo7Vykxbg8Dda96PAH2AM=;
        b=NHCUPhe0wegNtc03wLD+HebazFi0T+1hwG+s0oGw6f06wvLP+2zQwnT/ziUGmm0mkX
         sxdhIxi7CT1vw6PPb+/2EhSbE11A2/tuEXilx68tpurwShN6YnhGn1pRy3UXxUxueIJ7
         PjHlBk0tl77T33T0tToQXvQhnuUIu0GQ4S11A9V77GfiGmewUBLtMnTOrWiCIP0nXwP/
         s6PcO7Z+ECrYvRNu/kl7W2Xdi2muRegKSU+jUDsX8UHZ2TR2/NR/osTY0MDUriHQA4A+
         lDA4exkQh8fhxVs/iG2eOSh0f6jg3UzD9tzEzG6Oxqrydc9aYmVu+c94Cm2ODSzdfPbT
         mSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIynpudYJdTKGdqOJvco5BSo7Vykxbg8Dda96PAH2AM=;
        b=secH6LdT9hwqG68tHnyHpQSWBob2tPKh2z/Xn4TpMUoM7pr9B9lO1OOuBpfWoXW6cG
         6JCrzvvTVzHGUwYHEmHtMi4OMx8tMnpeCzzgWd9vzgXHRdaglUqUr4vGopafjk/4Tv+x
         Up3qNRiiOnKJNwogaUrtRq3pMvG6cAWTzqSmiCd8YhVdcChuIOL4uiPJtCp1wHURDfKn
         F4RxtrOqeAaHN0JBLx4b4xrcwql9BV2Jk5QvbDnS47yMSVr0m9GDuYuJcuL11udtr7Ii
         Ip0AHczhbJ67Ub90K5Jty4f/bCHeJXFxT4+dQXK+DV6EiwJKk1pln56AUZ6Y35O+8T7s
         5lUw==
X-Gm-Message-State: ANhLgQ0T/0gUPlfWk7P5yJb/axeU7NiEWOEJJzW5N33PBB2NXXAl/ob7
        7uMNI2JZK65ecIAL3gvbZnzR+0TPP08=
X-Google-Smtp-Source: ADFU+vuZq1meqvoBllrAvGw1UHr4lZ80J1WI3+dEI/oW70jUYw+jZegi6obzZkAAheGQgBuwbZqvOw==
X-Received: by 2002:ac8:6048:: with SMTP id k8mr1151620qtm.53.1583198084471;
        Mon, 02 Mar 2020 17:14:44 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q3sm31450qtf.67.2020.03.02.17.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 17:14:43 -0800 (PST)
Subject: Re: [PATCH 6/7] btrfs: hold a ref on the root->reloc_root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-7-josef@toxicpanda.com>
 <1b3545b5-ab19-6f0d-7dd3-d80fe20a865e@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b43791ba-b4de-8cb1-d68f-28858eeee1e3@toxicpanda.com>
Date:   Mon, 2 Mar 2020 20:14:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1b3545b5-ab19-6f0d-7dd3-d80fe20a865e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/20 8:12 PM, Qu Wenruo wrote:
> 
> 
> On 2020/3/3 上午2:47, Josef Bacik wrote:
>> We previously were relying on root->reloc_root to be cleaned up by the
>> drop snapshot, or the error handling.  However if btrfs_drop_snapshot()
>> failed it wouldn't drop the ref for the root.  Also we sort of depend on
>> the right thing to happen with moving reloc roots between lists and the
>> fs root they belong to, which makes it hard to figure out who owns the
>> reference.
>>
>> Fix this by explicitly holding a reference on the reloc root for
>> roo->reloc_root.  This means that we hold two references on reloc roots,
>> one for whichever reloc_roots list it's attached to, and the
>> root->reloc_root we're on.
>>
>> This makes it easier to reason out who owns a reference on the root, and
>> when it needs to be dropped.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> A small question inlined below, despite that,
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
>> ---
>>   fs/btrfs/relocation.c | 44 ++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index acd21c156378..c8ff28930677 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1384,6 +1384,7 @@ static void __del_reloc_root(struct btrfs_root *root)
>>   	struct rb_node *rb_node;
>>   	struct mapping_node *node = NULL;
>>   	struct reloc_control *rc = fs_info->reloc_ctl;
>> +	bool put_ref = false;
>>   
>>   	if (rc && root->node) {
>>   		spin_lock(&rc->reloc_root_tree.lock);
>> @@ -1400,8 +1401,13 @@ static void __del_reloc_root(struct btrfs_root *root)
>>   	}
>>   
>>   	spin_lock(&fs_info->trans_lock);
>> -	list_del_init(&root->root_list);
>> +	if (!list_empty(&root->root_list)) {
> 
> Can we make the ref of reloc root completely free from the list operation?
> It still looks like a compromise between fully ref counted reloc root
> and original non-ref counted one.
> 

No because we have things like prepare_to_merge() which does

list_del_init(&reloc_root->list);
btrfs_update_reloc_root() <- which can call __del_reloc_root
list_add_tail(&reloc_root->list, &rc->reloc_roots);

so we don't want to drop the ref in __del_reloc_root there, as we're still 
technically going to be holding the ref for the list to be cleared later.  Thanks,

Josef
