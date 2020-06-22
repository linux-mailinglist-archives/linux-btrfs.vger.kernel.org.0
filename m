Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A2203B94
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgFVPxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 11:53:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFVPxM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 11:53:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EA8FC216;
        Mon, 22 Jun 2020 15:53:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3DCADA82B; Mon, 22 Jun 2020 17:52:58 +0200 (CEST)
Date:   Mon, 22 Jun 2020 17:52:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-progs scripts 'btrfs-debugfs' 'show-blocks' need python3
 updating
Message-ID: <20200622155258.GH27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSf+Q2yUZs-A_CxunfzNubvMUyKzfdkWK9iMYuPUwO1zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSf+Q2yUZs-A_CxunfzNubvMUyKzfdkWK9iMYuPUwO1zg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 21, 2020 at 06:31:40PM -0600, Chris Murphy wrote:
> I'm not sure if these are still useful for btrfs developers. If not,
> maybe deprecate them. If so, hopefully someone in the community is
> interested in updating them so they work.
> 
> pythons2->python3 update needed for btrfs-debugfs show-blocks #261
> https://github.com/kdave/btrfs-progs/issues/261

The tool is deprecated, plan is to replace it with python-btrfs, so I
don't want to delete it just yet from the repository as people seem to
be using it.

Fixing it to work with python 3 is one patch away and I don't mind
merging it as I don't have ETA for the python-btrfs transition.
