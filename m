Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A8320109
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 22:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBSV70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 16:59:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:34202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhBSV6v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 16:58:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0232CAFF5;
        Fri, 19 Feb 2021 21:58:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75790DA783; Fri, 19 Feb 2021 22:56:11 +0100 (CET)
Date:   Fri, 19 Feb 2021 22:56:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RFC] btrfs-progs: format-output: remove newline in fmt_end text
 mode
Message-ID: <20210219215611.GM1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
References: <20210216162840.167845-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216162840.167845-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 04:28:40PM +0000, Sidong Yang wrote:
> Remove a code that inserting new line in fmt_end() for text mode.
> Old code made a failure in fstest btrfs/006.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> Hi, I've just read mail that Filipe written that some failure about fstest.
> I'm worried about this patch makes other problem. So make it RFC. Thanks.

I found the discussion under the device stats patch adding json, the
added line was known and "hopefully not causing problems", but the
fstests seem to notice.

I think we can fix that by removing the fmt_end newline but we also need
to update how the fmt_print is done for the text output. Ie. for json
there are some strict rules for line continuations  (",") but for the
textual output, each line ended by "\n" right away, without delaying
that to the next fmt_* call should work.
