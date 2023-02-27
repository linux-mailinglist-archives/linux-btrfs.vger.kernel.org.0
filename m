Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385136A4DE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 23:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjB0WTw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 17:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB0WTw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 17:19:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B54B442
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 14:19:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8E1F1FDA0;
        Mon, 27 Feb 2023 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677536389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79s+GLAeAh2sqlFYjmkHwdNGgEs7/a1VELt435q89R8=;
        b=3F8jr9k11FoJGHp33Nmk/ERgONTOgy0uzglQpowSiiC6ae4u/D1yv6iak1Jd0UcNHkgl0g
        4t3AvDDeKKCWPqOuC/+5sIgt2r1VOJV4IT9y2XHdhIyFPlP4t3xyJJ7vvqO+6o408hednE
        bTReApfpraUHkvA3E1otqVTbtXIu/wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677536389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79s+GLAeAh2sqlFYjmkHwdNGgEs7/a1VELt435q89R8=;
        b=tUkhKecLxyFctdWE6Uz9X12z4YRGB2WjQF6/DcuJjnLx2GoSPl7dNrmGRxI7zsec93SeRs
        eIO/r+14QAm8QvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80C9F13912;
        Mon, 27 Feb 2023 22:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v8zBHYUs/WNbTwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 22:19:49 +0000
Date:   Mon, 27 Feb 2023 23:13:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs_lookup_bio_sums v2
Message-ID: <20230227221350.GN10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230222170702.713521-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222170702.713521-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 09:07:00AM -0800, Christoph Hellwig wrote:
> Hi all,
> 
> this series takes advantage of the file_offset now provided in each btrfs_bio
> to clean up btrfs_lookup_bio_sums.
> 
> Changs since v1:
>  - keep the count variable signed
>  - remove the search_len variable

Added to misc-next, thanks.
