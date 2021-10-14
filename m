Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5E42DD90
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhJNPJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:09:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhJNPIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:08:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 89ED91FD39;
        Thu, 14 Oct 2021 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634223990;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gaagysc71AvBsd6rnUf2wPRZXZl4ht3mhw84t7VvyX4=;
        b=fucRP6EPxd04cQ6ek6fP1vBSE9oAoxIo0xiI7p06eQZCJ0uMPm7Zc7AwCoUMCPvlC7uB5l
        VgUmQisrzFpbrbbql1z4LowgjuuaXlNXwDLldjvisfO0sJ9yL8gyF881s1SUMwWE0yLlTy
        WkzwAfO4s+nO6PBcCoOJwJ/D0iBNeqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634223990;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gaagysc71AvBsd6rnUf2wPRZXZl4ht3mhw84t7VvyX4=;
        b=79TjymC+zDMIEbnGQ/9rvLJbhi9FrE4TAfCaQC3d07Se4briGtRJM8hoJiNJJoZrxh9TpV
        C7+YjGM9nDyJrsCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 82292A3B87;
        Thu, 14 Oct 2021 15:06:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C585DDA7A3; Thu, 14 Oct 2021 17:06:05 +0200 (CEST)
Date:   Thu, 14 Oct 2021 17:06:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a triggered ASSERT() for generic/029 when
 executed with compression
Message-ID: <20211014150605.GB19582@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211014071634.29738-1-wqu@suse.com>
 <YWhBjf64v2Q0h8uM@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWhBjf64v2Q0h8uM@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 10:41:17AM -0400, Josef Bacik wrote:
> > This commit can be fixed into the offending refactor.
> > It looks like I can't escape the recent destiny that refactors are
> > introducing more bugs.

Folded to the patch, thanks.

> This is what our continual testing is meant to catch, be happy the process is
> working!

Yep, I did not see the crash as I don't run the default setup with
-o compress.
