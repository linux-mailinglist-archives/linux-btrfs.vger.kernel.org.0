Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F034BBD62
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiBRQVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 11:21:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbiBRQVM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 11:21:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062C33E8E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 08:20:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1A05219A9;
        Fri, 18 Feb 2022 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645201252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISbfbzXij/Qvf58rOpBHTZolPFonmSmMKa3DsIz2QJU=;
        b=o1wyaUG/sHy0WYXmvhN3cwc7bcbyENth1tZRK9tArdOPOMy7gOivk/zoywzIqOk4v43O17
        58eUtcUkmL4HMpVGAgtxQOM0szWrRMeVfbCQeFu7+cbUS+qgBkXGWUdt4GjqB8UcnLuiVk
        Wu6QhhTgL3PRw/Bq157k7Erdv3tcYy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645201252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISbfbzXij/Qvf58rOpBHTZolPFonmSmMKa3DsIz2QJU=;
        b=c4L2L9sKJx5q0TbDPBuroE8HKM3HpMfJNXyG37fURBzudkH5FWJYPzgqCvBf9jv3y7UQuI
        FKMzAqtWWlbEhODA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AA8EEA3B89;
        Fri, 18 Feb 2022 16:20:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0FB77DA829; Fri, 18 Feb 2022 17:17:06 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:17:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/8] btrfs: handle csum lookup errors properly on reads
Message-ID: <20220218161706.GY12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645196493.git.josef@toxicpanda.com>
 <5b9da7cdf4f3bb6edbf6e52313f8451be10f56a6.1645196493.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9da7cdf4f3bb6edbf6e52313f8451be10f56a6.1645196493.git.josef@toxicpanda.com>
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

On Fri, Feb 18, 2022 at 10:03:23AM -0500, Josef Bacik wrote:
> +		/*
> +		 * We didn't find a csum for this range.  We need to make sure
> +		 * we complain loudly about this, because we are not NODATASUM.
> +		 *
> +		 * However for the DATA_RELOC inode we could potentially be
> +		 * relocating data extents for a NODATASUM inode, so the inode
> +		 * itself won't be marked with NODATASUM, but the extent we're
> +		 * copying is in fact NODATASUM.  If we don't find a csum we
> +		 * assume this is the case.
> +		 *
> +		 * TODO: make the relocation code look up the owning inode and
> +		 * see if it's marked as NODATASUM and set EXTENT_NODATASUM
> +		 * there, that way if there's corruption and there isn't a
> +		 * checksum when we want it we can fail here rather than later.

Please don't add TODOs to the code, that's the best place to forget
about them, we've had some unfixed for years.
