Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774D8E03BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbfJVMXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 08:23:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387575AbfJVMXh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:23:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D965B293;
        Tue, 22 Oct 2019 12:23:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 098E5DA733; Tue, 22 Oct 2019 14:23:48 +0200 (CEST)
Date:   Tue, 22 Oct 2019 14:23:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Message-ID: <20191022122348.GV3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
 <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
 <20191018172745.GD3001@twin.jikos.cz>
 <03ba36bd-fa92-fdea-6069-da60fe4df159@gmx.com>
 <20191021154404.GP3001@twin.jikos.cz>
 <07b33628-2cec-7bd3-26a1-e3be2367774a@gmx.com>
 <7435bf0f-ffbc-6723-4383-d780522d5af8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7435bf0f-ffbc-6723-4383-d780522d5af8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 02:30:22PM +0800, Qu Wenruo wrote:
> BTW, there is one important compatibility problem related to all the BGI
> related features.
> 
> Although I'm putting the BG_TREE feature as incompatible feature, but in
> theory, it should be RO compatible.

It could be RO compatible yes.

> As except extent/bg tree, we *should* read the fs without any problem.
> 
> But the problem is, current btrfs mount (including btrfs-check) still
> need to go through the block group item search, even for permanent RO mount.
> 
> This get my rescue mount option patchset to be involved.
> If we have such skip_bg feature earlier, we can completely afford to
> make all these potential features as RO compatible.
> 
> 
> Now my question is,  should we put this feature still as incompatible
> feature?

In some way it would probably have to be incompat, either full or RO. As
unknown tree items are ignored, if the rest of the filesystem provides
enough information to access the data, then incompat RO sounds like the
best option. And that's probably independent of how exactly the new BGI
is done.
