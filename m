Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1777428DBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhJKNX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 09:23:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38346 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhJKNX4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 09:23:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CFD1421E6B;
        Mon, 11 Oct 2021 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633958515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3P95of6oqoKjIdogz1Tczd7vLcE61gpyAW3OH8IrXoc=;
        b=yAgy7zpI24WLANNFugITpbnJ7v/QenL1JzeSDN0jBkL9t3c5F1Ga7O4owenck+mZXO0/xR
        JkPJFgB2ysR+aS7hCEqt3+E0AZU1eBxiItUaMxZvFHD0OllBDaeZpVTPxGMBQzI1Lr2J+R
        zREv0SvJVmTJX1CPhkOunSCA9mCgVL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633958515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3P95of6oqoKjIdogz1Tczd7vLcE61gpyAW3OH8IrXoc=;
        b=7SygEibZhtwpbOOrS5O3Ew+eHnHZe04DJLs/DyC7LeQD3JuQ1EwjTFdAQJgbX8CRVCoxNV
        XTicQW6q5J2EMoAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C88BFA3B81;
        Mon, 11 Oct 2021 13:21:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82ADEDA735; Mon, 11 Oct 2021 15:21:32 +0200 (CEST)
Date:   Mon, 11 Oct 2021 15:21:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: parse-utils: allow single number qgroup id
Message-ID: <20211011132132.GH9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011070937.32419-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011070937.32419-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 03:09:37PM +0800, Qu Wenruo wrote:
> [BUG]
> Since btrfs-progs v5.14, fstests/btrfs/099 always fail with the
> following output in 099.full:
> 
>   ...
>   # /usr/bin/btrfs quota enable /mnt/scratch
>   # /usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch
>   ERROR: invalid qgroupid or subvolume path: 5
>   failed: '/usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch'
> 
> [CAUSE]
> Since commit cb5a542871f9 ("btrfs-progs: factor out plain qgroupid
> parsing"), btrfs qgroup parser no longer accepts single number qgroup id
> like "5" used in that test case.
> 
> That commit is not a plain refactor without functional change, but
> removed a simple feature.
> 
> [FIX]
> Add back the handling for single number qgroupid.

This unfortunately breaks something else, as it's changing the whole
parse_qgroupid helper to accept single value id, which is also used for
'qgroup create'.

There's another combined helper for parsing qgroup id and path, so we
may need to add another one that also accepts the subvolid, in commands
where this makes sense. The helper parse_qgroupid should really remain
as it is and parse the 'number/number' format.
