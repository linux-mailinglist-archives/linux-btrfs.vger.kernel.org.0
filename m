Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017D446C364
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 20:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbhLGTQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 14:16:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhLGTQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 14:16:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E4EA421958;
        Tue,  7 Dec 2021 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638904384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvND/CpkEk4/amUqdb6C+TLf0iqgUu20ZBxdJYCWcSk=;
        b=inRl/UGCpAVw5VtCDhpIy715XwYT6jqFQA/fa3djR33grWDQWddeQajKLlQkbh4DYfaDxg
        Xpq+ENncS7mjJm53p8FJVFSteo9SeGjU3yA/OuVTj7iTrkw03GgmpnVJtKnjiu+W93L3Vr
        oKkj95ETXQcXUcClano5iPr5jjhK/8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638904384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvND/CpkEk4/amUqdb6C+TLf0iqgUu20ZBxdJYCWcSk=;
        b=e/SjxOl6KCSZjrALzjaazh6vknrKUoSgzI8yKtDEyWM8zZdTOFPljIwhrvOKBs7uL0Gf7D
        iF4Mx3VKOM3YPfAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DC2BBA3B81;
        Tue,  7 Dec 2021 19:13:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3EB8EDA799; Tue,  7 Dec 2021 20:12:50 +0100 (CET)
Date:   Tue, 7 Dec 2021 20:12:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: first batch of zoned cleanups
Message-ID: <20211207191249.GD28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638886948.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 06:28:33AM -0800, Johannes Thumshirn wrote:
> Here's the first btach of cleanups for the zoned code. In contrast to the 1st
> submission [1] it is a minimalized set of patches with no dependencies on
> other subsystems in btrfs. All of these patches are independant and can be
> applied on their own.
> 
> The remaining patches from v1 will be sent out separately, once properly
> reworked.
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1637745470.git.johannes.thumshirn@wdc.com/
> 
> Johannes Thumshirn (4):
>   btrfs: zoned: encapsulate inode locking for zoned relocation
>   btrfs: zoned: simplify btrfs_check_meta_write_pointer
>   btrfs: zoned: sink zone check into btrfs_repair_one_zone
>   btrfs: zoned: it's pointless to check for REQ_OP_ZONE_APPEND and
>     btrfs_is_zoned

Added to misc-next, thanks.
