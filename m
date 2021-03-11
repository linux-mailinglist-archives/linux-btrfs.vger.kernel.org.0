Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD5337899
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhCKP6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 10:58:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:18629 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234018AbhCKP5t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 10:57:49 -0500
IronPort-SDR: JzTy6vn+hG5vaC4mr1HVVV604SM6XhXKbjNhC146mduXX/jZgaWM4jH/pLxt4o0qlcMtExVTJp
 Vfud35QEJK6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="208512589"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="208512589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 07:57:49 -0800
IronPort-SDR: T9NgBxuLmQfyVoP+1uuu+kXqcqghmZvmA2pZZKMD3+0o8z+KHEVHi5/XqOj01MWt1m8iaVa1Zi
 7M56Mx/ejamA==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="410650575"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 07:57:49 -0800
Date:   Thu, 11 Mar 2021 07:57:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Convert kmap/memset/kunmap to memzero_user()
Message-ID: <20210311155748.GR3014244@iweiny-DESK2.sc.intel.com>
References: <20210309212137.2610186-1-ira.weiny@intel.com>
 <20210310155836.7d63604e28d746ef493c1882@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310155836.7d63604e28d746ef493c1882@linux-foundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 10, 2021 at 03:58:36PM -0800, Andrew Morton wrote:
> On Tue,  9 Mar 2021 13:21:34 -0800 ira.weiny@intel.com wrote:
> 
> > Previously this was submitted to convert to zero_user()[1].  zero_user() is not
> > the same as memzero_user() and in fact some zero_user() calls may be better off
> > as memzero_user().  Regardless it was incorrect to convert btrfs to
> > zero_user().
> > 
> > This series corrects this by lifting memzero_user(), converting it to
> > kmap_local_page(), and then using it in btrfs.
> 
> This impacts btrfs more than MM.  I suggest the btrfs developers grab
> it, with my

I thought David wanted you to take these this time?

"I can play the messenger again but now it seems a round of review is needed
and with some testing it'll be possible in some -rc. At that point you may take
the patches via the mm tree, unless Linus is ok with a late pull."

	-- https://lore.kernel.org/lkml/20210224123049.GX1993@twin.jikos.cz/

But reading that again I'm not sure what he meant.

David?

Ira

> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 
