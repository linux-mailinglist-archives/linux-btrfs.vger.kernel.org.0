Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592BD5F7B82
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJGQcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJGQcu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 12:32:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB9212BB9F
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 09:32:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDE1C21941;
        Fri,  7 Oct 2022 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665160367;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwIbSaIytAvqm2B7cdykxoESmnT1k0AtWWOqajKyjgU=;
        b=Uv55K/4wQHCScxT2ONfm7Djt6h9m4pBc2l/v++TNE/SGRRAAddLCkWhaUoYmGdSkKg2fdw
        Qs+6GUf+BeZl0eAnpoFHtwjRID2C53pzvKZ+cyLrg0wp9YzFsX/09JcYEAH3opb/JVrrtp
        ETCWU7sEMIfBwikARdY2gCH4qYotGFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665160367;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwIbSaIytAvqm2B7cdykxoESmnT1k0AtWWOqajKyjgU=;
        b=iMDInBoTROqsLkAv9rKxU5XtvBrazjt0SLt2nPhD9xWIdzkncJbEJP/cSEcQqrSZvEumQc
        z1Wawj91j4h4xLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87B1C13A3D;
        Fri,  7 Oct 2022 16:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VVTpH69UQGMXRgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 16:32:47 +0000
Date:   Fri, 7 Oct 2022 18:32:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove redundant code
Message-ID: <20221007163244.GS13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAPm50a+6tGRCkB7=QiA+y5EEPm_40N6d-KChPxnT+40Q=5EUQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50a+6tGRCkB7=QiA+y5EEPm_40N6d-KChPxnT+40Q=5EUQw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 10:56:12PM +0800, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Since leaf is already NULL, and no other branch will go fail_unlock,
> the fail_unlock branch is useless.

The patch does not aply cleanly, git am says it's corrupted on line 10
but I don't see anything obvious.

The change makes sense, I'll change the subject to "btrfs: simplify
cleanup after error in btrfs_create_tree" and add it to misc-next,
thanks.
