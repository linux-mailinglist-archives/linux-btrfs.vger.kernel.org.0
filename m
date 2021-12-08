Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0271E46C989
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 01:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhLHAsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 19:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbhLHAq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 19:46:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95606C061574;
        Tue,  7 Dec 2021 16:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aRWC1B7gJyn3yLja07Sz3zXJaEgrex8xJp2O6/0EFyE=; b=vGBc5Bji0pg/m5cdQDmvQQOj7p
        JR/h98kVP1XsCz076sxtqqPWbQCXEQ9W3BdUtBM0hX/p02YNkdOhDnICsiPiCP8LRpZNZ5S8Na2vf
        eP1OVyv1ULIir7ndMDDOPVB8TNbpD+ztq/WJXxzZt/mzCNssVwSe0H6UZZ8zdLSQPX5oVV1xZdfxW
        l1Na8LHk0Vs0AP3LShGTcdF3wg46TwdOIXGORKSyTvHJltIsehy2kuVvbPpDn6vdpHKY+ZDbHhuON
        A4TAzDTv7yIdzvT6SUBx4lnFrwWNrpzoOId+WpoSWnhH4cOfN+Y2GuZNcYi4Bg1tSsISNWX3ZPB/4
        rUGMDMiQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mul3H-007vm1-0V; Wed, 08 Dec 2021 00:43:19 +0000
Message-ID: <28105cc3-88b0-763d-5bc5-06eb67ee130f@infradead.org>
Date:   Tue, 7 Dec 2021 16:43:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] btrfs: zoned: convert comment to kernel-doc format
Content-Language: en-US
To:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20211203064820.27033-1-rdunlap@infradead.org>
 <20211207194820.GH28560@twin.jikos.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211207194820.GH28560@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/7/21 11:48, David Sterba wrote:
> On Thu, Dec 02, 2021 at 10:48:20PM -0800, Randy Dunlap wrote:
>> Complete kernel-doc notation for btrfs_zone_activate() to prevent
>> kernel-doc warnings:
>>
>> zoned.c:1784: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>  * Activate block group and underlying device zones
>> zoned.c:1784: warning: missing initial short description on line:
>>  * Activate block group and underlying device zones
> 
> We've been using a slightly different format than the strict kernel-doc,

I'm sorry to hear that.

> in this cas the function name is not repeated (because it's right under
> the comment), what we want is the argument list checks (order and
> completeness).

Please just eliminate/prevent the warning then.
I don't care how it's done.

thanks.
-- 
~Randy
