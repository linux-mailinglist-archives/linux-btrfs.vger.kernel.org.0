Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56D4165EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhIWTYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 15:24:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50144 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbhIWTYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 15:24:31 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD7E422389;
        Thu, 23 Sep 2021 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632424978;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgKuFNSR02Dvex/ui1DSBghtKjf+tqWyViiuujxSFBs=;
        b=HPLIpzugcFVshg7paIDpMQdvdOrBB8dJmpZcnPi2BU/KLC9+TzrqNj5cev1nBOC/yst3+D
        60sgqlb5EnD8qWlxxQHKw+rhgxEV4UaPKeMqFeKxksKIKpEaQVUMppImM7mV3TahYaQQlA
        kRUUBN7Wj3gyjwwiwRZaNjDdDMJGAGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632424978;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgKuFNSR02Dvex/ui1DSBghtKjf+tqWyViiuujxSFBs=;
        b=Qj3JmhHZhvSBaOsdQUgNQIzgba0XGi4+Mcsq3UP8lCNTchWDMJOL/0H+VgkUYiYA7CG2gF
        SY5+4YPaJjmwciCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id B65A825D3C;
        Thu, 23 Sep 2021 19:22:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6C3CDA799; Thu, 23 Sep 2021 21:22:45 +0200 (CEST)
Date:   Thu, 23 Sep 2021 21:22:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs-progs: properly format btrfs_header in
 btrfs_create_root()
Message-ID: <20210923192245.GY9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20210923152911.359451-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923152911.359451-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 24, 2021 at 12:29:11AM +0900, Naohiro Aota wrote:
> Enabling quota on zoned btrfs hits the following ASSERT().
> 
>     $ mkfs.btrfs -f -d single -m single -R quota /dev/nullb0
>     btrfs-progs v5.11
>     See http://btrfs.wiki.kernel.org for more information.
> 
>     Zoned: /dev/nullb0: host-managed device detected, setting zoned feature
>     Resetting device zones /dev/nullb0 (1600 zones) ...
>     bad tree block 25395200, bytenr mismatch, want=25395200, have=0
>     kernel-shared/disk-io.c:549: write_tree_block: BUG_ON `1` triggered, value 1
>     ./mkfs.btrfs(+0x26aaa)[0x564d1a7ccaaa]
>     ./mkfs.btrfs(write_tree_block+0xb8)[0x564d1a7cee29]
>     ./mkfs.btrfs(__commit_transaction+0x91)[0x564d1a7e3740]
>     ./mkfs.btrfs(btrfs_commit_transaction+0x135)[0x564d1a7e39aa]
>     ./mkfs.btrfs(main+0x1fe9)[0x564d1a7b442a]
>     /lib64/libc.so.6(__libc_start_main+0xcd)[0x7f36377d37fd]
>     ./mkfs.btrfs(_start+0x2a)[0x564d1a7b1fda]
>     zsh: IOT instruction  sudo ./mkfs.btrfs -f -d single -m single -R quota /dev/nullb0
> 
> The issue occur because btrfs_create_root() is not formatting the root node
> properly. This is fine on regular btrfs, because it's fortunately reusing
> an once freed buffer. As the previous tree node allocation kindly formatted
> the header, it will see the proper bytenr and pass the checks.
> 
> However, we never reuse an once freed buffer on zoned btrfs. As a result,
> we have zero-filled bytenr, FSID, and chunk-tree UUID, hitting the ASSERTs
> in check_tree_block().
> 
> Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to devel, thanks.
