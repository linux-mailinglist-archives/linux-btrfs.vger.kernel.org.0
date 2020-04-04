Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5219E1FF
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 02:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDDAxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 20:53:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDDAxE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 20:53:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 485F9ACF0;
        Sat,  4 Apr 2020 00:53:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4B01DA730; Sat,  4 Apr 2020 02:52:28 +0200 (CEST)
Date:   Sat, 4 Apr 2020 02:52:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: Introduce expand_command() to inject
 aruguments more accurately
Message-ID: <20200404005228.GL5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200330070232.50146-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330070232.50146-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 30, 2020 at 03:02:32PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> We want to inject $INSTRUMENT (mostly valgrind) before btrfs command but
> after root_helper.
> 
> Currently we won't inject $INSTRUMENT at all if we are using
> root_helper.
> This means the coverage is not good enough.
> 
> [FIX]
> This patch introduce a new function, expand_command(), to handle all
> parameter/argument injection, including existing 'btrfs check' inject.
> 
> This function will:
> - Detect where to inject $INSTRUMENT
>   If we have root_helper and the command is target command
>   (btrfs/mkfs.btrfs/btrfs-convert), then we inject $INSTRUMENT after
>   root_helper.
>   If we don't have root_helper, and the command is target command,
>   we inject $INSTRUMENT before the command.
>   Or we don't inject $INSTRUMENT (it's not the target command).
> 
> - Use existing spec facility to inject extra arguments
> 
> - Use an array to restore to result
>   To avoid bash interpret the IFS inside path/commands.
> 
> Now we can make sure no matter if we use root_helper, $INSTRUMENT is
> always injected corrected.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I don't know why, but with this patch (without my fixups) the misc tests
get stuck at 004-shrink-fs. Per 'ps' output it's inside the test.sh
script so not waiting for sync or such. I need to do the releease so
will skip this patch as it's not critical.
