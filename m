Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD952F77A
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 May 2022 04:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbiEUCCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 22:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiEUCCd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 22:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 994EA1611D3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653098550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uz87S3u4ogXJ6tSzQ1PZBCbqDcUqAw8kIxUBsoS3gio=;
        b=V6IfVy8djJgX1RVlAtjeVIYj9YlQVZXqxMFN0sMUPihExYgvDfJ8c42PoARjbDu3EjtMbV
        Lio5hJJz18VwMfNaGqghhBmx4pQHoDbjm8OXRMlw3TnxVe9RoXmBT9qV6Rk8nh47NIbit0
        DTE3kgrv8dzBViLUS1moaTTAm3gxHGE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-Xa6e1DbeNcWLZnD7lXwpfQ-1; Fri, 20 May 2022 22:02:29 -0400
X-MC-Unique: Xa6e1DbeNcWLZnD7lXwpfQ-1
Received: by mail-qt1-f198.google.com with SMTP id a18-20020ac85b92000000b002f3c5e0a098so7848710qta.7
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 19:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uz87S3u4ogXJ6tSzQ1PZBCbqDcUqAw8kIxUBsoS3gio=;
        b=G60ulz6C3bDvsEBMsxGY9kZJ7LdqoSUhr3u/2l9WZSSnqs8ZxZgdise6xjvGjU2drv
         KEtQNUMzopUpEot8bo3V7evub9Tf0yxxUEiUxmZfW9hERtskmQicQn5hi2+XnnQGyVoQ
         L3x0cLX35DBQ8CSPkMBHC6pIKwubAxPu4NfqFwFgcajrgERDp3gz+mzdODc2JC28hZcz
         XPuEgFjnURWvO4qlU84gnBrbPzOFh3/61PEMwzdb+Z8C03zEaJQz3TPBF/J4JKGG8Uax
         9dwPEtvWCtY84Tbn+Hq/AnnJ4FR7jfNR5aMCGg6lyiZ9EwzP92Pf/MkwLqf6K+edgfbm
         TdEQ==
X-Gm-Message-State: AOAM5301MxUUPBQLZ4DpAvgus/dQFlvj58OZOONNSKahlndFqM9WKbv/
        a8zY4Q+4Yg8C/Xg0uAB8g9Xn2D1ZjrDQKDDxqQH1/MoprBJFO239cij0BdH2XlyhIJwUFJMOUnq
        0Fjw+ORILlDss1G7kLt0qtGE=
X-Received: by 2002:a0c:ea89:0:b0:461:c43d:7b5c with SMTP id d9-20020a0cea89000000b00461c43d7b5cmr10168508qvp.38.1653098548297;
        Fri, 20 May 2022 19:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7JWoS58pbVuqD2O1CILd2m3IOXU+MNlR7+dDhJ4y6Ne1Q8HEKjgaIiwkDvNYNVzU8F4B2Gw==
X-Received: by 2002:a0c:ea89:0:b0:461:c43d:7b5c with SMTP id d9-20020a0cea89000000b00461c43d7b5cmr10168499qvp.38.1653098548028;
        Fri, 20 May 2022 19:02:28 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id cj19-20020a05622a259300b002f39b99f6aasm659495qtb.68.2022.05.20.19.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 19:02:27 -0700 (PDT)
Date:   Sat, 21 May 2022 10:02:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: test repair with sectors corrupted in
 multiple mirrors
Message-ID: <20220521020220.7qaktprdo47j3gno@zlang-mailbox>
References: <20220520164743.4023665-1-hch@lst.de>
 <20220520164743.4023665-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520164743.4023665-2-hch@lst.de>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 20, 2022 at 06:47:42PM +0200, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/btrfs/265     | 127 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/265.out |  75 ++++++++++++++++++++++++++
>  2 files changed, 202 insertions(+)
>  create mode 100755 tests/btrfs/265
>  create mode 100644 tests/btrfs/265.out
> 
> diff --git a/tests/btrfs/265 b/tests/btrfs/265
> new file mode 100755
> index 00000000..96f37989
> --- /dev/null
> +++ b/tests/btrfs/265
> @@ -0,0 +1,127 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 265
> +#
> +# Test that btrfs raid repair on a raid1c3 profile can repair corruption on two
> +# mirrors for the same logical offset.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)

Hi Christoph,

Thanks for the new test cases. I'm not an btrfs expert, so I'll only give
this patchset some review points from fstests side. Btrfs forks please
feel free to review this patchset :)

If btrfs-map-logical is a general command from btffs-progs, I think we
can move above line into common/config.

> +
> +_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +_require_command "$FILEFRAG_PROG" filefrag
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +get_physical()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
> +}
> +			
> +get_device_path()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
> +}
> +
> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts="-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_btrfs_no_v1_cache_opt)
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
> +# one in $SCRATCH_DEV_POOL
> +echo "step 2......corrupt file extent"
> +
> +${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> +logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> +
> +physical1=$(get_physical ${logical_in_btrfs} 1)
> +devpath1=$(get_device_path ${logical_in_btrfs} 1)
> +
> +physical2=$(get_physical ${logical_in_btrfs} 2)
> +devpath2=$(get_device_path ${logical_in_btrfs} 2)

I saw you do the same steps from "${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar" to
this line in 2 patches, so I'm wondering are the FILEFRAG_PROG lines and
get_physical() and get_device_path() worth moving to common/btrfs (might need
to change name), to make them get "device_path" or "physical" from a filename
(e.g. $SCRATCH_MNT/foobar) argument?

Thanks,
Zorro

> +
> +_scratch_unmount
> +
> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical1 64K" $devpath1 \
> +	> /dev/null
> +
> +echo " corrupt stripe #2, devpath $devpath2 physical $physical2" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical2 64K" $devpath2 \
> +	> /dev/null
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +# since raid1c3 consists of three copies, and the bad copy was put on stripe #1
> +# while the good copy lies the other stripes, the bad copy only gets accessed
> +# when the reader's pid % 3 is 1
> +while true; do
> +	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> +	pid=$!
> +	wait
> +	if [ $((pid % 3)) == 1 ]; then
> +	    break
> +	fi
> +done
> +while true; do
> +	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
> +	pid=$!
> +	wait
> +	if [ $((pid % 3)) == 2 ]; then
> +	    break
> +	fi
> +done
> +
> +_scratch_unmount
> +
> +echo "step 4......check if the repair works"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/265.out b/tests/btrfs/265.out
> new file mode 100644
> index 00000000..4d3e7f80
> --- /dev/null
> +++ b/tests/btrfs/265.out
> @@ -0,0 +1,75 @@
> +QA output created by 265
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair works
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.30.2
> 

