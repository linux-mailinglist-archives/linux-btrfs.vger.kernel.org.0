Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D360F126F8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 22:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLSVQu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 16:16:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38437 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSVQs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 16:16:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id n15so6284493qtp.5
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 13:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cyz2FofkvAs+tYZsZmZnIcVc3z+B4FGuGfZg6Bel1Ds=;
        b=NjUHbewPFrlhBO7+xxcKjhKJTR57MkG0slnnY0EVFuKKez2T9vF+AbtWZrHfNfDlI2
         fwBekA6md/0BAml86ma0as40QVkgoPm8dUFalCFqq8Avf1pZ9ZJkqYgvMd5Jag4rQQz2
         d9avyaqAH4ryNHvQK+uIVCT+nKJLx8UloYhznr2456d3SR0OgWsQ5EnM30tqTvP8Gdzl
         99HD3rJ2m7Ipd+BcmqidAVNM/9N8XI24HqelYWjmOci3Q6uqdxbRNyLCWeAevhsFwlpE
         DQmwJ+E8N/x5j3pzpDY775C0tvKJQ03bkNPWycYjRsSpjWTSvfxIUQRt0fTro6q/5eFt
         1cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cyz2FofkvAs+tYZsZmZnIcVc3z+B4FGuGfZg6Bel1Ds=;
        b=Lev1v5uLGf+8kAYiig+1GkZuSk390fBFdwVa9bxwPTORv0DTrr2UJEzvZAuQBSQuEy
         T80XcT9DPH9N95mDU+eqwkGLMMdYBPqd4heF1npYrVffGLqi9dKR90Dh2wcwHM+6DVJn
         GaGmzw7J6VaMCqxPQwh9mZO774U8cq01w2KY18ED3u6+uKzKdlOUwfg2AbHdB4KnwBt1
         rHtAPUqOWEWDnBX5Udi/nUofRqz13I+DpYg94KmP69VAYjaM1OjU/blzkjq/EH/wfm3k
         tLTsKeJlJVU1nhs328XPa3gsRSEkr2uGXnhoYQ7KYXMg92U7WCK4uFhlxb79oyBfDm66
         sFAw==
X-Gm-Message-State: APjAAAVjxpbjwGkInt7Eqn/1PmNOS7cCcrxF49gBxQvX9e5FOFwg0Mxo
        MprPitgpf2LW4RU3COD4NReRKA==
X-Google-Smtp-Source: APXvYqx3kFF5c1xH9dyWHhxf9uybwO0ZlAwS6BO77nWN7DnDVuH6/ballj88tWPLWcZvNUVB9HJEsA==
X-Received: by 2002:ac8:614d:: with SMTP id d13mr8271090qtm.212.1576790207660;
        Thu, 19 Dec 2019 13:16:47 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::d837])
        by smtp.gmail.com with ESMTPSA id l35sm650498qtl.12.2019.12.19.13.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:16:46 -0800 (PST)
Subject: Re: [PATCH] btrfs: regression test for subvol deletion after rename
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
References: <20191219142835.50371-1-josef@toxicpanda.com>
 <db0849cb-66d9-4815-d111-b225cb27a3c5@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5ea1f28a-16bc-f97c-9c4a-ce47f94b1b43@toxicpanda.com>
Date:   Thu, 19 Dec 2019 16:16:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <db0849cb-66d9-4815-d111-b225cb27a3c5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/19/19 11:12 AM, Nikolay Borisov wrote:
> 
> 
> On 19.12.19 г. 16:28 ч., Josef Bacik wrote:
>> Test removal of a subvolume via rmdir after it has been renamed into a
>> snapshot of the volume that originally contained the subvolume
>> reference.
>>
>> This currently fails on btrfs but is fixed by the patch with the title
>>
>>    "btrfs: fix invalid removal of root ref"
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   tests/btrfs/202     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/202.out |  4 ++++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 59 insertions(+)
>>   create mode 100755 tests/btrfs/202
>>   create mode 100644 tests/btrfs/202.out
>>
>> diff --git a/tests/btrfs/202 b/tests/btrfs/202
>> new file mode 100755
>> index 00000000..b02ee446
>> --- /dev/null
>> +++ b/tests/btrfs/202
>> @@ -0,0 +1,54 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test 201
>> +#
>> +# Regression test for fix "btrfs: fix invalid removal of root ref"
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +rm -f $seqres.full
>> +
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +# Create a subvol b under a and then snapshot a into c.  This create's a stub
>> +# entry in c for b because c doesn't have a reference for b.
>> +#
>> +# But when we rename b c/foo it creates a ref for b in c.  However if we go to
>> +# remove c/b btrfs used to depend on not finding the root ref to handle the
>> +# unlink properly, but we now have a ref for that root.  We also had a bug that
>> +# would allow us to remove mis-matched refs if the keys matched, so we'd end up
>> +# removing too many entries which would cause a transaction abort.
>> +
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
>> +	| _filter_scratch
>> +ls $SCRATCH_MNT/c/b
> 
> Isn't this ls redundant?
> 

No we need the dummy entry in cache before we add the root ref during the 
rename.  Thanks,

Josef
