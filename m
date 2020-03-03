Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258E4177D78
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 18:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgCCR3l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 12:29:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:43072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbgCCR3l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 12:29:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F618B028;
        Tue,  3 Mar 2020 17:29:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A53FDA7AE; Tue,  3 Mar 2020 18:29:17 +0100 (CET)
Date:   Tue, 3 Mar 2020 18:29:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 05/10] btrfs: relocation: Refactor tree backref
 processing into its own function
Message-ID: <20200303172917.GK2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302094553.58827-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 05:45:48PM +0800, Qu Wenruo wrote:
> build_backref_tree() function is painfully long, as it has 3 big parts:
> - Tree backref handling
> - Weaving backref nodes
> - Useless nodes pruning

So this is the first patch that mentions the 'useless' nodes. This seems
like a misnomer or confusing at best but I haven't read enough code to
see if it's really the right name.

Also the term 'weaving', that seems to be added by you. Did you mean
splicing or merging?
