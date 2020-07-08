Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEF218B17
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgGHPV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 11:21:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbgGHPV7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 11:21:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80159AFF1;
        Wed,  8 Jul 2020 15:21:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8106DA818; Wed,  8 Jul 2020 17:21:38 +0200 (CEST)
Date:   Wed, 8 Jul 2020 17:21:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     dsterba@suse.cz, Robbie Ko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
Message-ID: <20200708152138.GB28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
        Robbie Ko <robbieko@synology.com>, linux-btrfs@vger.kernel.org
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz>
 <3b3f9eb4-96ef-d039-5d86-a4c165e6d993@synology.com>
 <20200708140455.GA28832@twin.jikos.cz>
 <de7bfbe5-7d83-2437-701c-700bbe5d3adc@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de7bfbe5-7d83-2437-701c-700bbe5d3adc@applied-asynchrony.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 04:57:56PM +0200, Holger Hoffstätte wrote:
> On 2020-07-08 16:04, David Sterba wrote:
> > On Wed, Jul 08, 2020 at 10:19:22AM +0800, Robbie Ko wrote:
> >> David Sterba 於 2020/7/8 上午3:25 寫道:
> >> I don't know why we don't make the change to readahead, because the current
> >> readahead is limited to the logical address in 64k is very unreasonable,
> >> and there is a good chance that the logical address of the next leaf
> >> node will
> >> not appear in 64k, so the existing readahead is almost useless.
> > 
> > I see and it seems that the assumption about layout and chances
> > succesfuly read blocks ahead is not valid. The logic of readahead could
> > be improved but that would need more performance evaluation.
> 
> FWIW I gave this a try and see the following numbers, averaged over multiple
> mount/unmount cycles on spinning rust:
> 
> without patch : ~2.7s
> with patch    : ~4.5s
> 
> ..ahem..

Hard to argue against numbers, thanks for posting that.
