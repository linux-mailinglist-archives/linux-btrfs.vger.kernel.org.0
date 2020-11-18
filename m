Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6B2B8189
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgKRQMG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 11:12:06 -0500
Received: from twin.jikos.cz ([91.219.245.39]:34059 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgKRQMG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 11:12:06 -0500
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 11:12:05 EST
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 0AIGBvPM016012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Nov 2020 17:11:58 +0100
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 0AIGBvMP016011;
        Wed, 18 Nov 2020 17:11:57 +0100
Date:   Wed, 18 Nov 2020 17:11:57 +0100
From:   David Sterba <dave@jikos.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 15/24] btrfs: extent-io: make type of
 extent_state::state to be at least 32 bits
Message-ID: <20201118161157.bazycid5hnz4iapf@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-16-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-16-wqu@suse.com>
User-Agent: NeoMutt/20161028 (1.7.1)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:40PM +0800, Qu Wenruo wrote:
> Currently we use 'unsigned' for extent_state::state, which is only ensured
> to be at least 16 bits.

Ensured maybe by the C standard but we use u32 and 'unsigned int'
interchangably everywhere. There are some inferior architectures that
use different type witdths, but all we care is 32bit and 64bit.

> But for incoming subpage support, we are going to introduce more bits,
> thus we will go beyond 16 bits.
> 
> To support this, make extent_state::state at least 32bit and to be more
> explicit, we use "u32" to be clear about the max supported bits.

Yeah that's fine to make the expected width requirement explicit.
