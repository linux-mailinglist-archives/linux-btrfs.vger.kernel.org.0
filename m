Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E229B70055
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfGVM6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 08:58:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727164AbfGVM6q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 08:58:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10D7AAC6C;
        Mon, 22 Jul 2019 12:58:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD998DA882; Mon, 22 Jul 2019 14:59:19 +0200 (CEST)
Date:   Mon, 22 Jul 2019 14:59:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Klemens =?iso-8859-1?Q?Sch=F6lhorn?= <klemens@schoelhorn.eu>
Subject: Re: [PATCH v2 1/2] btrfs-progs: Exhaust delayed refs and dirty block
 groups to prevent delayed refs lost
Message-ID: <20190722125919.GP20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Klemens =?iso-8859-1?Q?Sch=F6lhorn?= <klemens@schoelhorn.eu>
References: <20190708073352.6095-1-wqu@suse.com>
 <20190708073352.6095-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708073352.6095-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 08, 2019 at 03:33:51PM +0800, Qu Wenruo wrote:
[...]
> Reported-by: Klemens Schölhorn <klemens@schoelhorn.eu>
> Issue: 187
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied, thanks.
