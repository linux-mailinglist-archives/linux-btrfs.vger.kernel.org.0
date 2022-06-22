Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80405549AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357527AbiFVLon (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356969AbiFVLom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 07:44:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EF2F678
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 04:44:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 589721FB3B;
        Wed, 22 Jun 2022 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655898280;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z5qhTa6VB3poaZ/YQ4/xV+4oE5/Qv/InUUmM7fFbDKI=;
        b=fMQgoDC0vL95kZLHuqnltiyv4t4AlK+/RujGigPDWp7KShZ6i84heGF8wGz2ctAnFXH9p0
        maMpRph+1gFi9jN4Z6pDHM20LNPRvCHUu/kb0HxhFlzsJJB4B9JPIydna0BfnCEIH3IOFB
        3H10oGFIsIJwWRC8FPg7rQYrBcrI3JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655898280;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z5qhTa6VB3poaZ/YQ4/xV+4oE5/Qv/InUUmM7fFbDKI=;
        b=AD05dxrIbNT/7pL17OpYcsQLAQJ14dyxQtk/7h2YwFTYWDQQdTsPVMhQIKmq9et+TZpFe8
        Inhnpby3/a8yI6BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B87E13A5D;
        Wed, 22 Jun 2022 11:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id itChCagAs2J3dQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 11:44:40 +0000
Date:   Wed, 22 Jun 2022 13:40:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        hannes@cmpxchg.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove ->writepage
Message-ID: <20220622114002.GF20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        hannes@cmpxchg.org, linux-btrfs@vger.kernel.org
References: <20220621074944.2742214-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621074944.2742214-1-hch@lst.de>
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

On Tue, Jun 21, 2022 at 09:49:44AM +0200, Christoph Hellwig wrote:
> ->writepage is only used for single page writeback from memory reclaim,
> and not called at all for cgroup writeback.  Follow the lead of XFS
> and remove ->writepage and rely entirely on ->writepages.

I've looked up the commit from xfs, 21b4ee7029c9 ("xfs: drop ->writepage
completely"), there's a longer explanation so I'll copy a bit of it.
Thanks.
