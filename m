Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26D1D86FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 20:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgERS2j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 14:28:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387993AbgERS2i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 14:28:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CFA0CAD5B;
        Mon, 18 May 2020 18:28:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70BABDA7AD; Mon, 18 May 2020 20:27:43 +0200 (CEST)
Date:   Mon, 18 May 2020 20:27:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: unexport btrfs_compress_set_level()
Message-ID: <20200518182743.GA18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20200512053751.22092-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512053751.22092-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 11, 2020 at 10:37:51PM -0700, Anand Jain wrote:
> btrfs_compress_set_level() can be static function in the file
> compression.c.
> 
> Fixes: b0c1fe1eaf5e (btrfs: compression: replace set_level callbacks by
> a common helper)

Not really a candidate for Fixes, there's no bug. Otherwise ok, added to
misc-next.
