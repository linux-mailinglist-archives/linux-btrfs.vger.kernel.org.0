Return-Path: <linux-btrfs+bounces-14242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E58CAC3E6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 13:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C64177115
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159241FCF78;
	Mon, 26 May 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDo8/+6X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CE1FBCAE;
	Mon, 26 May 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258218; cv=none; b=vGPa1hF9m548fG+lnPa+/tfaCXfK27tSOv050CM9PHj47oU3kirEauw0nKNCFIjKZliqt5Uj2CkRyDOonlEu+gUxX6ISN7HQNEVZKL8ZAezPX1PM7nJLn+j1xHfEHAIlQpAD0ANUbLmDVSTLM4UPkpVDNEKAi4tblDg46tUFybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258218; c=relaxed/simple;
	bh=Vu9d1dR7c8MdrlriVh+RzW9gWvsNMj2O/CZccZtT6b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftGaBrXY2yhgBO8n38af5ap3CHZpvv3Ehhk38pipR5c0hjeZNHkw7Q34Mq/u52ADh5AZY4PFaXLBR1DqilWvYWKPdy76+BM/uAulIPOj2gDlMEylDKyIARft0Ao7mpsEM18VZPb+l9Xb7ilII3n9S6C+dvg1ariRvA+FK4T3+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDo8/+6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8960C4CEF0;
	Mon, 26 May 2025 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748258217;
	bh=Vu9d1dR7c8MdrlriVh+RzW9gWvsNMj2O/CZccZtT6b8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dDo8/+6XMtX3giU+9ptXF2QOauVR5x0BL33/tFtzQLojn54vyUKMLnz+fyXNLlSXI
	 YrDOFKRYseMscDBZ22W2JwWvEVoP4dCFXdbYBgiJOBFZgQUSamnyM8zxyzNfDzKjFP
	 arhDYpq/tfJMYgpOTxGdcN6h//G2UJ4jyUa3JXrU3HqDNxgGKRmYInBchWIfFGoD/P
	 rodYaP4KitdR2DFTtnHiqsfynW15HPr1ei/CyhGpYHw1338hKxKKwFiqEzU2XjZdMH
	 Kld6CMftNKyH+FsN5vVQqG+2WAMboq4nQ/GDI53juuSxbkoL4/JZ0xQfURbzMidPEb
	 gFe8xe3oHCO4Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad52d9be53cso291219866b.2;
        Mon, 26 May 2025 04:16:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLgznnkqZ43Nh6AZLMrjRHdbk2S/1OwEFL3CMYJMZ2eIIjysjJAsXxF7RJXrffGfz4co7ElLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0Yqz4GgQdbTt3hX6y49/7EZtnvXWUnBrOPF3iU1ILaEdlvuo
	v/j5nmMnWlMm5C+qda6IUUC6c/985jP5yVaM3tC10bsNVPWhWawvVY1nb6kpCbbvczgrG2CFX8i
	pbJic1xkLynzsrZ/l+7+LG/jmh4DYVCE=
X-Google-Smtp-Source: AGHT+IFSDjWwMX+VWX4WdgA9kRgpGZt4su9oivMFItAUW2Dq+P5o1Yc5To8TJer7X/l4VQ0u6+VxQZCsPFtsT0wrQyo=
X-Received: by 2002:a17:907:930c:b0:ad5:68b7:b0df with SMTP id
 a640c23a62f3a-ad85b22ab8dmr761993366b.46.1748258216273; Mon, 26 May 2025
 04:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526134027.187C.409509F4@e16-tech.com>
In-Reply-To: <20250526134027.187C.409509F4@e16-tech.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 May 2025 12:16:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H48BBHKd-3DHCgfxbx5zbJvqfeAr=UV1hQFGj0Lw4DEzA@mail.gmail.com>
X-Gm-Features: AX0GCFul-CieJSQLfGkVL9yU6r7rioTNJ7v68kfDXTWUAQLM1MVorZtKeygDwKg
Message-ID: <CAL3q7H48BBHKd-3DHCgfxbx5zbJvqfeAr=UV1hQFGj0Lw4DEzA@mail.gmail.com>
Subject: Re: 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implicit
 declaration of function 'ASSERT')
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 6:40=E2=80=AFAM Wang Yugui <wangyugui@e16-tech.com>=
 wrote:
>
> Hi,
> Cc: Filipe Manana
>
> I noticed 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implicit=
 declaration of function 'ASSERT')
>
> fs/btrfs/discard.c: In function 'peek_discard_list':
> fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSERT=
'; did you mean 'IS_ERR'? [-Werror=3Dimplicit-function-declaration]
>      ASSERT(block_group->discard_index !=3D
>      ^~~~~~
>      IS_ERR
>
> It seems realted to the patch(btrfs-fix-discard-worker-infinite-loop-afte=
r-disabling-discard.patch).

Yes, it is.

The patch, like most stable backports, was automatically picked by the
stable scripts and added to stable releases.
I assume that before the release was made, it was compile tested by
the stable automatic processes.

I just tried it, and it compiles successfully for me:

fdmanana 11:56:26 ~/git/hub/linux ((v6.12))> git clean -xfd
fdmanana 11:57:27 ~/git/hub/linux ((v6.12))> git co v6.1.140
fdmanana 11:59:53 ~/git/hub/linux ((v6.1.140))> make defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#

# Run make menuconfig to enable btrfs and all its config options
fdmanana 12:01:55 ~/git/hub/linux ((v6.1.140))> make menuconfig

fdmanana 12:02:17 ~/git/hub/linux ((v6.1.140))> grep BTRFS .config
CONFIG_BTRFS_FS=3Dm
CONFIG_BTRFS_FS_POSIX_ACL=3Dy
CONFIG_BTRFS_FS_CHECK_INTEGRITY=3Dy
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy
CONFIG_BTRFS_DEBUG=3Dy
CONFIG_BTRFS_ASSERT=3Dy
CONFIG_BTRFS_FS_REF_VERIFY=3Dy

fdmanana 12:06:08 ~/git/hub/linux ((v6.1.140))> make fs/btrfs/btrfs.ko
  SYNC    include/config/auto.conf
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  CC [M]  fs/btrfs/super.o
  CC [M]  fs/btrfs/ctree.o
  CC [M]  fs/btrfs/extent-tree.o
  CC [M]  fs/btrfs/print-tree.o
  CC [M]  fs/btrfs/root-tree.o
  CC [M]  fs/btrfs/dir-item.o
  CC [M]  fs/btrfs/file-item.o
  CC [M]  fs/btrfs/inode-item.o
  CC [M]  fs/btrfs/disk-io.o
  CC [M]  fs/btrfs/transaction.o
  CC [M]  fs/btrfs/inode.o
  CC [M]  fs/btrfs/file.o
  CC [M]  fs/btrfs/tree-defrag.o
  CC [M]  fs/btrfs/extent_map.o
  CC [M]  fs/btrfs/sysfs.o
  CC [M]  fs/btrfs/struct-funcs.o
  CC [M]  fs/btrfs/xattr.o
  CC [M]  fs/btrfs/ordered-data.o
  CC [M]  fs/btrfs/extent_io.o
  CC [M]  fs/btrfs/volumes.o
  CC [M]  fs/btrfs/async-thread.o
  CC [M]  fs/btrfs/ioctl.o
  CC [M]  fs/btrfs/locking.o
  CC [M]  fs/btrfs/orphan.o
  CC [M]  fs/btrfs/export.o
  CC [M]  fs/btrfs/tree-log.o
  CC [M]  fs/btrfs/free-space-cache.o
  CC [M]  fs/btrfs/lzo.o
  CC [M]  fs/btrfs/zstd.o
  CC [M]  fs/btrfs/compression.o
  CC [M]  fs/btrfs/delayed-ref.o
  CC [M]  fs/btrfs/relocation.o
  CC [M]  fs/btrfs/delayed-inode.o
  CC [M]  fs/btrfs/scrub.o
  CC [M]  fs/btrfs/backref.o
  CC [M]  fs/btrfs/ulist.o
  CC [M]  fs/btrfs/qgroup.o
  CC [M]  fs/btrfs/send.o
  CC [M]  fs/btrfs/dev-replace.o
  CC [M]  fs/btrfs/raid56.o
  CC [M]  fs/btrfs/uuid-tree.o
  CC [M]  fs/btrfs/props.o
  CC [M]  fs/btrfs/free-space-tree.o
  CC [M]  fs/btrfs/tree-checker.o
  CC [M]  fs/btrfs/space-info.o
  CC [M]  fs/btrfs/block-rsv.o
  CC [M]  fs/btrfs/delalloc-space.o
  CC [M]  fs/btrfs/block-group.o
  CC [M]  fs/btrfs/discard.o
  CC [M]  fs/btrfs/reflink.o
  CC [M]  fs/btrfs/subpage.o
  CC [M]  fs/btrfs/tree-mod-log.o
  CC [M]  fs/btrfs/extent-io-tree.o
  CC [M]  fs/btrfs/acl.o
  CC [M]  fs/btrfs/check-integrity.o
  CC [M]  fs/btrfs/ref-verify.o
  CC [M]  fs/btrfs/tests/free-space-tests.o
  CC [M]  fs/btrfs/tests/extent-buffer-tests.o
  CC [M]  fs/btrfs/tests/btrfs-tests.o
  CC [M]  fs/btrfs/tests/extent-io-tests.o
  CC [M]  fs/btrfs/tests/inode-tests.o
  CC [M]  fs/btrfs/tests/qgroup-tests.o
  CC [M]  fs/btrfs/tests/free-space-tree-tests.o
  CC [M]  fs/btrfs/tests/extent-map-tests.o
  LD [M]  fs/btrfs/btrfs.o
make[3]: 'fs/btrfs/btrfs.mod' is up to date.
  MODPOST modules-only.symvers
WARNING: vmlinux.o is missing.
         Modules may not have dependencies or modversions.
         You may get many unresolved symbol warnings.
WARNING: modpost: "bio_associate_blkg" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "zstd_cstream_workspace_bound" [fs/btrfs/btrfs.ko] undefi=
ned!
WARNING: modpost: "folio_invalidate" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "__page_file_index" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "strcpy" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "inode_init_owner" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "generic_fillattr" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "is_vmalloc_addr" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "krealloc" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: "vfs_fsync_range" [fs/btrfs/btrfs.ko] undefined!
WARNING: modpost: suppressed 521 unresolved symbol warnings because
there were too many)
  LD [M]  fs/btrfs/btrfs.ko

fdmanana 12:11:12 ~/git/hub/linux ((v6.1.140))> gcc --version
gcc (Debian 9.3.0-18) 9.3.0

>
> I walked around it with the following patch.

In the future please cc the stable list when you find problems with
stable backports.

>
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 98bce18..9ffe5c4 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -7,6 +7,7 @@
>  #include <linux/math64.h>
>  #include <linux/sizes.h>
>  #include <linux/workqueue.h>
> +#include "messages.h"
>  #include "ctree.h"
>  #include "block-group.h"
>  #include "discard.h"
>
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/05/26
>
>
>

