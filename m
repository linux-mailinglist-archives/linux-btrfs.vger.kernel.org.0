Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21C3402C8C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhIGQGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 12:06:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40264 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243467AbhIGQGR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 12:06:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 54DE71FFB9;
        Tue,  7 Sep 2021 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631030710;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YR3k2gfr0VZcTeFGvFMwyFmU8ewDds1OHT92Hij8sIQ=;
        b=SCG4fEf4nxWqflUts9d3YgdqXYsF/Wg1jaZM5vdUgqhM5iRInImdOkFZ6WX5tb4/kW4X8a
        1UGbD48R2X9QSLL9bo2BuDk7IWrJmV2poSyOOnV5Qj3NC/avCUroii5PiqmT9RKXXw/s0C
        8QHX79a3iFn4WFf3fQKDsSfWaK1Syzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631030710;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YR3k2gfr0VZcTeFGvFMwyFmU8ewDds1OHT92Hij8sIQ=;
        b=e4NwB+rKALq5L8iBsutW8KJTitAdcct5x6vIHNN1LaGZW/YcXNR524wPOUap/iShdL6bDY
        /BDeGs3pRAbQ+PAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4ACAAA3B8F;
        Tue,  7 Sep 2021 16:05:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3EF85DA7E1; Tue,  7 Sep 2021 18:05:06 +0200 (CEST)
Date:   Tue, 7 Sep 2021 18:05:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     anand.jain@oracle.com
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: remove the failing device argument from
 btrfs_check_rw_degradable()
Message-ID: <20210907160506.GQ3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, anand.jain@oracle.com,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1631026981.git.fdmanana@suse.com>
 <6979a21084ce679d34896cf8092349e845e1843e.1631026981.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6979a21084ce679d34896cf8092349e845e1843e.1631026981.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 07, 2021 at 04:15:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently all callers of btrfs_check_rw_degradable() pass a NULL value for
> its 'failing_dev' argument, therefore making it useless. So just remove
> that argument.

Anand, did you have plans with using the argument? It's been NULL since
the initial patch

https://lore.kernel.org/linux-btrfs/00433e34-a56e-3898-80b9-32a304fe32e2@gmx.com/t/#u

as commit 6528b99d3d20 ("btrfs: factor btrfs_check_rw_degradable() to
check given device") and it was not part of a series.
