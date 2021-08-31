Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2153FCAFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbhHaPmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 11:42:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42322 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhHaPmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 11:42:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1A62420195;
        Tue, 31 Aug 2021 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630424465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6CJdmoWP/OeBDKoceutwP0hjxdV/4HZQNQZSZKMsdk=;
        b=j7/uw5xFKRsEtFw5rMF/QY7vw47wGO2DVzklyQUagPFt7GlN3ysK6oT9OIMV+NwqJ3dmoi
        IbvsE6GSqHkusp801sk74o3tGz1COXsrJMcDDDufBerqS1iNkEy/Dbfzz8G9pilyfHfydf
        Y8zjrSC/3jN2p9waCOOL3hq/qZEjkMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630424465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6CJdmoWP/OeBDKoceutwP0hjxdV/4HZQNQZSZKMsdk=;
        b=ZTCajHAvOQI5ovSuxXpTLYliLYYwIcKb+iVK+Bx6PR3fEfoRFCyVu2ViN+ZYAhtZng03zI
        5unWnep9wqQHXEDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1250CA3B93;
        Tue, 31 Aug 2021 15:41:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E492DDA8C1; Tue, 31 Aug 2021 17:41:04 +0200 (CEST)
Date:   Tue, 31 Aug 2021 17:41:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V5 0/4] btrf_show_devname related fixes
Message-ID: <20210831154104.GL3379@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <cover.1629780501.git.anand.jain@oracle.com>
 <34118c32-0d7f-426b-7596-4372315599ea@oracle.com>
 <1r69r830.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1r69r830.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 10:28:24PM +0800, Su Yue wrote:
> 
> On Tue 31 Aug 2021 at 06:41, Anand Jain <anand.jain@oracle.com> 
> wrote:
> 
> > Ping.
> >
> In the past week, I spent some time on testing this patchset and
> the patch 'btrfs: fix lockdep warning while mounting sprout fs'.
> 
> Same as you, I wonder if there is any race condition. Just wrote
> some scripts including device removal, replace and sprout while
> busy looping showing mount info. It runned well and passed 
> xfstests
> in my two VMs. I'm not a pundit in btrfs device field so I can't 
> give my
> RBs even these patches looks almost okay to me.

So this could be a Tested-by if you want.
