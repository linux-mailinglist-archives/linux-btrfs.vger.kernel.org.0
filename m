Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110FB4A735C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 15:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbiBBOk1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 09:40:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiBBOk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 09:40:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CFA0521116;
        Wed,  2 Feb 2022 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643812825;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8sj2toJT7R1dFrkQNmLzXKcA3ifLcMtsBfxaEpEV+U=;
        b=MtYCWEQqPzORxibnM46FkNWnm4otWIZQqHLdfM9ftLP3Naqm0FFJ9dE5CJS7t+uk8s6HGs
        DeRIckRtZLUUQCOdm51HUMWIt44acZYSlaY47u0RBrmt2DM1LHsnJBmoATncxftenY98sH
        GiReg0phippLYFY+Ta1poJyStZtClgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643812825;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8sj2toJT7R1dFrkQNmLzXKcA3ifLcMtsBfxaEpEV+U=;
        b=luE+ZmPz/XK6k1NVkJmJEL7SfaPPN8fJrj8kecT+crG4nfosjhjqfvCQYdIVa0mEsdfzZe
        /lidhLXLYaQJVLDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B7ADFA3B84;
        Wed,  2 Feb 2022 14:40:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C23FDA781; Wed,  2 Feb 2022 15:39:41 +0100 (CET)
Date:   Wed, 2 Feb 2022 15:39:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't hold CPU for too long when defragging a file
Message-ID: <20220202143940.GZ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c572e24e1556b87cadb20761edbc7e33bb93ad20.1643547144.git.wqu@suse.com>
 <20220201145304.GP14046@twin.jikos.cz>
 <7076a72f-62d8-0f4a-6a2c-3885b62c76c4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7076a72f-62d8-0f4a-6a2c-3885b62c76c4@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 02, 2022 at 08:00:45AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/1 22:53, David Sterba wrote:
> > On Sun, Jan 30, 2022 at 08:53:15PM +0800, Qu Wenruo wrote:
> >> There is a user report about "btrfs filesystem defrag" causing 120s
> >> timeout problem.
> >
> > Do you have link of the report please?
> 
> Here it is, not really a formal one, but just mentjioned in a thread:
> 
> https://lore.kernel.org/linux-btrfs/10e51417-2203-f0a4-2021-86c8511cc367@gmx.com/

Thanks, that's much better than a vague "there's a report".
