Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF4D380879
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 13:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhENLcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 07:32:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENLcJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 07:32:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 489DBAFF5;
        Fri, 14 May 2021 11:30:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2DF57DA8EB; Fri, 14 May 2021 13:28:26 +0200 (CEST)
Date:   Fri, 14 May 2021 13:28:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210514112825.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, riteshh <riteshh@linux.ibm.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210513225409.GL7604@twin.jikos.cz>
 <2b05bb47-f16c-62dd-d234-8bffdd332081@gmx.com>
 <20210514022609.lixjorvhu6mwsaoe@riteshh-domain>
 <20210514102840.kifj3ryzrw5utwj4@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514102840.kifj3ryzrw5utwj4@riteshh-domain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 03:58:40PM +0530, riteshh wrote:
> On 21/05/14 07:56AM, riteshh wrote:
> > On 21/05/14 09:41AM, Qu Wenruo wrote:
> > If it helps, I tested "-g quick" on PPC64 with 64k config for 1-13 patches of
> > this patch series and didn't find any regression/crash with xfstests.
> > I am running "-g auto" now, will let you know the results once it completes.
> 
> I tested these patches (1-13) with "-g auto" config and I didn't see any
> regression/crashes on PPC64 platform.

Yes it helps, thanks for testing. You could also let the fstests run in
a loop or with different memory/cpu setup, this can catch some races.
