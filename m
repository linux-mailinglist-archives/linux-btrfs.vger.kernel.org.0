Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52F03FEF92
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbhIBOjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 10:39:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57540 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbhIBOjQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 10:39:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9C12A1FFA8;
        Thu,  2 Sep 2021 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630593497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KS9fF29jgYpZeGh7okmxONBxc/PWDUAnfublMJojU1U=;
        b=P+J6EJFfHTWtemgQ25hHsQOYwuHkhUfVkRlivG5AS9h+1SEngEa2+J1feNONKeflsbq9r3
        2Q0Tfw0JekAEZRCX9KB6ysu5aj7XS/tugOQYuoI2G3Nyib9paII8dkc67lu+oS170wzPct
        7EYg0tZtpfnYXZ9Nf0m/7cobfMBSZh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630593497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KS9fF29jgYpZeGh7okmxONBxc/PWDUAnfublMJojU1U=;
        b=pk66Yz4TTzrKToFXXds6Sj/gcpftgMrpS1QtdEYED120mg/pUVj0YKJlQfwsRBZmUPUice
        7b5nNyUvukbTg/Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 926FCA3B87;
        Thu,  2 Sep 2021 14:38:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6494ADA72B; Thu,  2 Sep 2021 16:38:16 +0200 (CEST)
Date:   Thu, 2 Sep 2021 16:38:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH V5 4/4] btrfs: fix comment about the btrfs_show_devname
Message-ID: <20210902143816.GV3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629780501.git.anand.jain@oracle.com>
 <c3e2f34f0d328196dd7cd6bdae67a8219cef840c.1629780501.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e2f34f0d328196dd7cd6bdae67a8219cef840c.1629780501.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 01:05:22PM +0800, Anand Jain wrote:
> There were few lock dep warnings because btrfs_show_devname() was using
> device_list_mutex as recorded in the commits
>   ccd05285e7f (btrfs: fix a possible umount deadlock)

Commit ccd05285e7f does not exist in my tree, but the subject matches
0ccd05285e7f. Please format the references like it's done for the Fixes:
tag with HASH ("Subject"). Nobody types that by hand, a simple git alias
does that for free:

.gitconfig:
[alias]
	one = show -s --pretty='format:%h (\"%s\")'
