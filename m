Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1C5AD922
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiIESje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiIESjA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 14:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B7452E56
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662403133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnyZf6CPG33d6IEZ/2P+r8rudXKW0eDqGpbNU/M4g04=;
        b=h+DeLnucXZbCfJ9/6D6PkOnoM858HQwr8+dN19sDJbhwfkelD1B82J+arnr/rYWcNaZKJ8
        9PvcPOzqovVK+mOGGfHRLlU3da+2BIOuo1lVcdmOhKygMeBGIeZVcVnRuvVv+Y78d5P9/J
        QN9l70Lt+NP6lR27kfg8GnZpdsgGQGs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-364-V7pDDUr2O82cCsFLrxiacw-1; Mon, 05 Sep 2022 14:38:52 -0400
X-MC-Unique: V7pDDUr2O82cCsFLrxiacw-1
Received: by mail-qt1-f197.google.com with SMTP id cj19-20020a05622a259300b003446920ea91so7368624qtb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Sep 2022 11:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RnyZf6CPG33d6IEZ/2P+r8rudXKW0eDqGpbNU/M4g04=;
        b=p0DyeXgrpeRSDBL3EAOk7rO8lv7MEbkfzd9QR9WeAle1GNiSABYDlr449qvjD4QCXf
         wPKnAIPrale6vjEyTTAWLwxRPrYTWKgpRERPloo2hw6E+drnQOoqje6rB5CedJknDhrU
         9TmfK8g7TOHaR316h2/IlMcVVfnssAneqW3h7oI2V7bEnPxGyLLFOfU6WrGlnW8S3Jmb
         rzwg+MfXYxZocTwHX06YjMaaSLjfJPlMSNi0sEnUkieSArhmotI91TKyh0ShQXVizYUr
         2YTiE61qbhymkH7ohylCCH2FuO8b161XT6AOauA+ZS8a43VsHCJu68ULdDNtjLMj8wJ5
         QkVg==
X-Gm-Message-State: ACgBeo3xiHWMpH0eDApppdz2IR6YRiiNhkYTourvIf1KJZiGA/RyFRtm
        AXfKBSRq/+m6JJj4aB8KmeEI35vZxYBEfSa9tsfCRzYk7GXuLuqYDwqZjckKlV9U5etksvmix8P
        SPUuROfazkBJsONvn/EivpQU=
X-Received: by 2002:a05:6214:27c3:b0:498:f448:f7fa with SMTP id ge3-20020a05621427c300b00498f448f7famr39113770qvb.18.1662403131421;
        Mon, 05 Sep 2022 11:38:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7TVc9iGarMY6c7MPLarqm3gbaTixNX5AduSXmnjgGHNDQArxA4MgEk4IRDhe7RokN2HSWX8Q==
X-Received: by 2002:a05:6214:27c3:b0:498:f448:f7fa with SMTP id ge3-20020a05621427c300b00498f448f7famr39113752qvb.18.1662403131100;
        Mon, 05 Sep 2022 11:38:51 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 21-20020ac85915000000b00338ae1f5421sm8123947qty.0.2022.09.05.11.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 11:38:50 -0700 (PDT)
Date:   Tue, 6 Sep 2022 02:38:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test that we can not delete a subvolume with
 an active swap file
Message-ID: <20220905183846.zvw36r4gwmtqqicq@zlang-mailbox>
References: <0bc9cd4abfbde3f76b981628942f94631cef7162.1662110839.git.fdmanana@suse.com>
 <20220903004401.xobe5elurx3bkh3f@zlang-mailbox>
 <CAL3q7H6zb9HzEUbHb-mjLEsHo_mQRM15qo101MdHLMCXyzEoXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6zb9HzEUbHb-mjLEsHo_mQRM15qo101MdHLMCXyzEoXg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 10:21:24AM +0100, Filipe Manana wrote:
> On Sat, Sep 3, 2022 at 1:44 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Sep 02, 2022 at 10:30:32AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Verify that we can not delete a subvolume that has an active swap file,
> > > and that after disabling the swap file, we can delete it.
> > >
> > > This tests a fix done by kernel commit 60021bd754c6ca ("btrfs: prevent
> > > subvol with swapfile from being deleted"), which landed in kernel 5.18.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >
> > > V2: Add _cleanup() override to make sure swapfile is disabled in case
> > >     the test is interrupted.
> >
> > Thanks for doing this cleanup, now it's good to me.
> 
> Great.
> Is there any reason why the test wasn't merged in yesterday's update?

Sorry, I forgot to add an 'acked' tag to this patch, after I gave it a RVB. That
caused I missed this patch in last release. It'll be in next release.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> >
> > >
> > >  tests/btrfs/274     | 58 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/274.out |  6 +++++
> > >  2 files changed, 64 insertions(+)
> > >  create mode 100755 tests/btrfs/274
> > >  create mode 100644 tests/btrfs/274.out
> > >
> > > diff --git a/tests/btrfs/274 b/tests/btrfs/274
> > > new file mode 100755
> > > index 00000000..c0594e25
> > > --- /dev/null
> > > +++ b/tests/btrfs/274
> > > @@ -0,0 +1,58 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 274
> > > +#
> > > +# Test that we can not delete a subvolume that has an active swap file.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick swap subvol
> > > +
> > > +_cleanup()
> > > +{
> > > +     cd /
> > > +     rm -f $tmp.*
> > > +     test -n "$swap_file" && swapoff $swap_file &> /dev/null
> > > +}
> > > +
> > > +. ./common/filter
> > > +
> > > +_supported_fs btrfs
> > > +_fixed_by_kernel_commit 60021bd754c6ca \
> > > +    "btrfs: prevent subvol with swapfile from being deleted"
> > > +_require_scratch_swapfile
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +swap_file="$SCRATCH_MNT/subvol/swap"
> > > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
> > > +
> > > +echo "Creating and activating swap file..."
> > > +_format_swapfile $swap_file $(($(get_page_size) * 32)) >> $seqres.full
> > > +_swapon_file $swap_file
> > > +
> > > +echo "Attempting to delete subvolume with swap file enabled..."
> > > +# Output differs with different btrfs-progs versions and some display multiple
> > > +# lines on failure like this for example:
> > > +#
> > > +#   ERROR: Could not destroy subvolume/snapshot: Operation not permitted
> > > +#   WARNING: deletion failed with EPERM, send may be in progress
> > > +#   Delete subvolume (no-commit): '/home/fdmanana/btrfs-tests/scratch_1/subvol'
> > > +#
> > > +# So just redirect all output to the .full file and check the command's exit
> > > +# status instead.
> > > +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 && \
> > > +    echo "subvolume deletion successful, expected failure!"
> > > +
> > > +echo "Disabling swap file..."
> > > +swapoff $swap_file
> > > +
> > > +echo "Attempting to delete subvolume after disabling swap file..."
> > > +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 || \
> > > +   echo "subvolume deletion failure, expected success!"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/274.out b/tests/btrfs/274.out
> > > new file mode 100644
> > > index 00000000..66e0de25
> > > --- /dev/null
> > > +++ b/tests/btrfs/274.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 274
> > > +Create subvolume 'SCRATCH_MNT/subvol'
> > > +Creating and activating swap file...
> > > +Attempting to delete subvolume with swap file enabled...
> > > +Disabling swap file...
> > > +Attempting to delete subvolume after disabling swap file...
> > > --
> > > 2.35.1
> > >
> >
> 

