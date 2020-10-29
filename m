Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7AC29F674
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 21:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJ2Ux3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 16:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ2Ux3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 16:53:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90625ACD8;
        Thu, 29 Oct 2020 20:53:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7790DA7CE; Thu, 29 Oct 2020 21:51:51 +0100 (CET)
Date:   Thu, 29 Oct 2020 21:51:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: clean up NULL checks in qgroup_unreserve_range()
Message-ID: <20201029205150.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20201023112633.GE282278@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023112633.GE282278@mwanda>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 02:26:33PM +0300, Dan Carpenter wrote:
> Smatch complains that this code dereferences "entry" before checking
> whether it's NULL on the next line.  Fortunately, rb_entry() will never
> return NULL so it doesn't cause a problem.  We can clean up the NULL
> checking a bit to silence the warning and make the code more clear.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Added to misc-next, thanks.
