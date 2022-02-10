Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC24B1089
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 15:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbiBJOgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 09:36:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiBJOgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 09:36:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ED233
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 06:36:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AFC0B21114;
        Thu, 10 Feb 2022 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644503800;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgJyvyRh3cX5zcvNZulF4jph40K15JEIYzrGaa90f7o=;
        b=lNRtPqF8ied8+RVFCEAk2en1mwDzhxuyyNuPlBKTM37lOkVhEqVr1RkU6ztHA6DJq39Tn6
        v7SdTeZvDBRGPmmXzYSUNLztRCVF3kbzqnEf7FOZMGNf0ut3giOpVvLnLxSjbFmspuu9EH
        I9NMXy9p7Qv+OuieNL4ZxPvliK3izhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644503800;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgJyvyRh3cX5zcvNZulF4jph40K15JEIYzrGaa90f7o=;
        b=9hluyi4pJFdHMTJSyNGeW1kzAd0tbvMoDgzMHj9WR3DNbhkWItL7cJHMCiwA8xlxbJkANz
        qb57fND1Mo1q7GCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E23DA3B8A;
        Thu, 10 Feb 2022 14:36:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 977AADA9BA; Thu, 10 Feb 2022 15:32:58 +0100 (CET)
Date:   Thu, 10 Feb 2022 15:32:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: introduce a minimal zone size and reject
 mount
Message-ID: <20220210143258.GP12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <3824ae6295104af815c8357525eaa896e836eb1c.1644500637.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3824ae6295104af815c8357525eaa896e836eb1c.1644500637.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 05:47:05AM -0800, Johannes Thumshirn wrote:
> When creating a filesystem on a zoned block device with a zone size of
> 32MB or 16MB successive mounting of this filesystem fails with the
> following error message:
>  host:/ # mount /dev/nullb0 /mnt/
>   BTRFS info (device nullb0): flagging fs with big metadata feature
>   BTRFS info (device nullb0): using free space tree
>   BTRFS info (device nullb0): has skinny extents
>   BTRFS info (device nullb0): host-managed zoned block device /dev/nullb0, 400 zones of 33554432 bytes
>   BTRFS info (device nullb0): zoned mode enabled with zone size 33554432
>   BTRFS error (device nullb0): zoned: block group 67108864 must not contain super block
>   BTRFS error (device nullb0): failed to read block groups: -117
>   BTRFS error (device nullb0): open_ctree failed
>  mount: /mnt: wrong fs type, bad option, bad superblock on /dev/nullb0, missing codepage or helper program, or other error.
> 
> This happens because mkfs.btrfs places the system block-group exactly at
> the location where regular btrfs would have it's 1st super block mirror.
> In case of a 16MiB filesystem, mkfs.btrfs will place the 1st metadata
> block-group at this location.
> 
> As the smallest zone size on the market today is 64MiB and we're expecting
> zone sizes to be more in the 256MiB - 4GiB region, refuse to mount a
> filesystem with a zone size of 32MiB or smaller.

Nooooo, I've been using 4MiB zones for testing, it's an excellent setup
to trigger all sorts of bugs. The 64MiB zone size is problematic for the
reason you say but I think it's an outlier, so maybe add it as an
exception.
