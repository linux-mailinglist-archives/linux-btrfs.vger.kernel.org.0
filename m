Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10B46A4B7
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 19:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbhLFSjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 13:39:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38212 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbhLFSjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 13:39:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D4C81FE04;
        Mon,  6 Dec 2021 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638815754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PDgCa6+Z/jvFnO90E1fzygbH1I3RwSxNg2L8RwmNLg=;
        b=PxXcI8dKmrPW8f7zmo04KjJ2RDV/2EQ8FN/IF04qW5hBY9VyGjsYWZ6PiuH6lqN0L1gmSs
        uUMqIQynMZ9Hkmq5H069238g+4RgX8RAoo4Fj5W6NDsam+bHznJqVddW8CDcMAGJlcl4VH
        nnVADVRsBkFoqzIuy8HBJlSvXZ1daZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638815754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PDgCa6+Z/jvFnO90E1fzygbH1I3RwSxNg2L8RwmNLg=;
        b=FvXYNkL0d0e64QJw1ODXOh/zpgSpjVvwM4FbdG5Fp4hN35GXMgRCuOpEF6ZsH4Z9+eoekG
        +GgZjQ5DQ0CZTnCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8BC47A3B8B;
        Mon,  6 Dec 2021 18:35:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67FECDA799; Mon,  6 Dec 2021 19:35:40 +0100 (CET)
Date:   Mon, 6 Dec 2021 19:35:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fstests: btrfs/011 increase the runtime for replace
 cancel
Message-ID: <20211206183540.GS28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
References: <01796d6bcec40ae80b5af3269e60a66cd4b89262.1638382763.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01796d6bcec40ae80b5af3269e60a66cd4b89262.1638382763.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 01, 2021 at 01:19:35PM -0500, Josef Bacik wrote:
> This test exercises the btrfs replace cancel path, but in order to do
> this we have to have enough work to do in order to successfully cancel
> the balance, otherwise the test fails because the operation has
> completed before we're able to cancel.  This test has a very low pass
> rate because we do not generate a large enough file system for replace
> to have enough work, passing around 5% of the time.  Increase the time
> spent to 10x the time we wait for the replace to start its work before
> we cancel, this allows us to consistently pass this test.

I've seen the test to pass most of the time but that it still fails
depending on the load is annoying and requires checking the results. So
even if it's probably a workaround (not sure we can make it 100%
reliable without peeking into the internals) it's making things better.

Acked-by: David Sterba <dsterba@suse.com>
