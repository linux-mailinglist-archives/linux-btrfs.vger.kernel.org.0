Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D952B597FCF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiHRIK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 04:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiHRIKZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 04:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4ED83BE6;
        Thu, 18 Aug 2022 01:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACA096172E;
        Thu, 18 Aug 2022 08:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17633C433D7;
        Thu, 18 Aug 2022 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660810223;
        bh=E1fQfZS5ERKG9i4AQ6XzlstUKAui8XJWz/lA3NQtSyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cixTkJk0gGs8L2PlG5TX+byIG4DJNIpEpjwDK6kfN8cPFw2UU3wfLi7iPG/NfXvys
         MooedvbwcuP4LJcvLgGmQ1PESgCjpZXfSUeebnz0XiKjKL1gjqD0C4ZKxiaKl000CB
         QAeH9BOcCFPsRu2bz5Hl4uRxN9kAkoQikHkGrnQg2AbvQqkk6g3hlJnjvmAmhsN7E6
         AfOhf6Rx3TJlUiFML4/yqK0bfFUdexFzDJQHhgfLHA8xAlo99nlOHbsB/UwHnrASgN
         qWRox7iGJyVCSBbu30PXPYDv9SerpWASjB2KYzL22SKXWaxNXm7miL8t3rcBVhcX3v
         2liUnCHekmT/g==
Received: by mail-ej1-f44.google.com with SMTP id dc19so1799780ejb.12;
        Thu, 18 Aug 2022 01:10:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo0BNE7UqbT3TKNzuew4b1sZyE5tXTrCE5FJsvqehdJG8QOHoqb4
        XYO51cQaPRmalmisCKpm+QYCUh3MpSg29xqViDw=
X-Google-Smtp-Source: AA6agR5TlQdExmmgc7kImRMYtA/RLYZOkVIRnG2EN+Ne9bWc3Bn0/05bX4VM1jHZEcsvgNSlvqcY3Nm3h6rYWQ6dLi8=
X-Received: by 2002:a17:907:6d8b:b0:730:c160:1f9c with SMTP id
 sb11-20020a1709076d8b00b00730c1601f9cmr1226091ejc.342.1660810221229; Thu, 18
 Aug 2022 01:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220816214051.wsw75y3mtjdsim6w@fiona> <143a26d6-9237-b745-ece6-ce37dc7dca9a@oracle.com>
In-Reply-To: <143a26d6-9237-b745-ece6-ce37dc7dca9a@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 18 Aug 2022 09:09:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H46y85Y4K14ud0Hv8bGS+6ikuRTj84CNYzg=hJwDSA95Q@mail.gmail.com>
Message-ID: <CAL3q7H46y85Y4K14ud0Hv8bGS+6ikuRTj84CNYzg=hJwDSA95Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Test xattr changes for read-only btrfs property
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 18, 2022 at 4:08 AM Anand Jain <anand.jain@oracle.com> wrote:
>
>
>
>
> On 8/17/22 05:40, Goldwyn Rodrigues wrote:
> > Test creation, modification and deletion of xattr for a BTRFS filesystem
> > which has the read-only property set to true.
> >
> > Re-test the same after BTRFS read-only property is set to false.
> >
> > This tests the bug for "security.*" modifications which escape
> > xattr_permission(), because security parameters are let through
> > in xattr_permission(), without checks from
> > inode_permission()->btrfs_permission(). There is no restriction on
> > security.* from VFS and decision is left to the underlying filesystem.
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > diff --git a/tests/btrfs/273 b/tests/btrfs/273
> > new file mode 100755
> > index 00000000..ec7d264d
> > --- /dev/null
> > +++ b/tests/btrfs/273
> > @@ -0,0 +1,78 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test No. 273
> > +#
> > +# Test that no xattr can be changed once btrfs property is set to RO
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick attr
> > +
> > +# Import common functions.
> > +#. ./common/filter
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_attrs
> > +_require_btrfs_command "property"
> > +_require_scratch
> > +
> > +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +FILENAME=$SCRATCH_MNT/foo
> > +
> > +set_xattr() {
> > +     local value=$1
> > +     $SETFATTR_PROG -n "user.one" -v $value $FILENAME
> > +     $SETFATTR_PROG -n "security.one" -v $value $FILENAME
> > +     $SETFATTR_PROG -n "trusted.one" -v $value $FILENAME
> > +}
> > +
> > +get_xattr() {
> > +     $GETFATTR_PROG -n "user.one" $FILENAME
> > +     $GETFATTR_PROG -n "security.one" $FILENAME
> > +     $GETFATTR_PROG -n "trusted.one" $FILENAME
> > +}
> > +
> > +del_xattr() {
> > +     $SETFATTR_PROG -x "user.one" $FILENAME
> > +     $SETFATTR_PROG -x "security.one" $FILENAME
> > +     $SETFATTR_PROG -x "trusted.one" $FILENAME
> > +}
> > +
>
> This output contains mnt references that need to be filtered.
> Filter _filter_scratch should help.

That was already pointed out in my previous review, wasn't it?

>
>
>
> > +# Create a test file.
> > +echo "hello world" > $FILENAME
> > +
> > +set_xattr 1
> > +
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro true
> > +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> > +
> > +# Attempt to change values of RO (property) filesystem
> > +set_xattr 2
> > +
> > +# Check the values of RO (property) filesystem is not changed
> > +get_xattr
> > +
> > +# Attempt to remove xattr from RO (property) filesystem
> > +del_xattr
> > +
> > +# Change filesystem property RO to false
> > +
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
> > +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> > +
> > +# Change the xattrs after RO is false
>
> > +set_xattr 2
> > +
>
>   Nit:  We are reusing the value "2" and changing it to "3"  makes it
>   unique and so the debugging easier.

That's a good idea.

>
>
> > +# Get the changed values
> > +get_xattr
> > +
> > +# Remove xattr
> > +del_xattr
> > +
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/273.out b/tests/btrfs/273.out
> > new file mode 100644
> > index 00000000..f6fca029
> > --- /dev/null
> > +++ b/tests/btrfs/273.out
> > @@ -0,0 +1,33 @@
> > +QA output created by 273
> > +ro=true
> > +setfattr: /scratch/foo: Read-only file system
> > +setfattr: /scratch/foo: Read-only file system
> > +setfattr: /scratch/foo: Read-only file system
> > +getfattr: Removing leading '/' from absolute path names
> > +# file: scratch/foo
> > +user.one="1"
> > +
> > +getfattr: Removing leading '/' from absolute path names
> > +# file: scratch/foo
> > +security.one="1"
> > +
> > +getfattr: Removing leading '/' from absolute path names
> > +# file: scratch/foo
> > +trusted.one="1"
> > +
> > +setfattr: /scratch/foo: Read-only file system
> > +setfattr: /scratch/foo: Read-only file system
> > +setfattr: /scratch/foo: Read-only file system
> > +ro=false
> > +getfattr: Removing leading '/' from absolute path names
> > +# file: scratch/foo
> > +user.one="2"
> > +
> > +getfattr: Removing leading '/' from absolute path names
> > +# file: scratch/foo
> > +security.one="2"
> > +
> > +getfattr: Removing leading '/' from absolute path names
> > +# file: scratch/foo
> > +trusted.one="2"
>
>
> > +
>
> Nit: A whitespace.

It's needed, getfattr prints a blank line at the end.

>
> Thanks.
>
>
