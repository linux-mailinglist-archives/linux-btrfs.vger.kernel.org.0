Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF99B261C40
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgIHTQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 15:16:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:52956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731166AbgIHQDl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 12:03:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2709FAF62;
        Tue,  8 Sep 2020 15:48:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F2D0DA781; Tue,  8 Sep 2020 17:47:02 +0200 (CEST)
Date:   Tue, 8 Sep 2020 17:47:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Message-ID: <20200908154702.GA18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "nborisov@suse.com" <nborisov@suse.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
 <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
 <SN4PR0401MB35988315D6DF0068151AE2359B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598B2EC32C25D601E59BF879B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <a0f3b051-b9e6-e881-cdb1-0c75224f6760@oracle.com>
 <SN4PR0401MB35981763EBBC62E6CFEE7B759B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35981763EBBC62E6CFEE7B759B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 07, 2020 at 03:09:20PM +0000, Johannes Thumshirn wrote:
> On 07/09/2020 14:00, Anand Jain wrote:
> > David and I decided to avoid cleanups in the patch 1/16, and are
> > pushed into the patch 3-7/16, mainly to make the bug fix patch easy
> > to backport.
> 
> Yep I know, but one prep patch in front shoukld be ok even, when you 
> need to backport something to stable. I think 4/16 can go in front of
> the series and be backported as well. Sorry that I didn't scan the whole
> series before replying to the 1st patch.

There is some duplication but the bugfix is clear and minimal, just
adding the condition around some code which I'd prefer for a stable
patch. The prep or cleanup creates a dependency and this needs to be
tracked in the real fix either by subject or in Fixes: and commit id.
When the fix can be in one patch it's all easier.
