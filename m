Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F3F1141BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 14:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfLENlS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 08:41:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:60644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729417AbfLENlS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 08:41:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC9B9B1D2;
        Thu,  5 Dec 2019 13:41:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5BB4DA733; Thu,  5 Dec 2019 14:41:11 +0100 (CET)
Date:   Thu, 5 Dec 2019 14:41:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <Damenly_Su@gmx.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs-progs: port block group cache tree insertion
 and lookup functions
Message-ID: <20191205134111.GL2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <Damenly_Su@gmx.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-4-Damenly_Su@gmx.com>
 <d75b62a9-b88b-d44c-16b5-55ebef426534@gmx.com>
 <f84fa08d-219e-3ea7-7f11-7153a2045af1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f84fa08d-219e-3ea7-7f11-7153a2045af1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 04:32:57PM +0800, Su Yue wrote:
> On 2019/12/5 3:29 PM, Qu Wenruo wrote:
> > On 2019/12/5 下午12:29, damenly.su@gmail.com wrote:
> >> From: Su Yue <Damenly_Su@gmx.com>
> >>
> >> Simple copy and paste codes, remove useless lock operantions in progs.
> >> Th new coming lookup functions are named with suffix _kernel in
> >> temporary.
> >>
> >> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> >
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> > Just an extra hint, it would be much better if we backport this
> > functions to block-group.c.
> >
> Considered it, then porting functions moved will not require
> any suffixes to avoid conflictions. It will be more clean while doing
> reform work. But I wonder if it's a proper timing to create
> block-group.c in progs.

The small incremental changes are IMHO better for now, the kernel and
userspace code bases are not close enough so we can just copy code. When
the code that implements some logic (and uses same structures) is "close
enough", we can copy it directly (eg. the delayed-refs.[ch]), but
otherwise it needs to be done in small steps like you do in this
patchset.
