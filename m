Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6487E5FB3F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJKNzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJKNzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 09:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E57B283
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665496545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qv6CI8gJnYlc/5Y7jhgCyI53q0hVFJTunW3M4GVDRUM=;
        b=Vh+Mhan2uSxtH5T/888wLg8kR6VGz3rbqEIdyriNLzWHn84RVXr49PZtvOBJVmTFL9dZCu
        XNv+2etZxznmE6ItHsGjzPTr0XpK3H5BWy4KsL/jEAw3MoyDCNnfmrj2fj6TbIJQtPzVR6
        hw9TVapNoAEsMKJwplo7ktFltZkqrmw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-ONrvH82SMImzSMdrL-SSlA-1; Tue, 11 Oct 2022 09:55:44 -0400
X-MC-Unique: ONrvH82SMImzSMdrL-SSlA-1
Received: by mail-qt1-f197.google.com with SMTP id d1-20020ac80601000000b00388b0fc84beso9130677qth.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 06:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv6CI8gJnYlc/5Y7jhgCyI53q0hVFJTunW3M4GVDRUM=;
        b=yywT/6oJrA4czutmpZkLD9NKkjEQoYZO73J6vCFsJu/AYAU6KKwFf9/5Buq1oCmBT7
         epS+yUl5h2C+n2a8eygFIly49YiT4uO4CHkVhLhm0x0h5Ml+EoOFebr++uA3BTkSX+zL
         +FVl0Pm+tlFd7iDdlBcAxoJsGEUg9a5Ex61Lw0nLcKsrjWas7hZo83KV27KIsK/0oH45
         EhCoi9YhLEQotwkjLtQww/1pO1H1u8SelE3koFgjAi8+48tRwFCA94irX2gTw/6iF8HM
         AiUE3XaCGgTg/VToNYmYyCa6ekQDDF+qW340jXdMOEaNlqtkxVK7eMB/Q9W2t0B45jI6
         9wig==
X-Gm-Message-State: ACrzQf3Ygq8PpbO9/KuUwbIxUAKIJywgSVCLJjwyhxSJYPiEg1LSEWdt
        k71vfaZvomVvZ8Sfpx7azDY8iW4ZU6akUtIpW9cRieO2wvSYK89wvhUZb7f6ihB33j7K7eSK2u0
        deiPjYIQ56SB5Ku0PsD2IpqM=
X-Received: by 2002:a05:620a:1aa6:b0:6ec:52f3:6584 with SMTP id bl38-20020a05620a1aa600b006ec52f36584mr9384272qkb.128.1665496543057;
        Tue, 11 Oct 2022 06:55:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Ahk2k2jka9huLcqQCTCauKUflOSjsMmzXyFUMW/guVVq+ot/mmOMRumuVrcyct2pECtfg5w==
X-Received: by 2002:a05:620a:1aa6:b0:6ec:52f3:6584 with SMTP id bl38-20020a05620a1aa600b006ec52f36584mr9384222qkb.128.1665496542275;
        Tue, 11 Oct 2022 06:55:42 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a25cf00b006bbf85cad0fsm13353373qko.20.2022.10.11.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:55:41 -0700 (PDT)
Date:   Tue, 11 Oct 2022 21:55:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/3] fstests: add fiemap group
Message-ID: <20221011135536.bl2kwov7vznn3pnt@zlang-mailbox>
References: <cover.1665150613.git.fdmanana@suse.com>
 <db8bc237902bcfc4e2c55ec33752d3209e074b2e.1665150613.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8bc237902bcfc4e2c55ec33752d3209e074b2e.1665150613.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 07, 2022 at 02:53:36PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add a fiemap group for all tests that exercise fiemap, either directly
> through xfs_io, or more indirectly like through filefrag or helpers in
> common/* (like _count_extents, _count_holes, etc). This is useful in
> order to quickly test changes made to the fiemap implementation of a
> filesystem for example.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

By checking each cases below, I think this patch is fine. Not only the
"xfs_io -c fiemap", you count those cases which use "filefrag" in fiemap
group too. I'm OK to accept that, so if there's not more review points,
I'll merge this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  doc/group-names.txt | 1 +
>  tests/btrfs/004     | 2 +-
>  tests/btrfs/079     | 2 +-
>  tests/btrfs/137     | 2 +-
>  tests/btrfs/140     | 2 +-
>  tests/btrfs/199     | 2 +-
>  tests/btrfs/200     | 2 +-
>  tests/btrfs/211     | 2 +-
>  tests/btrfs/257     | 2 +-
>  tests/btrfs/258     | 2 +-
>  tests/btrfs/259     | 2 +-
>  tests/btrfs/260     | 2 +-
>  tests/btrfs/263     | 2 +-
>  tests/btrfs/276     | 2 +-
>  tests/ext4/001      | 2 +-
>  tests/ext4/034      | 2 +-
>  tests/ext4/308      | 2 +-
>  tests/f2fs/002      | 2 +-
>  tests/generic/009   | 2 +-
>  tests/generic/012   | 2 +-
>  tests/generic/016   | 2 +-
>  tests/generic/017   | 2 +-
>  tests/generic/021   | 2 +-
>  tests/generic/022   | 2 +-
>  tests/generic/032   | 2 +-
>  tests/generic/043   | 2 +-
>  tests/generic/044   | 2 +-
>  tests/generic/045   | 2 +-
>  tests/generic/046   | 2 +-
>  tests/generic/047   | 2 +-
>  tests/generic/048   | 2 +-
>  tests/generic/049   | 2 +-
>  tests/generic/058   | 2 +-
>  tests/generic/060   | 2 +-
>  tests/generic/061   | 2 +-
>  tests/generic/063   | 2 +-
>  tests/generic/064   | 2 +-
>  tests/generic/092   | 2 +-
>  tests/generic/094   | 2 +-
>  tests/generic/110   | 2 +-
>  tests/generic/111   | 2 +-
>  tests/generic/115   | 2 +-
>  tests/generic/177   | 2 +-
>  tests/generic/225   | 2 +-
>  tests/generic/255   | 2 +-
>  tests/generic/301   | 2 +-
>  tests/generic/302   | 2 +-
>  tests/generic/305   | 2 +-
>  tests/generic/316   | 2 +-
>  tests/generic/326   | 2 +-
>  tests/generic/327   | 2 +-
>  tests/generic/328   | 2 +-
>  tests/generic/352   | 2 +-
>  tests/generic/353   | 2 +-
>  tests/generic/372   | 2 +-
>  tests/generic/414   | 2 +-
>  tests/generic/425   | 2 +-
>  tests/generic/473   | 2 +-
>  tests/generic/483   | 2 +-
>  tests/generic/516   | 2 +-
>  tests/generic/519   | 2 +-
>  tests/generic/540   | 2 +-
>  tests/generic/541   | 2 +-
>  tests/generic/542   | 2 +-
>  tests/generic/543   | 2 +-
>  tests/generic/578   | 2 +-
>  tests/generic/654   | 2 +-
>  tests/generic/655   | 2 +-
>  tests/generic/677   | 2 +-
>  tests/generic/679   | 2 +-
>  tests/generic/695   | 2 +-
>  tests/overlay/066   | 2 +-
>  tests/shared/298    | 2 +-
>  tests/xfs/180       | 2 +-
>  tests/xfs/182       | 2 +-
>  tests/xfs/184       | 2 +-
>  tests/xfs/192       | 2 +-
>  tests/xfs/193       | 2 +-
>  tests/xfs/198       | 2 +-
>  tests/xfs/200       | 2 +-
>  tests/xfs/204       | 2 +-
>  tests/xfs/207       | 2 +-
>  tests/xfs/208       | 2 +-
>  tests/xfs/209       | 2 +-
>  tests/xfs/210       | 2 +-
>  tests/xfs/211       | 2 +-
>  tests/xfs/212       | 2 +-
>  tests/xfs/213       | 2 +-
>  tests/xfs/214       | 2 +-
>  tests/xfs/231       | 2 +-
>  tests/xfs/232       | 2 +-
>  tests/xfs/252       | 2 +-
>  tests/xfs/344       | 2 +-
>  tests/xfs/345       | 2 +-
>  tests/xfs/346       | 2 +-
>  tests/xfs/347       | 2 +-
>  tests/xfs/443       | 2 +-
>  97 files changed, 97 insertions(+), 96 deletions(-)
> 
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index ef411b5e..6cc9af78 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -47,6 +47,7 @@ eio			IO error reporting
>  encrypt			encrypted file contents
>  enospc			ENOSPC error reporting
>  exportfs		file handles
> +fiemap			fiemap ioctl
>  filestreams		XFS filestreams allocator
>  freeze			filesystem freeze tests
>  fsck			general fsck tests
> diff --git a/tests/btrfs/004 b/tests/btrfs/004
> index 4e767a2f..aa37c45d 100755
> --- a/tests/btrfs/004
> +++ b/tests/btrfs/004
> @@ -10,7 +10,7 @@
>  # We check to end up back at the original file with the correct offset.
>  #
>  . ./common/preamble
> -_begin_fstest auto rw metadata
> +_begin_fstest auto rw metadata fiemap
>  
>  noise_pid=0
>  
> diff --git a/tests/btrfs/079 b/tests/btrfs/079
> index 1acd1855..92d59479 100755
> --- a/tests/btrfs/079
> +++ b/tests/btrfs/079
> @@ -18,7 +18,7 @@
>  # btrfs: Fix the wrong condition judgment about subset extent map
>  #
>  . ./common/preamble
> -_begin_fstest auto rw metadata
> +_begin_fstest auto rw metadata fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/137 b/tests/btrfs/137
> index 64ed2450..7d03c260 100755
> --- a/tests/btrfs/137
> +++ b/tests/btrfs/137
> @@ -7,7 +7,7 @@
>  # Test that both incremental and full send operations preserve file holes.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send
> +_begin_fstest auto quick send fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index fdff6eb2..247a7356 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -12,7 +12,7 @@
>  #	commit 2e949b0a5592 ("Btrfs: fix invalid dereference in btrfs_retry_endio")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick read_repair
> +_begin_fstest auto quick read_repair fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/199 b/tests/btrfs/199
> index 2024447c..709ad1f9 100755
> --- a/tests/btrfs/199
> +++ b/tests/btrfs/199
> @@ -16,7 +16,7 @@
>  # boundary"
>  #
>  . ./common/preamble
> -_begin_fstest auto quick trim
> +_begin_fstest auto quick trim fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> index 48cd7046..5ce3775f 100755
> --- a/tests/btrfs/200
> +++ b/tests/btrfs/200
> @@ -8,7 +8,7 @@
>  # operations for extents that are shared between the same file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send clone
> +_begin_fstest auto quick send clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/211 b/tests/btrfs/211
> index 60ef3d1b..f5744b75 100755
> --- a/tests/btrfs/211
> +++ b/tests/btrfs/211
> @@ -10,7 +10,7 @@
>  # the NO_HOLES feature.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick log prealloc
> +_begin_fstest auto quick log prealloc fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/257 b/tests/btrfs/257
> index 87f9e0b2..f8e69f7a 100755
> --- a/tests/btrfs/257
> +++ b/tests/btrfs/257
> @@ -9,7 +9,7 @@
>  #
>  
>  . ./common/preamble
> -_begin_fstest auto quick defrag prealloc
> +_begin_fstest auto quick defrag prealloc fiemap
>  
>  # Override the default cleanup function.
>  # _cleanup()
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> index be61d039..e4a23dcc 100755
> --- a/tests/btrfs/258
> +++ b/tests/btrfs/258
> @@ -8,7 +8,7 @@
>  # in the middle
>  #
>  . ./common/preamble
> -_begin_fstest auto defrag quick
> +_begin_fstest auto defrag quick fiemap
>  
>  . ./common/filter
>  
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> index 36f499f9..cbbea9f5 100755
> --- a/tests/btrfs/259
> +++ b/tests/btrfs/259
> @@ -8,7 +8,7 @@
>  # at their max capacity.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick defrag
> +_begin_fstest auto quick defrag fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/260 b/tests/btrfs/260
> index 8042ec4d..111a3bd6 100755
> --- a/tests/btrfs/260
> +++ b/tests/btrfs/260
> @@ -8,7 +8,7 @@
>  # algorithm of all regular extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick defrag compress prealloc
> +_begin_fstest auto quick defrag compress prealloc fiemap
>  
>  # Override the default cleanup function.
>  # _cleanup()
> diff --git a/tests/btrfs/263 b/tests/btrfs/263
> index d201f14e..8ff363d1 100755
> --- a/tests/btrfs/263
> +++ b/tests/btrfs/263
> @@ -8,7 +8,7 @@
>  # defragmentation.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick defrag
> +_begin_fstest auto quick defrag fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> index c27e8383..944b0c8f 100755
> --- a/tests/btrfs/276
> +++ b/tests/btrfs/276
> @@ -9,7 +9,7 @@
>  # and when the file's subvolume was snapshoted.
>  #
>  . ./common/preamble
> -_begin_fstest auto snapshot compress
> +_begin_fstest auto snapshot compress fiemap
>  
>  . ./common/filter
>  
> diff --git a/tests/ext4/001 b/tests/ext4/001
> index f1d1e829..f8650365 100755
> --- a/tests/ext4/001
> +++ b/tests/ext4/001
> @@ -8,7 +8,7 @@
>  #
>  seqfull=$0
>  . ./common/preamble
> -_begin_fstest auto prealloc quick zero
> +_begin_fstest auto prealloc quick zero fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/ext4/034 b/tests/ext4/034
> index 223c964f..bf7466d4 100755
> --- a/tests/ext4/034
> +++ b/tests/ext4/034
> @@ -11,7 +11,7 @@
>  # "ext4: make sure enough credits are reserved for dioread_nolock writes"
>  #
>  . ./common/preamble
> -_begin_fstest auto quick quota
> +_begin_fstest auto quick quota fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/ext4/308 b/tests/ext4/308
> index b88ea056..849ebdf8 100755
> --- a/tests/ext4/308
> +++ b/tests/ext4/308
> @@ -9,7 +9,7 @@
>  # So if ioctl was performed twice then inode's layout should not change.
>  #
>  . ./common/preamble
> -_begin_fstest auto ioctl rw prealloc quick defrag
> +_begin_fstest auto ioctl rw prealloc quick defrag fiemap
>  
>  PIDS=""
>  
> diff --git a/tests/f2fs/002 b/tests/f2fs/002
> index 59ca2a2d..8235d88a 100755
> --- a/tests/f2fs/002
> +++ b/tests/f2fs/002
> @@ -40,7 +40,7 @@
>  # just test LZ4.
>  
>  . ./common/preamble
> -_begin_fstest auto quick rw encrypt compress
> +_begin_fstest auto quick rw encrypt compress fiemap
>  
>  . ./common/filter
>  . ./common/f2fs
> diff --git a/tests/generic/009 b/tests/generic/009
> index 3b362943..7c9b137f 100755
> --- a/tests/generic/009
> +++ b/tests/generic/009
> @@ -7,7 +7,7 @@
>  # Test fallocate FALLOC_FL_ZERO_RANGE
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc zero
> +_begin_fstest auto quick prealloc zero fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/012 b/tests/generic/012
> index 4b3c69f4..74e7a02b 100755
> --- a/tests/generic/012
> +++ b/tests/generic/012
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch collapse
> +_begin_fstest auto quick prealloc punch collapse fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/016 b/tests/generic/016
> index 59cb8085..833e9161 100755
> --- a/tests/generic/016
> +++ b/tests/generic/016
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch collapse
> +_begin_fstest auto quick prealloc punch collapse fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/017 b/tests/generic/017
> index 12c486d1..5f0d8513 100755
> --- a/tests/generic/017
> +++ b/tests/generic/017
> @@ -10,7 +10,7 @@
>  # Also check for file system consistency after completing this operation
>  # for each blocksize.
>  . ./common/preamble
> -_begin_fstest auto prealloc collapse
> +_begin_fstest auto prealloc collapse fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/021 b/tests/generic/021
> index 7407bf03..532feeeb 100755
> --- a/tests/generic/021
> +++ b/tests/generic/021
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch collapse
> +_begin_fstest auto quick prealloc punch collapse fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/022 b/tests/generic/022
> index b983c5d0..62577b81 100755
> --- a/tests/generic/022
> +++ b/tests/generic/022
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch collapse
> +_begin_fstest auto quick prealloc punch collapse fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/032 b/tests/generic/032
> index 3302c1ee..90ff0773 100755
> --- a/tests/generic/032
> +++ b/tests/generic/032
> @@ -11,7 +11,7 @@
>  # are always read back as zeroes.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw
> +_begin_fstest auto quick rw fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/043 b/tests/generic/043
> index b1432e25..d5ca438a 100755
> --- a/tests/generic/043
> +++ b/tests/generic/043
> @@ -7,7 +7,7 @@
>  # Test for NULL files problem
>  #
>  . ./common/preamble
> -_begin_fstest shutdown metadata log auto
> +_begin_fstest shutdown metadata log auto fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/044 b/tests/generic/044
> index 56c50548..a5d3e9ed 100755
> --- a/tests/generic/044
> +++ b/tests/generic/044
> @@ -7,7 +7,7 @@
>  # Test for NULL files problem
>  #
>  . ./common/preamble
> -_begin_fstest shutdown metadata log auto
> +_begin_fstest shutdown metadata log auto fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/045 b/tests/generic/045
> index f5f36a7a..dfbcaeb4 100755
> --- a/tests/generic/045
> +++ b/tests/generic/045
> @@ -7,7 +7,7 @@
>  # Test for NULL files problem
>  #
>  . ./common/preamble
> -_begin_fstest shutdown metadata log auto
> +_begin_fstest shutdown metadata log auto fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/046 b/tests/generic/046
> index 5dbb8fa5..29165e45 100755
> --- a/tests/generic/046
> +++ b/tests/generic/046
> @@ -7,7 +7,7 @@
>  # Test for NULL files problem
>  #
>  . ./common/preamble
> -_begin_fstest shutdown metadata log auto
> +_begin_fstest shutdown metadata log auto fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/047 b/tests/generic/047
> index 770e7f1b..61590e9b 100755
> --- a/tests/generic/047
> +++ b/tests/generic/047
> @@ -8,7 +8,7 @@
>  # test inode size is on disk after fsync
>  #
>  . ./common/preamble
> -_begin_fstest shutdown metadata rw auto
> +_begin_fstest shutdown metadata rw auto fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/048 b/tests/generic/048
> index 10c87f3b..ebe9132e 100755
> --- a/tests/generic/048
> +++ b/tests/generic/048
> @@ -8,7 +8,7 @@
>  # test inode size is on disk after sync
>  #
>  . ./common/preamble
> -_begin_fstest shutdown metadata rw auto
> +_begin_fstest shutdown metadata rw auto fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/049 b/tests/generic/049
> index 4effc4a6..e5c5a0e3 100755
> --- a/tests/generic/049
> +++ b/tests/generic/049
> @@ -8,7 +8,7 @@
>  # test inode size is on disk after sync - expose log replay bug
>  #
>  . ./common/preamble
> -_begin_fstest shutdown metadata rw auto
> +_begin_fstest shutdown metadata rw auto fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/058 b/tests/generic/058
> index cb685ffb..dddadbe0 100755
> --- a/tests/generic/058
> +++ b/tests/generic/058
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch insert
> +_begin_fstest auto quick prealloc punch insert fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/060 b/tests/generic/060
> index 0fd42785..3a890ed0 100755
> --- a/tests/generic/060
> +++ b/tests/generic/060
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch insert
> +_begin_fstest auto quick prealloc punch insert fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/061 b/tests/generic/061
> index c4998b93..e370ffdf 100755
> --- a/tests/generic/061
> +++ b/tests/generic/061
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch insert
> +_begin_fstest auto quick prealloc punch insert fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/063 b/tests/generic/063
> index 60a5f242..3974647b 100755
> --- a/tests/generic/063
> +++ b/tests/generic/063
> @@ -11,7 +11,7 @@
>  # For the type of tests, check the description of _test_generic_punch
>  # in common/rc.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch insert
> +_begin_fstest auto quick prealloc punch insert fiemap
>  
>  # Import common functions.
>  # we need to include common/punch to get defination fo filter functions
> diff --git a/tests/generic/064 b/tests/generic/064
> index 3b32fa1b..b50c55e7 100755
> --- a/tests/generic/064
> +++ b/tests/generic/064
> @@ -10,7 +10,7 @@
>  # on the previously inserted ranges to test merge code of collapse
>  # range. Also check for data integrity and file system consistency.
>  . ./common/preamble
> -_begin_fstest auto quick prealloc collapse insert
> +_begin_fstest auto quick prealloc collapse insert fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/092 b/tests/generic/092
> index 505e0ec8..8fefcb85 100755
> --- a/tests/generic/092
> +++ b/tests/generic/092
> @@ -12,7 +12,7 @@
>  # preallocated space.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc
> +_begin_fstest auto quick prealloc fiemap
>  
>  status=0	# success is the default!
>  
> diff --git a/tests/generic/094 b/tests/generic/094
> index 7a078a88..5c12b731 100755
> --- a/tests/generic/094
> +++ b/tests/generic/094
> @@ -7,7 +7,7 @@
>  # Run the fiemap (file extent mapping) tester with preallocation enabled
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc
> +_begin_fstest auto quick prealloc fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/110 b/tests/generic/110
> index 5d6d6ecb..ef5ac5f6 100755
> --- a/tests/generic/110
> +++ b/tests/generic/110
> @@ -11,7 +11,7 @@
>  #   - Modify the reflinked file
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/111 b/tests/generic/111
> index 3e376096..5df0fa80 100755
> --- a/tests/generic/111
> +++ b/tests/generic/111
> @@ -12,7 +12,7 @@
>  #   - Modify one of the copies
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/115 b/tests/generic/115
> index daaca523..13d4b537 100755
> --- a/tests/generic/115
> +++ b/tests/generic/115
> @@ -10,7 +10,7 @@
>  #   - Delete the original (moved) file, check that the copy still exists.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/177 b/tests/generic/177
> index 8ad3f966..ff55a79f 100755
> --- a/tests/generic/177
> +++ b/tests/generic/177
> @@ -11,7 +11,7 @@
>  # This test is motivated by a bug found in btrfs.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc metadata punch log
> +_begin_fstest auto quick prealloc metadata punch log fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/225 b/tests/generic/225
> index 26156c9b..d9638299 100755
> --- a/tests/generic/225
> +++ b/tests/generic/225
> @@ -7,7 +7,7 @@
>  # Run the fiemap (file extent mapping) tester
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/255 b/tests/generic/255
> index 307d5287..39efb6b2 100755
> --- a/tests/generic/255
> +++ b/tests/generic/255
> @@ -7,7 +7,7 @@
>  # Test Generic fallocate hole punching
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch
> +_begin_fstest auto quick prealloc punch fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/301 b/tests/generic/301
> index faf982f5..3f895ff8 100755
> --- a/tests/generic/301
> +++ b/tests/generic/301
> @@ -10,7 +10,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/302 b/tests/generic/302
> index 01177602..9c305abe 100755
> --- a/tests/generic/302
> +++ b/tests/generic/302
> @@ -10,7 +10,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/305 b/tests/generic/305
> index 3b0ff698..b46d5127 100755
> --- a/tests/generic/305
> +++ b/tests/generic/305
> @@ -8,7 +8,7 @@
>  # charged for buffered copy on write.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/316 b/tests/generic/316
> index 5bc9c1d9..5b890126 100755
> --- a/tests/generic/316
> +++ b/tests/generic/316
> @@ -7,7 +7,7 @@
>  # Test Generic fallocate hole punching w/o unwritten extent
>  #
>  . ./common/preamble
> -_begin_fstest auto quick punch
> +_begin_fstest auto quick punch fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/326 b/tests/generic/326
> index 3e9332ac..f5c557b3 100755
> --- a/tests/generic/326
> +++ b/tests/generic/326
> @@ -8,7 +8,7 @@
>  # charged for directio copy on write.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/327 b/tests/generic/327
> index 95a22461..92540b19 100755
> --- a/tests/generic/327
> +++ b/tests/generic/327
> @@ -7,7 +7,7 @@
>  # Ensure that we can't go over the hard block limit when reflinking.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/328 b/tests/generic/328
> index 2b589211..db7fd3db 100755
> --- a/tests/generic/328
> +++ b/tests/generic/328
> @@ -7,7 +7,7 @@
>  # Ensure that we can't go over the hard block limit when CoWing a file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/352 b/tests/generic/352
> index 608c6c81..52ec4850 100755
> --- a/tests/generic/352
> +++ b/tests/generic/352
> @@ -11,7 +11,7 @@
>  # Which btrfs will soft lock up and return wrong shared flag.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone
> +_begin_fstest auto clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/353 b/tests/generic/353
> index 1ce6ce6d..9a1471bd 100755
> --- a/tests/generic/353
> +++ b/tests/generic/353
> @@ -12,7 +12,7 @@
>  # This caused SHARED flag only occurs after sync.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/372 b/tests/generic/372
> index b649f590..ca50ae39 100755
> --- a/tests/generic/372
> +++ b/tests/generic/372
> @@ -7,7 +7,7 @@
>  # Check that bmap/fiemap accurately report shared extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/generic/414 b/tests/generic/414
> index 6416216d..f2d63c17 100755
> --- a/tests/generic/414
> +++ b/tests/generic/414
> @@ -8,7 +8,7 @@
>  # block mapping extent.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/generic/425 b/tests/generic/425
> index 13a76563..b43294f9 100755
> --- a/tests/generic/425
> +++ b/tests/generic/425
> @@ -8,7 +8,7 @@
>  # block to hold extended attributes.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick attr
> +_begin_fstest auto quick attr fiemap
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/generic/473 b/tests/generic/473
> index 89241770..125b9518 100755
> --- a/tests/generic/473
> +++ b/tests/generic/473
> @@ -9,7 +9,7 @@
>  # Also the test used 16k holes to be compatible with 16k block filesystems
>  #
>  . ./common/preamble
> -_begin_fstest broken
> +_begin_fstest broken fiemap
>  
>  # Import common functions.
>  . ./common/punch
> diff --git a/tests/generic/483 b/tests/generic/483
> index 39129542..8a8a6f24 100755
> --- a/tests/generic/483
> +++ b/tests/generic/483
> @@ -8,7 +8,7 @@
>  # are placed beyond a file's size.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick log metadata
> +_begin_fstest auto quick log metadata fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/516 b/tests/generic/516
> index e846ee24..47af6237 100755
> --- a/tests/generic/516
> +++ b/tests/generic/516
> @@ -9,7 +9,7 @@
>  #   - Check that nothing changes in either file
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dedupe clone
> +_begin_fstest auto quick dedupe clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/519 b/tests/generic/519
> index 28747c21..0839c6b8 100755
> --- a/tests/generic/519
> +++ b/tests/generic/519
> @@ -8,7 +8,7 @@
>  # 79b3dbe4adb3 fs: fix iomap_bmap position calculation
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/540 b/tests/generic/540
> index da36939a..8c66b572 100755
> --- a/tests/generic/540
> +++ b/tests/generic/540
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/541 b/tests/generic/541
> index a0f6cae3..227c45e1 100755
> --- a/tests/generic/541
> +++ b/tests/generic/541
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/542 b/tests/generic/542
> index 530fb8e0..7b413d6d 100755
> --- a/tests/generic/542
> +++ b/tests/generic/542
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/543 b/tests/generic/543
> index 1dad37fb..66f46e92 100755
> --- a/tests/generic/543
> +++ b/tests/generic/543
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/578 b/tests/generic/578
> index d04cacb4..b024f6ff 100755
> --- a/tests/generic/578
> +++ b/tests/generic/578
> @@ -7,7 +7,7 @@
>  # Make sure that we can handle multiple mmap writers to the same file.
>  
>  . ./common/preamble
> -_begin_fstest auto quick rw clone
> +_begin_fstest auto quick rw clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/654 b/tests/generic/654
> index da7eaf4d..45ed19de 100755
> --- a/tests/generic/654
> +++ b/tests/generic/654
> @@ -10,7 +10,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/655 b/tests/generic/655
> index ec8366e3..8106d15c 100755
> --- a/tests/generic/655
> +++ b/tests/generic/655
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/677 b/tests/generic/677
> index 4dbfed7d..84146c5e 100755
> --- a/tests/generic/677
> +++ b/tests/generic/677
> @@ -9,7 +9,7 @@
>  # after we mount the filesystem.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick log prealloc
> +_begin_fstest auto quick log prealloc fiemap
>  
>  _cleanup()
>  {
> diff --git a/tests/generic/679 b/tests/generic/679
> index a0094e48..ddf975a2 100755
> --- a/tests/generic/679
> +++ b/tests/generic/679
> @@ -9,7 +9,7 @@
>  # space to allocate extents for the holes.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc
> +_begin_fstest auto quick prealloc fiemap
>  
>  . ./common/filter
>  . ./common/punch
> diff --git a/tests/generic/695 b/tests/generic/695
> index b46e35cf..d53457dc 100755
> --- a/tests/generic/695
> +++ b/tests/generic/695
> @@ -12,7 +12,7 @@
>  # btrfs-progs 5.15).
>  #
>  . ./common/preamble
> -_begin_fstest auto quick log punch
> +_begin_fstest auto quick log punch fiemap
>  
>  _cleanup()
>  {
> diff --git a/tests/overlay/066 b/tests/overlay/066
> index 163e74f1..5b9f7b18 100755
> --- a/tests/overlay/066
> +++ b/tests/overlay/066
> @@ -8,7 +8,7 @@
>  # Test overlayfs copy-up function for variant sparse files.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick copyup
> +_begin_fstest auto quick copyup fiemap
>  
>  # Import common functions..
>  . ./common/filter
> diff --git a/tests/shared/298 b/tests/shared/298
> index bd52b6a0..807d4c87 100755
> --- a/tests/shared/298
> +++ b/tests/shared/298
> @@ -7,7 +7,7 @@
>  # Test that filesystem sends discard requests only on free blocks
>  #
>  . ./common/preamble
> -_begin_fstest auto trim
> +_begin_fstest auto trim fiemap
>  
>  _supported_fs ext4 xfs btrfs
>  _require_test
> diff --git a/tests/xfs/180 b/tests/xfs/180
> index 9b52f1ff..cfea2020 100755
> --- a/tests/xfs/180
> +++ b/tests/xfs/180
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/182 b/tests/xfs/182
> index 93852229..ec3f7dc0 100755
> --- a/tests/xfs/182
> +++ b/tests/xfs/182
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/184 b/tests/xfs/184
> index 2ca6528e..e6f083f0 100755
> --- a/tests/xfs/184
> +++ b/tests/xfs/184
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/192 b/tests/xfs/192
> index 8329604d..a4a33bc7 100755
> --- a/tests/xfs/192
> +++ b/tests/xfs/192
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/193 b/tests/xfs/193
> index 18f2fc2f..c71aef35 100755
> --- a/tests/xfs/193
> +++ b/tests/xfs/193
> @@ -10,7 +10,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/198 b/tests/xfs/198
> index 231e1c23..c61fbab7 100755
> --- a/tests/xfs/198
> +++ b/tests/xfs/198
> @@ -10,7 +10,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/200 b/tests/xfs/200
> index 435cd9b9..eb0121e3 100755
> --- a/tests/xfs/200
> +++ b/tests/xfs/200
> @@ -13,7 +13,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/204 b/tests/xfs/204
> index 3f9b6dca..c62ad980 100755
> --- a/tests/xfs/204
> +++ b/tests/xfs/204
> @@ -13,7 +13,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/207 b/tests/xfs/207
> index ba07f1ee..4bdafd26 100755
> --- a/tests/xfs/207
> +++ b/tests/xfs/207
> @@ -10,7 +10,7 @@
>  # - Ensure that whatever we set we get back later.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/208 b/tests/xfs/208
> index 0fbb99c8..9a71b74f 100755
> --- a/tests/xfs/208
> +++ b/tests/xfs/208
> @@ -14,7 +14,7 @@
>  # - Repeat, but with extsz = 1MB and cowextsz = $blocksize.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/209 b/tests/xfs/209
> index 08ec87f5..1ef6d33d 100755
> --- a/tests/xfs/209
> +++ b/tests/xfs/209
> @@ -7,7 +7,7 @@
>  # Make sure setting cowextsz on a directory propagates it to subfiles.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/210 b/tests/xfs/210
> index 2439967b..5f05ab26 100755
> --- a/tests/xfs/210
> +++ b/tests/xfs/210
> @@ -11,7 +11,7 @@
>  # otherwise.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/211 b/tests/xfs/211
> index b99871ba..96c0b85b 100755
> --- a/tests/xfs/211
> +++ b/tests/xfs/211
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest clone_stress
> +_begin_fstest clone_stress fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/212 b/tests/xfs/212
> index 805a72af..6df03608 100755
> --- a/tests/xfs/212
> +++ b/tests/xfs/212
> @@ -10,7 +10,7 @@
>  # - Crash the FS to test recovery.
>  #
>  . ./common/preamble
> -_begin_fstest shutdown auto quick clone
> +_begin_fstest shutdown auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/213 b/tests/xfs/213
> index 3e1c45cd..e1849624 100755
> --- a/tests/xfs/213
> +++ b/tests/xfs/213
> @@ -9,7 +9,7 @@
>  # play with cowextsz.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/214 b/tests/xfs/214
> index 7c694e92..84ba838f 100755
> --- a/tests/xfs/214
> +++ b/tests/xfs/214
> @@ -9,7 +9,7 @@
>  # with cowextsz.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/231 b/tests/xfs/231
> index fd7d7a85..de8a7ca9 100755
> --- a/tests/xfs/231
> +++ b/tests/xfs/231
> @@ -12,7 +12,7 @@
>  # - Write more and see how bad fragmentation is.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/232 b/tests/xfs/232
> index 0bf3bb75..5ca1a9f1 100755
> --- a/tests/xfs/232
> +++ b/tests/xfs/232
> @@ -13,7 +13,7 @@
>  # - Write more and see how bad fragmentation is.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/252 b/tests/xfs/252
> index 43740cb4..f167fd5a 100755
> --- a/tests/xfs/252
> +++ b/tests/xfs/252
> @@ -7,7 +7,7 @@
>  # Test fallocate hole punching
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc punch
> +_begin_fstest auto quick prealloc punch fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/344 b/tests/xfs/344
> index f87095bf..230757e4 100755
> --- a/tests/xfs/344
> +++ b/tests/xfs/344
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/345 b/tests/xfs/345
> index 702c6d82..8511e568 100755
> --- a/tests/xfs/345
> +++ b/tests/xfs/345
> @@ -10,7 +10,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/346 b/tests/xfs/346
> index 6d371342..0cbe8ab3 100755
> --- a/tests/xfs/346
> +++ b/tests/xfs/346
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/347 b/tests/xfs/347
> index 86f405b5..e5a2dcd4 100755
> --- a/tests/xfs/347
> +++ b/tests/xfs/347
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone fiemap
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/443 b/tests/xfs/443
> index de28b85b..764c63eb 100755
> --- a/tests/xfs/443
> +++ b/tests/xfs/443
> @@ -15,7 +15,7 @@
>  # accounting inconsistency.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick ioctl fsr punch
> +_begin_fstest auto quick ioctl fsr punch fiemap
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.35.1
> 

