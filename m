Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CC4E5A8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 22:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiCWVVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 17:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCWVVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 17:21:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713BC5FDD
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 14:20:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 297C41F38C;
        Wed, 23 Mar 2022 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648070401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5jPZE1xV/gnRYd6Jz1kmJNOQM3qJuJhG8759qMWvmY=;
        b=VAhhHNUlvTo4XIb5GkcOEdNy07cJPfYaG6/i6LBjNO9Mt2s9fx3jeIWFEwPeo5QRYXM/Vu
        jbbbcS2lAfdopQbhtqvgMqodzCl7tqGB7YY89mp5lOf50J7ax8lzbebBrgHRJoFvY7HrCo
        tGvktm1wPs3kVM3YeE22MtPCO8HvVfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648070401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5jPZE1xV/gnRYd6Jz1kmJNOQM3qJuJhG8759qMWvmY=;
        b=1zDMMm3nZJDHsUTgOUzkxvhbmvJJBuduxC4D+80jAep2yR9WBgy1xnq9gtYg7y+utABz5W
        xTsiIMSUIy0HVcCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 20D33A3B83;
        Wed, 23 Mar 2022 21:20:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8B78DA7DA; Wed, 23 Mar 2022 22:16:06 +0100 (CET)
Date:   Wed, 23 Mar 2022 22:16:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not warn for free space inode in cow_file_range
Message-ID: <20220323211606.GE2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <ae796792f263dd906ce5f3962c6bddec6b8048e3.1648049428.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae796792f263dd906ce5f3962c6bddec6b8048e3.1648049428.git.josef@toxicpanda.com>
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

On Wed, Mar 23, 2022 at 11:30:36AM -0400, Josef Bacik wrote:
> This is a long time leftover from when I originally added the free space
> inode, the point was to catch cases where we weren't honoring the NOCOW
> flag.  However there exists a race with relocation, if we allocate our
> free space inode in a block group that is about to be relocated, we
> could trigger the COW path before the relocation has the opportunity to
> find the extents and delete the free space cache.  In production where
> we have auto-relocation enabled we're seeing this WARN_ON_ONCE() around
> 5k times in a 2 week period, so not super common but enough that it's at
> the top of our metrics.
> 
> We're properly handling the error here, and with us phasing out v1 space
> cache anyway just drop the WARN_ON_ONCE.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
