Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3287A0C40
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjINSLB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINSLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 14:11:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C39186;
        Thu, 14 Sep 2023 11:10:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4977E1F74A;
        Thu, 14 Sep 2023 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694715055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ScywnoXyfmdvMmVEnP3WBso/yH+Ndfihjxhp4Fy7vfc=;
        b=cBP78N2ChaQnAH0Zu6RrG9yqDd5LaRUlC/gYGkKtAlVskh63KRnp/K90mJWtk/ZQZvw1Rr
        7VRsm4TeHyR1LhDeXPcdIjubOC7U94FcQaz/zD91+IGQXBgmHCBCZH2FO+LzV/ehkqPjp/
        zU0R+brXq2xg67rq9NemTOEGjeUWycI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694715055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ScywnoXyfmdvMmVEnP3WBso/yH+Ndfihjxhp4Fy7vfc=;
        b=kal6kZKUkgSqmNr2Iuquig7ab0NDp2adxOU3PbVB9YJ78Bt8yjxk6goDECoKTf8ZYqZpVM
        sSamayXRN0hhV6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05CB013580;
        Thu, 14 Sep 2023 18:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ImecAK9MA2UwXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Sep 2023 18:10:55 +0000
Date:   Thu, 14 Sep 2023 20:10:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/11] btrfs: add support for inserting raid stripe
 extents
Message-ID: <20230914181052.GC20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-3-15d423829637@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-raid-stripe-tree-v9-3-15d423829637@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 09:06:58AM -0700, Johannes Thumshirn wrote:
> +	map_type = list_first_entry(&ordered_extent->bioc_list, typeof(*bioc),
> +				    ordered_entry)->map_type;
> +
> +	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +	case BTRFS_BLOCK_GROUP_DUP:
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +	case BTRFS_BLOCK_GROUP_RAID1C3:
> +	case BTRFS_BLOCK_GROUP_RAID1C4:
> +		ret = btrfs_insert_mirrored_raid_extents(trans, ordered_extent,
> +							 map_type);
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +		ret = btrfs_insert_striped_raid_extents(trans, ordered_extent,
> +							map_type);
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +		ret = btrfs_insert_striped_mirrored_raid_extents(trans, ordered_extent, map_type);
> +		break;
> +	default:
> +		btrfs_err(trans->fs_info, "unknown block-group profile %lld",
> +			  map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
> +		ASSERT(0);

Please don't use ASSERT(0), the error is handled and no need to crash
here.

> +		ret = -EINVAL;
> +		break;
> +	}
