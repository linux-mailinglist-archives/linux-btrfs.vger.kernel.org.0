Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D779F253
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 20:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfH0SbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 14:31:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfH0SbU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 14:31:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56C56B021;
        Tue, 27 Aug 2019 18:31:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7367ADA809; Tue, 27 Aug 2019 20:31:42 +0200 (CEST)
Date:   Tue, 27 Aug 2019 20:31:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 0/5] Btrfs: add interface for writing compressed
 extent directly
Message-ID: <20190827183142.GY2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565900769.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:01PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hello,
> 
> This series adds a way to write compressed data directly to Btrfs. The
> intended use case is making send/receive on compressed file systems more
> efficient; however, the interface is general enough that it could be
> used in other scenarios. Patch 5 is the main change; see that for more
> details.
> 
> Patches 1-3 are small fixes/cleanups that I ran into while implementing
> this; they should go in regardless of the remainder of the series.

1-3 added to misc-next, thanks. I haven't looked at the rest yet.
