Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628CD48B182
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 17:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349772AbiAKQBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 11:01:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57664 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349774AbiAKQBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 11:01:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B017B212FE;
        Tue, 11 Jan 2022 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641916905;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXKYs4ra3NRvTaNlfbEt3oNWU5VgasAIPHciq0jSQjw=;
        b=uQETi83jsJukmfOl0B4ZiAncPHQ1WVUEo8deK8wn+udAyknwR6i/kpABSV4FHelh49a0xG
        +7DSJ+JoX8mQpEzhjZQ1rIPrM3CrnjNhHiWqFinKPWl3FP0AUOpGzY1FE3zINg6FVY/Zk7
        emPN6yijySGy2J4kW7/7h9QMgH+cuFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641916905;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXKYs4ra3NRvTaNlfbEt3oNWU5VgasAIPHciq0jSQjw=;
        b=bHHGH4PL23017vWemiDoB/twNzesY0v5matHF/Ttf8r0g/OIXB30zk8vIP9sYge9cYtoGQ
        KQH/KBBLGl/dHFCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A9A66A3B8A;
        Tue, 11 Jan 2022 16:01:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8534CDA7A9; Tue, 11 Jan 2022 17:01:12 +0100 (CET)
Date:   Tue, 11 Jan 2022 17:01:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Case for "datacow-forced" option
Message-ID: <20220111160112.GP14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <42e747ca-faf1-ed7c-9823-4ab333c07104@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e747ca-faf1-ed7c-9823-4ab333c07104@georgianit.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 08:30:46PM -0500, Remi Gauvin wrote:
> I notice some software is silently creating files with +C attribute
> without user input.  (Systemd journals, libvert qcow files, etc.)... I
> can appreciate the goal of a performance boost, but I can only see this
> as disaster for users of btrfs RAID, which will lead to inconsistent
> mirrors on unclean shutdown, (and no way to fix, other than full balance.)
> 
> I think a datacow-forced option would be a good idea to prevent
> accidental creation of critical files with nocow attribute.

Settings like that start some kind of "policy wars" and list of
exceptions, ie. who decides what the filesystem is allowed to do. A
mount option like you suggest would never allow to create a nocow file,
but having some scratch nocow files with better performance would be
nice to have. A global forced option would prevent accidental nocow
files while you as user would consider them important.

I'd rather see that fixed or made configurable on the side of
applications, the filesystem is really just providing features and
options and limits the policies and forced options to the users.

IIRC the systemd journals got +C because the write pattern is 'append'
that over time creates highly fragmented files. For VM images it's a
performance optimization at the cost of no checksums. Both performance
vs reliability trade off, that somebody made on behalf of users. But not
to satisfaction to all, wich I understand but don't agree that the
filesystem should be the level where this gets resolved.

If fragmentation is problem, eventual runs of the defrag ioctl on the
files can make the problem bearable.
