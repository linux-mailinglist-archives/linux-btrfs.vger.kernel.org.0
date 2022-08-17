Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F6F596D05
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiHQKwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 06:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiHQKwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 06:52:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A596C77F;
        Wed, 17 Aug 2022 03:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E113B815DF;
        Wed, 17 Aug 2022 10:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA87C433D6;
        Wed, 17 Aug 2022 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660733520;
        bh=KG8xvvbGiZe/TkhMXPD6bsus1SW8j0TgQ/LLNUFBJl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=md2t5MRIZwFZzv5lV6xLWrCGAp1KrXTW+ixASKqAM7Ngn5js/oz7AeF8SEz3JsbiO
         CoVqdiNyE2vmwVsShpRFI2ul5ovo3Aiv/vqaO6iIMBasfCr2nmZJYBi4omBs8uadz4
         L+YArt2pa7X2bu+xfkW3eWPSJ8f6X2taCS8plrpMU5H8uvr/XqU6a8vRvuL94UoHV4
         8nhO6P4YvHpKLZU7LtO/YNkE55qQCrYz29JCshApopiCQtj4p4Tzt23k2Kti18uNch
         4F2HUg+WVAviB2wIMScixXN/aj9TUfTx80j8vvDGUXS0xVxVHjSmnk0dBiteoLq1rT
         gHJzIid7aEmBQ==
Date:   Wed, 17 Aug 2022 11:51:57 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Test xattr changes for read-only btrfs property
Message-ID: <20220817105157.GC2815552@falcondesktop>
References: <20220816214051.wsw75y3mtjdsim6w@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816214051.wsw75y3mtjdsim6w@fiona>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 04:40:51PM -0500, Goldwyn Rodrigues wrote:
> Test creation, modification and deletion of xattr for a BTRFS filesystem
> which has the read-only property set to true.
> 
> Re-test the same after BTRFS read-only property is set to false.
> 
> This tests the bug for "security.*" modifications which escape
> xattr_permission(), because security parameters are let through
> in xattr_permission(), without checks from
> inode_permission()->btrfs_permission(). There is no restriction on
> security.* from VFS and decision is left to the underlying filesystem.

When a test currently fails and we have a patch that fixes it, we mention
it in the changelog and/or the test itself.

Nowadays (and I learned this recently as it's new), we have an annotation
to add to the test itself, like this:

_fixed_by_kernel_commit XXXXXXXXXXXX "btrfs: check if root is readonly while setting security xattr"

(Notice that I changed "Check" to "check", because that's the convention
for btrfs patches, and David would fix that when picking the patch anyway)

In this case since the patch is not yet in Linus' tree, we can leave
the XXXXXXXXXXXX marker and later update it once it lands in his tree.

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/tests/btrfs/273 b/tests/btrfs/273
> new file mode 100755
> index 00000000..ec7d264d
> --- /dev/null
> +++ b/tests/btrfs/273
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 273
> +#
> +# Test that no xattr can be changed once btrfs property is set to RO
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr

subvol group too.

> +
> +# Import common functions.
> +#. ./common/filter

Ratther than comment, remove it, but we'll need a filter, see below.

> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs btrfs
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
> +	$SETFATTR_PROG -n "user.one" -v $value $FILENAME
> +	$SETFATTR_PROG -n "security.one" -v $value $FILENAME
> +	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME
> +}
> +
> +get_xattr() {
> +	$GETFATTR_PROG -n "user.one" $FILENAME
> +	$GETFATTR_PROG -n "security.one" $FILENAME
> +	$GETFATTR_PROG -n "trusted.one" $FILENAME
> +}
> +
> +del_xattr() {
> +	$SETFATTR_PROG -x "user.one" $FILENAME
> +	$SETFATTR_PROG -x "security.one" $FILENAME
> +	$SETFATTR_PROG -x "trusted.one" $FILENAME
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
> +# Check the values of RO (property) filesystem is not changed
> +get_xattr
> +
> +# Attempt to remove xattr from RO (property) filesystem
> +del_xattr

Here we should call get_xattr() again to verify the xattrs were
not deleted, just like we did before.

> +
> +# Change filesystem property RO to false
> +
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
> +status=0
> +exit
> diff --git a/tests/btrfs/273.out b/tests/btrfs/273.out
> new file mode 100644
> index 00000000..f6fca029
> --- /dev/null
> +++ b/tests/btrfs/273.out
> @@ -0,0 +1,33 @@
> +QA output created by 273
> +ro=true
> +setfattr: /scratch/foo: Read-only file system
> +setfattr: /scratch/foo: Read-only file system
> +setfattr: /scratch/foo: Read-only file system
> +getfattr: Removing leading '/' from absolute path names

We can get rid of this message by passing --absolute-names to getfattr.
We do that in every generic test case I can find.

> +# file: scratch/foo

And --absolute-names is also used in order to be able to filter the
golden output.

The test fails on any config where SCRATCH_MNT is not "/scratch",
like in my environment:

   -# file: scratch/foo
   +# file: home/fdmanana/btrfs-tests/scratch_1/foo

By passing --absolute-names we can then use _filter_scratch and have
this instead in the golden output:

# file: SCRATCH_MNT/foo

> +user.one="1"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +security.one="1"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +trusted.one="1"
> +
> +setfattr: /scratch/foo: Read-only file system

Same here. The test fails if SCRATCH_MNT is not "/scratch".
We need to append "2>&1 | _filter_scratch" to every setfattr call in the test.

And then have the following in the golden output instead:

setfattr: SCRATCH_MNT/foo: Read-only file system

Here's a diff that fixes the golden output and adds the other things
mentioned before:

diff --git a/tests/btrfs/273 b/tests/btrfs/273
index ec7d264d..37e9e52c 100755
--- a/tests/btrfs/273
+++ b/tests/btrfs/273
@@ -7,14 +7,15 @@
 # Test that no xattr can be changed once btrfs property is set to RO
 #
 . ./common/preamble
-_begin_fstest auto quick attr
+_begin_fstest auto quick attr subvol
 
 # Import common functions.
-#. ./common/filter
+. ./common/filter
 . ./common/attr
 
 # real QA test starts here
 _supported_fs btrfs
+_fixed_by_kernel_commit XXXXXXXXXXXX "btrfs: check if root is readonly while setting security xattr"
 _require_attrs
 _require_btrfs_command "property"
 _require_scratch
@@ -23,24 +24,23 @@ _scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
 FILENAME=$SCRATCH_MNT/foo
-
 set_xattr() {
 	local value=$1
-	$SETFATTR_PROG -n "user.one" -v $value $FILENAME
-	$SETFATTR_PROG -n "security.one" -v $value $FILENAME
-	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME
+	$SETFATTR_PROG -n "user.one" -v $value $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -n "security.one" -v $value $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME 2>&1 | _filter_scratch
 }
 
 get_xattr() {
-	$GETFATTR_PROG -n "user.one" $FILENAME
-	$GETFATTR_PROG -n "security.one" $FILENAME
-	$GETFATTR_PROG -n "trusted.one" $FILENAME
+	$GETFATTR_PROG -n "user.one" --absolute-names $FILENAME | _filter_scratch
+	$GETFATTR_PROG -n "security.one" --absolute-names $FILENAME | _filter_scratch
+	$GETFATTR_PROG -n "trusted.one" --absolute-names $FILENAME | _filter_scratch
 }
 
 del_xattr() {
-	$SETFATTR_PROG -x "user.one" $FILENAME
-	$SETFATTR_PROG -x "security.one" $FILENAME
-	$SETFATTR_PROG -x "trusted.one" $FILENAME
+	$SETFATTR_PROG -x "user.one" $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -x "security.one" $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -x "trusted.one" $FILENAME 2>&1 | _filter_scratch
 }
 
 # Create a test file.
@@ -54,12 +54,15 @@ $BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
 # Attempt to change values of RO (property) filesystem
 set_xattr 2
 
-# Check the values of RO (property) filesystem is not changed
+# Check the values of RO (property) filesystem are not changed
 get_xattr
 
 # Attempt to remove xattr from RO (property) filesystem
 del_xattr
 
+# Check the values of RO (property) filesystem are not changed
+get_xattr
+
 # Change filesystem property RO to false
 
 $BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
diff --git a/tests/btrfs/273.out b/tests/btrfs/273.out
index f6fca029..ae85b0a5 100644
--- a/tests/btrfs/273.out
+++ b/tests/btrfs/273.out
@@ -1,33 +1,36 @@
 QA output created by 273
 ro=true
-setfattr: /scratch/foo: Read-only file system
-setfattr: /scratch/foo: Read-only file system
-setfattr: /scratch/foo: Read-only file system
-getfattr: Removing leading '/' from absolute path names
-# file: scratch/foo
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+# file: SCRATCH_MNT/foo
 user.one="1"
 
-getfattr: Removing leading '/' from absolute path names
-# file: scratch/foo
+# file: SCRATCH_MNT/foo
 security.one="1"
 
-getfattr: Removing leading '/' from absolute path names
-# file: scratch/foo
+# file: SCRATCH_MNT/foo
+trusted.one="1"
+
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+# file: SCRATCH_MNT/foo
+user.one="1"
+
+# file: SCRATCH_MNT/foo
+security.one="1"
+
+# file: SCRATCH_MNT/foo
 trusted.one="1"
 
-setfattr: /scratch/foo: Read-only file system
-setfattr: /scratch/foo: Read-only file system
-setfattr: /scratch/foo: Read-only file system
 ro=false
-getfattr: Removing leading '/' from absolute path names
-# file: scratch/foo
+# file: SCRATCH_MNT/foo
 user.one="2"
 
-getfattr: Removing leading '/' from absolute path names
-# file: scratch/foo
+# file: SCRATCH_MNT/foo
 security.one="2"
 
-getfattr: Removing leading '/' from absolute path names
-# file: scratch/foo
+# file: SCRATCH_MNT/foo
 trusted.one="2"
 

Thanks.


> +setfattr: /scratch/foo: Read-only file system
> +setfattr: /scratch/foo: Read-only file system
> +ro=false
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +user.one="2"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +security.one="2"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +trusted.one="2"
> +
> 
> -- 
> Goldwyn
