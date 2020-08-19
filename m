Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AE24A1CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHSOgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 10:36:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgHSOgX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 10:36:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FF4CB593;
        Wed, 19 Aug 2020 14:36:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7FDF3DA703; Wed, 19 Aug 2020 16:35:16 +0200 (CEST)
Date:   Wed, 19 Aug 2020 16:35:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] btrfs: a few performance improvements for fsync and
 rename/link
Message-ID: <20200819143516.GO2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200811114328.688282-1-fdmanana@kernel.org>
 <20200819140803.GM2026@twin.jikos.cz>
 <CAL3q7H7RHp095a7Fsw_Nn-8r_joWOAsqPp=EUObun5dv0mA6Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7RHp095a7Fsw_Nn-8r_joWOAsqPp=EUObun5dv0mA6Aw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 03:23:27PM +0100, Filipe Manana wrote:
> On Wed, Aug 19, 2020 at 3:09 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Aug 11, 2020 at 12:43:28PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > A small group of changes to improve performance of fsync, rename and link operations.
> >
> > Thank you very much!
> >
> > > They are farily independent, but patch 3 needs to be applied before patch 2, the
> > > order can be changed if needed.
> > > Details and performance tests are mentioned in the change log of each patch.
> >
> > A lot of two-digit improvements in throughput and runtime, that's great.
> 
> Btw, could you fold the following into patch 3?
> 
> https://pastebin.com/raw/hmmmnzJY

Updated and pushed, thanks.
