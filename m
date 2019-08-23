Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B829B56B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfHWR1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:27:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbfHWR1m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:27:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DE27AC93
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:27:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4BE9EDA796; Fri, 23 Aug 2019 19:28:06 +0200 (CEST)
Date:   Fri, 23 Aug 2019 19:28:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterb@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Remove BUG_ON from run_delalloc_nocow
Message-ID: <20190823172805.GS2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        dsterb@suse.cz, linux-btrfs@vger.kernel.org
References: <20190821155517.GB2752@twin.jikos.cz>
 <20190822142420.1126-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822142420.1126-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 05:24:20PM +0300, Nikolay Borisov wrote:
> Correctly handle failure cases when adding an ordered extents in case
> of REGULAR or PREALLOC extents.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
