Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2800234781
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgGaONb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 10:13:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:35378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbgGaONb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 10:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19305B6B6;
        Fri, 31 Jul 2020 14:13:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A01ABDA82B; Fri, 31 Jul 2020 16:12:59 +0200 (CEST)
Date:   Fri, 31 Jul 2020 16:12:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: handle errors from async submission
Message-ID: <20200731141259.GN3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200728112541.3401-1-johannes.thumshirn@wdc.com>
 <20200730164657.GJ3703@twin.jikos.cz>
 <SN4PR0401MB3598FF781B4DE1120955FCDC9B4E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598FF781B4DE1120955FCDC9B4E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 31, 2020 at 07:39:06AM +0000, Johannes Thumshirn wrote:
> On 30/07/2020 18:47, David Sterba wrote:
> [...]
> > The submit bio hooks have become a trivial indirect call to two
> > functions, so we might get rid of the indirection eventually.
> 
> Yes that was my thought as well, but then I got distracted by more urgent
> things again.

Sure, that's just a drive-by comment. I had a quick look at the io
submit call chains for some easy cleanups but haven't spotted anything.
So this will need some deeper reorganization, we can live with the
indirection until then.
