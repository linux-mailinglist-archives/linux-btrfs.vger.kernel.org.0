Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DB7545989
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 03:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiFJB1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 21:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiFJB1L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 21:27:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2DEDA;
        Thu,  9 Jun 2022 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654824430; x=1686360430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X87m7q3tNoU6oagLh7Y6DHIGCQb6dAM9+lllad+bC5A=;
  b=IuEHdeg5qlrQYBeObeT3REpTjVGbIixAnT9/OzjscFRrlg6GLOkYA9NA
   zkhPgnvcX13pb/cGLw5S1DhIrMuI0lZ3hWGzOLTRPHa4CwkWVwlWi51Vl
   rlmdJ92dRZq8zqvKYA94sIrXXW95UzSnMQglk5/Mdspfd2LydeagOouao
   SCyHPEve90+2AXbDvz2Jx6gMZ7AKJi9tysY5HFiuhfxFRFNa7T5ISdead
   0qRcoIv/xu/hnVypcylazENb97r9FAU62kjrSQol4A4hegbaNjOhCPv/I
   bbcYD16pgjErabB9LXzcqzKjMYPz1Uu4KkQwDYIqSHm8GuTFr93iFL6BD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276247171"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276247171"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 18:27:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="760300997"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 18:27:08 -0700
Date:   Fri, 10 Jun 2022 09:26:59 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, lkp@lists.01.org
Subject: Re: [btrfs]  62bd8124e2:
 WARNING:at_fs/btrfs/block-rsv.c:#btrfs_release_global_block_rsv[btrfs]
Message-ID: <20220610012659.GA6844@xsang-OptiPlex-9020>
References: <bf924988687205627604f36cbd8ff13936e938ab.1654009356.git.fdmanana@suse.com>
 <20220608152303.GB31193@xsang-OptiPlex-9020>
 <20220609094652.GB3668047@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609094652.GB3668047@falcondesktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hi, Filipe Manana,

On Thu, Jun 09, 2022 at 10:46:52AM +0100, Filipe Manana wrote:
> 
> I am unable to reproduce that on a 12 cores box.
> I also don't see anything wrong that could lead to that by manual inspection.
> 
> How easy is it for you to trigger it?

we reproduced this upon 62bd8124e2 4 times out of 6 runs.
but since the other 2 runs crash early due to other issues (below (1)), we
cannot say they are clean.
at the same time, the 6 runs for parent are clean.

7e2bb5b3f3bca223 62bd8124e2f17910fcd89568e50
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6           67%           4:6     dmesg.RIP:btrfs_release_global_block_rsv[btrfs]
           :6           67%           4:6     dmesg.WARNING:at_fs/btrfs/block-rsv.c:#btrfs_release_global_block_rsv[btrfs]
           :6           33%           2:6     dmesg.kernel_BUG_at_fs/xfs/xfs_message.c  <----- (1)


> 
> Can you also run it with CONFIG_BTRFS_ASSERT=y set in the kernel config?

got it, we will enable this config and rerun tests, for both this commit and
parent.

