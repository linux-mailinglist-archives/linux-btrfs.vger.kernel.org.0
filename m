Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D47D3F86
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjJWSte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWStd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 14:49:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88588127
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 11:49:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 039F51FD80;
        Mon, 23 Oct 2023 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698086970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vcyzo9rT5KRYVMAzbC/vK/mq70r5GzOzj9SOHEA4S6I=;
        b=qm0+nbZBjuyxNLDhN2cjhcsOC5za2fV/oqimV91Af3GlTv4x8y1QJxoTk1qTjpLZjl9DfZ
        ncR/rYZlDUtcG6Wr//kDv07O1nu/U4+BmW52s8kez4f7oLTe34ira+tbkBXDALlblKIHSt
        vDMtDgcGNxfFqcLP6PK/URkXUsyeAyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698086970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vcyzo9rT5KRYVMAzbC/vK/mq70r5GzOzj9SOHEA4S6I=;
        b=dDo/jx+dZZydzTOPL5mhr6wIm5uosX5I9totwQOLHE+95Ws1YJMq76PAE5/ZkC2ODaV3mC
        ngrbRxundKebbOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5D6B139C2;
        Mon, 23 Oct 2023 18:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /mZ3LznANmX2dAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 23 Oct 2023 18:49:29 +0000
Date:   Mon, 23 Oct 2023 20:42:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a corruption after snapshoting a new
 subvolume
Message-ID: <20231023184236.GM26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697716427.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697716427.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.62
X-Spamd-Result: default: False [-5.62 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.82)[93.95%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 19, 2023 at 01:19:27PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with kernel 6.5, we no longer commit the transaction used to
> create a subvolume when we finish creating the subvolume. This behaviour
> was introduced for performance reasons and done with commit 1b53e51a4a8f
> ("btrfs: don't commit transaction for every subvol create"). However this
> allows for a corruption if we snapshot a subvolume created in the current
> transaction, where basically we get a snapshot root that points to an
> extent buffer that was not written. This makes attempt to read the extent
> buffer later to fail, either with the infamous "parent transid verify
> failed ..." error or with checksum failures.
> 
> More details on the changelog of the first patch, and the remaining patches
> are just cleanups.
> 
> Filipe Manana (3):
>   btrfs: fix unwritten extent buffer after snapshoting a new subvolume
>   btrfs: use bool for return type of btrfs_block_can_be_shared()
>   btrfs: make the logic from btrfs_block_can_be_shared() easier to read

Thanks for catching it and for the fix, patch has been meanwhile merged
to 6.6-rc7 so it'll be in the next stable update.
