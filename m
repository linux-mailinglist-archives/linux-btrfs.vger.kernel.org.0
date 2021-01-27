Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385E9305F83
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhA0PZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbhA0PX5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:23:57 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6670C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:23:16 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id a12so2000401qkh.10
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oX1C851tWH+F9xwDpGL+REU560z176QA6OOWlJCzI+w=;
        b=xUOiwoCzGzlSCn4uESL5Qo7clcYuUOhxJONomSl3gkdJ7/PUMy1pTeAhwgcW5sPC1Z
         sKM2WlXLMNFq9rcGwCf7j2D0FcAu1lyD65HYOkVia/Cd7JMb1ghiCTX2W/xo3PIs6EST
         HUidL0j4M5MSWXHnzwuDqYvGuo3JYTqvC5RyhM9lYMM1hn0Q5l3lIq/x/hPBv8pNV53J
         dL/mBQFl4g3A0NCVkeYvftIhtgcLyp8GQJK5eZ99UvrT4fSKduW8QbAEmJlPXkpWcufZ
         KHELPyieI7/MLiY1RUhgfYo/nofkc0kF1aqnaq/Q9cBwp/H5+pmnErmayKmvH0spjoF6
         QUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oX1C851tWH+F9xwDpGL+REU560z176QA6OOWlJCzI+w=;
        b=OkUS3RRWfg3dv0le5zyZyc5UYeyAahqUUeVG7LSVQaPb80aEjZY2o/3IhWrEO5lv+P
         lfjbSxr0Rpo81u9Gh0heZFehr6Yg2khqOf7oghOa3C5QIRkDrwintnYYJx0OjbcLHNyR
         D0Bi9Lv2eulyJ4a0z8fhO8HN8cmNx8h2DJk93hRZOskkE+0Q9D8afZxqsQSiNvQDfqf3
         RlCr871U4iwc1noE0E8lACU06JJ8013GU6Ne19D9xH8pBUH1fi++nYtfwefmo5DN0LZg
         rn12ULXNBerRycJHmCQPTEAK0WngXyLOEtQ1G5ydAsMi+qo6kwIWlxWnVMTEZMTN9851
         Zd8g==
X-Gm-Message-State: AOAM5310XBXOQiVmG8CGtVrMXOBEla/G05uH5EwJAeYS6NsIxPbU+fke
        wtHoQSDJ0leWJozQ4mDo0QgrgJs6Dq6Rtaz2
X-Google-Smtp-Source: ABdhPJyKe2RgmRq9P+3DCxgI+QKI7ikAvPXuu/8RaM6w+ChG8mCNzfBmcFnZArZCf2WUFpU9pS2HsA==
X-Received: by 2002:a37:8703:: with SMTP id j3mr11036858qkd.455.1611760995573;
        Wed, 27 Jan 2021 07:23:15 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c12sm1424952qtq.76.2021.01.27.07.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:23:14 -0800 (PST)
Subject: Re: [PATCH 6/7] btrfs: remove unnecessary
 check_parent_dirs_for_sync()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1611742865.git.fdmanana@suse.com>
 <77b21c64a5aed56e5602c59558c1b09254f3b494.1611742865.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1a949e1e-4138-abef-bff7-0ce525be6ae3@toxicpanda.com>
Date:   Wed, 27 Jan 2021 10:23:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <77b21c64a5aed56e5602c59558c1b09254f3b494.1611742865.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/21 5:34 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Whenever we fsync an inode, if it is a directory, a regular file that was
> created in the current transaction or has last_unlink_trans set to the
> generation of the current transaction, we check if any of its ancestor
> inodes (and the inode itself if it is a directory) can not be logged and
> need a fallback to a full transaction commit - if so, we return with a
> value of 1 in order to fallback to a transaction commit.
> 
> However we often do not need to fallback to a transaction commit because:
> 
> 1) The ancestor inode is not an immediate parent, and therefore there is
>     not an explicit request to log it and it is not needed neither to
>     guarantee the consistency of the inode originally asked to be logged
>     (fsynced) nor its immediate parent;
> 
> 2) The ancestor inode was already logged before, in which case any link,
>     unlink or rename operation updates the log as needed.
> 
> So for these two cases we can avoid an unnecessary transaction commit.
> Therefore remove check_parent_dirs_for_sync() and add a check at the top
> of btrfs_log_inode() to make us fallback immediately to a transaction
> commit when we are logging a directory inode that can not be logged and
> needs a full transaction commit. All we need to protect is the case where
> after renaming a file someone fsyncs only the old directory, which would
> result is losing the renamed file after a log replay.
> 
> This patch is part of a patchset comprised of the following patches:
> 
>    btrfs: remove unnecessary directory inode item update when deleting dir entry
>    btrfs: stop setting nbytes when filling inode item for logging
>    btrfs: avoid logging new ancestor inodes when logging new inode
>    btrfs: skip logging directories already logged when logging all parents
>    btrfs: skip logging inodes already logged when logging new entries
>    btrfs: remove unnecessary check_parent_dirs_for_sync()
>    btrfs: make concurrent fsyncs wait less when waiting for a transaction commit
> 
> Performance results, after applying all patches, are mentioned in the
> change log of the last patch.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I'm having a hard time with this one.

Previously we would commit the transaction if the inode was a regular file, that 
was created in this current transaction, and had been renamed.  Now with this 
patch you're only committing the transaction if we are a directory and were 
renamed ourselves.  Before if you already had directories A and B and then did 
something like

echo "foo" > /mnt/test/A/blah
fsync(/mnt/test/A/blah);
fsync(/mnt/test/A);
mv /mnt/test/A/blah /mnt/test/B
fsync(/mnt/test/B/blah);

we would commit the transaction on this second fsync, but with your patch we are 
not.  I suppose that's keeping in line with how fsync is allowed to work, but 
it's definitely a change in behavior from what we used to do.  Not sure if 
that's good or not, I'll have to think about it.  Thanks,

Josef
