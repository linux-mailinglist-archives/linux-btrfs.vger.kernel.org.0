Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5D7B034
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfG3RhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:37:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:48360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfG3RhB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:37:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91A15AD45
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 17:37:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D4C9DA808; Tue, 30 Jul 2019 19:37:35 +0200 (CEST)
Date:   Tue, 30 Jul 2019 19:37:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 07/17] btrfs-progs: use btrfs_csum_data() in
 __csum_tree_block_size()
Message-ID: <20190730173735.GI28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <cf0d71c9744a1841278fc08b0c294d4b1292cb8f.1564046972.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0d71c9744a1841278fc08b0c294d4b1292cb8f.1564046972.git.jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 11:33:54AM +0200, Johannes Thumshirn wrote:
> Use the btrfs_csum_data() wrapper in __csum_tree_block_size() instead of
> directly calling crc32c().
> 
> This helps us when plumbing new checksum algorithms into the FS.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Added to devel.
