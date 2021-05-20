Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6072F38AFCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 15:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhETNUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 09:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:52486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235749AbhETNUi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 09:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 386EEAC85;
        Thu, 20 May 2021 13:19:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E275DA7F9; Thu, 20 May 2021 15:16:42 +0200 (CEST)
Date:   Thu, 20 May 2021 15:16:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: abort the transaction if we fail to replay log
 trees
Message-ID: <20210520131641.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <9513d31a4d2559253088756f99d162abaf090ebd.1621438132.git.josef@toxicpanda.com>
 <PH0PR04MB7416EC2004FF7AB6B2F4D5339B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519201551.GX7604@twin.jikos.cz>
 <1a3f7033-90be-4106-380b-8efca3a9e930@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3f7033-90be-4106-380b-8efca3a9e930@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 04:22:33PM -0400, Josef Bacik wrote:
> On 5/19/21 4:15 PM, David Sterba wrote:
> > On Wed, May 19, 2021 at 04:22:20PM +0000, Johannes Thumshirn wrote:
> >> On 19/05/2021 17:29, Josef Bacik wrote:
> > Good point and I want to keep the abort pattern consistent so it should
> > be called before the goto error's. Note that this function still uses
> > btrfs_handle_fs_error which predates the transaction abort framework and
> > should be replaced as needed.
> 
> Yeah this is a good point, I assume since we're now going to get the transaction 
> abort message for the spots I replace btrfs_handle_fs_error() we don't need to 
> replace the message?  Thanks,

Yeah, plain btrfs_abort_transaction should be ok.
