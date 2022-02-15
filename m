Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3717A4B6CC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiBOMzc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 07:55:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbiBOMza (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 07:55:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451804475D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 04:55:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F1AA4210F3;
        Tue, 15 Feb 2022 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644929716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkH/Acw75TTaAPkr8kchxyz5RsXG36QdRIgBSfc4clo=;
        b=Z4/ECp3epEjpO1XP+fIWFtF37cgDF9o9vtnfUhvgCaIy+tmR5REpJ3niDLWh8jOvzJELXX
        rwOb4TOXTT6k3KOaSr9Ea+VD9WpQ49spPKs2b1fXlF+ENkp1kfp3D+DqTf2hBi7zJFJCJk
        q1jE1z1WPJu/x//ezcFfSjM+nozwkks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644929717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkH/Acw75TTaAPkr8kchxyz5RsXG36QdRIgBSfc4clo=;
        b=CGFZNoBHKcJGYh9OAwvbkmtKmRu2rcB9/W7digQZFiJjf7m0iIpRXHs4ZrJ79mV9t35NP+
        oKlE/Z+yZ+QQ22BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E24D3A3B8B;
        Tue, 15 Feb 2022 12:55:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED072DA818; Tue, 15 Feb 2022 13:51:32 +0100 (CET)
Date:   Tue, 15 Feb 2022 13:51:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, lkp@lists.01.org,
        lkp@intel.com, linux-btrfs@vger.kernel.org
Subject: Re: [btrfs] dae7bf275f: last_state.incomplete
Message-ID: <20220215125132.GM12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, lkp@lists.01.org, lkp@intel.com,
        linux-btrfs@vger.kernel.org
References: <20220215072054.GD28159@xsang-OptiPlex-9020>
 <20220215120541.GL12643@twin.jikos.cz>
 <5dc2fd83-5c87-4ec7-2b2a-3eb6a48b7186@gmx.com>
 <37c59b99-bd45-c017-6d2b-ff9b7a7fc1af@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37c59b99-bd45-c017-6d2b-ff9b7a7fc1af@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 15, 2022 at 08:32:20PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/15 20:25, Qu Wenruo wrote:
> >
> >
> > On 2022/2/15 20:05, David Sterba wrote:
> >> On Tue, Feb 15, 2022 at 03:20:54PM +0800, kernel test robot wrote:
> >>> If you fix the issue, kindly add following tag
> >>> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>>
> >>>
> >>> the test's last state 'incomplete' seems be caused by below error
> >>> (detail
> >>> in attached dmesg.xz)
> >>>
> >>> [   49.293458][ T3822] BTRFS info (device sdb3): flagging fs with big
> >>> metadata feature
> >>> [   49.301630][ T3822] BTRFS info (device sdb3): disk space caching
> >>> is enabled
> >>> [   49.309039][ T3822] BTRFS info (device sdb3): has skinny extents
> >>> [   49.320312][ T3822] BTRFS error (device sdb3): invalid number of
> >>> stripes 0 in sys_array at offset 17
> >
> > The offset is just one key, so we're reading the first chunk item in sys
> > chunk array.
> >
> > If you guys can reproduce the situation, please provide the dump of sdb3
> > by:
> >
> > # btrfs ins dump-super -fFa /dev/sdb3
> 
> No need, your fs should be completely sane.
> 
> >
> >
> > A quick glance gives me some concern, as for super block sys chunk
> > array, we're not doing the proper extent buffer thing, but a dummy/fake
> > extent buffer just to get the extent buffer accessors.
> >
> > Thus some get_**bits function may return false 0 and cause the problem.
> >
> > I'll try to reproduce and hopefully fix it.
> 
> It's the condition, completely opposite:
> 
> -       ASSERT(check_setget_bounds(token->eb, ptr, off, size));         \
> +       if (check_setget_bounds(token->eb, ptr, off, size))             \
> +               return 0;
> 
> check_setget_bounds() return true if nothing is wrong.

Right, the condition needs to be flipped.
