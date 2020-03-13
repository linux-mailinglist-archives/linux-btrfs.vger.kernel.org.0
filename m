Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C901C184ACC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCMPck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:32:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35704 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMPck (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:32:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so13172726qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IAAwwG00xxFkc3zUOmc2RSniw+NJbPI3+TLCd/6XtTM=;
        b=bJFyN73EaYYd+CyCeI0IyodHaYsxzdyuVLQOCTmyXzWUnyQh8C85RK//Kv6v7bKDs7
         gX4k7pQI/SFJkMIjTJsDfbwr94sHNlKUODjK0S44Z7K9w0R1YewhqLe9EDTWMX9LCkcL
         jDg9xjEG9DziflMD5HCs/nfSL5fecEoZvprpNG0S3Q94A7yRpF5R/RFRAgxkYhOI2C1t
         qGOocOwRkh9SBFLf6n9xzz+ogHjj7ZwAZMzP0ONRUHnIlGJe7IZ4qN6TiRVU8u+jySPR
         IAmSLhU+B6QlGp6nBSX55K0tLiYMkpcd+Q2TKt/xRNisvC+IxPV02JVohVelzImOzwQs
         roaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IAAwwG00xxFkc3zUOmc2RSniw+NJbPI3+TLCd/6XtTM=;
        b=pmCxXsmzHI33AW6ZVIeKGuZ6xtQ3SVB1PISYTLZvIrAsh2Tcoe0bUoYZgD7gNF7K1S
         QuyQ8A/igU2sskawz1nUgAJbI09gajHBGTxv+5nqdIMwsScEMwt315ZRzrOz1G43/n+O
         M9Ql+SE10MXRBRShIngNAuwhISdOZdKpO+x341BGfVcgPvex35QpWm/xnhGso3FdlqY5
         f7uuIAl5dV2cOBD5vVyh+yf6BDY8xbrjHko/SczGlq/2hefmXr2GLUiwTGaYNMFU/3s3
         XBBLIO5s2JX6ODbwlk/JLzAlZjTpu8YzDdbisgrRPrTYRMI1z2HZcEJlZ/xrNtueMGwh
         UcOw==
X-Gm-Message-State: ANhLgQ0Cp+z2nresL8kj8rC9D9/Qw12xTLt8ra+6FJja0OHwlSJgVsJl
        ffbUuiuxnj5k/uapslKBiTy8WFxs44Y=
X-Google-Smtp-Source: ADFU+vteW790Q1L2SWRc6YCH+qylEK9zyC6hRd8dx3GNo1QQ9n9+8Xb/C8/ldpQ6GQJqNzTBnZ8ArQ==
X-Received: by 2002:ae9:e90e:: with SMTP id x14mr13770771qkf.222.1584113557911;
        Fri, 13 Mar 2020 08:32:37 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l60sm8644600qtd.35.2020.03.13.08.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 08:32:36 -0700 (PDT)
Subject: Re: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-5-josef@toxicpanda.com>
 <f77683bc-c644-25a8-6d97-fbe339bd5f98@gmx.com>
 <20200313151829.GN12659@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <940ee1b7-a854-275e-e01f-05770435ee15@toxicpanda.com>
Date:   Fri, 13 Mar 2020 11:32:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313151829.GN12659@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/13/20 11:18 AM, David Sterba wrote:
> On Thu, Mar 05, 2020 at 07:39:33PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/3/5 上午12:18, Josef Bacik wrote:
>>> If we have an error while processing the reloc roots we could leak roots
>>> that were added to rc->reloc_roots before we hit the error.  We could
>>> have also not removed the reloct tree mapping from our rb_tree, so clean
>>> up any remaining nodes in the reloc root rb_tree.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>   fs/btrfs/relocation.c | 18 ++++++++++++++++--
>>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>> index c496f8ed8c7e..f6237d885fe0 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -4387,6 +4387,20 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
>>>   	return rc;
>>>   }
>>>   
>>> +static void free_reloc_control(struct reloc_control *rc)
>>> +{
>>> +	struct rb_node *rb_node;
>>> +	struct mapping_node *node;
>>> +
>>> +	free_reloc_roots(&rc->reloc_roots);
>>> +	while ((rb_node = rb_first(&rc->reloc_root_tree.rb_root))) {
>>
>> rbtree_postorder_for_each_entry_safe().
>>
>> So that we don't need to bother the re-balance of rbtree.
> 
> I'll update the patch with this
> 
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4240,15 +4240,13 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
>   
>   static void free_reloc_control(struct reloc_control *rc)
>   {
> -       struct rb_node *rb_node;
> -       struct mapping_node *node;
> +       struct mapping_node *node, *tmp;
>   
>          free_reloc_roots(&rc->reloc_roots);
> -       while ((rb_node = rb_first(&rc->reloc_root_tree.rb_root))) {
> -               node = rb_entry(rb_node, struct mapping_node, rb_node);
> -               rb_erase(rb_node, &rc->reloc_root_tree.rb_root);
> +       rbtree_postorder_for_each_entry_safe(node, tmp,
> +                       &rc->reloc_root_tree.rb_root, rb_node)
>                  kfree(node);

You need an rb_erase() in here.  I'm updating the series so I'll fix it before I 
send the new set.  Thanks,

Josef
