Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED192FEF30
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbhAUPlk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 10:41:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733066AbhAUPko (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 10:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9743ABD6;
        Thu, 21 Jan 2021 15:39:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 472F9DA6E3; Thu, 21 Jan 2021 16:37:59 +0100 (CET)
Date:   Thu, 21 Jan 2021 16:37:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.10
Message-ID: <20210121153759.GZ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210118222021.11603-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118222021.11603-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 18, 2021 at 11:20:21PM +0100, David Sterba wrote:
> Hi,
> 
> btrfs-progs version 5.10 have been released.

I got a report that static build is broken. It's caused by libmount that
has some internal functions with the same name as is in progs
(canonicalize_path, parse_size). I don't have a final fix, only
workarounds hiding or renaming the functions but there are still some
other problems that can't be solved by that.

ld: /../lib64/libmount.a(libcommon_la-canonicalize.o): in function `canonicalize_dm_name':
util-linux-2.34/lib/canonicalize.c:58: multiple definition of `canonicalize_dm_name';
	common/path-utils.static.o:btrfs-progs/common/path-utils.c:286: first defined here

similar for canonicalize_path and parse_size, and then it's

ld: ../lib64/libmount.a(la-utils.o): in function `mnt_get_gid':
util-linux-2.34/libmount/src/utils.c:625: warning: Using 'getgrnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
ld: ../lib64/libmount.a(la-utils.o): in function `mnt_get_uid':
util-linux-2.34/libmount/src/utils.c:598: warning: Using 'getpwnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
ld: ../lib64/libmount.a(la-utils.o): in function `mnt_get_username':
util-linux-2.34/libmount/src/utils.c:577: warning: Using 'getpwuid_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking

Only warnings but I haven't checked if that affects runtime.

ld: ../lib64/libmount.a(la-optstr.o): in function `mnt_optstr_fix_secontext':
util-linux-2.34/libmount/src/optstr.c:909: undefined reference to `selinux_trans_to_raw_context'
ld: util-linux-2.34/libmount/src/optstr.c:934: undefined reference to `freecon'

The functions are from selinux that's pulled by libmount.so.1 and adds
yet another library dependency.

We want to support the static build so this will get fixed.
