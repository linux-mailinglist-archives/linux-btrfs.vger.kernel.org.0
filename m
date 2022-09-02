Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706685AA5B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 04:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiIBCYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 22:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiIBCXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 22:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6810AE846
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 19:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662085273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y11GUVPM7Abq1rbjL02OSZAcs7zhPBTB8dZID+BKISI=;
        b=RHDoJsegdRU5VPqE7y/CA32S7lkUtMuGsUHbpyz+rj9YM02/l2vL7JrnOSlxV7rEJxVs17
        /iuAdZ00M8LXz60YeADjy5i8KkhsJcq9aen28qiqLunzYMkUTlPX7m5mMdSLTtNC2UAUYc
        42CmeIvT4ndRM8LfTQYKifhjufwE268=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-JbN-fW6oO12zhptSCKYpGA-1; Thu, 01 Sep 2022 22:21:12 -0400
X-MC-Unique: JbN-fW6oO12zhptSCKYpGA-1
Received: by mail-qk1-f199.google.com with SMTP id x22-20020a05620a259600b006b552a69231so838885qko.18
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 19:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=y11GUVPM7Abq1rbjL02OSZAcs7zhPBTB8dZID+BKISI=;
        b=vtiD5umrW4GhhfRUjoqhVQGC6VBJQ0V373UeYS6pJ6UsYS7glypoH3BUj7m+MaYY8J
         MDZXVgpZF5gSz0ejmYUFQKzHfTHZCySKo+Txh9Qt4k/7WTYO5tVa/FUOWn7b4ThLh8we
         15laU3+PPb4NSf5Vs22LcnmtW3YcUghYse3Yu6Ur7qm2QB6surLGU0gm4iPvbBC6Wb7z
         C2LvOiVoFYpUpOUog8bsyPPAMuoSoSi1iQRUI1ofgpF03JsHg2/1SwknF78kCaTYJzOh
         d8oM7Suaxw0War/SZ70fO0E+KTg2qRV76/12nDB/DDJ54mfH/z5I3KFwgHXpWfR3Z5Ja
         /JNg==
X-Gm-Message-State: ACgBeo0ajicfG26utID8FU7uKiZ9JRwcD3gx7yIS5jyRLGT4X21W1iSY
        27USFu5C9STlQ6prBNYM8tmG0vH128fRQip3qdgoiTvQGMdQUEydbJR/O6kEPgIIgsT69A8+B7Q
        xhY6/Mr0TEM0qGYL/enD4sbI=
X-Received: by 2002:ac8:7e94:0:b0:344:7e3a:3daa with SMTP id w20-20020ac87e94000000b003447e3a3daamr25477191qtj.524.1662085272142;
        Thu, 01 Sep 2022 19:21:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6iFHCIxIX6kIaxC4nP0gM08syZUW1MkrTZgN8K+pwCgGL6aonnTmwwnC7ntuYBHUbX5L/D9g==
X-Received: by 2002:ac8:7e94:0:b0:344:7e3a:3daa with SMTP id w20-20020ac87e94000000b003447e3a3daamr25477179qtj.524.1662085271760;
        Thu, 01 Sep 2022 19:21:11 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h13-20020ac8138d000000b00342e86b3bdasm295843qtj.12.2022.09.01.19.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:21:11 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:21:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH v2] btrfs: test security xattr changes for RO btrfs
 property
Message-ID: <20220902022105.lqlp5oxsfmnsmzsx@zlang-mailbox>
References: <20220901191102.zryecg6n635z6p5o@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901191102.zryecg6n635z6p5o@fiona>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:11:02PM -0500, Goldwyn Rodrigues wrote:
> Test creation, modification and deletion of xattr for a BTRFS filesystem
> which has the read-only property set to true.
> 
> Re-test the same after read-only property is set to false.
> 
> This tests the bug for "security.*" modifications which escape
> xattr_permission(), because security parameters are usually let through
> in xattr_permission, without checking
> inode_permission()->btrfs_permission().
> 
> Signed-off-by: Filipe Manana <fdmanana@kernel.org>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/tests/btrfs/275 b/tests/btrfs/275
> new file mode 100755
> index 00000000..f7b10b18
> --- /dev/null
> +++ b/tests/btrfs/275
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 275
> +#
> +# Test that no xattr can be changed once btrfs property is set to RO
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_fixed_by_kernel_commit b51111271b03 \
> +	"btrfs: check if root is readonly while setting security xattr"
> +_require_attrs
> +_require_btrfs_command "property"
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +FILENAME=$SCRATCH_MNT/foo
> +
> +set_xattr() {
> +	local value=$1
> +	$SETFATTR_PROG -n "user.one" -v $value $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -n "security.one" -v $value $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME 2>&1 | _filter_scratch
> +}
> +
> +get_xattr() {
> +	$GETFATTR_PROG --absolute-names -n "user.one" $FILENAME 2>&1 | _filter_scratch
> +	$GETFATTR_PROG --absolute-names -n "security.one" $FILENAME 2>&1 | _filter_scratch
> +	$GETFATTR_PROG --absolute-names -n "trusted.one" $FILENAME 2>&1 | _filter_scratch
> +}

I remember we recommend using _getfattr helper, due to a behavior change between
old and new getfattr.

Thanks,
Zorro

> +
> +del_xattr() {
> +	$SETFATTR_PROG -x "user.one" $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -x "security.one" $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -x "trusted.one" $FILENAME 2>&1 | _filter_scratch
> +}
> +
> +# Create a test file.
> +echo "hello world" > $FILENAME
> +
> +set_xattr 1
> +
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro true
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> +
> +# Attempt to change values of RO (property) filesystem
> +set_xattr 2
> +
> +# Check the values of RO (property) filesystem are not changed
> +get_xattr
> +
> +# Attempt to remove xattr from RO (property) filesystem
> +del_xattr
> +
> +# Check if xattr still exist
> +get_xattr
> +
> +# Change filesystem property RO to false
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> +
> +# Change the xattrs after RO is false
> +set_xattr 2
> +
> +# Get the changed values
> +get_xattr
> +
> +# Remove xattr
> +del_xattr
> +
> +# check if the xattrs are really deleted
> +get_xattr
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/275.out b/tests/btrfs/275.out
> new file mode 100644
> index 00000000..fb8f02f8
> --- /dev/null
> +++ b/tests/btrfs/275.out
> @@ -0,0 +1,39 @@
> +QA output created by 275
> +ro=true
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +# file: SCRATCH_MNT/foo
> +user.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +security.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +trusted.one="1"
> +
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +# file: SCRATCH_MNT/foo
> +user.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +security.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +trusted.one="1"
> +
> +ro=false
> +# file: SCRATCH_MNT/foo
> +user.one="2"
> +
> +# file: SCRATCH_MNT/foo
> +security.one="2"
> +
> +# file: SCRATCH_MNT/foo
> +trusted.one="2"
> +
> +SCRATCH_MNT/foo: user.one: No such attribute
> +SCRATCH_MNT/foo: security.one: No such attribute
> +SCRATCH_MNT/foo: trusted.one: No such attribute
> 
> -- 
> Goldwyn
> 

