Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01952A157
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbiEQMR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 08:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiEQMRz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 08:17:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726347072
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 05:17:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25FE71F8CA;
        Tue, 17 May 2022 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652789873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6mwB3KSJlss2KF/JHxilYMSlGCpHK01NyflNcrWq9qc=;
        b=Ymk3gx4iPdKLpHvI9lCmQgd7Oih5Vr4GozT4/39+1qVGJWBOX4p+yxeNAA7xdyfk3v0fkR
        ikN2Vf+fEj+5z3X7Nnf2yZBsbXIPAtfTkrow68XjCnnSrlxx3YKCbhWlm9vxymPk74NpTy
        xj7DUegcKT66H1ypcM4L/GUporFRXGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652789873;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6mwB3KSJlss2KF/JHxilYMSlGCpHK01NyflNcrWq9qc=;
        b=vCMnWgSeasNcuHazP3dj7gJlGSLCFtI8OrQtww9mGuNnTM1HRnnVwjF1OIe9pGtfYMjdDx
        KUj0yACCjhGKMxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E49DF13305;
        Tue, 17 May 2022 12:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tpfzNnCSg2L9DgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 12:17:52 +0000
Date:   Tue, 17 May 2022 14:13:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com, dsterba@suse.com,
        gost.dev@samsung.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs:zoned: Fix comment description for
 sb_write_pointer logic
Message-ID: <20220517121334.GB18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com, dsterba@suse.com,
        gost.dev@samsung.com, linux-btrfs@vger.kernel.org
References: <CGME20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404@eucas1p2.samsung.com>
 <20220517082255.28547-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517082255.28547-1-p.raghav@samsung.com>
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

On Tue, May 17, 2022 at 10:22:55AM +0200, Pankaj Raghav wrote:
> The comments describing the logic for evaluating the sb write pointer
> does not represent what is done in the code. Fix it to represent the
> actual logic used.

It would be good to briefly describe what is the actual mistake in the
comment, so one can have an idea without looking to the code.
