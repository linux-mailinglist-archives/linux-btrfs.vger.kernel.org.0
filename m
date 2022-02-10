Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512DD4B14AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 18:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiBJRzp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 12:55:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiBJRzp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 12:55:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB51A8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 09:55:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EC41921121;
        Thu, 10 Feb 2022 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644515744;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKjL0J3sTc6OlgZRPP4gu67FmZQ/HtT094TZhvz2bdI=;
        b=TEuEzLW1SfoGvtLSkObaW5SlMR+hj66hVmBG7RbyGtamN2pSWKz2J14vQ2TaK1M86hDmJ4
        MWjqRjUBwPLBkPVgtnqrhKAUomPQrlzVaBeZuPHjpwk2ocerbWciuDnOheKLdhJ0vcHhiH
        0AxfJCNsHngSckJtpVixo/e+KnxJ2v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644515744;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKjL0J3sTc6OlgZRPP4gu67FmZQ/HtT094TZhvz2bdI=;
        b=QO/WKMrXcA/R5/YBzCH7ua3+4Vu+vxLEoiDihpayN2X8pppHKOfjOUCDCTnfCYG3HASoaB
        IquoanvKQedD6uCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E4B36A3B83;
        Thu, 10 Feb 2022 17:55:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C612DA9BA; Thu, 10 Feb 2022 18:52:03 +0100 (CET)
Date:   Thu, 10 Feb 2022 18:52:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: remove redundant check in up
 check_setget_bounds
Message-ID: <20220210175203.GU12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1643904960.git.dsterba@suse.com>
 <0cccec1104fd7058b4b19c6960dd4c10da646058.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cccec1104fd7058b4b19c6960dd4c10da646058.1643904960.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 03, 2022 at 06:26:24PM +0100, David Sterba wrote:
> There are two separate checks in the bounds checker, the first one being
> a special case of the second. As this function is performance critical
> due to checking access to any eb member, reducing the size can slightly
> improve performance.
> 
> On a release build on x86_64 the helper is completely inlined so the
> function call overhead is also gone.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

This patch can be applied standalone, it's a perf optimization. I'll
update the changelog with numbers that I measured back then (it's
mentioned in the cover letter). The rest of the series will be reworked.
