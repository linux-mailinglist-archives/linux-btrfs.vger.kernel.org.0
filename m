Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B233BEA42
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhGGPGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 11:06:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58528 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhGGPGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 11:06:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 86A94200A1;
        Wed,  7 Jul 2021 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625670200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/njSWsFKmrr+gCtk5oLKLx0gnGyNTSkRi3qeU7FkYJc=;
        b=P70mfZINIHga/GUSB474MUZ/h3uZi7rozCxArusbasTg4gcWmobEYqPY/sTCUi6mNa9C6M
        ntLaJVEUEtvG2a+WOsc4QvKjikYlix0TusAj5dIxIQDxD6cgxHEuX/pPLRUkgbEEaTTy0Z
        Y5Jho/NqRo2LT7BAe14b97nzMq97Bn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625670200;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/njSWsFKmrr+gCtk5oLKLx0gnGyNTSkRi3qeU7FkYJc=;
        b=yor2vNtUHhEUakJ1XrwjM1hEGtN2wJ+5A3qSKpDiRDplrJKmbqaMvDu4nVVtruXhxKl8P9
        RJF5BX29JgVyqVCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7C8C8A3B8A;
        Wed,  7 Jul 2021 15:03:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6A03DA6FD; Wed,  7 Jul 2021 17:00:46 +0200 (CEST)
Date:   Wed, 7 Jul 2021 17:00:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: change btrfs_io_bio_init inline function to
 macro
Message-ID: <20210707150046.GL2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1625237377.git.anand.jain@oracle.com>
 <0ae479ebdecf5501937b5d93449a782d96864cce.1625237377.git.anand.jain@oracle.com>
 <05870252-7ab1-0306-7360-a6edeed2b168@suse.com>
 <a9f156a1-354b-6555-ba71-da6c92235d09@oracle.com>
 <7ba26789-f98e-adb2-a6d9-7979e519e802@suse.com>
 <PH0PR04MB7416055C3C4AC524B8F5CAC29B1B9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416055C3C4AC524B8F5CAC29B1B9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 06, 2021 at 06:14:38AM +0000, Johannes Thumshirn wrote:
> On 06/07/2021 07:29, Nikolay Borisov wrote:
> >> The gain is macro is guaranteed to be inline-ed. A function with the
> >> inline prefix isn't.
> >>
> > In this particular case it's guaranteed that the function will be inlined.
> > 
> 
> And we also get additional type safety from the function, which the macro
> doesn't provide.

Yeah, using static inlines instead of macros is preferred when they're
reasonably simple, like in this case.
