Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD85725C415
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgICPDQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 3 Sep 2020 11:03:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:38263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgICN6v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 09:58:51 -0400
IronPort-SDR: YAhaW+RyLQepdox+9fTVQYjSZtPcCQjixBgP7Klj5NzQUqinJnqDcxle2o5XqL1mmg/049l9Kh
 aJY8kdcG+s5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="156839375"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="156839375"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 06:30:00 -0700
IronPort-SDR: Ii80nP53OMhKu3YPQanI2V3JEHYHtL7FOqbXWnBxegPkQJnHeLe8iGmOnrNuw5ZytWdFKHt8+v
 PmIgzgzmD4iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="282676539"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2020 06:30:00 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 06:29:59 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 21:29:57 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.1713.004;
 Thu, 3 Sep 2020 21:29:57 +0800
From:   "Sang, Oliver" <oliver.sang@intel.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [btrfs] c0aaf9b7a1: ltp: stuck at diotest4
Thread-Topic: [btrfs] c0aaf9b7a1: ltp: stuck at diotest4
Thread-Index: AQHWgdJgTz1eQ6GVAE+fMaKAQV67JalW6OSQ
Date:   Thu, 3 Sep 2020 13:29:57 +0000
Message-ID: <06668b52b9ac4d4e81f945e06223d9b7@intel.com>
References: <20200903062837.GA3654@xsang-OptiPlex-9020>
 <20200903091123.GO28318@suse.cz>
In-Reply-To: <20200903091123.GO28318@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: David Sterba <dsterba@suse.cz>
> Sent: Thursday, September 3, 2020 5:11 PM
> To: Sang, Oliver <oliver.sang@intel.com>
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>; David Sterba
> <dsterba@suse.com>; LKML <linux-kernel@vger.kernel.org>; lkp@lists.01.org;
> lkp <lkp@intel.com>; ltp@lists.linux.it; linux-btrfs@vger.kernel.org
> Subject: Re: [btrfs] c0aaf9b7a1: ltp: stuck at diotest4
> 
> On Thu, Sep 03, 2020 at 02:28:37PM +0800, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: c0aaf9b7a114f6b75e0da97be7d99c102347a751 ("btrfs: switch to
> > iomap_dio_rw() for dio")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> > master
> 
> That's probably the O_DIRECT + O_(D)SYNC deadlock that was found recently.
> One of the cases in diotest4 does
> 
> 	open(filename, O_DIRECT | O_RDWR | O_SYNC)
> 
> Fix is work in progress, thanks for the report.

Thanks a lot for information!
