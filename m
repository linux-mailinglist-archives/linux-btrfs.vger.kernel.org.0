Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7693B65F0C9
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjAEQFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 11:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjAEQFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 11:05:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE271C910;
        Thu,  5 Jan 2023 08:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523DF61B0F;
        Thu,  5 Jan 2023 16:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70DCC433F1;
        Thu,  5 Jan 2023 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672934707;
        bh=M9j+q16e2PHmdReOHomsxAShZ1syHIKm65rpYP3ESBY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iRIPlnLqIxJU4ohyvIwYd4kbDZNqLchT/A+Qha1zTp01kCQeMJWPH6OGOsnbnXh1o
         e5b6cDylvpJm3XZq0qX6WqShuJTWZJG3Uhth/JI24fZOFw0rN4p/wHPmfDzleH0kCK
         X5NYQ4bocsAA9fCyGDCKGOv5xDASEn09otUbZ3QrzapqthC5twhd+XWZxEY5HM1XD5
         NlgkaGkUbP5SHXgLOAeQD3M7NsKhRfEq6RFhAAReN+fa9wMHgB9KmAYbJ4XXpRgpl/
         0PgUjJF7PrpYD4U0cMkHA+TrCNtOopmnYP4Oqg8kCiB40yLBZbOegugHk1XjIqHhqU
         lMwvRaFNBMIPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69A145C029A; Thu,  5 Jan 2023 08:05:07 -0800 (PST)
Date:   Thu, 5 Jan 2023 08:05:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH rcu 18/27] fs/btrfs: Remove "select SRCU"
Message-ID: <20230105160507.GA4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-18-paulmck@kernel.org>
 <20230105154518.GT11562@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105154518.GT11562@twin.jikos.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 05, 2023 at 04:45:18PM +0100, David Sterba wrote:
> On Wed, Jan 04, 2023 at 04:38:04PM -0800, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Chris Mason <clm@fb.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: <linux-btrfs@vger.kernel.org>
> 
> Acked-by: David Sterba <dsterba@suse.com>

Thank you, David!  I will apply this on my next rebase.

							Thanx, Paul
