Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6E61441A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 06:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiKAFLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 01:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFLD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 01:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC42BF0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 22:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667279411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BIEernCcUEUHxoRDrcTv/IwlIxa7IWjUn0SfzmFL7U=;
        b=MgYVvQh33pSswGCkyDe16zjL8K5lF8dyHfadpMqkWlg4yGVJ6mecrBiApcbeXsMdhfcvIF
        ZrPSO7chLHvz68AjAkfC15iXPdD5kqN+c1SwaKvVCPa6z4+Xn2R+FgsKvt0ct0h9h1v1ER
        IHK+C0pRqZOJwhnIth6oAOyz8ozieYg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-tlD4yhf_MlqsaafF21hk9g-1; Tue, 01 Nov 2022 01:10:10 -0400
X-MC-Unique: tlD4yhf_MlqsaafF21hk9g-1
Received: by mail-pg1-f199.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so7183951pgl.8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 22:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BIEernCcUEUHxoRDrcTv/IwlIxa7IWjUn0SfzmFL7U=;
        b=VUYgGDV6a5iL+gqIRuEwkDFysA3vWCERdyqbYYBbGz7tZIBWtWv9IF3+ZJOKzgtbke
         pdyDgf8MvQ5wNg+ojLItVLVjExum+WWWxq6mmEeK0jF9nD9dhnKjx0dxwYqCOMxiSGF9
         4jpliw4q+5vHk7XkO5vKh0xaC+6t0fd+4J8Ql4mlWjfn+5z6211/+x814xooEI/8XNDU
         h/XYie+gYaOPnuME2pciHT+Ny88xQCdIpVC2VUxAMyJICz3nMnBf/qIjFiKf7zVhuzdE
         3bJdsxvfOio7LMAHFp4idQDpUhhOwwCl/Px4XwNd11CXqSynIxyqCBJ7n+HhY5M8SLBr
         Rlqw==
X-Gm-Message-State: ACrzQf3oXRSCfLXYzVdNO9sZGHpqxcMD5P0rv1n1F9Sval0cf3q6+o2z
        RdbwWr4KNXJoPW7Z9hyVNNSA4WdLJ6KdYt3UKJscpRkgKBGqj5TcEeimCA45XiGXUb/iDXmhVkr
        qH+4eGdFCrAHSu85D3rZuCpA=
X-Received: by 2002:a05:6a00:cc6:b0:56d:3028:23ea with SMTP id b6-20020a056a000cc600b0056d302823eamr14308255pfv.19.1667279409292;
        Mon, 31 Oct 2022 22:10:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63Vb4HN/mWSwTqzSx++rM6d4YezYnOVjIezkCbIeSTIbxrx6dCPnYVoFTvCBxqcUqSTQSZBw==
X-Received: by 2002:a05:6a00:cc6:b0:56d:3028:23ea with SMTP id b6-20020a056a000cc600b0056d302823eamr14308228pfv.19.1667279408906;
        Mon, 31 Oct 2022 22:10:08 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g17-20020aa79f11000000b0056b8e788acesm2212909pfr.82.2022.10.31.22.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:10:08 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:10:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/3] btrfs: test that fiemap reports extent as not shared
 after deleting file
Message-ID: <20221101051003.wl37x6jxiuiphkr5@zlang-mailbox>
References: <cover.1667214081.git.fdmanana@suse.com>
 <27a0c4ab551b7a7410f4062f5235f20c88e77cfc.1667214081.git.fdmanana@suse.com>
 <20221031164128.z4cujrkrcxe6ujqr@zlang-mailbox>
 <CAL3q7H73zCMQgJ9VTneZ7rX9Z8qVTFojsuEVU5OhZw37StU_Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H73zCMQgJ9VTneZ7rX9Z8qVTFojsuEVU5OhZw37StU_Ww@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 04:51:06PM +0000, Filipe Manana wrote:
> On Mon, Oct 31, 2022 at 4:41 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Mon, Oct 31, 2022 at 11:11:20AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that if we have two files with shared extents, after removing one of
> > > the files, if we do a fiemap against the other file, it does not report
> > > extents as shared anymore.
> > >
> > > This exercises the processing of delayed references for data extents in
> > > the backref walking code, used by fiemap to determine if an extent is
> > > shared.
> > >
> > > This used to fail until very recently and was fixed by the following
> > > kernel commit that landed in 6.1-rc2:
> > >
> > >   4fc7b5722824 (""btrfs: fix processing of delayed data refs during backref walking")
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> >
> > Looks good to me. As this's not a genericcase, I'm not sure if you need
> > _require_congruent_file_oplen helper.
> 
> Hum? Why would it be needed?
> That helper was introduced because of xfs's realtime config.
> On btrfs reflinking always works for any multiple of the sector size.

Sure, I was not asking you to use that, as it's not a generic case, so I just
tried to double check with you, to make sure btrfs doesn't need it. Thanks
for you confirm that, this patchset looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> >
> > Thanks,
> > Zorro
> >
> > >  tests/btrfs/279     | 82 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/279.out | 39 +++++++++++++++++++++
> > >  2 files changed, 121 insertions(+)
> > >  create mode 100755 tests/btrfs/279
> > >  create mode 100644 tests/btrfs/279.out
> > >
> > > diff --git a/tests/btrfs/279 b/tests/btrfs/279
> > > new file mode 100755
> > > index 00000000..5b5824fd
> > > --- /dev/null
> > > +++ b/tests/btrfs/279
> > > @@ -0,0 +1,82 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 279
> > > +#
> > > +# Test that if we have two files with shared extents, after removing one of the
> > > +# files, if we do a fiemap against the other file, it does not report extents as
> > > +# shared anymore.
> > > +#
> > > +# This exercises the processing of delayed references for data extents in the
> > > +# backref walking code, used by fiemap to determine if an extent is shared.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick subvol fiemap clone
> > > +
> > > +. ./common/filter
> > > +. ./common/reflink
> > > +. ./common/punch # for _filter_fiemap_flags
> > > +
> > > +_supported_fs btrfs
> > > +_require_scratch_reflink
> > > +_require_cp_reflink
> > > +_require_xfs_io_command "fiemap"
> > > +
> > > +_fixed_by_kernel_commit 4fc7b5722824 \
> > > +     "btrfs: fix processing of delayed data refs during backref walking"
> > > +
> > > +run_test()
> > > +{
> > > +     local file_path_1=$1
> > > +     local file_path_2=$2
> > > +     local do_sync=$3
> > > +
> > > +     $XFS_IO_PROG -f -c "pwrite 0 64K" $file_path_1 | _filter_xfs_io
> > > +     _cp_reflink $file_path_1 $file_path_2
> > > +
> > > +     if [ $do_sync -eq 1 ]; then
> > > +             sync
> > > +     fi
> > > +
> > > +     echo "Fiemap of $file_path_1 before deleting $file_path_2:" | \
> > > +             _filter_scratch
> > > +     $XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
> > > +
> > > +     rm -f $file_path_2
> > > +
> > > +     echo "Fiemap of $file_path_1 after deleting $file_path_2:" | \
> > > +             _filter_scratch
> > > +     $XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
> > > +}
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +# Create two test subvolumes, we'll reflink files between them.
> > > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 | _filter_scratch
> > > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv2 | _filter_scratch
> > > +
> > > +echo
> > > +echo "Testing with same subvolume and without transaction commit"
> > > +echo
> > > +run_test "$SCRATCH_MNT/subv1/f1" "$SCRATCH_MNT/subv1/f2" 0
> > > +
> > > +echo
> > > +echo "Testing with same subvolume and with transaction commit"
> > > +echo
> > > +run_test "$SCRATCH_MNT/subv1/f3" "$SCRATCH_MNT/subv1/f4" 1
> > > +
> > > +echo
> > > +echo "Testing with different subvolumes and without transaction commit"
> > > +echo
> > > +run_test "$SCRATCH_MNT/subv1/f5" "$SCRATCH_MNT/subv2/f6" 0
> > > +
> > > +echo
> > > +echo "Testing with different subvolumes and with transaction commit"
> > > +echo
> > > +run_test "$SCRATCH_MNT/subv1/f7" "$SCRATCH_MNT/subv2/f8" 1
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
> > > new file mode 100644
> > > index 00000000..a959a86d
> > > --- /dev/null
> > > +++ b/tests/btrfs/279.out
> > > @@ -0,0 +1,39 @@
> > > +QA output created by 279
> > > +Create subvolume 'SCRATCH_MNT/subv1'
> > > +Create subvolume 'SCRATCH_MNT/subv2'
> > > +
> > > +Testing with same subvolume and without transaction commit
> > > +
> > > +wrote 65536/65536 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +Fiemap of SCRATCH_MNT/subv1/f1 before deleting SCRATCH_MNT/subv1/f2:
> > > +0: [0..127]: shared|last
> > > +Fiemap of SCRATCH_MNT/subv1/f1 after deleting SCRATCH_MNT/subv1/f2:
> > > +0: [0..127]: last
> > > +
> > > +Testing with same subvolume and with transaction commit
> > > +
> > > +wrote 65536/65536 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +Fiemap of SCRATCH_MNT/subv1/f3 before deleting SCRATCH_MNT/subv1/f4:
> > > +0: [0..127]: shared|last
> > > +Fiemap of SCRATCH_MNT/subv1/f3 after deleting SCRATCH_MNT/subv1/f4:
> > > +0: [0..127]: last
> > > +
> > > +Testing with different subvolumes and without transaction commit
> > > +
> > > +wrote 65536/65536 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +Fiemap of SCRATCH_MNT/subv1/f5 before deleting SCRATCH_MNT/subv2/f6:
> > > +0: [0..127]: shared|last
> > > +Fiemap of SCRATCH_MNT/subv1/f5 after deleting SCRATCH_MNT/subv2/f6:
> > > +0: [0..127]: last
> > > +
> > > +Testing with different subvolumes and with transaction commit
> > > +
> > > +wrote 65536/65536 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +Fiemap of SCRATCH_MNT/subv1/f7 before deleting SCRATCH_MNT/subv2/f8:
> > > +0: [0..127]: shared|last
> > > +Fiemap of SCRATCH_MNT/subv1/f7 after deleting SCRATCH_MNT/subv2/f8:
> > > +0: [0..127]: last
> > > --
> > > 2.35.1
> > >
> >
> 

