Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847762C2C4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390125AbgKXQHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 11:07:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:44748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgKXQHC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 11:07:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0039EAC2D;
        Tue, 24 Nov 2020 16:07:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45C12DA818; Tue, 24 Nov 2020 17:05:32 +0100 (CET)
Date:   Tue, 24 Nov 2020 17:05:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove noinline attribute from wait_for_commit
Message-ID: <20201124160532.GA6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201124144502.3168362-1-nborisov@suse.com>
 <20201124153950.GA1803@twin.jikos.cz>
 <ed0b6532-e4ee-1bdb-6376-0393c3d976b2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed0b6532-e4ee-1bdb-6376-0393c3d976b2@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 24, 2020 at 05:42:57PM +0200, Nikolay Borisov wrote:
> 
> 
> On 24.11.20 г. 17:39 ч., David Sterba wrote:
> > On Tue, Nov 24, 2020 at 04:45:02PM +0200, Nikolay Borisov wrote:
> >> The function is a plain wrapper that noinline makes no sense.
> > 
> > Or it is a way to let the function name appear in a stack trace, which
> > could be useful for debugging or analyzing system state.
> > 
> 
> Well, this information could generally be derived by having the debug
> info  either in crash or one of the "beautify" scripts. In any case I
> won't insist.

The way it's used is 'cat /proc/*/stack', without the need of debugging
kernels and not in a post-mortem analysis with crash.
