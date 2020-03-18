Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5DD189E12
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCROlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 10:41:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:47094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCROlV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 10:41:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7A27B22C;
        Wed, 18 Mar 2020 14:41:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E86E0DA70E; Wed, 18 Mar 2020 15:40:50 +0100 (CET)
Date:   Wed, 18 Mar 2020 15:40:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] Drop some mis-uses of READA
Message-ID: <20200318144049.GY12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313210954.148686-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313210954.148686-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 05:09:52PM -0400, Josef Bacik wrote:
> In debugging Zygo's huge commit delays I noticed we were burning a bunch of time
> doing READA in cases where we don't need to.  The way READA works in btrfs is
> we'll load up adjacent nodes and leaves as we walk down.  This is useful for
> operations where we're going to be reading sequentially across the tree.
> 
> But for delayed refs we're looking up one bytenr, and then another one which
> could be elsewhere in the tree.  With large enough extent trees this results in
> a lot of unneeded latency.
> 
> The same applies to build_backref_tree, but that's even worse because we're
> looking up backrefs, which are essentially randomly spread out across the extent
> root.  Thanks,

Makes sense, I'll add it to misc-next. Thanks.
