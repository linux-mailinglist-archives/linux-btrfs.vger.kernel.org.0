Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17A127886
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfLTJxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 04:53:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbfLTJxr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 04:53:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 25315ACFE;
        Fri, 20 Dec 2019 09:53:45 +0000 (UTC)
Subject: Re: [PATCH] btrfs: regression test for subvol deletion after rename
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
References: <20191219142835.50371-1-josef@toxicpanda.com>
 <db0849cb-66d9-4815-d111-b225cb27a3c5@suse.com>
 <5ea1f28a-16bc-f97c-9c4a-ce47f94b1b43@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <0f3fe438-acc5-31b4-a366-3210b31e5b17@suse.com>
Date:   Fri, 20 Dec 2019 11:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5ea1f28a-16bc-f97c-9c4a-ce47f94b1b43@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.12.19 г. 23:16 ч., Josef Bacik wrote:
> On 12/19/19 11:12 AM, Nikolay Borisov wrote:
>>
>>
>> On 19.12.19 г. 16:28 ч., Josef Bacik wrote:
>>> Test removal of a subvolume via rmdir after it has been renamed into a
>>> snapshot of the volume that originally contained the subvolume
>>> reference.
>>>
>>> This currently fails on btrfs but is fixed by the patch with the title
>>>
>>>    "btrfs: fix invalid removal of root ref"
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>   tests/btrfs/202     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/btrfs/202.out |  4 ++++
>>>   tests/btrfs/group   |  1 +
>>>   3 files changed, 59 insertions(+)
>>>   create mode 100755 tests/btrfs/202
>>>   create mode 100644 tests/btrfs/202.out
>>>
>>> diff --git a/tests/btrfs/202 b/tests/btrfs/202
>>> new file mode 100755
>>> index 00000000..b02ee446
>>> --- /dev/null
>>> +++ b/tests/btrfs/202
>>> @@ -0,0 +1,54 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +#
>>> +# FS QA Test 201
>>> +#
>>> +# Regression test for fix "btrfs: fix invalid removal of root ref"
>>> +#
>>> +seq=`basename $0`
>>> +seqres=$RESULT_DIR/$seq
>>> +echo "QA output created by $seq"
>>> +
>>> +here=`pwd`
>>> +tmp=/tmp/$$
>>> +status=1    # failure is the default!
>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>> +
>>> +_cleanup()
>>> +{
>>> +    cd /
>>> +    rm -f $tmp.*
>>> +}
>>> +
>>> +. ./common/rc
>>> +. ./common/filter
>>> +
>>> +rm -f $seqres.full
>>> +
>>> +_supported_fs btrfs
>>> +_supported_os Linux
>>> +
>>> +_scratch_mkfs >> $seqres.full 2>&1
>>> +_scratch_mount
>>> +
>>> +# Create a subvol b under a and then snapshot a into c.  This 
>>> create's a stub
>>> +# entry in c for b because c doesn't have a reference for b.
>>> +#
>>> +# But when we rename b c/foo it creates a ref for b in c.  However 
>>> if we go to
>>> +# remove c/b btrfs used to depend on not finding the root ref to 
>>> handle the
>>> +# unlink properly, but we now have a ref for that root.  We also had 
>>> a bug that
>>> +# would allow us to remove mis-matched refs if the keys matched, so 
>>> we'd end up
>>> +# removing too many entries which would cause a transaction abort.
>>> +
>>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
>>> +    | _filter_scratch
>>> +ls $SCRATCH_MNT/c/b
>>
>> Isn't this ls redundant?
>>
> 
> No we need the dummy entry in cache before we add the root ref during 
> the rename.  Thanks,

A comment stating this would be good.

> 
> Josef
