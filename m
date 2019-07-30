Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59617AFA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfG3RSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:18:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:43798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfG3RSb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:18:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF556AF74
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 17:18:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF8F0DA808; Tue, 30 Jul 2019 19:19:04 +0200 (CEST)
Date:   Tue, 30 Jul 2019 19:19:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] btrfs: sysfs: export supported checksums
Message-ID: <20190730171904.GE28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <e377ded65e4f2799776596ead308658710e4c8c1.1564046812.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e377ded65e4f2799776596ead308658710e4c8c1.1564046812.git.jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 11:33:51AM +0200, Johannes Thumshirn wrote:
> From: David Sterba <dsterba@suse.com>
> 
> Export supported checksum algorithms via sysfs.

I wonder if we should also export the implementation that would be used.
This could be crross referenced with /proc/crypto, but having it in one
place would be IMHO convenient.  Also for the case when the kernel
module is missing.

Currently the hash names are printed as comma separated values so we'd
need bit something structured:

crc32c: crc32c-intel
xxhash64: xxhash-generic

or if there's some other format in common use.
