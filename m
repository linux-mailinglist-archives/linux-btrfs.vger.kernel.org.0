Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B925AEDB
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIBPaC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgIBP3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:29:55 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE21C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 08:29:54 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j10so2378682qvk.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NDGtHV3+xZ+QgHAPo/ikKnk1UyAjOinZA/yddNp58eo=;
        b=IEpT4YXgeD3Ril/IndxdyXZOz8FjUL/o7Fvgf2p6tr2TlXS3m+4d4LiZ+ww/6Fg6KQ
         yYqsISvKzEL8nZSb+/jrm6vsL0bMouLGcb3BeQVMp3yPyPwVXwqmHCuMU/0mq7sbToa+
         iAfOHyP61gg3OiYxowgey5qFLKRIKNsliQebtLg800JXYcnt0Ezh/dj7WndLis2zXVP1
         vqQgGAjaxWKem5AFk/ymMULj3aCCk9acdN4iLKfPcZAe60+N/pYV+aV39i7Xe49Y3p8O
         KP5EXzmB9ZXlmFkXKj9I5dP9toHd5YFEW1o3GQv27+c8oOD8GzXiFJk0wsAInsGx+kgH
         wCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NDGtHV3+xZ+QgHAPo/ikKnk1UyAjOinZA/yddNp58eo=;
        b=VFZdHCGjv3PUTdmweqF0/XBrQpGq6CdqXT4g0JT9muH0qldbokKO1SHFnauV3JTlkD
         +yPyZ5Uz4dltVMUXz6f2UzmVvYwa7BWC7c5+hxaLlzg2tKw3/5RGTQarPgTl8+gw+utl
         LxK3GY9TI+sQAItcN7YNBD3VzfGchkFpLG6w4uIP450VCwNBzb7GG+KpX/2AkyucNOXX
         V1vQptOGsWiHssCWxnkDUstZdW2DTBVlezSpgb4YmE8uh/diVC/UrAmbfvNyxzZtK6Hy
         QLxuxGFx5Pj0OswMUtuURk15Ck+9G2UAe0Swd9xlnXuto32EHss5p2FsELV1h8oyQdqa
         rgVQ==
X-Gm-Message-State: AOAM530UeOXU/2JJSmiHnAz1iBdItAW+PWYCKlQHQYDoZRCO6wXrq7cV
        eShl+6aXoCWG9UWVgXG+dcta2g==
X-Google-Smtp-Source: ABdhPJwkIHT5mNGTbhNPgD4xPNTrA7+U4P37ua0k7LDtQjVL6ftn4oXayMpgzlgWHKjaDp5WpJfAJw==
X-Received: by 2002:a0c:c3cb:: with SMTP id p11mr3067961qvi.101.1599060593704;
        Wed, 02 Sep 2020 08:29:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i65sm4756556qkf.126.2020.09.02.08.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 08:29:52 -0700 (PDT)
Subject: Re: [PATCH] fstests: add generic/609 to test O_DIRECT|O_DSYNC
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
 <CAL3q7H5VEHK3rduT5gELdSd9EF3g8LLqJgkyHKdA-VUYSni37w@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3a696ffa-905f-fd28-1d25-790ac450ec0f@toxicpanda.com>
Date:   Wed, 2 Sep 2020 11:29:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5VEHK3rduT5gELdSd9EF3g8LLqJgkyHKdA-VUYSni37w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 11:18 AM, Filipe Manana wrote:
> On Wed, Sep 2, 2020 at 4:03 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> We had a problem recently where btrfs would deadlock with
>> O_DIRECT|O_DSYNC because of an unexpected dependency on ->fsync in
>> iomap.  This was only caught by chance with aiostress, because weirdly
>> we don't actually test this particular configuration anywhere in
>> xfstests.  Fix this by adding a basic test that just does
>> O_DIRECT|O_DSYNC writes.  With this test the box deadlocks right away
>> with Btrfs, which would have been helpful in finding this issue before
>> the patches were merged.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   .gitignore                      |  1 +
>>   src/aio-dio-regress/dio-dsync.c | 61 +++++++++++++++++++++++++++++++++
>>   tests/generic/609               | 44 ++++++++++++++++++++++++
>>   tests/generic/group             |  1 +
>>   4 files changed, 107 insertions(+)
>>   create mode 100644 src/aio-dio-regress/dio-dsync.c
>>   create mode 100755 tests/generic/609
>>
>> diff --git a/.gitignore b/.gitignore
>> index 5f5c4a0f..07c8014b 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -175,6 +175,7 @@
>>   /src/aio-dio-regress/aio-last-ref-held-by-io
>>   /src/aio-dio-regress/aiocp
>>   /src/aio-dio-regress/aiodio_sparse2
>> +/src/aio-dio-regress/dio-dsync
>>   /src/log-writes/replay-log
>>   /src/perf/*.pyc
>>
>> diff --git a/src/aio-dio-regress/dio-dsync.c b/src/aio-dio-regress/dio-dsync.c
>> new file mode 100644
>> index 00000000..53cda9ac
>> --- /dev/null
>> +++ b/src/aio-dio-regress/dio-dsync.c
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-newer
>> +/*
>> + * Copyright (c) 2020 Facebook.
>> + * All Rights Reserved.
>> + *
>> + * Do some O_DIRECT writes with O_DSYNC to exercise this path.
>> + */
>> +#include <stdio.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <errno.h>
>> +#include <string.h>
>> +
>> +int main(int argc, char **argv)
>> +{
>> +       struct stat st;
>> +       char *buf;
>> +       ssize_t ret;
>> +       int fd, i;
>> +       int bufsize;
>> +
>> +       if (argc != 2) {
>> +               printf("Usage: %s filename\n", argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       fd = open(argv[1], O_DIRECT | O_RDWR | O_TRUNC | O_CREAT | O_DSYNC,
>> +                 0644);
>> +       if (fd < 0) {
>> +               perror(argv[1]);
>> +               return 1;
>> +       }
>> +
>> +       if (fstat(fd, &st)) {
>> +               perror(argv[1]);
>> +               return 1;
>> +       }
>> +       bufsize = st.st_blksize * 10;
>> +
>> +       ret = posix_memalign((void **)&buf, st.st_blksize, bufsize);
>> +       if (ret) {
>> +               errno = ret;
>> +               perror("allocating buffer");
>> +               return 1;
>> +       }
>> +
>> +       memset(buf, 'a', bufsize);
>> +       for (i = 0; i < 10; i++) {
>> +               ret = write(fd, buf, bufsize);
>> +               if (ret < 0) {
>> +                       perror("writing");
>> +                       return 1;
>> +               }
>> +       }
>> +       free(buf);
>> +       close(fd);
>> +       return 0;
>> +}
>> diff --git a/tests/generic/609 b/tests/generic/609
>> new file mode 100755
>> index 00000000..8a888eb9
>> --- /dev/null
>> +++ b/tests/generic/609
>> @@ -0,0 +1,44 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 Josef Bacik.  All Rights Reserved.
>> +#
>> +# FS QA Test 609
>> +#
>> +# iomap can call generic_write_sync() if we're O_DSYNC, so write a basic test to
>> +# exercise O_DSYNC so any unsuspecting file systems will get lockdep warnings if
>> +# they're locking isn't compatible.
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
>> +       rm -rf $TEST_DIR/file
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_test
>> +_require_aiodio dio-dsync
>> +
>> +$AIO_TEST $TEST_DIR/file
> 
> This can be triggered with xfs_io and without adding a new test program:
> 
> #!/bin/bash
> 
> mkfs.btrfs -f /dev/sdj
> mount /dev/sdj /mnt/sdj
> 
> xfs_io -f -d -c "pwrite -D -V 1 0 4K" /mnt/sdj/foobar
> 
>

Ah that's how you do it, I didn't realize I could pass the open flags on the 
command line, so I had done something wonkey like

xfs_io -c "open -fds FILE" -c "pwrite"

and it hadn't worked, I really didn't want to write a bunch of code.  Thanks, 
I'll fix that,

Josef
