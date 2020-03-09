Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233A117EC9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 00:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgCIXZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 19:25:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:53406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgCIXZz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 19:25:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93558AC6E;
        Mon,  9 Mar 2020 23:25:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A04A5DA7A7; Tue, 10 Mar 2020 00:25:28 +0100 (CET)
Date:   Tue, 10 Mar 2020 00:25:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: Make balance cancelling response faster
Message-ID: <20200309232528.GP2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200217061654.65567-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217061654.65567-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 17, 2020 at 02:16:51PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> There are quite some users reporting that 'btrfs balance cancel' slow to
> cancel current running balance, or even doesn't work for certain dead
> balance loop.
> 
> With the following script showing how long it takes to fully stop a
> balance:
> 
> [FIX]
> This patchset will add more cancelling check points, to make cancelling
> faster.

Patches have been in for-next and also used to develop various fixes in
the relocation code, so from that point I think it's ok to move them to
misc-next. The benefit for usability is also clear, so thanks for
working on that. As pointed elsewhere, the commandline UI will need to
be extended to wire the cancelation of resize/deletion to make use of
it, we have time for that for the next cycle.
