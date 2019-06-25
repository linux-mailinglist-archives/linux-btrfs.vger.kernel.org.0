Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08154E0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfFYL6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 07:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbfFYL57 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 07:57:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4009AEE9;
        Tue, 25 Jun 2019 11:57:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E59E0DA921; Tue, 25 Jun 2019 13:58:43 +0200 (CEST)
Date:   Tue, 25 Jun 2019 13:58:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/11] btrfs: move the space_info handling code to
 space-info.c
Message-ID: <20190625115843.GO8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190618200926.3352-1-josef@toxicpanda.com>
 <20190618200926.3352-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618200926.3352-5-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 18, 2019 at 04:09:19PM -0400, Josef Bacik wrote:
> --- /dev/null
> +++ b/fs/btrfs/space-info.c
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Facebook.  All rights reserved.
> + */

How does the copyright claim work here? You're just moving code from a
file (extent-tree.c) that has

  "Copyright (C) 2007 Oracle.  All rights reserved."

Adding company copyright to new files that implement something
completely new seems to be fine and I don't object against adding it,
though personally I think it's pointless to add the copyrights when
there's the Signed-off-by mechanism and full and immutable history of
changes tracked in git and newly the SPDX tag to disperse any confusion
about licensing of individual files.

