Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EEE4FC2A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbiDKQpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiDKQpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 12:45:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED436324
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 09:43:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 004721F38D;
        Mon, 11 Apr 2022 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649695408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXxxWqqdGX8yRebT1xE2lmcPXNyLqB+qFjm2uuOTCQo=;
        b=RwD0x478BOSAbgf29a/9yaLeJV4yzaeFg9ZqqjMYj6dFwR0H0mgrV4V1Ht3n4oEltYw5Qp
        qIJVZDCm040T7yBDd7VFQJl7RGqG4JLG3SxcdNpwSDWxa26j5w+ncYfzwiw8WqLwc3Ju1q
        T54rs2ySvN57Z0HYie29eyj3aam+KyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649695408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXxxWqqdGX8yRebT1xE2lmcPXNyLqB+qFjm2uuOTCQo=;
        b=C1oxpN0/jRxtkS9wl2kL7+ubvJ3NtEyYNMrDTD9jS0FUmYcyzdSVeW3ogmT6fzQBCO2bsq
        wAMzGhEPg26rTODw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BFEF2A3B82;
        Mon, 11 Apr 2022 16:43:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3FDE0DA7F7; Mon, 11 Apr 2022 18:39:23 +0200 (CEST)
Date:   Mon, 11 Apr 2022 18:39:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs zoned fixlets
Message-ID: <20220411163923.GQ15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220324165210.1586851-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324165210.1586851-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 05:52:08PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes a minor and slightly less minor problem in the btrfs
> zoned device code.  Note that for the second patch the comment might
> not be correct any more - AFAICS 5.18 added support for the dup
> profile for zoned devices, which means we do have a real issue now
> if different devices have different hardware limitations.  I think we'll
> need some code to check that all zoned devices have the exact same
> hardware limits (max_sectors, max_segments, max_segment_size,
> queue_boundary, virt_boundary), but I don't know the code well enough
> to implement that myself
> 
> Found by code inspection as part of my bio cleanups.

Added to misc-next, thanks.
