Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9586F32C547
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450667AbhCDAT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:57 -0500
Received: from verein.lst.de ([213.95.11.211]:36884 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380991AbhCCPh6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 10:37:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E0DE68CF0; Wed,  3 Mar 2021 10:39:57 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:39:56 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     Joe Perches <joe@perches.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 08/10] fsdax: Dedup file range to use a compare
 function
Message-ID: <20210303093956.GA15389@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <OSBPR01MB2920D986D605EE229E091601F4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2920D986D605EE229E091601F4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 03, 2021 at 08:45:14AM +0000, ruansy.fnst@fujitsu.com wrote:
> Sorry for making you confused. This is because I misunderstood how I should
> use iomap_apply2(). I have re-sent two new patches to fix this(PATCH 08/10)
> and the previous(PATCH 07/10) which are in-reply-to these two patch, please
> take a look on those two.  Maybe I should resend all of the patchset as a
> new one...

I haven't found any resent patch in my inbox yet, but then again
various mail servers seem to malfunction in the last days..
