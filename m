Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D04220699
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgGOH5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 03:57:12 -0400
Received: from [195.135.220.15] ([195.135.220.15]:36154 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgGOH5M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 03:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3779DAE51;
        Wed, 15 Jul 2020 07:57:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C0E5EDA790; Wed, 15 Jul 2020 09:56:48 +0200 (CEST)
Date:   Wed, 15 Jul 2020 09:56:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: assert sizes of ioctl structures
Message-ID: <20200715075648.GV3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200714093236.6107-1-johannes.thumshirn@wdc.com>
 <20200714123234.GP3703@twin.jikos.cz>
 <SN4PR0401MB35986997606AF4136D0218439B610@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200714145534.GT3703@suse.cz>
 <SN4PR0401MB35989268008F43EA5CF63CA79B7E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35989268008F43EA5CF63CA79B7E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 15, 2020 at 07:12:09AM +0000, Johannes Thumshirn wrote:
> On 14/07/2020 16:56, David Sterba wrote:
> > On Tue, Jul 14, 2020 at 02:49:31PM +0000, Johannes Thumshirn wrote:
> >> On 14/07/2020 14:33, David Sterba wrote:
> >>> On Tue, Jul 14, 2020 at 06:32:36PM +0900, Johannes Thumshirn wrote:
> >>>> When expanding ioctl interfaces we want to make sure we're not changing
> >>>> the size of the structures, otherwise it can lead to incorrect transfers
> >>>> between kernel and user-space.
> >>>>
> >>>> Build time assert the size of each structure so we're not running into any
> >>>> incompatibilities.
> >>>>
> >>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>>
> >>> I've tried 32bit build and the assertion fails for many structures, but
> >>> I was expecting only the send one because it contains the pointer.
> >>
> >> I wonder if we should have two different asserts for 32 and 64bit for 
> >> these structures or remove the asserts from them.
> >>
> >> Having a 32 and 64bit assert will add some ifdeffery, let me see how 
> >> ugly this will get.
> > 
> > Progs do the switch using sizeof(long) and ?: operator but I don't know
> > if this works with _Static_assert as progs use the struct + bitfield
> > way.
> > 
> 
> I can try but it's ugly as hell IMHO

Or we can add macros like

ASSERT_STRUCT_SIZE(struct name, 64);

ASSERT_STRUCT_SIZE_32_64(struct name, 32, 64);

and then do the ifdefs at the definition time.

