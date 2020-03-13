Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9AC184DC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCMRjp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 13:39:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46990 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMRjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 13:39:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id f28so13881773qkk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yvVfz+YxOB4NZAlBZojBk53n+Z35QTVJu5z8F1tnan4=;
        b=wx1nEWEE1b0NzAmw4xrun85PUlHMFnOqhwLqN2NAdK3ugpwOkrgVjiYb3MkUUWg2sp
         6IAU7om0vNWJL08syjApbO54S7wBabNB2r9ZztStEtYxamATx3yfN47qvfDxgvMQBjdN
         gGmDu4Jrf9Mbq/UWUtb/I2WvBInllhC1oYNqb+j75AMrmD7DTGtppouitM/HBqCyvgSC
         1cSLNFSn2G/v0OKdb/Kj8FR0WHnkxvrC5yGfVUaeP+axnsA0ytHEHP9PPrMQdkvjMuVE
         8kFVyFxZWvUwYg9pv7C0iLzAJb8xX7L0Krc+VRRqKoYdAYFO50AYKYIEfqGpsvUWAcOi
         wVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvVfz+YxOB4NZAlBZojBk53n+Z35QTVJu5z8F1tnan4=;
        b=QnG4Qek+CPE/LglWlN79QADczB9I3u7cAzNmKsaNuZPjQieNSN9LFl/WE6Vu76zeXs
         OeNqxEg2qX1dAoQKMEhi0HJsx734fvBGWc/bw/riHh/MrIfWTqniYk7VxSrLVbtCnLGI
         QLkNN4vcvTNhDa5he13WzPb6sKfVdmI3uDUSms2SH7V+rD67gVaeKSMb5kAoLuADbWC+
         LmodfgJ5C7dPNX8wl4hoeSr9JgwoefRhm40QGY8njXrfF6etn8i/G7wzzss5paDZbauh
         fYPp6bLByUYXX+Lv30ib4nP64cZ+mTouqkZhxqDgXs5vcpyhvIKJsH4EHEF+b1UIIAi/
         CM0w==
X-Gm-Message-State: ANhLgQ1spTHkVuukFRLCg5e1ounVMjXQKhXAYeXRLDX2jZgYh5wZ+5Ch
        F2KSQdbEJNd1CBIkgT/mZ+xqqw==
X-Google-Smtp-Source: ADFU+vtFeT1a1lZ5o7FrYUofcGw0fZ1A4uQEVifOGVNMxscq3RDj4ilNHg/Hh919EOoa0ERLsWDyTw==
X-Received: by 2002:a05:620a:1669:: with SMTP id d9mr2359795qko.250.1584121183633;
        Fri, 13 Mar 2020 10:39:43 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u13sm29325863qtg.64.2020.03.13.10.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:39:42 -0700 (PDT)
Subject: Re: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313154448.53461-1-josef@toxicpanda.com>
 <20200313154448.53461-5-josef@toxicpanda.com>
 <20200313171851.GO12659@twin.jikos.cz> <20200313173808.GP12659@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <75665769-55ce-9420-c760-286e0a826d1b@toxicpanda.com>
Date:   Fri, 13 Mar 2020 13:39:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313173808.GP12659@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/13/20 1:38 PM, David Sterba wrote:
> On Fri, Mar 13, 2020 at 06:18:51PM +0100, David Sterba wrote:
>> On Fri, Mar 13, 2020 at 11:44:44AM -0400, Josef Bacik wrote:
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
>>> index c496f8ed8c7e..721d049ff2b5 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -4387,6 +4387,20 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
>>>   	return rc;
>>>   }
>>>   
>>> +static void free_reloc_control(struct reloc_control *rc)
>>> +{
>>> +	struct mapping_node *node, *tmp;
>>> +
>>> +	free_reloc_roots(&rc->reloc_roots);
>>> +	rbtree_postorder_for_each_entry_safe(node, tmp,
>>> +					     &rc->reloc_root_tree.rb_root,
>>> +					     rb_node) {
>>> +		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
>>
>> The rb_erase is not needed here, the postorder traversal just goes over
>> all nodes and allows to free the containing structures together with the
>> rb_node. Dangling pointers are not an issue.
> 
> I had not seen your reply when I replied to the v2 patch but if you
> think the rb_erase is needed, I don't see why.
> 

Because I looked at it and thought it was needed and was confused and had to go 
look when you replied when you said it wasn't.  So it's needed for clarity sake ;).

Josef
