Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028FACE886
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 18:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJGQCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 12:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727711AbfJGQCV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 12:02:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5760AEF8;
        Mon,  7 Oct 2019 16:02:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52D42DA7FB; Mon,  7 Oct 2019 18:02:35 +0200 (CEST)
Date:   Mon, 7 Oct 2019 18:02:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: add sha256 as supported checksumming
 algorithm
Message-ID: <20191007160234.GG2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191007111326.10474-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007111326.10474-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 01:13:26PM +0200, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Please write even a short changelog. The patch adds the definition and
allows the new hash in mkfs, that's beyond what I'd consider trivial
that a subject would be sufficient. I wrote something like that so no
need to resend.

And hooray we're almost there, I'm going to add blake2.
