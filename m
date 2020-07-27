Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A64222EB8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 13:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgG0Lz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 07:55:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:51710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgG0Lz6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 07:55:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97AE5AE1C;
        Mon, 27 Jul 2020 11:56:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1282EDA701; Mon, 27 Jul 2020 13:55:29 +0200 (CEST)
Date:   Mon, 27 Jul 2020 13:55:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: only search for left_info if there is no
 right_info
Message-ID: <20200727115528.GJ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200722184245.19699-1-josef@toxicpanda.com>
 <20200722184537.19896-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722184537.19896-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 02:45:37PM -0400, Josef Bacik wrote:
> The CVE referenced doesn't actually trigger the problem anymore because
> of the tree-checker improvements, however the underlying issue can still
> happen.

What was the problem?

> If we find a right_info, but rb_prev() is NULL, then we're the furthest
> most item in the tree currently, and there will be no left_info.
> However we'll still search from offset-1, which would return right_info
> again which we store in left_info.  If we then free right_info we'll
> have free'd left_info as well, and boom, UAF.  Instead fix this check so
> that if we don't have a right_info we do the search for the left_info,
> otherwise left_info comes from rb_prev or is simply NULL as it should
> be.
> 
> Reference: CVE-2019-19448
> Fixes: 963030817060 ("Btrfs: use hybrid extents+bitmap rb tree for free space")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Fixed the title, I had changed the fix but forgot to change the title in v1

The title still repeats what the code does and left_info or right_info
are not terms that are understood without context (unlike eg. fs_info)
