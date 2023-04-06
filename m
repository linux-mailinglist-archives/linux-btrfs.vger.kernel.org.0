Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD96D9D0B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbjDFQGh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbjDFQGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 12:06:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF3976F;
        Thu,  6 Apr 2023 09:06:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FF681F7AB;
        Thu,  6 Apr 2023 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680797187;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aVV3RmEHolDPVdcV/kckRLrvlkisCHD6kofnIT3jEsE=;
        b=T8HJvX+SVW4kQnpJRtHZr+8VpQq/7KUsKZvtqFrM2Qy+kqmpmyblnHrbESwqA+8ME1oGIH
        va/ZBBpydMjLc9FYGpfkgXHy5328H+qPoEgfG5+awssG1kyhxFK2wI2oyxQjMzutY987TO
        5wPuQWJh7sOcQKOQpHz9l+f8070YwDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680797187;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aVV3RmEHolDPVdcV/kckRLrvlkisCHD6kofnIT3jEsE=;
        b=PG1RH/ULvwN2JlpmtD3qXbKZXNsrL6zigIbOO35+4E3FGnatOMiU0WnRlDImISlDYlu1/O
        KLTOyZdH2OThjdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E942D1351F;
        Thu,  6 Apr 2023 16:06:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T5U6OALuLmSQawAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 16:06:26 +0000
Date:   Thu, 6 Apr 2023 18:06:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Carpenter <error27@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: use safer allocation function in
 init_scrub_stripe()
Message-ID: <20230406160624.GW19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
 <ZC7hjYQOR7owkzmH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC7hjYQOR7owkzmH@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 06, 2023 at 08:13:17AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 06, 2023 at 11:56:44AM +0300, Dan Carpenter wrote:
> > It's just always better to use kcalloc() instead of open coding the
> > +	stripe->csums = kcalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits),
> 
> The inner braces can and should go away now.

Right, thanks, commit updated.
