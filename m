Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E56CCA09
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjC1Sax (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 14:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjC1Sau (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 14:30:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D3199D
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 11:30:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0526A219F2;
        Tue, 28 Mar 2023 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680028243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6WIB6/zhZjsjYBgxkjAsZ8X8ct3S6Jc4Au1M8dvGYo=;
        b=EIrgokcwonDDi6nL8tKSD/vQcfdMAZkSyOx8pilu7rp93qOatvjwkZaD/YSE++4Yu8uGww
        foL9TxHVmf20tHniY6ZNrM/bJz8j8K47OoEySis1kqDN6jFGKDNQ/pYnC1o90o5H3f3VnO
        ZVzuiHV5XTYHhMzbUIzmab6KI1RtvzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680028243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6WIB6/zhZjsjYBgxkjAsZ8X8ct3S6Jc4Au1M8dvGYo=;
        b=b9njfdMoQus68Ez0xILJ0ptRVzE34eX+z/sRMHeX9xdUx+HDshARsYDeqeF/AvP4jVfQrJ
        bO92gcL5+s1mpRCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D01C21390B;
        Tue, 28 Mar 2023 18:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZrAMMlIyI2S8dgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Mar 2023 18:30:42 +0000
Date:   Tue, 28 Mar 2023 20:24:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs: fix corruption caused by partial dio writes v7
Message-ID: <20230328182428.GN10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230328051957.1161316-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328051957.1161316-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 02:19:46PM +0900, Christoph Hellwig wrote:
> [this is a resend of the series from Boris, with my changes to avoid
>  the three-way split in btrfs_extract_ordered_extent inserted in the
>  middle]
> 
> The final patch in this series ensures that bios submitted by btrfs dio
> match the corresponding ordered_extent and extent_map exactly. As a
> result, there is no hole or deadlock as a result of partial writes, even
> if the write buffer is a partly overlapping mapping of the range being
> written to.
> 
> This required a bit of refactoring and setup. Specifically, the zoned
> device code for "extracting" an ordered extent matching a bio could be
> reused with some refactoring to return the new ordered extents after the
> split.
> 
> 
> Changes since v6:
>  - use ERR_CAST
>  - clarify a commit log

I'll add this to for-next for a day in case there's another iteration,
but I'm expecting to be the final version so it'll be in misc-next by
the end of the week. Thanks.
