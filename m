Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E963BD6600
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfJNPRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 11:17:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732397AbfJNPRN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 11:17:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9C67B540;
        Mon, 14 Oct 2019 15:17:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 035B8DA7E3; Mon, 14 Oct 2019 17:17:23 +0200 (CEST)
Date:   Mon, 14 Oct 2019 17:17:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Message-ID: <20191014151723.GP2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008044936.157873-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 08, 2019 at 12:49:29PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/bg_tree
> Which is based on v5.2.2 tag.
> 
> This patchset provides the needed user space infrastructure for BG_TREE
> feature.
> 
> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-progs
> is needed to convert existing fs (unmounted) to new format.
> 
> Now btrfstune can convert regular extent tree fs to bg tree fs to
> improve mount time.

Have we settled the argument whether to use a new tree or key tricks for
the blocgroup data? I think we have not and will read the previous
discussions. For a feature like this I want to be sure we understand all
the pros and cons.
