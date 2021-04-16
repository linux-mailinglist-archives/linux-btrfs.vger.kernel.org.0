Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8F3626FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbhDPRiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 13:38:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:41766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243237AbhDPRiI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 13:38:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D87C3ADDB;
        Fri, 16 Apr 2021 17:37:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0726DA790; Fri, 16 Apr 2021 19:35:25 +0200 (CEST)
Date:   Fri, 16 Apr 2021 19:35:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mark BUG() as unreachable
Message-ID: <20210416173525.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <5c7b703beca572514a28677df0caaafab28bfff8.1617265419.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7b703beca572514a28677df0caaafab28bfff8.1617265419.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 01, 2021 at 05:41:00PM +0900, Naohiro Aota wrote:
> Marking BUG() unreachable helps us silence unnecessary warnings e.g.
> "warning: control reaches end of non-void function [-Wreturn-type]" like
> the code below.
> 
>    int foo()
>    {
>    ...
>    	if (XXX)
>    		return 0;
> 	else if (YYY)
> 		return 1;
>    	else
>    		BUG();
>    }
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to devel, thanks.
