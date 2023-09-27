Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1427B0B58
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjI0R4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0R4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:56:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F65A1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:56:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69B29218E4;
        Wed, 27 Sep 2023 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695837392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJuieW6XRWGgSFm38Rb+PUJHm1f0TSLkt9It7wrgEbs=;
        b=yNFdWE62t7FGWuBxIWffnmIp66AvwAd6lIT81NAKZNHLjaVZSDJkZb1pq/Vc4h9tSCJsO7
        k1+r6+cIH1Wux239rTotGlsOxTX2oidyFbfgmZtNVA7izPnEGFr447GkZm8a777NPxB/9S
        7xjdqYeVw8JSs5FKODnkJYLGFiSx8nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695837392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJuieW6XRWGgSFm38Rb+PUJHm1f0TSLkt9It7wrgEbs=;
        b=OKWIfNQJVOWZjBx7o5CW9L8BnnrwphDFBxoB7x89WEnANJk1ySZRew3SpS3YIpcS1X/EtN
        WtfdGkK6fJl7+gCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AAC113479;
        Wed, 27 Sep 2023 17:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RXJaEdBsFGVONwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Sep 2023 17:56:32 +0000
Date:   Wed, 27 Sep 2023 19:49:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH] btrfs: qgroup: fix double unlock in btrfs_quota_disable
Message-ID: <20230927174954.GC13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ed61ba7891b9f86a20a46ee5bb42cb4649311af.1695833099.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed61ba7891b9f86a20a46ee5bb42cb4649311af.1695833099.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 09:45:14AM -0700, Boris Burkov wrote:
> Flushing reservations in quota disable is done while we do not hold the
> qgroup ioctl lock, therefore jumping to releasing that lock on failure
> is wrong. We don't have the transaction handle yet, either, so just jump
> to unlocking the cleaner mutex. This was found by smatch.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-btrfs/dfadfecc-e50b-425a-80f7-3ae1290db2d3@moroto.mountain/T/#u
> Fixes: 5e99a45f1f0f ("btrfs: qgroup: flush reservations during quota disable")
> Signed-off-by: Boris Burkov <boris@bur.io>

Folded to the commit, thanks.
