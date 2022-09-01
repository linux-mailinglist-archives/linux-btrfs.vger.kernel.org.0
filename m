Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A25A9A3E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIAO1O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiIAO07 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:26:59 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5CC100F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:26:58 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id f9so9884805qvw.11
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zUFYTzmfqnycO3veknWz50nDQppP82L4rvUsD9vulqE=;
        b=Dh2AZ4jNDWcNdsj2UUL0g7t7m87ptRJS796BtIoynkTPcoQxFV2wX7zusu4CfxBuUh
         uISZtwFDtqGjkRWKTTNj+9hVpnxsYe8xAfMdPh+LF8rVLGpqPyKmw99ZuAXVTrR2w3Qm
         2i1L6L3QBxgC9Yh6+fcDdTjuzST0lJrCNmzsh7MoeemJhEvigWQMGcZxIlj12gC3Xw6H
         XssdzhR1Uz93UDVErFQpa3KscHwAfupWZuw53iplG8QR1U6vM8am/TPPeIokrJju4iDk
         XHGOiOb8Om1rVV0ijSN4fB46eoDasiZfZpeTpk1zRZo2kdAX7xMcglU7OPdfhhvBkZEk
         wH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zUFYTzmfqnycO3veknWz50nDQppP82L4rvUsD9vulqE=;
        b=Pfb1Wgzy48jKg3GCu93L6DQ73oqfBnB3kHg9IZeCYn0DMRtgC+Jec5QiBUsVglV1UU
         ab1IKB5uzWjeqEJijbTM+RWFSgf9XpuRcM/9ar9eYWqzl/dgbqNQ/yVevgsj6ORXYVzz
         vZ6tZk2Ni98yVMnlxgTE6DQcefehY7DtonP3e/uNNgL5fgOQs2PH+TeIgWN48DjC3U2l
         mn1jbEz5XF5omIwxPd0/0yw6pLVbaDhgK8b1u4mAnPWWXQRsbybNrtYawgkgikkPdUCH
         jOw/qgSpALGp0vv12HK+f/pk2wvmXGEU1yDEp4xPW2+jC69uNNPpgxAjjcW2u3U1RzcS
         B1CA==
X-Gm-Message-State: ACgBeo3i8h1S8QyMP6pScEvdPOm6dkMPjQhSXBHdknQBLJLvWDhZ9O1f
        pdJ5kiXXTaz+uU1ZL6lUDslqmVi/5zveFQ==
X-Google-Smtp-Source: AA6agR4H2QmbQNY5S9LRLt4nR0KsNpKDdOSHxOJLidDl6x5rU5AvPIYh1YeSnudV9TGWOxzNFhgUeA==
X-Received: by 2002:a05:6214:2a4a:b0:499:5d6:da01 with SMTP id jf10-20020a0562142a4a00b0049905d6da01mr16303447qvb.36.1662042417059;
        Thu, 01 Sep 2022 07:26:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n19-20020ac85b53000000b003447c4f5aa5sm10875710qtw.24.2022.09.01.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:26:56 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:26:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/10] btrfs: skip unnecessary extent buffer sharedness
 checks during fiemap
Message-ID: <YxDBL5qXmAU9qllX@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <d80f75e12d0212da59cbcccac2eddd506c8998af.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80f75e12d0212da59cbcccac2eddd506c8998af.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During fiemap, for each file extent we find, we must check if it's shared
> or not. The sharedness check starts by verifying if the extent is directly
> shared (its refcount in the extent tree is > 1), and if it is not directly
> shared, then we will check if every node in the subvolume b+tree leading
> from the root to the leaf that has the file extent item (in reverse order),
> is shared (through snapshots).
> 
> However this second step is not needed if our extent was created in a
> transaction more recent than the last transaction where a snapshot of the
> inode's root happened, because it can't be shared indirectly (through
> shared subtrees) without a snapshot created in a more recent transaction.
> 
> So grab the generation of the extent from the extent map and pass it to
> btrfs_is_data_extent_shared(), which will skip this second phase when the
> generation is more recent than the root's last snapshot value. Note that
> we skip this optimization if the extent map is the result of merging 2
> or more extent maps, because in this case its generation is the maximum
> of the generations of all merged extent maps.
> 
> The fact the we use extent maps and they can be merged despite the
> underlying extents being distinct (different file extent items in the
> subvolume b+tree and different extent items in the extent b+tree), can
> result in some bugs when reporting shared extents. But this is a problem
> of the current implementation of fiemap relying on extent maps.
> One example where we get incorrect results is:
> 
>     $ cat fiemap-bug.sh
>     #!/bin/bash
> 
>     DEV=/dev/sdj
>     MNT=/mnt/sdj
> 
>     mkfs.btrfs -f $DEV
>     mount $DEV $MNT
> 
>     # Create a file with two 256K extents.
>     # Since there is no other write activity, they will be contiguous,
>     # and their extent maps merged, despite having two distinct extents.
>     xfs_io -f -c "pwrite -S 0xab 0 256K" \
>               -c "fsync" \
>               -c "pwrite -S 0xcd 256K 256K" \
>               -c "fsync" \
>               $MNT/foo
> 
>     # Now clone only the second extent into another file.
>     xfs_io -f -c "reflink $MNT/foo 256K 0 256K" $MNT/bar
> 
>     # Filefrag will report a single 512K extent, and say it's not shared.
>     echo
>     filefrag -v $MNT/foo
> 
>     umount $MNT
> 
> Running the reproducer:
> 
>     $ ./fiemap-bug.sh
>     wrote 262144/262144 bytes at offset 0
>     256 KiB, 64 ops; 0.0038 sec (65.479 MiB/sec and 16762.7030 ops/sec)
>     wrote 262144/262144 bytes at offset 262144
>     256 KiB, 64 ops; 0.0040 sec (61.125 MiB/sec and 15647.9218 ops/sec)
>     linked 262144/262144 bytes at offset 0
>     256 KiB, 1 ops; 0.0002 sec (1.034 GiB/sec and 4237.2881 ops/sec)
> 
>     Filesystem type is: 9123683e
>     File size of /mnt/sdj/foo is 524288 (128 blocks of 4096 bytes)
>      ext:     logical_offset:        physical_offset: length:   expected: flags:
>        0:        0..     127:       3328..      3455:    128:             last,eof
>     /mnt/sdj/foo: 1 extent found
> 
> We end up reporting that we have a single 512K that is not shared, however
> we have two 256K extents, and the second one is shared. Changing the
> reproducer to clone instead the first extent into file 'bar', makes us
> report a single 512K extent that is shared, which is algo incorrect since
> we have two 256K extents and only the first one is shared.
> 
> This is z problem that existed before this change, and remains after this
> change, as it can't be easily fixed. The next patch in the series reworks
> fiemap to primarily use file extent items instead of extent maps (except
> for checking for delalloc ranges), with the goal of improving its
> scalability and performance, but it also ends up fixing this particular
> bug caused by extent map merging.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
