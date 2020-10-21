Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30629525F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 20:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411310AbgJUSlJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 14:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411305AbgJUSlJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 14:41:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3FC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 11:41:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k9so3543202qki.6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1mBURGHGPVz7Y4aQBGjAz07r/tWWJJfBDfwgChjPdcM=;
        b=q1+6xs0ynvC+sjVXX1p9JIoetZpw2JW+IHnrcKdtkS358BwRkIXhL+F7qvAxWrlw8T
         IMvYja82mbgnNmvyCVnOv/qDCTJdgckxYbd0xbkdv3TkIOTkIdiiFCr2Y+G5xQk3hsCY
         eixlBni5keBYbmLU7uNNNCm0H9/c4kh2UVTzWJE54qQtXrt35OryDrTuVdb44+uXQvjN
         AUCLQwS/bjVvm9rvYINqcLAhUcV6gvddH2K6kQHHMAjmLayqrste5xMmI+yF1ygWlcqj
         R8QdybjnJXsOK6HIUWFrMJ8Y8ui4BbhOL8GHwnnKVACL65I1Vy/mr+l8zMGpMwKKp6P0
         E4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1mBURGHGPVz7Y4aQBGjAz07r/tWWJJfBDfwgChjPdcM=;
        b=iR8CM714W1zg2OLpiTL1Mvh52ScjvFRMeVIy13CaDXzyYRcCWsRUku4b2jYa55oWEG
         a5FgbCvlyCqd5k8IzQy2qjdhHKcHz6pZGir+lEeeyriV8b3jLj6fq1uHOtqX8HgYKWJJ
         ePatey5S0bpNnswC1K/39JAc8mrY8H+7hrDjDOjOADi6eIyxnGKRccFZx40T7gMjksBo
         gMam8wyxlZOwadeOiqLbQtqUAZqrZ3rtyHaeVdS5tBsQCD2jxUhzVGqXEykSI3L3+VVn
         PvwOSJchSJgoaupPhtkV+7szG/HX5M5qbS3NGOOoi6quD5f/k3+VIupXnvnwkxltEiVW
         Tjkg==
X-Gm-Message-State: AOAM531a6rblVh+AnyYzduHXkqoBCTkh9FgAFrYnt1br6roQUciMREUd
        TfnXjttZ774TvEEUyrSnjAMKdzaP7vymgg==
X-Google-Smtp-Source: ABdhPJzuWmU8dzvbsY3Mrl2G3A/4Lew45XWOkePTYt2+VB6Y6MEH0kWOj3f/sfqkIVycYf1+oAAKeA==
X-Received: by 2002:ac8:4e49:: with SMTP id e9mr4326447qtw.114.1603305664811;
        Wed, 21 Oct 2020 11:41:04 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1363? ([2620:10d:c091:480::1:39ba])
        by smtp.gmail.com with ESMTPSA id 61sm1764397qta.19.2020.10.21.11.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 11:41:03 -0700 (PDT)
Subject: Re: [PATCH] btrfs: add test case for rwf_nowait writes
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <5cfe8cb86da5593dda6c03b4ac404fa3b4c8b0d8.1603204654.git.fdmanana@suse.com>
 <1aa6d939-6818-f8f3-d857-642237e56cf8@toxicpanda.com>
 <CAL3q7H7RsANt+xYjuVrasz8xONm5qLyEHQbzDP_MONP_9_=wQA@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aebb596f-a3a5-a1a8-69d3-4554c4ea454d@toxicpanda.com>
Date:   Wed, 21 Oct 2020 14:41:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7RsANt+xYjuVrasz8xONm5qLyEHQbzDP_MONP_9_=wQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/21/20 12:39 PM, Filipe Manana wrote:
> On Wed, Oct 21, 2020 at 3:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 10/20/20 10:43 AM, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Test several scenarios for RWF_NOWAIT writes, to verify we don't regress
>>> on btrfs specific behaviour (snapshots, cow files, reflinks, holes,
>>> prealloc extent beyond eof).
>>>
>>> We had some bugs in the past related to RWF_NOWAIT writes not failing on
>>> btrfs when they should or failing when they shouldn't, these were fixed by
>>> the following kernel commits:
>>>
>>>     4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
>>>     260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    tests/btrfs/225     | 140 ++++++++++++++++++++++++++++++++++++++++++++
>>>    tests/btrfs/225.out |  70 ++++++++++++++++++++++
>>>    tests/btrfs/group   |   1 +
>>>    3 files changed, 211 insertions(+)
>>>    create mode 100755 tests/btrfs/225
>>>    create mode 100644 tests/btrfs/225.out
>>>
>>> diff --git a/tests/btrfs/225 b/tests/btrfs/225
>>> new file mode 100755
>>> index 00000000..f55e8c80
>>> --- /dev/null
>>> +++ b/tests/btrfs/225
>>> @@ -0,0 +1,140 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test No. btrfs/225
>>> +#
>>> +# Test several (btrfs specific) scenarios with RWF_NOWAIT writes, cases where
>>> +# they should fail and cases where they should succeed.
>>> +#
>>> +seq=`basename $0`
>>> +seqres=$RESULT_DIR/$seq
>>> +echo "QA output created by $seq"
>>> +
>>> +tmp=/tmp/$$
>>> +status=1     # failure is the default!
>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>> +
>>> +_cleanup()
>>> +{
>>> +     cd /
>>> +     rm -f $tmp.*
>>> +}
>>> +
>>> +# get standard environment, filters and checks
>>> +. ./common/rc
>>> +. ./common/filter
>>> +. ./common/reflink
>>> +
>>> +# real QA test starts here
>>> +_supported_fs btrfs
>>> +_require_scratch_reflink
>>> +_require_chattr C
>>> +_require_odirect
>>> +_require_xfs_io_command pwrite -N
>>> +_require_xfs_io_command falloc -k
>>> +_require_xfs_io_command fpunch
>>> +
>>> +rm -f $seqres.full
>>> +
>>> +_scratch_mkfs >>$seqres.full 2>&1
>>> +_scratch_mount
>>> +
>>> +# Test a write against COW file/extent - should fail with -EAGAIN. Disable the
>>> +# NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
>>> +echo "Testing write against COW file"
>>> +touch $SCRATCH_MNT/f1
>>> +$CHATTR_PROG -C $SCRATCH_MNT/f1
>>> +$XFS_IO_PROG -s -c "pwrite -S 0xab 0 128K" $SCRATCH_MNT/f1 | _filter_xfs_io
>>> +$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xff 32K 64K" $SCRATCH_MNT/f1
>>
>> Should we do something like
>>
>> expected_to_fail_command > /dev/null 2>&1 || echo "FAILED!"
>>
>> so we don't get screwed by error strings changing in the future or some such
>> other nonsense?  Thanks,
> 
> 1) That's generally considered an anti-pattern in fstests.
> 
> 2) More importantly, I want to make sure the failure reason is -EAGAIN
> ("Resource temporarily unavailable") and not something else, in which
> case it means we have a regression and we want to notice it.
> 

Fair enough

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
