Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED06E5060
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDQSqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQSqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 14:46:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336797
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 11:46:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C1A7219EC;
        Mon, 17 Apr 2023 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681757204;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eDaHqBZ59NI164aHOkvr1RWJWfQISP66D+etIQjzAp4=;
        b=uIOWvmoz5w68+9DRi+SmIOin37ewJX3T8MwYfTn5c7gfU4myLNnCZOiom4shxnnlHOBmw5
        uRNgzepCf3YP8ckZ4Vh0Nd9kYdfyaVP/YtBPOINEJXcBM/c93KbaoKPoNgzrzJ+kM7eUiY
        wqhAvNHcNcP/Tgj+kEZtXXplxVATWsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681757204;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eDaHqBZ59NI164aHOkvr1RWJWfQISP66D+etIQjzAp4=;
        b=PQ80e052U2EK0E+z4tFVdFtHsCYlaiH3c4eMY406MUE7pDM2ySm8ybPb6zHDPmHEdae1eN
        12OUEfVaFzXfCBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 081E013319;
        Mon, 17 Apr 2023 18:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yPMdARSUPWS2GwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Apr 2023 18:46:44 +0000
Date:   Mon, 17 Apr 2023 20:46:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
Message-ID: <20230417184635.GL19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 11, 2023 at 03:10:53PM -0400, Sweet Tea Dorminy wrote:
> Recently a Meta-internal workload encountered subvolume creation taking
> up to 2s each, significantly slower than directory creation. As they
> were hoping to be able to use subvolumes instead of directories, and
> were looking to create hundreds, this was a significant issue. After
> Josef investigated, it turned out to be due to the transaction commit
> currently performed at the end of subvolume creation.
> 
> This change improves the workload by not doing transaction commit for every
> subvolume creation, and merely requiring a transaction commit on fsync.
> In the worst case, of doing a subvolume create and fsync in a loop, this
> should require an equal amount of time to the current scheme; and in the
> best case, the internal workload creating hundreds of subvols before
> fsyncing is greatly improved.
> 
> While it would be nice to be able to use the log tree and use the normal
> fsync path, logtree replay can't deal with new subvolume inodes
> presently.
> 
> It's possible that there's some reason that the transaction commit is
> necessary for correctness during subvolume creation; however,
> git logs indicate that the commit dates back to the beginning of
> subvolume creation, and there are no notes on why it would be necessary.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

For subvolume creation the situation is much easier than with deletion,
as said by others, the semantics is similar to creating a directory,
fsync works to make sure the data are persistent.

So I think it's safe and allows the use case of creating many subvolumes
without the full transaction commit overhead. And we don't need the
commandline options. Added to misc-next, thanks.
