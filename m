Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945D09B56A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbfHWR1g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:27:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:57830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbfHWR1g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92A59AC93
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:27:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F15CDA796; Fri, 23 Aug 2019 19:27:59 +0200 (CEST)
Date:   Fri, 23 Aug 2019 19:27:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterb@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Streamline code in run_delalloc_nocow
Message-ID: <20190823172757.GR2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        dsterb@suse.cz, linux-btrfs@vger.kernel.org
References: <20190821154039.GA2752@twin.jikos.cz>
 <20190822142523.1425-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822142523.1425-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 05:25:23PM +0300, Nikolay Borisov wrote:
> Add a comment explaining why we keep the BUG also use the already read
> and cached value of extent ram bytes stored in 'ram_bytes'.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
