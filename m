Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE91DE647
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgEVMIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 08:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:47428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbgEVMIR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 08:08:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75897AE67;
        Fri, 22 May 2020 12:08:19 +0000 (UTC)
Date:   Fri, 22 May 2020 07:08:13 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200522120813.bpyi244xygwujxda@fiona>
References: <20200507113741.GJ18421@twin.jikos.cz>
 <20200507121037.GA25363@infradead.org>
 <20200508031405.br4dcibcyuoluxum@fiona>
 <20200509135914.GA4962@infradead.org>
 <20200510040601.bub3du7g5kepeakw@fiona>
 <20200512145807.GA23409@infradead.org>
 <20200512171927.tk46sbriqvhasvsq@fiona>
 <20200515141305.GA27936@infradead.org>
 <20200519201116.6qyoaxc7g2krxzzx@fiona>
 <20200522113642.GK18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522113642.GK18421@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13:36 22/05, David Sterba wrote:
> 
> With the updated top commit 6cbb7a0c7b33d33e6 it passes fstests in my
> setup, so that's the minimum for inclusion.
> 
> Regarding merge, I'm willing to add it to 5.8 queue still. In total it's
> 7 patches, 6 of which are preparatory or cleanups that have been
> reviewed by several people. The switch to iomap is one patch and not a
> huge one.
> 
> Sending the latest version proably makes sense so we have it in the
> mailinglist, I can add the patches to misc-next right away so it gets
> more testing exposure.
> 

Yes, sending them in some time. Thanks for testing.

-- 
Goldwyn
