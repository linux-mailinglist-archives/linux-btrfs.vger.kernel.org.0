Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C4D349BF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCYVtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 17:49:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhCYVtL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 17:49:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53C85AF9C;
        Thu, 25 Mar 2021 21:49:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 499D0DA732; Thu, 25 Mar 2021 22:47:04 +0100 (CET)
Date:   Thu, 25 Mar 2021 22:47:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, dsterba@suse.cz,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] btrfs: fixed rudimentary typos
Message-ID: <20210325214704.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210325042113.12484-1-unixbhaskar@gmail.com>
 <20210325124954.GL7604@twin.jikos.cz>
 <YFzR/E+GFlrYyxdm@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFzR/E+GFlrYyxdm@Gentoo>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 11:40:04PM +0530, Bhaskar Chowdhury wrote:
> On 13:49 Thu 25 Mar 2021, David Sterba wrote:
> >On Thu, Mar 25, 2021 at 09:51:13AM +0530, Bhaskar Chowdhury wrote:
> >>
> >> s/contaning/containing
> >> s/clearning/clearing/
> >
> >Have hou scanned the whole subdirectory for typos? We do typo fixing
> >about once a year in one big patch and won't fix them one by one.
> 
> Once a year???? You must be kidding! that is not good whatever the workflow
> you have .

No kidding. It's even worse, we get that every two years.

* 2016 0132761017e012ab4dc8584d679503f2ba26ca86
  33 files changed, 106 insertions(+), 105 deletions(-)

* 2018 52042d8e82ff50d40e76a275ac0b97aa663328b0
  25 files changed, 70 insertions(+), 69 deletions(-)

You can see the diffstat touches nearly all the files, almost hundred of
fixed typos per patch. Now compare that to sending 70-100 individual
patches. Time spent on any patch is not zero and for such trivial
changes it's not justified so the workflow is to do that in batches.
If you care about fixing typos in fs/btrfs/, please fix them all. I've
found about 50.
