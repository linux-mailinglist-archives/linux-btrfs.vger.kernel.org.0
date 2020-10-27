Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE929C520
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824214AbgJ0SEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 14:04:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1824201AbgJ0SEJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 14:04:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FBEBADCA;
        Tue, 27 Oct 2020 18:04:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A0A5DA6E2; Tue, 27 Oct 2020 19:02:34 +0100 (CET)
Date:   Tue, 27 Oct 2020 19:02:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com
Subject: Re: [PATCH v9 0/3] readmirror feature (read_policy sysfs and
 in-memory only approach)
Message-ID: <20201027180233.GF6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <20201023170403.GM6756@twin.jikos.cz>
 <31c3da05-2238-da84-509e-3b29835ec33a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c3da05-2238-da84-509e-3b29835ec33a@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 27, 2020 at 09:52:11AM +0800, Anand Jain wrote:
> 
> 
> On 24/10/20 1:04 am, David Sterba wrote:
> > On Thu, Oct 22, 2020 at 03:43:34PM +0800, Anand Jain wrote:
> >> v9: C coding style fixes in 1/3 and 3/3
> > 
> > So the point of adding the sysfs knobs is to allow testing various
> > mirror selection strategies, what exactly was discussed in the past. Do
> > you have patches for that as well? It does not need to be final and
> > polished but at least give us something to test.
> > 
> 
> Sure. I just sent out the patchset [1]. It provides read_policy: 
> latency, device, and round-robin.
> 
> [1]
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=371023

Exporting more information from the devices would help us to decide but
is there anything we can do just with what we have? Or eventually add
our counters like for the in-flight requests or total bytes. The
intention is not to duplicate what block layer does as we need to
experiment with the stats and heuristics it's just for that purpose and
we don't have to rely on other subsystem patches.
