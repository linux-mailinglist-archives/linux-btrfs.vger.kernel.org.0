Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5379A219EBA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGILGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 07:06:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgGILGV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 07:06:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67BA2AE2C;
        Thu,  9 Jul 2020 11:06:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C07FFDAB7F; Thu,  9 Jul 2020 13:05:59 +0200 (CEST)
Date:   Thu, 9 Jul 2020 13:05:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/2] btrfs: avoid possible signal interruption for
 btrfs_drop_snapshot() on relocation tree
Message-ID: <20200709110557.GH28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200709083333.137927-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709083333.137927-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 09, 2020 at 04:33:32PM +0800, Qu Wenruo wrote:

> From the mentioned forced read-only, to later balance error due to half
> dropped reloc trees.
> 
> [FIX]
> Fix this problem by using btrfs_join_transaction() if
> btrfs_drop_snapshot() is called from relocation context.
> 
> As btrfs_join_transaction() won't wait full tickets, it won't get
> interrupted from signal.

Could you please rephrase the text above?
