Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877192A2DB2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgKBPKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 10:10:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:37124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgKBPKc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 10:10:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87C03B950;
        Mon,  2 Nov 2020 15:10:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10558DA7D2; Mon,  2 Nov 2020 16:08:52 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:08:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from
 fs_info
Message-ID: <20201102150851.GD6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1603981452.git.dsterba@suse.com>
 <b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com>
 <5d586f76-7cad-b7be-60d3-44c8d3b67623@gmx.com>
 <c798fbcc-c7e9-fca6-992b-bd006d6a61b4@gmx.com>
 <SN4PR0401MB3598B9DAD09F08946CBF6C3E9B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598B9DAD09F08946CBF6C3E9B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 02:31:35PM +0000, Johannes Thumshirn wrote:
> On 02/11/2020 15:20, Qu Wenruo wrote:
> > This may sounds like a nitpicking, but what about "ffs(4096) - 1"?
> > IMHO it should be a little more faster than ilog2, especially when we
> > have ensure all sector size is power of 2 already.
> 
> Looking at the actual ilog2() implementation (and considering you're 
> passing 4096, a constant) you'll end up in const_ilog() which will 
> evaluate to 9.
> 
> ffs() on the other hand on x86_64 will evaluate to a bfsl. So ffs() will
> evaluated at runtime, while ilog2() at compile time.

As the value is calculated only once for the whole filesystem lifetime,
I'm not concerned about speed but readability.
