Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5262229778
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGVLcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 07:32:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVLcr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 07:32:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37017AC2D;
        Wed, 22 Jul 2020 11:32:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B7FDDA70B; Wed, 22 Jul 2020 13:32:20 +0200 (CEST)
Date:   Wed, 22 Jul 2020 13:32:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
Message-ID: <20200722113220.GR3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
 <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
 <20200721135533.GL3703@twin.jikos.cz>
 <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 06:58:39AM +0800, Qu Wenruo wrote:
> >> Thus casting both would definitely be right, without the need to refer
> >> to the complex rule book, thus save the reviewer several minutes.
> >
> > The opposite, if you send me code that's not following known schemes or
> > idiomatic schemes I'll be highly suspicious and looking for the reasons
> > why it's that way and making sure it's correct costs way more time.
> >
> OK, then would you please remove one casting at merge time, or do I need
> to resend?

Yeah, I fix such things routinely no need to resend.
