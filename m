Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04DA587D0B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbiHBN0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHBN0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 09:26:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8815FC3
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:26:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 894C11FECD;
        Tue,  2 Aug 2022 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659446776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4db24kbMBVt7QagB/IIS51hpC6avQXek2sR4SA9yscI=;
        b=GWDLsQkJCJc3R9+zuYkq3HAK7Fm/vuzP/6W7jsK+xarD3DIeQ9GYs/HASUaO/PaZwpeFkH
        shvyl33EuVMgXMrjXRL2Nn17yP/huA9+c5jWYOfBnPVbDHMofiv9STlnnZS4vs+Hlm3/qk
        Q+5HQN7LxCf+xMSHx0cHA8e32iNUxAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659446776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4db24kbMBVt7QagB/IIS51hpC6avQXek2sR4SA9yscI=;
        b=M/neZgmyx96/YR20j/fkYVblyrtvCkQVczs6v7M08PShuKr620PDddYypnmMGlkAnaeZ1M
        fsvIKQHDDsE/60Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B9D71345B;
        Tue,  2 Aug 2022 13:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SNtmGfgl6WLlWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 13:26:16 +0000
Date:   Tue, 2 Aug 2022 15:21:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] btrfs: add checksum implementation selection
 after mount
Message-ID: <20220802132114.GK13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1659443199.git.dsterba@suse.com>
 <cc590040e5393aad0294e3d7c592de991706cf2e.1659443199.git.dsterba@suse.com>
 <PH0PR04MB7416F25B2C1D7CACC27F83859B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416F25B2C1D7CACC27F83859B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 01:00:28PM +0000, Johannes Thumshirn wrote:
> On 02.08.22 14:33, David Sterba wrote:
> > +static bool strmatch(const char *buffer, const char *string);
> > +
> > +static ssize_t btrfs_checksum_store(struct kobject *kobj,
> > +				    struct kobj_attribute *a,
> > +				    const char *buf, size_t len)
> > +{
> > +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> > +
> > +	if (!fs_info)
> > +		return -EPERM;
> > +
> > +	/* Pick the best available, generic or accelerated */
> > +	if (strmatch(buf, csum_impl[CSUM_DEFAULT])) {
> 
> Same question as with v1, why not sysfs_streq()?

The semantics a bit different with our strmatch that skips initial
whitespace, but otherwise should be same. Nevertheless we should
probablly drop strmatch and use sysfs_streq. I'll change it in this
patch and send another to delete the other one.
