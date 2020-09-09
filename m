Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8162B26286B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIIHVa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 03:21:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgIIHVT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 03:21:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4896AD3C;
        Wed,  9 Sep 2020 07:21:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9AB1DA7C6; Wed,  9 Sep 2020 09:20:02 +0200 (CEST)
Date:   Wed, 9 Sep 2020 09:20:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: introduce rescue=all
Message-ID: <20200909072002.GD18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <921662f28b90d7e5a67bb52a1e0b0b2e9584f946.1599579772.git.josef@toxicpanda.com>
 <b862077c-0903-b4f0-ccc9-ee1c815534bc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b862077c-0903-b4f0-ccc9-ee1c815534bc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 09, 2020 at 07:10:49AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/9/8 下午11:43, Josef Bacik wrote:
> > One of the things that came up consistently in talking with Fedora about
> > switching to btrfs as default is that btrfs is particularly vulnerable
> > to metadata corruption.  If any of the core global roots are corrupted,
> > the fs is unmountable and fsck can't usually do anything for you without
> > some special options.
> > 
> > What we really want is a simple mount option we can tell all users to
> > try if things are really wrong that are going to give them the highest
> > chance of allowing them to mount their file system and copy off their
> > data in the most direct way possible.
> 
> Then "all" doesn't look correct for such usage.
> I'd prefer "salvage" then.

Let's focus on the functionality for now.
