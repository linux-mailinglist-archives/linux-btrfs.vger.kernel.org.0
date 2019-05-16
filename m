Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4D20750
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfEPMw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 08:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:50868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727015AbfEPMw1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 08:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11FA4AF68
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 12:52:26 +0000 (UTC)
Date:   Thu, 16 May 2019 14:52:25 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3.1 1/3] btrfs-progs: factor out super_block reading
 from load_and_dump_sb
Message-ID: <20190516125225.GE3922@x250.microfocus.com>
References: <20190514132532.16934-2-jthumshirn@suse.de>
 <20190514135804.18669-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190514135804.18669-1-jthumshirn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 14, 2019 at 03:58:04PM +0200, Johannes Thumshirn wrote:
> inspect-internal dump-superblock's load_and_dump_sb() already reads a
> super block from a file descriptor and places it into a 'struct
> btrfs_super_block'.
> 
> For inspect-internal dump-csum we need this super block as well but don't
> care about printing it.
> 
> Separate the read from the dump phase so we can re-use it elsewhere.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
> - Fix double sizeof() @!$#$ (Nikolay)
> 
>  cmds-inspect-dump-super.c | 15 ++++++---------
>  utils.c                   | 15 +++++++++++++++
>  utils.h                   |  2 ++
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/cmds-inspect-dump-super.c b/cmds-inspect-dump-super.c
> index 7815c863f2ed..879f979f526a 100644
> --- a/cmds-inspect-dump-super.c
> +++ b/cmds-inspect-dump-super.c
> @@ -477,16 +477,13 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
>  static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>  		int force)
>  {
> -	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
> -	struct btrfs_super_block *sb;
> +	struct btrfs_super_block sb;
>  	u64 ret;
>  
> -	sb = (struct btrfs_super_block *)super_block_data;
> -
> -	ret = pread64(fd, super_block_data, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
> -	if (ret != BTRFS_SUPER_INFO_SIZE) {
> +	ret = load_sb(fd, sb_bytenr, &sb);
> +	if (ret) {

This is buggy. We need to copy the whole BTRFS_SUPER_INFO_SIZE and calculate
the checksums over this area.

Sorry,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
