Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08F53CD81
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbiFCQt2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344078AbiFCQt1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 12:49:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0E4D62E
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 09:49:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 713EB219F3;
        Fri,  3 Jun 2022 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654274964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQmp/eW4J2f9grruGoyP3htwn0lfEvlOdIQ3KIxLwNg=;
        b=NTxGRDlcFlq3sgrQqII5Z0Cz/E71/A+8lKkI+u+iZ+mfi0zTRKm+OAAmslC41IQxcrYl2z
        D2WarBo26386G7U/TH/p20V8P80NlHNFQv/Zs6Q39leweX8k+KEOUL8b2v+1RWKeaJtHfv
        /cRU0xaCvkAvoOCOzguAkM/MBYR4UVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654274964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQmp/eW4J2f9grruGoyP3htwn0lfEvlOdIQ3KIxLwNg=;
        b=q56VzrQBstRgicnwWTn53lpUmmcnlQs90Z/acQ12O5utsd3V59dZcXZbTZfYENzRmcgU8w
        KEXHfsmBNAgxEQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D02613AA2;
        Fri,  3 Jun 2022 16:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4IIdDpQ7mmK/SwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 03 Jun 2022 16:49:24 +0000
Date:   Fri, 3 Jun 2022 18:44:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/10] btrfs: defer I/O completion based on the
 btrfs_raid_bio
Message-ID: <20220603164456.GW20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220429143040.106889-1-hch@lst.de>
 <20220429143040.106889-6-hch@lst.de>
 <4e93a857-43f2-9e67-9ef8-4db00edd2f6c@gmx.com>
 <6dba9162-c64d-2d27-12eb-d48ac6a4ac8a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dba9162-c64d-2d27-12eb-d48ac6a4ac8a@gmx.com>
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

On Sun, May 01, 2022 at 12:53:00PM +0800, Qu Wenruo wrote:
> On 2022/5/1 12:40, Qu Wenruo wrote:
> > On 2022/4/29 22:30, Christoph Hellwig wrote:
> >> Instead of attaching a an extra allocation an indirect call to each
> >> low-level bio issued by the RAID code, add a work_struct to struct
> >> btrfs_raid_bio and only defer the per-rbio completion action.  The
> >> per-bio action for all the I/Os are trivial and can be safely done
> >> from interrupt context.
> >>
> >> As a nice side effect this also allows sharing the boilerplate code
> >> for the per-bio completions
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > It looks like this patch is causing test failure in btrfs/027, at least
> > for subapge (64K page size, 4K sectorsize) cases.
> 
> Also confirmed the same hang on the same commit on x86_64 (4K page size
> 4K sectorsize).
> 
> Also 100% reproducible.

The test passes on my VM setup, the whole suite was run on the patchset
at least twice.
