Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7893B59C56E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiHVRvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbiHVRvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 13:51:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F345F43
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:50:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F2EB1F9B0;
        Mon, 22 Aug 2022 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661190655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ildi23ruo184acqYecilr+N/CGWfZhrHycXrvIvJFls=;
        b=fn5UA7iZ52e8IfC3vsTF5Dy1yhV29jthglFZzMQNh/1W6i4Bz1HwCB6E2X/hmd6yP1YdDs
        2A4gjTUPT3dNVgcJopgxKRNokq87VJT8QAs7CmaqRNki5WZ5ci3XNMTafEtlIY/qhrpDUC
        gFcdZA95yqZtUyhuplsJUXNWBb7Hpaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661190655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ildi23ruo184acqYecilr+N/CGWfZhrHycXrvIvJFls=;
        b=rX0TcK9JX43A0qY+G/63rq8n2lx2i3OV7KPXPF4jse53oJvMj6Qag4wdZl29+0+gCbv0Xw
        5X0O6cQTN6gH57Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6102F1332D;
        Mon, 22 Aug 2022 17:50:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tLeNFv/BA2NWTQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 17:50:55 +0000
Date:   Mon, 22 Aug 2022 19:45:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5]  btrfs: qgroup: address the performance penalty
 for subvolume dropping
Message-ID: <20220822174541.GB13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1657260271.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657260271.git.wqu@suse.com>
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

On Fri, Jul 08, 2022 at 02:07:25PM +0800, Qu Wenruo wrote:
> Changelog:
> v2:
> - Split /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags into two
>   entries
> 
> - Update the cover letter to explain the drop_subtree_threshold better
> 
> v3:
> - Rebased to latest misc-next

I'll add this to misc-next, but regarding the overall design how to
set/unset the quota recalculation I'm not sure it's a clean solution.
