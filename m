Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D221421A5B9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGIRYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 13:24:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:58242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgGIRYu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 13:24:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98556AC52;
        Thu,  9 Jul 2020 17:24:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23D5ADAB7F; Thu,  9 Jul 2020 19:24:29 +0200 (CEST)
Date:   Thu, 9 Jul 2020 19:24:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, Andy Lavr <andy.lavr@gmail.com>
Subject: Re: [PATCH] btrfs: wire up iter_file_splice_write
Message-ID: <20200709172428.GD15161@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org, Andy Lavr <andy.lavr@gmail.com>
References: <20200709162206.113927-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709162206.113927-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 09, 2020 at 06:22:06PM +0200, Christoph Hellwig wrote:
> btrfs implements the iter_write op and thus can use the more efficient
> iov_iter based splice implementation.  For now falling back to the less
> efficient default is pretty harmless, but I have a pending series that
> removes the default, and thus would cause btrfs to not support splice
> at all.

Do you want this patch to go in this cycle? I have some more patches
queued and don't mind adding it if it makes development of your patchset
easier.
