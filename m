Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B28E3D5CA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhGZO2U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 10:28:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58944 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhGZO2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 10:28:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E00D1FD34;
        Mon, 26 Jul 2021 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627312128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xELkNNS8QB7bINED7zX5s/ksbTH1C+q8Vtq5QOW4xCY=;
        b=Gpcm2dWwAFMt9KMj3MIYbN8raDOUk95r0a7aCjSvb8fRUV4qdRHXDsTRf966K4r0gtGOCq
        oCd2CEU6MJtUiQtmRKrDulZ+LQLgvgceyqLyecEWEQ9a0q4+5r+S7a/BfPBNXPDjQLf+cn
        /NRHV7mbzn7TrtZgZc4KpUJN83IIRLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627312128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xELkNNS8QB7bINED7zX5s/ksbTH1C+q8Vtq5QOW4xCY=;
        b=yAiuIeXGFsHNQ3p4vWI8+WfChnIRPUCSFmuuD70YFNZ87LO5zSZOyPTT6HR6mlYggOdkUA
        QUSeHIG2SAzTVdAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 05506A3B88;
        Mon, 26 Jul 2021 15:08:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A572DA8D8; Mon, 26 Jul 2021 17:06:04 +0200 (CEST)
Date:   Mon, 26 Jul 2021 17:06:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] btrfs: uninline btrfs_bg_flags_to_raid_index
Message-ID: <20210726150604.GE5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <6a4949f84e640c299bf7b1d0898e54895b76c0c7.1627300614.git.dsterba@suse.com>
 <cea44339-1e8b-0066-86a6-3980bbc00e1d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cea44339-1e8b-0066-86a6-3980bbc00e1d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 08:34:20PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/26 下午8:15, David Sterba wrote:
> > The helper does a simple translation from block group flags to index to
> > the btrfs_raid_array table. There's no apparent reason to inline the
> > function, the translation happens usually once per function and is not
> > called in a loop.
> >
> > Making it a proper function saves quite some binary code (x86_64,
> > release config):
> >
> >     text    data     bss     dec     hex filename
> > 1164011   19253   14912 1198176  124860 pre/btrfs.ko
> > 1161559   19253   14912 1195724  123ecc post/btrfs.ko
> >
> > DELTA: -2451
> 
> My memory says there used to be some option to allow the compiler to
> uninline some functions, but I can't find it in the latest kernel.

Inlining is the compiler magic, the inline annotations are taken as
hints (that's what compiler people say) but they mostly work as written
in the source.

> It looks to me that this should really be something dependent on kernel
> config/compiler optimization.

Leaving the optimizations to the compiler is a good idea in general,
recompiling the same sources on a newer CPU target can lead to better
code compared to some hand-crafted code that may prevent the
optimizations. The one I uninlined here was an obvious "too big for
inline" and it was not a hot path. I'd rather remove such obvious cases
as we see them, the size and scope of the change is measurable.

> E.g. to allow -Os optimization to uninline such functions.

IIRC -Os is not recommended for kernel as it could generate worse code.
Also I don't think it's not a common default option so we'd have to live
with the worse code for most builds.
