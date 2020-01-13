Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8013921B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 14:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMNYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 08:24:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:59740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgAMNYA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 08:24:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AB66AADF1;
        Mon, 13 Jan 2020 13:23:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62585DA78B; Mon, 13 Jan 2020 14:23:46 +0100 (CET)
Date:   Mon, 13 Jan 2020 14:23:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Converting from one csum hash algorithm to another?
Message-ID: <20200113132346.GT3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQanp1_gHJyvhbZz1BNBToamAO9027zH7SjuxMg9nezkzQQ@mail.gmail.com>
 <ebb53e46-f9c4-e2fa-5e35-15af94c1b41f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebb53e46-f9c4-e2fa-5e35-15af94c1b41f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 07:31:58PM +0800, Qu Wenruo wrote:
> On 2020/1/13 下午4:45, Sebastian Döring wrote:
> > just a quick question: Will it be possible to convert existing btrfs
> > to a different csum hash? It seems viable to re-read all
> > data&metadata, verify existing checksums, and then recalculate a new
> > one.
> 
> Yes, but consideration the complexity, it's not suitable for kernel i guess.

Yeah, not for kernel.

> > I'm pretty excited about the inclusion of xxhash and am wondering if I
> > have to recreate the whole fs at some point...
> 
> Considering there is the use case, we may consider add such ability to
> btrfs-progs.
> 
> Since we already have things like btrfstune -M to change UUID, we may be
> able to do that.

The UUID change rewrites the same bytes, all the new checksums need more
bytes for the data checksum items so this requires COWing all checksum
tree leaves. Handling all the intermediate cases (interruption/crash in
the middle of the conversion) would be harder than for the UUID change.
The overall run time would be longer due to more blocks to rewrite, so
there's enough complexity and risk on the way.
