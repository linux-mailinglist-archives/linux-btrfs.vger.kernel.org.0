Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57521A3E7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGIPj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 11:39:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIPj3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 11:39:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F0A6AAC5;
        Thu,  9 Jul 2020 15:39:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0120DAB7F; Thu,  9 Jul 2020 17:39:08 +0200 (CEST)
Date:   Thu, 9 Jul 2020 17:39:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2][v2] btrfs: convert block group refcount to refcount_t
Message-ID: <20200709153908.GB3533@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <20200706131412.28870-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706131412.28870-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 06, 2020 at 09:14:11AM -0400, Josef Bacik wrote:
> We have refcount_t now with the associated library to handle refcounts,
> which gives us extra debugging around reference count mistakes that may
> be made.  For example it'll warn on any transition from 0->1 or 0->-1,
> which is handy for noticing cases where we've messed up reference
> counting.  Convert the block group ref counting from an atomic_t to
> refcount_t and use the appropriate helpers.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

1 and 2 added to msic-next, thanks.
