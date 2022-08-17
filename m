Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53575971B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiHQOpv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiHQOpu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:45:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721F29C2CC;
        Wed, 17 Aug 2022 07:45:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C58A37EE1;
        Wed, 17 Aug 2022 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660747548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amL+iF2cr6EtQ+csZwTHCA7BDKkZdnV1P3L69CoMvGU=;
        b=Jria0wi7L9l9AGAaCDAYR7qSOMoeUreuCUB2L67vhgX1P3upeFO93NQh4TaNg9G+MYmTd+
        48Dph65ETRWexlZowVQffoMX9K4AH8gHSCqqJZgUFTK+TXMQpKe6cVQg12w+7UlPd48Bnm
        QSBJyB/CJTGEMZaloinU9xXgC3zndd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660747548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amL+iF2cr6EtQ+csZwTHCA7BDKkZdnV1P3L69CoMvGU=;
        b=M8RlbKtjf+dVnV8JsxlRgzZ+gzJiS0maLzMKT4ujhjfPCWg2OCl3wqwiOdKba2rdI0fP40
        z/0HBWuL0pI9WEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C027D13428;
        Wed, 17 Aug 2022 14:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DSq6IRv//GKffAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Wed, 17 Aug 2022 14:45:47 +0000
Date:   Wed, 17 Aug 2022 09:45:45 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Test xattr changes for read-only btrfs property
Message-ID: <20220817144545.jc4hjf6fbp2e5acq@fiona>
References: <20220816214051.wsw75y3mtjdsim6w@fiona>
 <20220817105157.GC2815552@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817105157.GC2815552@falcondesktop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11:51 17/08, Filipe Manana wrote:
> On Tue, Aug 16, 2022 at 04:40:51PM -0500, Goldwyn Rodrigues wrote:
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
> 
> When a test currently fails and we have a patch that fixes it, we mention
> it in the changelog and/or the test itself.
> 
> Nowadays (and I learned this recently as it's new), we have an annotation
> to add to the test itself, like this:
> 
> _fixed_by_kernel_commit XXXXXXXXXXXX "btrfs: check if root is readonly while setting security xattr"
> 
> (Notice that I changed "Check" to "check", because that's the convention
> for btrfs patches, and David would fix that when picking the patch anyway)
> 
> In this case since the patch is not yet in Linus' tree, we can leave
> the XXXXXXXXXXXX marker and later update it once it lands in his tree.
> 
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
> 
> subvol group too.
> 
> > +
> > +# Import common functions.
> > +#. ./common/filter
> 
> Ratther than comment, remove it, but we'll need a filter, see below.
> 
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
> > +	local value=$1
> > +	$SETFATTR_PROG -n "user.one" -v $value $FILENAME
> > +	$SETFATTR_PROG -n "security.one" -v $value $FILENAME
> > +	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME
> > +}
> > +
> > +get_xattr() {
> > +	$GETFATTR_PROG -n "user.one" $FILENAME
> > +	$GETFATTR_PROG -n "security.one" $FILENAME
> > +	$GETFATTR_PROG -n "trusted.one" $FILENAME
> > +}
> > +
> > +del_xattr() {
> > +	$SETFATTR_PROG -x "user.one" $FILENAME
> > +	$SETFATTR_PROG -x "security.one" $FILENAME
> > +	$SETFATTR_PROG -x "trusted.one" $FILENAME
> > +}
> > +
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
> 
> Here we should call get_xattr() again to verify the xattrs were
> not deleted, just like we did before.
> 

This should be called after they are truly deleted once the filesystem
is RW. I will add that.

> > +
> > +# Change filesystem property RO to false
> > +
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
> > +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> > +
> > +# Change the xattrs after RO is false
> > +set_xattr 2
> > +
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
> 
> We can get rid of this message by passing --absolute-names to getfattr.
> We do that in every generic test case I can find.
> 
> > +# file: scratch/foo
> 
> And --absolute-names is also used in order to be able to filter the
> golden output.
> 
> The test fails on any config where SCRATCH_MNT is not "/scratch",
> like in my environment:
> 
>    -# file: scratch/foo
>    +# file: home/fdmanana/btrfs-tests/scratch_1/foo
> 
> By passing --absolute-names we can then use _filter_scratch and have
> this instead in the golden output:
> 
> # file: SCRATCH_MNT/foo

Yes, missed that.


-- 
Goldwyn
