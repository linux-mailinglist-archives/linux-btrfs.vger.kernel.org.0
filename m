Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43BA3E5C47
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 15:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbhHJNyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 09:54:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbhHJNyF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 09:54:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CD2A91FE56;
        Tue, 10 Aug 2021 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628603622;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edwz4b7dZPE83tdlML3lqDaFmRl4cAjzQa0k+TBzpps=;
        b=fzba0drhUNnw6/rZyljPBngoP1iz7t7zgp+1+XOtf8jzJPpMxe9SFpUzvmG77wbBg+F497
        LkUOToQ6Ybd1uxXf/VQKLthScfBty76ak7SKOFdZVQQgARKlNTZMvt/CJJqQMqIjs4rgJV
        brG92Y9ZRPSG7D1Z7a5fraz7iQXPtOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628603622;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edwz4b7dZPE83tdlML3lqDaFmRl4cAjzQa0k+TBzpps=;
        b=4z7SU2UloEM4bQq8hqm3kcTCZIuYdwx4jJapf2jNDq2SLAmaMVBlXSyIU2TzpTD0mFW/4U
        DQU0nV9MGaQDP4CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9C684A3B95;
        Tue, 10 Aug 2021 13:53:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F9A4DA880; Tue, 10 Aug 2021 15:50:50 +0200 (CEST)
Date:   Tue, 10 Aug 2021 15:50:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: suppress reclaim error message on EAGAIN
Message-ID: <20210810135050.GT5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210809043230.3033804-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809043230.3033804-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 01:32:30PM +0900, Naohiro Aota wrote:
> btrfs_relocate_chunk() can fail with -EAGAIN when e.g. send operations are
> running. The message can fail btrfs/187 and it's unnecessary because we
> anyway add it back to the reclaim list.
> 
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

With the stacktrace and Fixes: added to misc-next, thanks.
