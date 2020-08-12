Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E962425A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHLGxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLGxR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:53:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4E89AB71;
        Wed, 12 Aug 2020 06:53:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D56A8DA81B; Wed, 12 Aug 2020 08:52:14 +0200 (CEST)
Date:   Wed, 12 Aug 2020 08:52:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Jungyeon Yoon <jungyeon.yoon@gmail.com>
Subject: Re: [PATCH v4 0/4] btrfs: Enhanced runtime defence against fuzzed
 images
Message-ID: <20200812065214.GX2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Jungyeon Yoon <jungyeon.yoon@gmail.com>
References: <20200812060509.71590-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812060509.71590-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 12, 2020 at 02:05:05PM +0800, Qu Wenruo wrote:
> v4:
> - Remove one patch which is already merged
>   A little surprised by the fact that git can't detecth such case.

I've looked at it and that's a normal patch from git perspective,
there's not even a conflict in the context, you're adding a new hunk.
That it's the same one that's a few lines below is caused by
intermediate changes, but that's what happens with any other patch.
