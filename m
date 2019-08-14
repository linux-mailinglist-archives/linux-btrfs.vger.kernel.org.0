Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF898C84F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 04:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfHNCa1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 13 Aug 2019 22:30:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:55094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729571AbfHNCa0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 22:30:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C352AFB6;
        Wed, 14 Aug 2019 02:30:24 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5/5] btrfs-progs: mkfs: print error messages instead of just error number
From:   Jeff Mahoney <jeffm@suse.com>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <c8c2eaea-104c-40c5-a85c-59dd2f4a4687@gmx.com>
Date:   Tue, 13 Aug 2019 22:30:21 -0400
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AD3EE789-F682-4ADB-AA91-C81229287EFB@suse.com>
References: <20190814010402.22546-1-jeffm@suse.com> <20190814010402.22546-5-jeffm@suse.com> <c8c2eaea-104c-40c5-a85c-59dd2f4a4687@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> On Aug 13, 2019, at 9:54 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
> 
> 
>> On 2019/8/14 上午9:04, Jeff Mahoney wrote:
>> Printing the error number means having to go look up what that error
>> number means.  For a developer, it's easy.  For a user, it's unhelpful.
>> 
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>> mkfs/main.c | 47 ++++++++++++++++++++++++++++++-----------------
>> 1 file changed, 30 insertions(+), 17 deletions(-)
>> 
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index b752da13..7bfeb610 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -1197,37 +1197,43 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>> 
>>    ret = create_metadata_block_groups(root, mixed, &allocation);
>>    if (ret) {
>> -        error("failed to create default block groups: %d", ret);
>> +        error("failed to create default block groups: %d/%s",
>> +              ret, strerror(-ret));
> 
> The new trend is to use %m.
> 
> So we would do something like:
>    errno = -ret;
>    error("%m");
> 

Ok. It seems like that’s a job for a macro to set errno and autoappend the error message. I have a local branch that does that already.

-Jeff


> Thanks,
> Qu
> 
>>        goto error;
>>    }
>> 
>>    trans = btrfs_start_transaction(root, 1);
>>    if (IS_ERR(trans)) {
>> -        error("failed to start transaction");
>> +        error("failed to start transaction: %ld/%s",
>> +              PTR_ERR(trans), strerror(-PTR_ERR(trans)));
>>        goto error;
>>    }
>> 
>>    ret = create_data_block_groups(trans, root, mixed, &allocation);
>>    if (ret) {
>> -        error("failed to create default data block groups: %d", ret);
>> +        error("failed to create default data block groups: %d/%s",
>> +              ret, strerror(-ret));
>>        goto error;
>>    }
>> 
>>    ret = make_root_dir(trans, root);
>>    if (ret) {
>> -        error("failed to setup the root directory: %d", ret);
>> +        error("failed to setup the root directory: %d/%s",
>> +              ret, strerror(-ret));
>>        goto error;
>>    }
>> 
>>    ret = btrfs_commit_transaction(trans, root);
>>    if (ret) {
>> -        error("unable to commit transaction: %d", ret);
>> +        error("unable to commit transaction: %d/%s",
>> +              ret, strerror(-ret));
>>        goto out;
>>    }
>> 
>>    trans = btrfs_start_transaction(root, 1);
>>    if (IS_ERR(trans)) {
>> -        error("failed to start transaction");
>> +        error("failed to start transaction: %ld/%s",
>> +              PTR_ERR(trans), strerror(-PTR_ERR(trans)));
>>        goto error;
>>    }
>> 
>> @@ -1267,7 +1273,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>        ret = btrfs_add_to_fsid(trans, root, fd, file, dev_block_count,
>>                    sectorsize, sectorsize, sectorsize);
>>        if (ret) {
>> -            error("unable to add %s to filesystem: %d", file, ret);
>> +            error("unable to add %s to filesystem: %d/%s", file, ret, strerror(-ret));
>>            goto error;
>>        }
>>        if (verbose >= 2) {
>> @@ -1284,46 +1290,52 @@ raid_groups:
>>    ret = create_raid_groups(trans, root, data_profile,
>>             metadata_profile, mixed, &allocation);
>>    if (ret) {
>> -        error("unable to create raid groups: %d", ret);
>> +        error("unable to create raid groups: %d/%s",
>> +              ret, strerror(-ret));
>>        goto out;
>>    }
>> 
>>    ret = create_data_reloc_tree(trans);
>>    if (ret) {
>> -        error("unable to create data reloc tree: %d", ret);
>> +        error("unable to create data reloc tree: %d/%s",
>> +              ret, strerror(-ret));
>>        goto out;
>>    }
>> 
>>    ret = create_uuid_tree(trans);
>>    if (ret)
>>        warning(
>> -    "unable to create uuid tree, will be created after mount: %d", ret);
>> +    "unable to create uuid tree, will be created after mount: %d/%s",
>> +            ret, strerror(-ret));
>> 
>>    ret = btrfs_commit_transaction(trans, root);
>>    if (ret) {
>> -        error("unable to commit transaction: %d", ret);
>> +        error("unable to commit transaction: %d/%s",
>> +              ret, strerror(-ret));
>>        goto out;
>>    }
>> 
>>    ret = cleanup_temp_chunks(fs_info, &allocation, data_profile,
>>                  metadata_profile, metadata_profile);
>>    if (ret < 0) {
>> -        error("failed to cleanup temporary chunks: %d", ret);
>> +        error("failed to cleanup temporary chunks: %d/%s",
>> +              ret, strerror(-ret));
>>        goto out;
>>    }
>> 
>>    if (source_dir_set) {
>>        ret = btrfs_mkfs_fill_dir(source_dir, root, verbose);
>>        if (ret) {
>> -            error("error while filling filesystem: %d", ret);
>> +            error("error while filling filesystem: %d/%s",
>> +                  ret, strerror(-ret));
>>            goto out;
>>        }
>>        if (shrink_rootdir) {
>>            ret = btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
>>                           shrink_rootdir);
>>            if (ret < 0) {
>> -                error("error while shrinking filesystem: %d",
>> -                    ret);
>> +                error("error while shrinking filesystem: %d/%s",
>> +                    ret, strerror(-ret));
>>                goto out;
>>            }
>>        }
>> @@ -1383,8 +1395,9 @@ out:
>> 
>>    if (!ret && close_ret) {
>>        ret = close_ret;
>> -        error("failed to close ctree, the filesystem may be inconsistent: %d",
>> -              ret);
>> +        error(
>> +    "failed to close ctree, the filesystem may be inconsistent: %d/%s",
>> +              ret, strerror(-ret));
>>    }
>> 
>>    btrfs_close_all_devices();
>> 
> 

--
Jeff Mahoney
SUSE Labs
