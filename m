Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D51913CAC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAORUV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:20:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33922 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgAORUU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:20:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so16406198qkk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hpEgd8J4/IGAAaI8eoIdac+A0jCjM9FowqZf7LHgze0=;
        b=EhbSSgmJ4xOdZCFa0ek/4j0vGbPM1hBI8p2KKRVgoCYwa59KuseayOmQlHHfYVEVAK
         7sdzAWk52owiawZ+x3viT5r2pZj7oEWeFsGZs995ql0lFRTIr76EpHHqSxfLb9vBAEDB
         i6kkgDSq6g2aDE9Ir8JXWAj+gBUXmkUHMtAdOQYudzRmMoEpt6Y0MSUw+N3N428Lm0PN
         W0DGuBuqY8LqTbUD26PNQSTqYbD391BQB9FGSaZK9AfCsHyvv5cXoUUGxYJc4b/aQwpI
         lBiYcpPcuvXCyVgwQjCoySzji7nQ0ZSUk4aBpoLM15tjbzKcPLbnWzSOa3wIfcYaOqbk
         3hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hpEgd8J4/IGAAaI8eoIdac+A0jCjM9FowqZf7LHgze0=;
        b=ZoIMiYTGuJuydCetGZhx6qsxVyCdVYSZuyKK7UgSGfRVY4cgFTVYltNOJi7l3welQ3
         kxIPOb5qAFPv1jhKNrWCsU45Nyhr+OeeSzb/l0MOqMtcE3h2eEIsGuytTHfCQVW8AuMn
         ojooivmn+uf7JM+p3o0wOQq5l9tWM4W+kESkDznb8SMIrIQS4fKj0Z3Yq7ozkcWNQBpL
         0H1IcFilaessD20fGMo0Hc7yoqn1rI2Oso5SxJqy4VbZhFnL+Az3Xl9nwC3mY2vonUad
         ++OFQCQ6VP/aVMb1mPh5wLBZXoiOXm/0G1IORYdwzXHoP69oWY+WmI7TNakCI/BFHyoI
         mzZA==
X-Gm-Message-State: APjAAAVG/6anZYjq0/i8PKiJeSfEdaVtv19rd1GhTBo14/3WfGYmy/y9
        LvL9k85Z5g7f2yP/I9EP/TvN1g==
X-Google-Smtp-Source: APXvYqzopQ4qJ3gguXOr8FbFnDu3L7523AEUDv5OyF8bs2GzdMMrtNirHUqIVcA3AZK4SwDSyLOGww==
X-Received: by 2002:a05:620a:228:: with SMTP id u8mr28585784qkm.88.1579108819657;
        Wed, 15 Jan 2020 09:20:19 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::56ca])
        by smtp.gmail.com with ESMTPSA id 2sm8748296qkv.98.2020.01.15.09.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:20:18 -0800 (PST)
Subject: Re: [PATCH 3/5] btrfs: use the file extent tree infrastructure
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <20200107194237.145694-1-josef@toxicpanda.com>
 <20200107194237.145694-4-josef@toxicpanda.com>
 <CAL3q7H6eDnVxVj7qE0Naw_VNzhQR=vvNGM+57kHrmx7vZSfsYQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <20374930-aa36-cd59-54e8-334b2ce8b58e@toxicpanda.com>
Date:   Wed, 15 Jan 2020 12:20:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6eDnVxVj7qE0Naw_VNzhQR=vvNGM+57kHrmx7vZSfsYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/20 12:12 PM, Filipe Manana wrote:
> On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> We want to use this everywhere we modify the file extent items
>> permanently.  These include
>>
>> 1) Inserting new file extents for writes and prealloc extents.
>> 2) Truncating inode items.
>> 3) btrfs_cont_expand().
>> 4) Insert inline extents.
>> 5) Insert new extents from log replay.
>> 6) Insert a new extent for clone, as it could be past isize.
>>
>> We do not however call the clear helper for hole punching because it
>> simply swaps out an existing file extent for a hole, so there's
>> effectively no change as far as the i_size is concerned.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/delayed-inode.c |  4 +++
>>   fs/btrfs/file.c          |  6 ++++
>>   fs/btrfs/inode.c         | 59 +++++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/tree-log.c      |  5 ++++
>>   4 files changed, 73 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>> index d3e15e1d4a91..8b4dcf4f6b3e 100644
>> --- a/fs/btrfs/delayed-inode.c
>> +++ b/fs/btrfs/delayed-inode.c
>> @@ -1762,6 +1762,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
>>   {
>>          struct btrfs_delayed_node *delayed_node;
>>          struct btrfs_inode_item *inode_item;
>> +       struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
>>
>>          delayed_node = btrfs_get_delayed_node(BTRFS_I(inode));
>>          if (!delayed_node)
>> @@ -1779,6 +1780,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
>>          i_uid_write(inode, btrfs_stack_inode_uid(inode_item));
>>          i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
>>          btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(inode_item));
>> +       btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
>> +                                         round_up(i_size_read(inode),
>> +                                                  fs_info->sectorsize));
> 
> Why set it here when we have already done it at btrfs_read_locked_inode()?
> This seems duplicated.
> 

Because if btrfs_fill_inode() returns true it means we had a delayed inode in 
memory still and we skip the reading of the inode off of disk, so it's an either 
or case, not a duplicate.  Thanks,

Josef
