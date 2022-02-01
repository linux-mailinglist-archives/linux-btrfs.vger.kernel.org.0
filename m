Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353B94A61A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 17:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbiBAQwQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 11:52:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42088 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiBAQwQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 11:52:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5D25C21111;
        Tue,  1 Feb 2022 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643734335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glReoLSpaTWI44C0+YHwz6Jf/kWPx7pvkA5Avcn4UeI=;
        b=XK3wcZDpilYkWRHGiI7GV4GuQpWqZIccUhQw4QHe9WWxqbTp4/m23DWQnHrNiumnJYZ98e
        4VhHckhSBtc7m7o2LY2HEZkGPdH+XgcG1Wly0NieL3SySb7NoLoZ1CBoZjfFwf0ya8fzMU
        WcSzZFNDzO2SKZPNNOTzaNfcnfbSbAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643734335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glReoLSpaTWI44C0+YHwz6Jf/kWPx7pvkA5Avcn4UeI=;
        b=HmnfxcWYTxvziviA1aQKg6SXH48sOWGig6VmvsAmNmZOyYosHprnGuSxNCyDsxFyNuTbme
        STY00GFg3gC426Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2B561A3B85;
        Tue,  1 Feb 2022 16:52:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27E5ADA7A9; Tue,  1 Feb 2022 17:51:30 +0100 (CET)
Date:   Tue, 1 Feb 2022 17:51:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: support DUP on metadata for zoned
Message-ID: <20220201165130.GU14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 01:04:01AM -0800, Johannes Thumshirn wrote:
> This is the userspace part for supporting BTRFS_BLOCK_GROUP_DUP on zoned
> devices for metadata block groups.

mkfs with DUP on metadata works, I also tried it on -d dup and it
crashes inside btrfs_add_block_group (kernel-shared/extent-tree.c:2781:)
due to missing error handling. Can you please also have a look? It
should at least exit with a normal error, so we can throw zoned devices
into more tests eventually.

> Johannes Thumshirn (2):
>   btrfs-progs: use profile_supported in mkfs as well
>   btrfs-progs: zoned support DUP on metadata block groups

Added to devel, thanks.
