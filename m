Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09866804FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 05:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjA3E23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Jan 2023 23:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjA3E21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Jan 2023 23:28:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C14EEF
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 20:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675052858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1+N8E9DtTGxUxYMx3vHzprK1Tc7w6Bsg136Fj7o6fY=;
        b=i7bS9+KtRMpA6p9PsLcn6TtGhtkq5tWP9P0quAvw4KjxR7S7d6Smu9/1Y6LDp970fLlOBq
        bt4EPpTbKXIBzdlLrQpfgz1WDG3zskKRNP63LzJeFH/pwqVBjxommRp3FNLTPxr1oHefQL
        oAWsnzEdm0E6Fs1QjePwPgCCOPuwIEA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-2TLppJnLMUisArUwDck_-Q-1; Sun, 29 Jan 2023 23:27:36 -0500
X-MC-Unique: 2TLppJnLMUisArUwDck_-Q-1
Received: by mail-pf1-f199.google.com with SMTP id k22-20020a056a00169600b00593939d0601so1919555pfc.5
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 20:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1+N8E9DtTGxUxYMx3vHzprK1Tc7w6Bsg136Fj7o6fY=;
        b=cqs4Dj2aL1tFO37tHa1l4qWCpUBdd2v00/iaKRzkI98ZdoIa4sf+vMey5XlMGplpHH
         z4GkqfrAlvEgA+tVnW/wDFrsKdPzpBUOyfTZmdN2iQGJnYoeiHLBBm3JwFpNeoM4Dl04
         63Wd3ePV4ks8I5+2p1pVWcGXOFH+n+VTmVDz2iDhT9Uu9dWJW+KYlLyAit/P4BzdaOTq
         ufJ/WjWrM7KlkwJm+AWf6cHtD+ujT5Z8fbCda/cCx3IeOVvLy50g4kxwPKuNUiH9kW0z
         P0bhqW7XtUNXtSGu1elI7+HvwL2tFKbkzUevsYaSL5Pb5Euut0x40kmiqwvBCZbuBM/9
         bdcA==
X-Gm-Message-State: AO0yUKUe1ezGJlaNCsQN2QxOI72EaDb3pwqYSsdXkuItl/eSi8w0vX8c
        AP5M0qHrnF+gKKR2br4qRBGILSGqKKyPLsOAc0H1H6T8m+KA8sZ73asVWXvzSAUhaARq8YpUi84
        wcat+AeYMFaNYJViLGluITTs=
X-Received: by 2002:a17:902:ec8a:b0:196:b66:eb74 with SMTP id x10-20020a170902ec8a00b001960b66eb74mr8218751plg.57.1675052855539;
        Sun, 29 Jan 2023 20:27:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+1UHhX46+9/icN6HKsDzro9ptZnCFK1SfYX3P1nJcLb4qUvCGllWX6PQM78QS1CENAuw3OeQ==
X-Received: by 2002:a17:902:ec8a:b0:196:b66:eb74 with SMTP id x10-20020a170902ec8a00b001960b66eb74mr8218738plg.57.1675052855209;
        Sun, 29 Jan 2023 20:27:35 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i14-20020a63b30e000000b004790eb3fee1sm5694826pgf.90.2023.01.29.20.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:27:34 -0800 (PST)
Date:   Mon, 30 Jan 2023 12:27:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test send optimal cloning behaviour
Message-ID: <20230130042730.su3k6v6t62i5mcqc@zlang-mailbox>
References: <49e01810eff8d5ddd7d3c99796a66b997faaaf84.1674644814.git.fdmanana@suse.com>
 <20230125132121.7c7be706@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125132121.7c7be706@echidna.fritz.box>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 25, 2023 at 01:21:21PM +0100, David Disseldorp wrote:
> On Wed, 25 Jan 2023 11:07:54 +0000, fdmanana@kernel.org wrote:
> 
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Test that send operations do the best cloning decisions when we have
> > extents that are shared but some files refer to the full extent while
> > others refer to only a section of the extent.
> > 
> > This exercises an optimization that was added to kernel 6.2, by the
> > following commit:
> > 
> >   c7499a64dcf6 ("btrfs: send: optimize clone detection to increase extent sharing")
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/283     | 88 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/283.out | 26 ++++++++++++++
> >  2 files changed, 114 insertions(+)
> >  create mode 100755 tests/btrfs/283
> >  create mode 100644 tests/btrfs/283.out
> > 
> > diff --git a/tests/btrfs/283 b/tests/btrfs/283
> > new file mode 100755
> > index 00000000..c1f6007d
> > --- /dev/null
> > +++ b/tests/btrfs/283
> > @@ -0,0 +1,88 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 283
> > +#
> > +# Test that send operations do the best cloning decisions when we have extents
> > +# that are shared but some files refer to the full extent while others refer to
> > +# only a section of the extent.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send clone fiemap
> > +
> > +. ./common/filter
> > +. ./common/reflink
> > +. ./common/punch # for _filter_fiemap_flags
> > +
> > +_supported_fs btrfs
> > +_require_test
> > +_require_scratch_reflink
> > +_require_cp_reflink
> > +_require_xfs_io_command "fiemap"
> > +_require_fssum
> > +
> > +_wants_kernel_commit c7499a64dcf6 \
> > +	     "btrfs: send: optimize clone detection to increase extent sharing"
> > +
> > +send_files_dir=$TEST_DIR/btrfs-test-$seq
> > +send_stream=$send_files_dir/snap.stream
> > +snap_fssum=$send_files_dir/snap.fssum
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> 
> I'm not sure what the rules are regarding TEST_DIR residuals, but it
> might be worth adding a custom _cleanup() for $send_files_dir .
> Anyhow, looks good as-is.

Thanks for reviewing this patch. The $send_files_dir (and files under it) won't
take big space (maybe < 1M). So I think we can keep it in TEST_DIR, don't need
more changes :)

Thanks,
Zorro

> Reviewed-by: David Disseldorp <ddiss@suse.de>
> 

