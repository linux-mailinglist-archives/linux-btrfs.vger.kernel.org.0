Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2474833D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiACO5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 09:57:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41126 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiACO5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 09:57:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A61492110B;
        Mon,  3 Jan 2022 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641221822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7mbEP9TZnoXgafys4nMV1iK2O1UbNQxUJ82oqF3CCc=;
        b=JxLa52D6HaLa8Wz+nwxV3/cMdcE/v3swB/xybDWodyjZAlliUl0a5DZDn9GslSvEwnqPsW
        emMuZ0IV4BzvtEGYVUcK4P4LHmRbnTVM1DQO45EUmCd3G4akg5XhxhhMBZyTK6VW83X0jZ
        6unhN/ycK43XanGbz+HRp2Z/bkSJaKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641221822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7mbEP9TZnoXgafys4nMV1iK2O1UbNQxUJ82oqF3CCc=;
        b=1cZvRNIAQNKFioorpr5/3DHHPg2iZjOWYy0WkXuNiTX0cD18n7owJJhLqsckD/f/oNjAMA
        rRlHRfOfGNmrIZCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9F6D7A3B98;
        Mon,  3 Jan 2022 14:57:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F3A1EDA729; Mon,  3 Jan 2022 15:56:33 +0100 (CET)
Date:   Mon, 3 Jan 2022 15:56:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: process_snapshot: don't free ERR
Message-ID: <20220103145633.GI28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20220102015016.48470-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220102015016.48470-1-davispuh@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 02, 2022 at 03:50:16AM +0200, Dāvis Mosāns wrote:
> When some error happens when trying to search for parent subvolume
> then parent_subvol will contain errno so don't try to free that
> 
> Crash backtrace would look like:
> 0  process_snapshot at cmds/receive.c:358
>     358		free(parent_subvol->path);
> 1  0x00005646898aaa67 in read_and_process_cmd at common/send-stream.c:348
> 2  btrfs_read_and_process_send_stream at common/send-stream.c:525
> 3  0x00005646898c9b8b in do_receive at cmds/receive.c:1113
> 4  cmd_receive at cmds/receive.c:1316
> 5  0x00005646898750b1 in cmd_execute at cmds/commands.h:125
> 6  main at btrfs.c:405
> 
> (gdb) p parent_subvol
> $1 = (struct subvol_info *) 0xfffffffffffffffe
> 
> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>

Added to devel, thanks.
