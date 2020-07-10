Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8551221B8BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJOfd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJOfd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:35:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188DC08C5DC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:35:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so5421394qke.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6CA0BtWDr6V5amY/gr+CQDO+ySxguynEikD6u0adTEU=;
        b=ikcdKWjsx0d7PCgrcOHCk1nbxtLDzeifxieurntgjK+aasJFYSe95/HRfp2LSQpyWs
         N+171k3wzO2n40eddASYhQWSv7Zom7o9R34lWSziedlDCzZC5mHYUJnF6kP4ig0Ot5ws
         4bHEulqcaJzKK/UntFdPM2/pfkAZRz+54g74LHUndqmszjtpsd1U88XCyCrZrT82dOop
         gdNc5E0sM5cbP6d/TAgKJOhZ9I/qrwh231S4qALZMG9ilptM6hscv3BZJ2HvnWMgXzF9
         iTZf+bocfypyulfWu4rXGclUvryIxVIF2crW9WzwqNtekKTWOu7/FaeC04p+lfzwSZSG
         WWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6CA0BtWDr6V5amY/gr+CQDO+ySxguynEikD6u0adTEU=;
        b=lBgulZOg0rD3o8S5H2xg0W1020tnI/RsYDXR+XZXdMA6hdhJKRRPgyJEIlwbPIwRro
         5ZpGikV5XpRMnG6Gi4p43SYdOBIu4PpTpHwI7u/mBOfZF6YoXiDxJRWErJS3sZUGdDQI
         svHnmvTcWhLKvLt4nxKZO2BKY/p7qDDqf2BBFnvyMyPlDDbwpAsFCYFBtGeKHmibPKA5
         R8hsxCQI/RroG1HVwLlHF0LTx+vLXmzXRVyIfIqLXukK4W+BGS/ZBz7YFfV4gM55fjT8
         Ig2QBm1Vbpl4m8JbYZCiUDg1kgTg1MBgNzLNRWXACE8utoSHz1bEL/xk7CCc/JoKBI6T
         h0aw==
X-Gm-Message-State: AOAM530m+3UQWqiwNTZnUk7uydhfMOVzvhpFioFPeME9BXWlJTvjSEBM
        e6f0j3zIv57s7q0x/8AoVnukrsC1xK58hA==
X-Google-Smtp-Source: ABdhPJxjzPbXKwH/FhK4UVmcmnjNToPzxD4irDZSXSWuTADyiUD97ryDlCxnRzOmeE0dzYVKg1xJ7w==
X-Received: by 2002:a37:2dc3:: with SMTP id t186mr58469954qkh.157.1594391731577;
        Fri, 10 Jul 2020 07:35:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j9sm7599869qtr.60.2020.07.10.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:35:30 -0700 (PDT)
Subject: Re: [PATCH] btrfs: add a test for umount racing mount
To:     Boris Burkov <boris@bur.io>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200710005545.1276395-1-boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c8bfc2c7-4c13-72e4-3665-c2e2dec99dd4@toxicpanda.com>
Date:   Fri, 10 Jul 2020 10:35:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710005545.1276395-1-boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/9/20 8:55 PM, Boris Burkov wrote:
> Test if dirtying many inodes, which delays the umount in `evict_inodes`,
> then umounting and quickly mounting again causes the mount to fail.
> 
> This race is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   tests/btrfs/215     | 52 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/215.out |  2 ++
>   tests/btrfs/group   |  1 +
>   3 files changed, 55 insertions(+)
>   create mode 100755 tests/btrfs/215
>   create mode 100644 tests/btrfs/215.out
> 
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> new file mode 100755
> index 00000000..b142c2d6
> --- /dev/null
> +++ b/tests/btrfs/215
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.

Facebook should go in "YOUR NAME HERE".

> +#
> +# FS QA Test 215
> +#
> +# Evicting dirty inodes can take a long time during umount.
> +# Check that a new mount racing with such a delayed umount succeeds.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic

This isn't btrfs specific, so I'd put it in tests/generic/<whatever>

> +_supported_os Linux
> +_require_test
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +for i in $(seq 0 500)
> +	do
> +		  dd if=/dev/zero of="$SCRATCH_MNT/$i" bs=1M count=1 > /dev/null 2>&1
> +		  done
> +		  _scratch_unmount&
> +		  _scratch_mount
> +

Looks like your tabbing got carried away here, and add a space between 
_scratch_unmount and the &.

> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/215.out b/tests/btrfs/215.out
> new file mode 100644
> index 00000000..0a11773b
> --- /dev/null
> +++ b/tests/btrfs/215.out
> @@ -0,0 +1,2 @@
> +QA output created by 215
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 505665b5..dda0763e 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -217,3 +217,4 @@
>   212 auto balance dangerous
>   213 auto balance dangerous
>   214 auto quick send snapshot
> +215 auto quick

Spacing appears to be off here too.  Thanks,

Josef
