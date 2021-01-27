Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23778306002
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhA0PpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhA0Pmz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:42:55 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FAAC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:42:14 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id l27so2074915qki.9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ihrtKWzpdHFZt9pWsXJXNdeksPNF+yYepokyiwSc9Uo=;
        b=1gWaBHJ8p0dp2S2n5i7zNoULYJhfNtK+NiqQqewa868oA7nRjxQvQwjqYq87Dti5E6
         1cuspcidHdEkceunwSL/s/GZfTv1LdEioYl6AwruqRbkdISvTbGqwkh96dYCKGLYLzlm
         C8wepxas46t3qRtZUQFlEN5tVPcHmaW3mw3pJ/dW8IbJ66qykjYiQuPm7fzS9cwg1R8N
         TXrHQ8kLQNbh+PBpCU2XL1wJ3VCH6W077jz3wji3KP3lbVgLeqQ9t6COaG9cAAevHWZ3
         DksS33JXp/rvTNlbdSWYOe6fNrslCUYELEBprmtSiLgWqa6b12n+Fx3/RUDU85prqIK/
         oSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihrtKWzpdHFZt9pWsXJXNdeksPNF+yYepokyiwSc9Uo=;
        b=Zu+h4O61qY56Pnz04znEm59Wd0blZtxJNRnRjH7JaHEkLoxaibSML3Tn9+0wYZ9wWA
         Rx3vBEp+/p8WwYJ+Twuu4OikwmP1Y2GgrxwAyG9D8K/Z9ygOuMEbgohUD6BDmUbGeWSk
         P3HU5tADsVgFDsKMkKCuzcaE7lWAU+gjN1FlPAw/fGAooNjrhm/axcl28UzIRXAiGAIU
         Dlcd59/XGRVyoBRbnhQbBTd0++z6OLC8xACtDHeo+xk1xEHhousX/iMioAF8TG/8HeQj
         vFk5MhFyZE8C9TLyWulcHd2yXz3GlktSSN29fTkahbAw38YgfPKGvRQ7QPDUjWl/bq7R
         UlBw==
X-Gm-Message-State: AOAM531NkxRXXwQ+xaRe7s1FKtwg6Hwf8EL+w4zK8Dy1PQpamv/TnzCQ
        ayhtGJGFij3UZKoCibTUf5ttxbGtcONOjuUs
X-Google-Smtp-Source: ABdhPJyo5Ab7dmjlfIfeaUCrtnsFur4bO93hHD5v8xzrTyxRoYWxjf2JNo5iHH9PEP4CPA75XqEzug==
X-Received: by 2002:a37:4f4a:: with SMTP id d71mr11332859qkb.55.1611762133291;
        Wed, 27 Jan 2021 07:42:13 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h63sm431994qtd.14.2021.01.27.07.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:42:12 -0800 (PST)
Subject: Re: [PATCH 6/7] btrfs: remove unnecessary
 check_parent_dirs_for_sync()
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1611742865.git.fdmanana@suse.com>
 <77b21c64a5aed56e5602c59558c1b09254f3b494.1611742865.git.fdmanana@suse.com>
 <1a949e1e-4138-abef-bff7-0ce525be6ae3@toxicpanda.com>
 <CAL3q7H674gb03GJh3owLSVBndSO0JsT3STVHJDeOGU72_Ar4LQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3fec2b88-99e8-7aba-25bd-f746aed8ac7f@toxicpanda.com>
Date:   Wed, 27 Jan 2021 10:42:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H674gb03GJh3owLSVBndSO0JsT3STVHJDeOGU72_Ar4LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/21 10:36 AM, Filipe Manana wrote:
> On Wed, Jan 27, 2021 at 3:23 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 1/27/21 5:34 AM, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Whenever we fsync an inode, if it is a directory, a regular file that was
>>> created in the current transaction or has last_unlink_trans set to the
>>> generation of the current transaction, we check if any of its ancestor
>>> inodes (and the inode itself if it is a directory) can not be logged and
>>> need a fallback to a full transaction commit - if so, we return with a
>>> value of 1 in order to fallback to a transaction commit.
>>>
>>> However we often do not need to fallback to a transaction commit because:
>>>
>>> 1) The ancestor inode is not an immediate parent, and therefore there is
>>>      not an explicit request to log it and it is not needed neither to
>>>      guarantee the consistency of the inode originally asked to be logged
>>>      (fsynced) nor its immediate parent;
>>>
>>> 2) The ancestor inode was already logged before, in which case any link,
>>>      unlink or rename operation updates the log as needed.
>>>
>>> So for these two cases we can avoid an unnecessary transaction commit.
>>> Therefore remove check_parent_dirs_for_sync() and add a check at the top
>>> of btrfs_log_inode() to make us fallback immediately to a transaction
>>> commit when we are logging a directory inode that can not be logged and
>>> needs a full transaction commit. All we need to protect is the case where
>>> after renaming a file someone fsyncs only the old directory, which would
>>> result is losing the renamed file after a log replay.
>>>
>>> This patch is part of a patchset comprised of the following patches:
>>>
>>>     btrfs: remove unnecessary directory inode item update when deleting dir entry
>>>     btrfs: stop setting nbytes when filling inode item for logging
>>>     btrfs: avoid logging new ancestor inodes when logging new inode
>>>     btrfs: skip logging directories already logged when logging all parents
>>>     btrfs: skip logging inodes already logged when logging new entries
>>>     btrfs: remove unnecessary check_parent_dirs_for_sync()
>>>     btrfs: make concurrent fsyncs wait less when waiting for a transaction commit
>>>
>>> Performance results, after applying all patches, are mentioned in the
>>> change log of the last patch.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> I'm having a hard time with this one.
>>
>> Previously we would commit the transaction if the inode was a regular file, that
>> was created in this current transaction, and had been renamed.  Now with this
>> patch you're only committing the transaction if we are a directory and were
>> renamed ourselves.  Before if you already had directories A and B and then did
>> something like
>>
>> echo "foo" > /mnt/test/A/blah
>> fsync(/mnt/test/A/blah);
>> fsync(/mnt/test/A);
>> mv /mnt/test/A/blah /mnt/test/B
>> fsync(/mnt/test/B/blah);
>>
>> we would commit the transaction on this second fsync, but with your patch we are
>> not.  I suppose that's keeping in line with how fsync is allowed to work, but
>> it's definitely a change in behavior from what we used to do.  Not sure if
>> that's good or not, I'll have to think about it.  Thanks,
> 
> Yes. Because of the rename (or a link), we will set last_unlink_trans
> to the current transaction, and when logging the file that will cause
> logging of all its old parents (A). That was added several years ago
> to fix corruptions, and it turned out to be needed later as well to
> ensure we have
> a behaviour similar to xfs and ext4 (and others) regarding strictly
> ordered metadata updates (I added several tests to fstests over the
> years for all the cases).
> There's also the fact that on replay we will delete any inode refs
> that aren't in the log (that one was added in commit 1f250e929a9c
> ("Btrfs: fix log replay failure after unlink and link combination").
> 
> For that example we also have A updated in the log by the rename. So
> we know the log is consistent.
> 
> So that's why the whole check_parents_for_sync() is not needed.
> 

Ok that's reasonable, thanks,

Josef

