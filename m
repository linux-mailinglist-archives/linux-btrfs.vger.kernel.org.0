Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D23F4D0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhHWPHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 11:07:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52950 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhHWPHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 11:07:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4115721FDE;
        Mon, 23 Aug 2021 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629731228;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tv1CiltLTfPcBv9BYhK/5S+U5E1GUdKv8ycd7XgpvfU=;
        b=R8gCSdPE9DXY+bSY66oOqYHtAvLfefhpTkYsq3CTlzbZ0s3cuVH274gMm0qeh7fMjnT0bt
        PWgrkRbd6OQlspS37lZRbf/fU4Jz+so6Gdcvut1LmhsEx9/6h851FPmmjST9tavV5PqU+1
        dZNLst+I9LK+ohZTH7tlGHJimMtnOzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629731228;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tv1CiltLTfPcBv9BYhK/5S+U5E1GUdKv8ycd7XgpvfU=;
        b=PVO/5SarAKibvKDBdZUY8Dzx74H2zZPk+PgL6g3AQrNJdAS8CQKBs5wyju1a2OQMhRPeA/
        J2EOGSZCCkZCJ/DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 396D5A3BB9;
        Mon, 23 Aug 2021 15:07:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2FE5DA725; Mon, 23 Aug 2021 17:04:08 +0200 (CEST)
Date:   Mon, 23 Aug 2021 17:04:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 02/12] btrfs-progs: do not infinite loop on corrupt
 keys with lowmem mode
Message-ID: <20210823150408.GD5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <aaaf2cadf66d9e573e2dbcc3e8fab7984ce42f99.1629322156.git.josef@toxicpanda.com>
 <05f2cfc1-ab2f-0e92-13ef-488a9e7d716c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05f2cfc1-ab2f-0e92-13ef-488a9e7d716c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 01:42:39PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/19 上午5:33, Josef Bacik wrote:
> > By enabling the lowmem checks properly I uncovered the case where test
> > 007 will infinite loop at the detection stage.  This is because when
> > checking the inode item we will just btrfs_next_item(), and because we
> > ignore check tree block failures at read time we don't get an -EIO from
> > btrfs_next_leaf.  Generally what check usually does is validate the
> > leaves/nodes as we hit them, but in this case we're not doing that.  Fix
> > this by checking the leaf if we move to the next one and if it fails
> > bail.  This allows us to pass the 007 test with lowmem.
> 
> Doesn't this mean btrfs_next_item() is not doing what it should do?
> 
> Normally we would expect btrfs_next_item() to return -EIO other than
> manually checking the returned leaf.

That's an interesting point, I think we rely on that behaviour
elsewhere too.

