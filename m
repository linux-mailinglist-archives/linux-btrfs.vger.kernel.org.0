Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3276774
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGZN2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 09:28:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfGZN2s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 09:28:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3936AF1D;
        Fri, 26 Jul 2019 13:28:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF30EDA811; Fri, 26 Jul 2019 15:29:22 +0200 (CEST)
Date:   Fri, 26 Jul 2019 15:29:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: BTRFS: Kmemleak errrors with do_sys_ftruncate
Message-ID: <20190726132922.GA2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Paul Menzel <pmenzel@molgen.mpg.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <8c9b2f4e-252c-fee7-ef52-4ec2b9b54042@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9b2f4e-252c-fee7-ef52-4ec2b9b54042@molgen.mpg.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 03:16:57PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Power 8 server
> 
>     Linux power 5.3.0-rc1+ #1 SMP Fri Jul 26 11:34:28 CEST 2019 ppc64le ppc64le ppc64le GNU/Linux
> 
> Kmemleak reports the warnings below.

There are memory leaks of struct extent_state introduced in 5.3 pull and
there's a fix going to 5.3-rc2 (https://patchwork.kernel.org/patch/11060447/).

> I believe these have been present for some releases already, but Kmemleak
> was broken until now on that system, so that I could only report them now.

We have a leak detector built-in btrfs so I think we'd notice and that
you observe the known leak. You could try to apply the patch or wait for
rc2 and restst.
