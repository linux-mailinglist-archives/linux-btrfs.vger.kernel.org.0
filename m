Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6916640B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 18:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgBTRMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 12:12:31 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33514 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTRMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 12:12:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so4289909qkm.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RKWY0DMoXnEu1WmHgr5Iqe8RfZpYOw8d33B6eKLen4s=;
        b=U5KOU6impQ77VfnnLOo9c834YJrna49cNohqnYW/N8QNPMiHzJFdXbk8v6xAacT6En
         ZfToCbkSlu0TqXhEc9TeE4T4kKd2BkTD0erIOCRAn3CMk4cc9hwPYau28xhno+nTl4JH
         riSNN3kmE3q5xBuECJv0Me0q4qVkQ7e3oOowEV7aAwqU4dz5HO16CfmvoUuRCRyE8UIn
         H1HbkF6K/GRo5fGoyrTaA5y+BceRozTSmmTbksWW7ezWO7ksSX0fwcvX/xEex/xCaEdW
         6sTcx8Q41JTe2Tnfw9Z1ogW/Zff8B0K4eSxsP0voPQnMVBWCHpVzWArzf62YRard/HRi
         aEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RKWY0DMoXnEu1WmHgr5Iqe8RfZpYOw8d33B6eKLen4s=;
        b=JMFJWWNLSay4fmzg5XqV49vfAmgqnVq3UzyHViqxb4DRrADCjX0fa343YXTKxl3ltJ
         /3dZk/I9uHdfxI3/iWsWgbyoLFu+U+pSTa/XE7bJs4JyeoRQjkTXFIv2VqE8vi6mNilP
         xCFDumB9Jq9tej01Tb71gU4DwRF858EKaIwM7GY8NRxnMBnUiwfFs9wVGe6igpTpIzLE
         i220qMmDxYzeb6+mHOiYhFOe0d1AhydrYf2hxE2HzvihEC3ueXaFQJ2TNQLQBS1IvOld
         of1n7UJroEuAfFFXEIjkJWrt6+A1upZLpi8TisFLI/hJB2SEJaK2oIBv1KuwEoji6eqe
         9iYA==
X-Gm-Message-State: APjAAAWuNMR0Dwp/UqbZXIkTkPEbWzKFoefr1smoTR9L85xx/YKe/Ndh
        HyqoGB6nkvZFednTluiC4MipGw==
X-Google-Smtp-Source: APXvYqyMiHnUjA3b4dtPOVH810ig8a+ZxQxBRCOfhSoms2Jz8bmiMvDSv16AvSZv9DeU5cvHQOKUaQ==
X-Received: by 2002:a37:742:: with SMTP id 63mr29117750qkh.31.1582218749639;
        Thu, 20 Feb 2020 09:12:29 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a13sm77179qkh.123.2020.02.20.09.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 09:12:28 -0800 (PST)
Subject: Re: [PATCH] fstests: add a another gap extent testcase for btrfs
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        fstests <fstests@vger.kernel.org>
References: <20200220143855.3883650-1-josef@toxicpanda.com>
 <CAL3q7H7UaJ-_aT4-Ab1eheVJUDwyuc6UQ6-Q9cQZCU1GqjuSGQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4969c822-5775-b91c-ba29-6d3f15d6cc40@toxicpanda.com>
Date:   Thu, 20 Feb 2020 12:12:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7UaJ-_aT4-Ab1eheVJUDwyuc6UQ6-Q9cQZCU1GqjuSGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/20/20 11:24 AM, Filipe Manana wrote:
> On Thu, Feb 20, 2020 at 2:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> This is a testcase for a corner that I missed when trying to fix gap
>> extents for btrfs.  We would end up with gaps if we hole punched past
>> isize and then extended past the gap in a specific way.  This is a
>> simple reproducer to show the problem, and has been properly fixed by my
>> patches now.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   tests/btrfs/204     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/204.out |  5 +++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 91 insertions(+)
>>   create mode 100755 tests/btrfs/204
>>   create mode 100644 tests/btrfs/204.out
>>
>> diff --git a/tests/btrfs/204 b/tests/btrfs/204
>> new file mode 100755
>> index 00000000..0d5c4bed
>> --- /dev/null
>> +++ b/tests/btrfs/204
>> @@ -0,0 +1,85 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
>> +#
>> +# FS QA Test 204
>> +#
>> +# Validate that without no-holes we do not get a i_size that is after a gap in
>> +# the file extents on disk when punching a hole past i_size.  This is fixed by
>> +# the following patches
>> +#
>> +#      btrfs: use the file extent tree infrastructure
>> +#      btrfs: replace all uses of btrfs_ordered_update_i_size
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/dmlogwrites
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_test
>> +_require_scratch
>> +_require_log_writes
> 
> _require_xfs_io_command "falloc" "-k"
> _require_xfs_io_command "fpunch"
> 
>> +
>> +_log_writes_init $SCRATCH_DEV
>> +_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
>> +
>> +# There's not a straightforward way to commit the transaction without also
>> +# flushing dirty pages, so shorten the commit interval to 1 so we're sure to get
>> +# a commit with our broken file
>> +_log_writes_mount -o commit=1
>> +
>> +# This creates a gap extent because fpunch doesn't insert hole extents past
>> +# i_size
>> +xfs_io -f -c "falloc -k 4k 8k" $SCRATCH_MNT/file
>> +xfs_io -f -c "fpunch 4k 4k" $SCRATCH_MNT/file
>> +
>> +# The pwrite extends the i_size to cover the gap extent, and then the truncate
>> +# sets the disk_i_size to 12k because it assumes everything was a-ok.
>> +xfs_io -f -c "pwrite 0 4k" $SCRATCH_MNT/file | _filter_xfs_io
>> +xfs_io -f -c "pwrite 0 8k" $SCRATCH_MNT/file | _filter_xfs_io
>> +xfs_io -f -c "truncate 12k" $SCRATCH_MNT/file
>> +
>> +# Wait for a transaction commit
>> +sleep 2
>> +
>> +_log_writes_unmount
>> +_log_writes_remove
>> +
>> +cur=$(_log_writes_find_next_fua 0)
>> +echo "cur=$cur" >> $seqres.full
>> +while [ ! -z "$cur" ]; do
>> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
>> +
>> +       # We only care about the fs consistency, so just run fsck, we don't have
>> +       # to mount the fs to validate it
>> +       _check_scratch_fs
>> +
>> +       cur=$(_log_writes_find_next_fua $(($cur + 1)))
>> +done
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/204.out b/tests/btrfs/204.out
>> new file mode 100644
>> index 00000000..44c7c8ae
>> --- /dev/null
>> +++ b/tests/btrfs/204.out
>> @@ -0,0 +1,5 @@
>> +QA output created by 204
>> +wrote 4096/4096 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 8192/8192 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 6acc6426..7a840177 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -206,3 +206,4 @@
>>   201 auto quick punch log
>>   202 auto quick subvol snapshot
>>   203 auto quick send clone
>> +204 auto quick log replay
> 
> "prealloc" and "punch" groups as well.
> 
> Since this just tests another variant of the same problem, maybe it
> could be added to btrfs/172, since that test is very recent and you
> authored it as well.
> Anyway, I don't have a strong preference.
> 
> The test itself looks good to me, and with the _require_xfs_io_command
> thing added and the groups (maybe Eryu can add these at commit time):
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 

I like to keep these things discrete, if a test is testing two different things 
and it fails I have to go comment out one part and re-run to figure out which 
actually failed.  Thanks,

Josef
