Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018EC24D6CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHUOAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 10:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgHUOAj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 10:00:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78FEC061573
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:00:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so1232198qts.6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ejhdOBMmRUrRTtLgfj5oVb+qzqoxoWLgeROFPNWXVfQ=;
        b=a0/e9edOunjBQuxJ01eRMHdqJE0tMBtWkrs7lyaEu12ekoEAJIqIelPUPZ554eDUn4
         APPnPWf8xAAHq2nhYChwPTUsZROdUvce/bl17IKNt5KmpNmDYuIr3QFu55P3LKzhqtsj
         RJwT+4F776Zcihs2wC1rUhUCyYmAUK8FuF4St3lyLaQQc6fVGtAJnEfSPcWhvLM0oxDc
         b51f+L2Ul4kRCBGZoxRZh4b2TxewmXLdb7NbG7r6vnovwQt9tNMqdIoZrsAz8N39tSV6
         flur2JB1pVT3UKHWu/KpvU+Wuzej4jsBD/xLZIya6z8GMNQVE8aPJ2MSssMOy3FDEVnF
         9q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejhdOBMmRUrRTtLgfj5oVb+qzqoxoWLgeROFPNWXVfQ=;
        b=SzNDlsq3Mz8YsTSebJ5eoDxrWK4JqcdfT9UVtWJ9cY1o3j5lD9GyPMuE8J/E53F86H
         88qPJ3oLL6xgxsGm2NSVG/D+hTmzsQLX5/eGjcehhw7E0DOYHcaq+BxPCycLqIdH3r2c
         WcGNPcRRB41ym5zQupEPhJHtx/aEb/vONKVifI3YR1cl9R4NeJrPQWfnUCB0LsW3z5D6
         p+BGOjZZvv41mDorn9xr4jvAPnhb6uMR49S4G2zloWQGzHt+EpY7Gzjia1uuywKQG5Tg
         S2jSn8uVqZQkaSc15FjrivXVXSQ5vVSj9sKMUsGwMosIla9nkf2vAlTkiOgGzogJHvMj
         y3lw==
X-Gm-Message-State: AOAM532uXPVc8ez8CmNOTpr8gOjUlVfB+GBD+Z437epkD50M67xos4WN
        I1MOQdCKj3wejzjTWesLedNQf4p52xX29PE5
X-Google-Smtp-Source: ABdhPJy5zpAT9ND9pVSGL7SQQdfzIOVkDTOmflCoMCxN/9dMbI5yRIcGbUqiFDUm/Ox1gbrbGyW2qw==
X-Received: by 2002:ac8:7b94:: with SMTP id p20mr2572503qtu.312.1598018437687;
        Fri, 21 Aug 2020 07:00:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p4sm1673932qkj.135.2020.08.21.07.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:00:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] btrfs: pretty print leaked root name
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1597953516.git.josef@toxicpanda.com>
 <461693e5c015857e684878e99e5e65075bb97c13.1597953516.git.josef@toxicpanda.com>
 <d98bb04e-1bcf-80c7-26ae-e91f3ecfd818@suse.com>
 <20200821101301.GC2026@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cff7de4d-e4de-01cf-62b2-3de0b9e51eb2@toxicpanda.com>
Date:   Fri, 21 Aug 2020 10:00:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821101301.GC2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 6:13 AM, David Sterba wrote:
> On Fri, Aug 21, 2020 at 10:35:38AM +0300, Nikolay Borisov wrote:
>>
>>
>> On 20.08.20 г. 23:00 ч., Josef Bacik wrote:
>>> I'm a actual human being so am incapable of converting u64 to s64 in my
>>> head, so add a helper to get the pretty name of a root objectid and use
>>> that helper to spit out the name for any special roots for leaked roots,
>>> so I don't have to scratch my head and figure out which root I messed up
>>> the refs for.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>   fs/btrfs/disk-io.c    |  8 +++++---
>>>   fs/btrfs/print-tree.c | 37 +++++++++++++++++++++++++++++++++++++
>>>   fs/btrfs/print-tree.h |  1 +
>>>   3 files changed, 43 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index ac6d6fddd5f4..a7358e0f59de 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -1506,11 +1506,13 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
>>>   	struct btrfs_root *root;
>>>   
>>>   	while (!list_empty(&fs_info->allocated_roots)) {
>>> +		const char *name = btrfs_root_name(root->root_key.objectid);
>>> +
>>>   		root = list_first_entry(&fs_info->allocated_roots,
>>>   					struct btrfs_root, leak_list);
>>> -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
>>> -			  root->root_key.objectid, root->root_key.offset,
>>> -			  refcount_read(&root->refs));
>>> +		btrfs_err(fs_info, "leaked root %s%lld-%llu refcount %d",
>>
>> nit: Won't this string result in some rather awkward looking strings,
>> such as:
>>
>> "leaked root ROOT_TREE<objectid>-<offset>..." i.e shouldn't the
>> (objectid,offset) pair be marked with parentheses?
> 
> I don't understand why need/want to print the offset here. It is from
> the key.offset but for a message we should print it in an understandable
> way.
> 

The offset matters for the TREE_RELOC roots, because it's the object id 
of the fs root that the reloc root refers to.  Thanks,

Josef
