Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE43FB337
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhH3Jig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 05:38:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52154 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbhH3Jif (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 05:38:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AA4FD220E2;
        Mon, 30 Aug 2021 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630316261;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WxSwWZ2kZXtLjSXb5YzbQVxNVI7JwKEj6lsHBzmLWtQ=;
        b=u1YhemHQLMjobL+OsiPGgmD5IsDfdqZBKkj0JSF0RFC4BPkr/KJYILRj1z1gW2LtBL/ekG
        A10Bp7Xoe3k1c/kyUcLYj9yatKLoLRGqPZBfovOLX7hcnCgx9W+2+pmFWS6QtgTR7Dqqyi
        rPSChg66On3eQmc5XVNaOqHx7lXUxX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630316261;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WxSwWZ2kZXtLjSXb5YzbQVxNVI7JwKEj6lsHBzmLWtQ=;
        b=uKwi6LvZczd87YrTJ5YN4+hZxUy1lTwukR/Cog0oL32OaVky6FGcQYAG1Bj/tUhSijTKya
        M44lYiZ2rtkArEBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A15CBA3B8C;
        Mon, 30 Aug 2021 09:37:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A70BDA733; Mon, 30 Aug 2021 11:34:51 +0200 (CEST)
Date:   Mon, 30 Aug 2021 11:34:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     li zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Fix the issues btrfs-convert don't
 recognition ext4  i_{a,c,a}time_extra
Message-ID: <20210830093451.GZ3379@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, li zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <1629824687-21014-1-git-send-email-zhanglikernel@gmail.com>
 <20210826183406.GQ3379@twin.jikos.cz>
 <20210828044117.GA29273@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828044117.GA29273@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 28, 2021 at 12:41:19PM +0800, li zhang wrote:
> Is there any possibility that the version of the GNU build system caused
> the ./configure error
> to be generated? On my machine, I produced a valid ./configure, and my
> compilation
> environment is as follows:
> aclocal:    aclocal (GNU automake) 1.13.4
> autoconf:   autoconf (GNU Autoconf) 2.69
> autoheader: autoheader (GNU Autoconf) 2.69
> automake:   automake (GNU automake) 1.13.4
> OS: centos 7.6

You'd have to run the ./configure script or inspect it manually though
it could be hard to locate the lines in the generated script.

I get the following diff, the commas are interprted as shell commands.

--- configure-bad       2021-08-30 11:35:22.034446343 +0200
+++ configure-good      2021-08-30 11:34:19.130281370 +0200
@@ -6469,6 +6469,8 @@ else
   have_ext4_epoch_mask_define=no
 fi
 
+have_ext4_epoch_mask_define=no
+
 if test "x$have_ext4_epoch_mask_define" = xno; then :
 
     ac_fn_c_check_member "$LINENO" "struct ext2_inode_large" "i_atime_extra" "ac_cv_member_struct_ext2_inode_large_i_atime_extra" "#include <ext2fs/ext2_fs.h>
@@ -6482,16 +6484,16 @@ _ACEOF
 
 
 $as_echo "#define HAVE_EXT4_EPOCH_MASK_DEFINE 1" >>confdefs.h
-,
+
 
 $as_echo "#define EXT4_EPOCH_BITS 2" >>confdefs.h
-,
+
 
 $as_echo "#define EXT4_EPOCH_MASK ((1 << EXT4_EPOCH_BITS) - 1)" >>confdefs.h
-,
+
 
 $as_echo "#define EXT4_NSEC_MASK (~0UL << EXT4_EPOCH_BITS)" >>confdefs.h
-,
+
 
 $as_echo "#define inode_includes(size, field) (size >= (sizeof(((struct ext2_inode_large *)0)->field) + offsetof(struct ext2_inode_large, field)))" >>confdefs.h
--- 
