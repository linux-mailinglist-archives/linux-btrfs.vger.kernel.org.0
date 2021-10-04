Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DB421296
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhJDPYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 11:24:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41754 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhJDPYi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 11:24:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 288682021F;
        Mon,  4 Oct 2021 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633360969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVqimDwXdZsagbP9gaYebg6bfTNzzTuJ/sFG7LvtfIU=;
        b=sg73zYL+ORhjpY5OYtAUd/KIbtBhnoh7UXCebInAusZ2IkCNCn29XCcNOfxS0/0DbsXjDN
        3tf8KnpPbMgIxBst9TN7FdK8itBgwDPQMejCEpFcgt+j4BAcZEvIuzm9hq9VYlwcAFN2EJ
        Mnd5OrBDaoGqd3yMrchXB3omCIFBcJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633360969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVqimDwXdZsagbP9gaYebg6bfTNzzTuJ/sFG7LvtfIU=;
        b=gOAZFFy9XtMytzf1K4s+849ImC7pXU4HSgISgQMvLQJGp99t/0ssbV+3eiLmdEq48WwWJ5
        xz+Czu+7t494jHBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 22A14A3CB5;
        Mon,  4 Oct 2021 15:22:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 073EEDA7F3; Mon,  4 Oct 2021 17:22:29 +0200 (CEST)
Date:   Mon, 4 Oct 2021 17:22:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs-progs: property: ro->rw and received_uuid
Message-ID: <20211004152229.GA9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1633101904.git.dsterba@suse.com>
 <4c02eb0d00433fa95b77befecafcdf147c230f21.1633101904.git.dsterba@suse.com>
 <cf04c434-c95d-eb88-770d-ca564a97dcb3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf04c434-c95d-eb88-770d-ca564a97dcb3@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 02, 2021 at 10:05:19AM +0300, Andrei Borzenkov wrote:
> On 01.10.2021 18:29, David Sterba wrote:
> > Implement safety check when a read-only subvolume is getting switched
> > to read-write and there's received_uuid set.
> > 
> > This prevents accidental breakage of incremental send usecase but allows
> > user to do the rw change anyway but resets the received_uuid in that
> > case.
> > 
> > As this is implemented entirely in userspace, it's racy and using the
> > raw ioctl won't prevent it nor reset the received_uuid.
> > 
> 
> Is it feasible to add "force" flag to ioctl itself?

Yeah that's possible but affects the ioctl semantics, so that's a bit
more tricky than the userspace side. It would solve the atomicity
problem in this patchset.
