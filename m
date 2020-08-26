Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55942532A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHZO7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:59:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgHZO7c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:59:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D9F8AC46;
        Wed, 26 Aug 2020 15:00:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62700DA730; Wed, 26 Aug 2020 16:58:22 +0200 (CEST)
Date:   Wed, 26 Aug 2020 16:58:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/12] Convert btree locking to an rwsem
Message-ID: <20200826145822.GG28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 20, 2020 at 11:45:59AM -0400, Josef Bacik wrote:
> v1->v2:
> - broke the lockdep fixes out into their own series.
> - added a new fix where we need to handle double splitting leaves in some cases.

The split lockdep patches are now in misc-next, I'd like to continue
with a piecemal steps with the whole rwsem series:

- preparatory stuff, like the annotations patches 1-10
- switch locks to rwsem (1 patch)
- post cleanups once things prove to be ok

So I'll take 1-10 now, this should not significantly affect things. We
have the data tickets in and I'd rather wait a bit before adding another
similarly intrusive change so we'd be able to identify where bugs
originate.
