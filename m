Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744A37D978A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 14:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbjJ0MQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbjJ0MQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 08:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C3C0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 05:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698408930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmcBpkcMtUzkFnS0Z4xfn2QsFi+vB2x0NJn50Z9ibvY=;
        b=hEiKujsNacVnt/bYWn0oqQmO1jaHCO6Pbq4wslqkre+Qg1X9mdzDXa9nsK7+7WHLbJmX0o
        JEimGvPTZyoXiOerKWc0xmaTgkmoPqBRJoHywcYvF/68c6RWuuzCK4DS5K95PgUZaZPdmD
        8wmHCc8hPvGNi/hFfL8EBN0ssFY+9aY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-IWDMgMGvPq-JCDQkGzpuTQ-1; Fri, 27 Oct 2023 08:15:29 -0400
X-MC-Unique: IWDMgMGvPq-JCDQkGzpuTQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so1765022a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 05:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408928; x=1699013728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmcBpkcMtUzkFnS0Z4xfn2QsFi+vB2x0NJn50Z9ibvY=;
        b=EuwWT4Pl1BuOrBDsoK07rOZADP7ZhHJ4cUB7gkNgsVcJF0QqEzUFICTKNK0IF3gFQW
         LpCsektFOoW3CxljgxKlHubgPKVxF5lXgify9vw8oPW0cZmna8Haw1BLtEOKQ3TyLGr4
         fHgVhg0NAYu01agkzmhWrfOHiwh30/PyHI+L/Q8mNHfCmfFjQ5yX0NjDhDYZmEmA8jRG
         Iodu/DoxN/vHkEW18VvacgnEY0ia6eMDtcpr2HcfTTEzjfMaoMQDPW+XjxVor9oI0OUO
         AEuYZh7IrSsNAivtzVCA08iNMfee8Qsi0mZC3OdFD5XREt3iZfzn1iovvq5PbjmyPwQ9
         oaVg==
X-Gm-Message-State: AOJu0YwtlvWcIfX5lwZr7MLd+37wtwUid8aImzOaSydOOgKg4fetZyo/
        W6k4uO+Kj6YMSxQ7QzAwMMRqnKtYUgU0d1V+Q9QiDBE8WsygPFJdN/LJvYk34oaLe8k8DGGzPLx
        2V5oRkHdWVuMDZrGBlk0BJX0=
X-Received: by 2002:a17:902:dcc5:b0:1cc:b3f:dd81 with SMTP id t5-20020a170902dcc500b001cc0b3fdd81mr1928419pll.67.1698408928352;
        Fri, 27 Oct 2023 05:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoLJf/9t+MxP2adSki0TQVAXmyVyTSsD8IcnwXQzAwyeGADdDb8gCK5sui/PYuTQpwtmJnPA==
X-Received: by 2002:a17:902:dcc5:b0:1cc:b3f:dd81 with SMTP id t5-20020a170902dcc500b001cc0b3fdd81mr1928401pll.67.1698408928020;
        Fri, 27 Oct 2023 05:15:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b001cc2c7a30e0sm49063plb.159.2023.10.27.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:15:27 -0700 (PDT)
Date:   Fri, 27 Oct 2023 20:15:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: test snapshotting a subvolume that was just
 created
Message-ID: <20231027121524.247ewzfnns3otte4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
 <c0b651af75a999cb1356e64d936080b65067ae56.1698146559.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b651af75a999cb1356e64d936080b65067ae56.1698146559.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 24, 2023 at 12:23:46PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that snapshotting a new subvolume (created in the current transaction)
> that has a btree with a height > 1, works and does not result in a fs
> corruption.
> 
> This exercises a regression introduced in kernel 6.5 by the kernel commit:
> 
>   1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> 
> v2: Add git commit ID for the kernel fix, as it was merged yesterday into
>     Linus' tree. Also fixed a typo and included Josef's Reviewed-by tag.

Thanks for doing this!

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/btrfs/302     | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/302.out |  4 +++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/btrfs/302
>  create mode 100644 tests/btrfs/302.out
> 
> diff --git a/tests/btrfs/302 b/tests/btrfs/302
> new file mode 100755
> index 00000000..f3e6044b
> --- /dev/null
> +++ b/tests/btrfs/302
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 302
> +#
> +# Test that snapshotting a new subvolume (created in the current transaction)
> +# that has a btree with a height > 1, works and does not result in a filesystem
> +# corruption.
> +#
> +# This exercises a regression introduced in kernel 6.5 by the kernel commit:
> +#
> +#    1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot subvol
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_fssum
> +
> +_fixed_by_kernel_commit eb96e221937a \
> +	"btrfs: fix unwritten extent buffer after snapshotting a new subvolume"
> +
> +# Use a filesystem with a 64K node size so that we have the same node size on
> +# every machine regardless of its page size (on x86_64 default node size is 16K
> +# due to the 4K page size, while on PPC it's 64K by default). This way we can
> +# make sure we are able to create a btree for the subvolume with a height of 2.
> +_scratch_mkfs -n 64K >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
> +
> +# Create a few empty files on the subvolume, this bumps its btree height to 2
> +# (root node at level 1 and 2 leaves).
> +for ((i = 1; i <= 300; i++)); do
> +	echo -n > $SCRATCH_MNT/subvol/file_$i
> +done
> +
> +# Create a checksum of the subvolume's content.
> +fssum_file="$SCRATCH_MNT/checksum.fssum"
> +$FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
> +
> +# Now create a snapshot of the subvolume and make it accessible from within the
> +# subvolume.
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
> +		 $SCRATCH_MNT/subvol/snap | _filter_scratch
> +
> +# Now unmount and mount again the fs. We want to verify we are able to read all
> +# metadata for the snapshot from disk (no IO failures, etc).
> +_scratch_cycle_mount
> +
> +# The snapshot's content should match the subvolume's content before we created
> +# the snapshot.
> +$FSSUM_PROG -r $fssum_file $SCRATCH_MNT/subvol/snap
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
> new file mode 100644
> index 00000000..8770aefc
> --- /dev/null
> +++ b/tests/btrfs/302.out
> @@ -0,0 +1,4 @@
> +QA output created by 302
> +Create subvolume 'SCRATCH_MNT/subvol'
> +Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
> +OK
> -- 
> 2.40.1
> 

