Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F983355992
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhDFQui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 12:50:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239963AbhDFQuh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 12:50:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52923B304;
        Tue,  6 Apr 2021 16:50:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79F23DA732; Tue,  6 Apr 2021 18:48:16 +0200 (CEST)
Date:   Tue, 6 Apr 2021 18:48:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.com" <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
Message-ID: <20210406164816.GK7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.com" <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
 <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com>
 <83ecd955-560f-14e5-ab97-33e0c0a3d3d0@oracle.com>
 <a6qdw0jr.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6qdw0jr.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 05, 2021 at 05:18:32PM +0800, Su Yue wrote:
> 
> On Mon 05 Apr 2021 at 16:38, Anand Jain <anand.jain@oracle.com> 
> wrote:
> 
> > Ping again.
> >
> It's already queued in misc-next.

> commit 441737bb30f83914bb8517f52088c0130138d74b (misc-next)
> Author: Anand Jain <anand.jain@oracle.com>
> Date:   Fri Jul 17 18:05:25 2020 +0800

No it's not, you must have checked some very old snapshot of misc-next,
I don't even have 441737bb30f83914bb8517f52088c0130138d74b in my stale
commit objects so it's been 'git gc'ed already.
