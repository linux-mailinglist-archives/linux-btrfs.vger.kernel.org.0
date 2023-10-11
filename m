Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE97C504E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 12:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjJKKg6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 06:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjJKKg4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 06:36:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912BFB7;
        Wed, 11 Oct 2023 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697020615; x=1728556615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=52YiH9Rm64BW8CkQzXjUhpKwgm4oo9z7eHhxwksiAv4=;
  b=UglVFxDZiGCyI1bnaBQ4VxS4tOIW5Hp8CO60QnsG+tYHH8Isk3iRwnpc
   NwHL4gdZeEj5MNzNdofCvtp/3WXbSYK+6NBIhVGQq655fVZr4rKczu0dz
   PKe/Lfh7nZ9QtX4sKr0b4rhInphagaLr12aJnzAhT14L6hUDwW6wutghx
   P5hV7jTi3B+AP6/noFqd3FfV3XXcaA8GefjLOl6LEH2DeuHXJq3OVMDWx
   htVxoB9Vz5eZUR0aXEun8HTzXFe4oVemN84RPocqsrEgBhjU6nszso4MC
   hhlSjIJiiqo3pzlwW1WMEkiRYdlbtrN5JiNTmk+YAse927WA9nPM/lBbO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415675482"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415675482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824114342"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824114342"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:36:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqWa7-00000004azc-2aLH;
        Wed, 11 Oct 2023 13:36:47 +0300
Date:   Wed, 11 Oct 2023 13:36:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] bitmap: extend bitmap_{get,set}_value8() to
 bitmap_{get,set}_bits()
Message-ID: <ZSZ6v1qgZbqKgKXa@smile.fi.intel.com>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-10-aleksander.lobakin@intel.com>
 <ZSQq02A9mTireK71@yury-ThinkPad>
 <a28542e2-4a5b-4c29-9d4a-12a0d2ab5527@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28542e2-4a5b-4c29-9d4a-12a0d2ab5527@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 11, 2023 at 11:33:25AM +0200, Alexander Lobakin wrote:
> From: Yury Norov <yury.norov@gmail.com>
> Date: Mon, 9 Oct 2023 09:31:15 -0700
> 
> > + Alexander Potapenko <glider@google.com>
> > 
> > On Mon, Oct 09, 2023 at 05:10:21PM +0200, Alexander Lobakin wrote:
> >> Sometimes there's need to get a 8/16/...-bit piece of a bitmap at a
> >> particular offset. Currently, there are only bitmap_{get,set}_value8()
> >> to do that for 8 bits and that's it.
> > 
> > And also a series from Alexander Potapenko, which I really hope will
> > get into the -next really soon. It introduces bitmap_read/write which
> > can set up to BITS_PER_LONG at once, with no limitations on alignment
> > of position and length:
> > 
> > https://lore.kernel.org/linux-arm-kernel/ZRXbOoKHHafCWQCW@yury-ThinkPad/T/#mc311037494229647088b3a84b9f0d9b50bf227cb
> > 
> > Can you consider building your series on top of it?
> 
> Yeah, I mentioned in the cover letter that I'm aware of it and in fact
> it doesn't conflict much, as the functions I'm adding here get optimized
> as much as the original bitmap_{get,set}_value8(), while Alexander's
> generic helpers are heavier.
> I realize lots of calls will be optimized as well due to the offset and
> the width being compile-time constants, but not all of them. The idea of
> keeping two pairs of helpers initially came from Andy if I understood
> him correctly.

Just a disclaimer: The idea came before I saw the series by Alexander Potapenko.

> What do you think? I can provide some bloat-o-meter stats after
> rebasing. And either way, I see no issue in basing this series on top of
> Alex' one.

-- 
With Best Regards,
Andy Shevchenko


