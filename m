Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED2297E38
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfHUPJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727134AbfHUPJl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:09:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44FEBAF18
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 15:09:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7DA2DA7DB; Wed, 21 Aug 2019 17:10:05 +0200 (CEST)
Date:   Wed, 21 Aug 2019 17:10:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: Improve comments around nocow path
Message-ID: <20190821151005.GL18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190805144708.5432-3-nborisov@suse.com>
 <20190821074257.22382-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821074257.22382-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 10:42:57AM +0300, Nikolay Borisov wrote:
> run_delalloc_nocow contains numerous, somewhat subtle, checks when
> figuring out whether a particular extent should be CoW'ed or not. This
> patch explicitly states the assumptions those checks verify. As a
> result also document 2 of the more subtle checks in check_committed_ref
> as well.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

with typos and whitespace fixes here and there.
