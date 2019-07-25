Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6A756D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGYSXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 14:23:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:52992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfGYSXR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 14:23:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30D21B035
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 18:23:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F7D6DA7DE; Thu, 25 Jul 2019 20:23:53 +0200 (CEST)
Date:   Thu, 25 Jul 2019 20:23:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Remove delalloc_end argument from
 extent_clear_unlock_delalloc
Message-ID: <20190725182352.GW2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190717131817.8567-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717131817.8567-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 17, 2019 at 04:18:16PM +0300, Nikolay Borisov wrote:
> It was added in ba8b04c1d4ad ("btrfs: extend btrfs_set_extent_delalloc
> and its friends to support in-band dedupe and subpage size patchset") as
> a preparatory patch for in-band and subapge block size patchsets.
> However neither of those are likely to be merged anytime soon and the
> code has diverged significantly from the last public post of either
> of those patchsets.

Yeah, keeping the parameter in place for the patchsets has become
indefensible.
