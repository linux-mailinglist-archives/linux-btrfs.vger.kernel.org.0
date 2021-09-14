Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91C040AEAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhINNOT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 09:14:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49562 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhINNOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 09:14:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 28ED320111;
        Tue, 14 Sep 2021 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631625181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1xCRaXBi8hU9uZsLdOK0OCoJxupLBRsWIjvmEz3tTc=;
        b=izGt9wM7Bf1bewIML68qFihwFBEMj3ZO2k/yAslKRc0sUYHGdU713FRbxK+ZEw5DG/ndSW
        AnyZJ0NhLghM7eHM+a5ioJXnga3Woj5tj0woJ6+5i9Z1sjd8obKGFhnSqutByTE3dho6/8
        xDP7oL+rJhsO+xPnkxFiT0WZKVJyL0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631625181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1xCRaXBi8hU9uZsLdOK0OCoJxupLBRsWIjvmEz3tTc=;
        b=S5mlhBRSoK3HUMAXKsE4AToVnywWrlL5wUd1+Y8JPwMqcvXmWEYi20cfszqhGMia7ux03h
        HF8OBY2Urr2gIbBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1FCABA3B90;
        Tue, 14 Sep 2021 13:13:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39B7FDA781; Tue, 14 Sep 2021 15:12:53 +0200 (CEST)
Date:   Tue, 14 Sep 2021 15:12:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_node_key static inline
Message-ID: <20210914131253.GA9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210914105335.28760-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914105335.28760-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 06:53:35PM +0800, Su Yue wrote:
> It looks strange that btrfs_node_key is in struct-funcs.c.
> So move it to ctree.h and make it static inline.

"looks strange" is not a sufficient reason. Inlining a function means
that the body will be expanded at each call site, bloating the binary
code. Have you measured the impact of that?

There's some performance cost of an non-inline function due to the call
overhead but it does not make sense to inline a function that's called
rarely and not in a tight loop. If you grep for the function you'd see
that it's called eg. once per function or in a loop that's not
performance critical on first sight (eg. in reada_for_search).
