Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0449D9DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 01:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHZXVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 19:21:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:56708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfHZXVY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 19:21:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EAAF7B08C
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 23:21:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C959DA809; Tue, 27 Aug 2019 01:21:46 +0200 (CEST)
Date:   Tue, 27 Aug 2019 01:21:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] btrfs: use xxhash64 for checksumming
Message-ID: <20190826232146.GE2752@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114834.14789-1-jthumshirn@suse.de>
 <20190826114834.14789-4-jthumshirn@suse.de>
 <238f4883-ced5-009e-2d77-61f5d4a8e5b8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238f4883-ced5-009e-2d77-61f5d4a8e5b8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 06:38:13PM +0300, Nikolay Borisov wrote:
> nit: I'd name this commit  "Add xxhash64 to supported checksum hashes"
> 
> Personally, I interpret 'use <some hash> for checksumming' as if you are
> modifying code to use that hash. But in fact you are not, at least not
> in that patch.

It could be percieved as nitpicking, but this kind of feedback is a
check that the author's intentions are understood by someone else.  Some
subtleties or nuances can be missed by authors and this is maybe
inevitable when one spends significant time on the code or changelog.
The fresh look and first impression is not possible anymore. But this is
how patches are read when found git log.

In this case I agree with you and the use use of 'use' is a bit
misleading, suggesting that xxhash is now default.
