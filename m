Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108232D7B04
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgLKQet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 11:34:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:51144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbgLKQes (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 11:34:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05B47ADA2;
        Fri, 11 Dec 2020 16:34:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 943FADA7A1; Fri, 11 Dec 2020 17:32:29 +0100 (CET)
Date:   Fri, 11 Dec 2020 17:32:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: only spit out the parent or ref root for
 ref mismatches
Message-ID: <20201211163229.GL6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <26927d5268dc42db5ba131dd80b190d474bd596f.1605800521.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26927d5268dc42db5ba131dd80b190d474bd596f.1605800521.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 19, 2020 at 10:42:12AM -0500, Josef Bacik wrote:
> While debugging some corruption, I got confused because it appeared as
> if we had an invalid parent set on a extent reference, because of this
> message
> 
> tree backref 67014213632 parent 5 root 5 not found in extent tree
> 
> But it turns out that parent and the root are a union, and we were just
> printing it out regardless of the type of backref it was.  Fix the error
> message to be consistent with the other mismatch messages, simply print
> parent or root, depending on the ref type.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to devel, thanks.
