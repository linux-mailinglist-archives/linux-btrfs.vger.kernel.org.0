Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E227D224
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 17:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgI2PH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 11:07:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:46934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgI2PH4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 11:07:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF0D9AC12;
        Tue, 29 Sep 2020 15:07:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4840CDA701; Tue, 29 Sep 2020 17:06:36 +0200 (CEST)
Date:   Tue, 29 Sep 2020 17:06:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/5] New rescue mount options
Message-ID: <20200929150636.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1601318001.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601318001.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 28, 2020 at 02:34:52PM -0400, Josef Bacik wrote:
> And finally we have rescue=all, which simply enables ignoredatacsums,
> ignorebadroots, and notreelogreplay.  We need an easy catch-all option for
> distros to fallback on to get users the highest probability of being able to
> recover their data, so we will use rescue=all to turn on all the fanciest rescue
> options that we have, and then use the discrete options for more fine grained
> recovery.  Thanks,
> 
> Josef
> 
> Josef Bacik (5):
>   btrfs: unify the ro checking for mount options
>   btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
>   btrfs: introduce rescue=ignorebadroots
>   btrfs: introduce rescue=ignoredatacsums
>   btrfs: introduce rescue=all

About the naming, the option names are quite clear but long to type. We
could have shorter aliases, eg. 'ibadroots', where 'i' is short for
'ignore'.

For completeness, we may also want to the negated options or add an
operator that will drop the bit, like

	mount -o rescue=all:^ignoredatacsums
	mount -o rescue=all,rescue=^ignoredatacsums
