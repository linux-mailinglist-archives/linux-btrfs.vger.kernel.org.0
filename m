Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD763F964D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbhH0IjL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 04:39:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55912 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbhH0IjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 04:39:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C985B222F2;
        Fri, 27 Aug 2021 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630053501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEYeL90TCgWNrRGsVstXc9UFCgdfXpQjj8uuqbQ0gow=;
        b=TYklgOoe5tNWWQp1pn4FptIUPYbnilNMAQpGwOzKFR+BPLjMj1jvf9g+kM9eYdR+XWU2RJ
        /P749bi8eYAkWphjTzn55dO2tFfn6wf67K7GE9wjXtrwbut4uw8/BIA9Fb0mCTB0wN0R18
        L2lf7KOaqzUrMNXB9uMNUh+87JqnJvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630053501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEYeL90TCgWNrRGsVstXc9UFCgdfXpQjj8uuqbQ0gow=;
        b=NlxXMSIqoL1TKmG1HYGDrLbRZ/dWPZGHgzB+JanKD4ytIINFxXI7NGPbxvzAQOUNYwXm42
        Ik6SH5WPemP0NCDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BFE26A3B94;
        Fri, 27 Aug 2021 08:38:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0CCE5DA7F3; Fri, 27 Aug 2021 10:35:32 +0200 (CEST)
Date:   Fri, 27 Aug 2021 10:35:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we
 don't have enough pages"
Message-ID: <20210827083532.GS3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210825054142.11579-1-wqu@suse.com>
 <20210827114153.19CB.409509F4@e16-tech.com>
 <025d8f85-a86c-63be-14be-a3f1e2170107@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <025d8f85-a86c-63be-14be-a3f1e2170107@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 27, 2021 at 01:04:56PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/27 上午11:41, Wang Yugui wrote:
> > Hi,
> >
> > With this patch, kernel panic when xfstest btrfs/244
> 
> It's completely unrelated.
> 
> The fix for btrfs/244 is beadb3347de2 ("btrfs: fix NULL pointer
> dereference when deleting device by invalid id").

The commit has been tagged for 5.4 but I don't see it in the stable
repo, there are no conflicts when applying. I don't know why,
nevertheless I can ask for merging it again.
