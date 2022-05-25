Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBBC5344CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 22:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiEYUYj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 16:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiEYUYi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 16:24:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B6113CD4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 13:24:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79CFA219E2;
        Wed, 25 May 2022 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653510275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPXITPQ0INqZCwrXT1FwpJXDhc8j58oExJAEoV78vbg=;
        b=LSHaVwehVgPmuJIxlYO8gc81WEXzMgg3cI8bsSDe+vZxKvpVfep4u6r1ww1lulfEtjco9k
        upJbj/h1w8eQF/t/tBcaeMoIUDC+lrt9ePFEvTnMTefRAJVEgRJQVHp2PekrIAOnHGGDOh
        xZ1yWBI1wR91IfAozd++aRDSpn7lAlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653510275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPXITPQ0INqZCwrXT1FwpJXDhc8j58oExJAEoV78vbg=;
        b=pjIxdqVc0siyfaODglnIRDvzWuUssAEei+T38XkTo3E/gVTS087+dJS1piuBbJTN7qbIrG
        FQMGkY5cpg1DVDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BA9913ADF;
        Wed, 25 May 2022 20:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X9BuEYOQjmJXfQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 May 2022 20:24:35 +0000
Date:   Wed, 25 May 2022 22:20:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: misc btrfs cleanups
Message-ID: <20220525202012.GF22722@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522114754.173685-1-hch@lst.de>
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

On Sun, May 22, 2022 at 01:47:46PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a bunch of random cleanups and factored out helpers split
> from the read repair series.

Thanks, I went through it, did some coding style fixups. Now it's under
tests and I'll move it to misc-next after that so the repair changes can
be based on that.
