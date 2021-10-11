Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5569F428AB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhJKKYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:24:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhJKKYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:24:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6B8662004C;
        Mon, 11 Oct 2021 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633947743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElQrjxxlbs/iJLIPBE7j+Xps32ZSZlFv4Z11qLYaol4=;
        b=kfMm3tCNuQ4ufimEUJFOcSUdWQEo9bt7dRlHf0scpJzRx+4YNA+rDB+YPuee78/LBZnnN+
        g69LIGh/rWL/Rh1pmIUWZjSaFHt+qSxCfYBwYKHrjtlxgMMsBBYscu8hLw56GnG+FY1wVP
        oTyyuTRSyCOZMHOn7ythVauRSAadXoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633947743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElQrjxxlbs/iJLIPBE7j+Xps32ZSZlFv4Z11qLYaol4=;
        b=8Bo+f9ehwEqb6hrdN58JExQ2iLffwABo6Gx37Nn5HTalaq2fSkpggl/0qLXUak2oF95ERE
        2kLCxIZDd7Y3J+Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 623FAA3B8F;
        Mon, 11 Oct 2021 10:22:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76C1BDA704; Mon, 11 Oct 2021 12:21:59 +0200 (CEST)
Date:   Mon, 11 Oct 2021 12:21:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eryu Guan <guan@eryu.me>
Cc:     Ma Xinjian <xinjianx.ma@intel.com>, fstests@vger.kernel.org,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs/049: remove the test
Message-ID: <20211011102159.GB9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eryu Guan <guan@eryu.me>,
        Ma Xinjian <xinjianx.ma@intel.com>, fstests@vger.kernel.org,
        Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072019.46609-1-xinjianx.ma@intel.com>
 <YWLrZHPZ1VIn5qIH@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWLrZHPZ1VIn5qIH@desktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 10, 2021 at 09:32:20PM +0800, Eryu Guan wrote:
> [cc'ed btrfs list]
> 
> On Mon, Sep 27, 2021 at 03:20:18PM +0800, Ma Xinjian wrote:
> > inode_cache is deprecated and will never appear in mount
> > options; remove it entirely
> 
> Please also cc btrfs list in future patches for btrfs-specific tests.
> 
> And I'd like an ack from btrfs folks.

Acked-by: David Sterba <dsterba@suse.com>
