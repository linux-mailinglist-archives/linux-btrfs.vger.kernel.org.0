Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFA49CF2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 17:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiAZQGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 11:06:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45166 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbiAZQGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 11:06:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 25A8821123;
        Wed, 26 Jan 2022 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643213182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PHWugMf4RnYJOsmhtPQQTSjm6MHIBh4hgVbu2uU3H8=;
        b=m832a3u+gj2jvfJPhUvE57ZYGmxTMzldQ35WsWH7W78KwDA+lmC+j69af3Y74ySm+f5vKf
        3l8/IK9+wZknBjDCp10sXdzP9zDM9PDMMysrI2K/cEIu5GRRudsilm53T4+MVj6xJOI+L5
        TWGhSq8FlQ2eOGP1R8tOPSyuVDVKrGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643213182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PHWugMf4RnYJOsmhtPQQTSjm6MHIBh4hgVbu2uU3H8=;
        b=Ydki0P6x4gCp1H3ywwUKdxRsm0gS8NYzTbq+JYiJZF/GfBi/XHc0TyqGKzeOQgNAQO3O7c
        35UFlFYK+173QsAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E89A5A3B93;
        Wed, 26 Jan 2022 16:06:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 14CD2DA7A9; Wed, 26 Jan 2022 17:05:40 +0100 (CET)
Date:   Wed, 26 Jan 2022 17:05:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: implement metadata DUP for zoned mode
Message-ID: <20220126160540.GB14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1643204608.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643204608.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 05:46:19AM -0800, Johannes Thumshirn wrote:
> Btrfs' default block-group profile for metadata on rotating devices has been
> DUP for a long time. Recently the default also changed for non-rotating
> devices.
> 
> Technically, there is no reason why btrfs on zoned devices can't use DUP for
> metadata as well. All I/O to metadata block-groups is serialized via the
> zoned_meta_io_lock and written with regular REQ_OP_WRITE operations. Therefore
> reordering due to REQ_OP_ZONE_APPEND cannot happen on metadata (as opposed to
> data).
> 
> The first three patches lay the groundwork by making sure zoned btrfs can work
> with more than one stripe and the last patch then implements DUP on metadata
> block groups in zoned btrfs.
> 
> Changes to v1:
> * if only one zone is active, activate the other one as well
> 
> Johannes Thumshirn (4):
>   btrfs: zoned: make zone activation multi stripe capable
>   btrfs: zoned: make zone finishing multi stripe capable
>   btrfs: zoned: prepare for allowing DUP on zoned
>   btrfs: zoned: allow DUP on meta-data block groups

I'll add the patchset to a topic for-next branch, as it's in zoned code
and should not break anything else. Thanks.
