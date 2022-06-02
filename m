Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F353BC5F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiFBQWV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 12:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbiFBQWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 12:22:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABC33887;
        Thu,  2 Jun 2022 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654186937; x=1685722937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4xj0OkaxBdoQiw9WXp+iQWfsQeHJ0rlw7PBOAmlgVt0=;
  b=lHqJbi7Z404Erlrhdd6erplN+7AwKhqoROJP8cGebQ2YEwuZhFWX7P6q
   uN9o04OEDGWxIHEUP0RR9i9RKZ2DobLk8du1pH4AiaXIMpaYN10NXDgUk
   eGvfBWV5QtxZvTZoVtVfSu+LJTT/eUpXmosRiBEC/TbXbMM3Xu7RIcoAz
   1bb8dFrHvLIkxPCdW+MdrIwrHlySNImdDqzCcEDLz1gnmVlfKQyRykAB4
   +SVHMUwbl1AAfw3d9YuTadRuWAfLf5PymyJ3D04kmgpW7grcJaPzt0S87
   AijCapqJMYOiCa1ElDh7hhmQgtYthn8ug9tAnyIIL050QI7831/rDsbhM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="336656237"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="336656237"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 09:22:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="582157443"
Received: from liqiong-mobl.amr.corp.intel.com (HELO localhost) ([10.209.7.136])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 09:22:15 -0700
Date:   Thu, 2 Jun 2022 09:22:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Message-ID: <Ypjjt87qL+ROFBtM@iweiny-desk3>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
 <20220601132545.GM20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601132545.GM20633@twin.jikos.cz>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 01, 2022 at 03:25:45PM +0200, David Sterba wrote:
> On Tue, May 31, 2022 at 04:53:32PM +0200, Fabio M. De Francesco wrote:
> > This is the first series of patches aimed towards the conversion of Btrfs
> > filesystem from the use of kmap() to kmap_local_page().
> 
> We've already had patches converting kmaps and you're changing the last
> ones, so this is could be the last series, with two exceptions.
> 
> 1) You've changed lzo.c and zlib. but the same kmap/kunmap pattern is
>    used in zstd.c.

I checked out zstd.c and one of the issues there is the way that the input
workspace is mapped page by page while iterating those pages.

This got me thinking about what Willy said at LSFmm concerning something like
kmap_local_range().  Mapping more than 1 page at a time could save some
unmap/remap of output pages required for kmap_local_page() ordering.

Unfortunately, I think the length of the input is probably to long in many
cases.  And some remapping may still be required.

Cc: Willy

As an aside, Willy, I'm thinking that a kmap_local_range() should return a
folio in some way.  Would you agree?

Ira
