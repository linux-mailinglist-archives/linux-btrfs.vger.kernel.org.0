Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46E87D3A32
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjJWO7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjJWO7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 10:59:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5569C
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 07:59:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47F2E1FE1F;
        Mon, 23 Oct 2023 14:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698073172;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4bFzBuuMWQ865Mmmz07ONhbd9sz9ikXu1TcexgSr3S8=;
        b=ANPo6s8aNeqqsiyb5u1v/I3EVHQyRoren3RteOlHhXK4qevHkS2CAdMYLWMvBdkBmQQFlt
        Nrwuw2jCoz4I5NqK3Iam+Z30PqNkrB7OPWL17QvGOr8DbqIZkhk1orpfDl5DprhreqKhRc
        9lM8kIDAdAQViehWHJzdfYtd/ohKzpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698073172;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4bFzBuuMWQ865Mmmz07ONhbd9sz9ikXu1TcexgSr3S8=;
        b=PnF1cTX0IbN4TuxrftgdgDuJ/4+oK5J/sPzJ6WnYpZNWS5n8lwxBBmECx1E9cbDNiT1dMf
        huCH0iXBXrByAoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CFE8139C2;
        Mon, 23 Oct 2023 14:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LlImBlSKNmU8AQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 23 Oct 2023 14:59:32 +0000
Date:   Mon, 23 Oct 2023 16:52:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: get correct owning_root when dropping snapshot
Message-ID: <20231023145238.GJ26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2bd997ea59e43e8f7db0f8fd8c8f3d85d0ff0c06.1697224683.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd997ea59e43e8f7db0f8fd8c8f3d85d0ff0c06.1697224683.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.46
X-Spamd-Result: default: False [-6.46 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.66)[98.49%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 13, 2023 at 03:18:17PM -0400, Josef Bacik wrote:
> Dave reported a bug where we were aborting the transaction while trying
> to cleanup the squota reservation for an extent.
> 
> This turned out to be because we're doing btrfs_header_owner(next) in
> do_walk_down when we decide to free the block.  However in this code
> block we haven't explicitly read next, so it could be stale.  We would
> then get whatever garbage happened to be in the pages at this point.
> 
> Fix this by saving the owner_root when we do the
> btrfs_lookup_extent_info().  We always do this in do_walk_down, it is
> how we make the decision of whether or not to delete the block.  This is
> cheap because we've already done the extent item lookup at this point,
> so it's straightforward to just grab the owner root as well.
> 
> Then we can use this when deleting the metadata block without needing to
> force a read of the extent buffer to find the owner.
> 
> This fixes the problem that Dave reported.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next with the note about the commit that introduced it.
