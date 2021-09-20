Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F067341138E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbhITLcU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:32:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53052 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhITLcU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:32:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D9EF2200C6;
        Mon, 20 Sep 2021 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632137452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikQkQp3ad7eFGhr1aY74rJcYNY6eXXuClwqPBLhBPEs=;
        b=Lbphmcnf908j0HahBnTr2ksS/kugba9FLTH4LAV1bGyFlHHRwG8YVKwYZxbBm2LeoKjCt0
        laPsWfpbtPHON3qJoX5mzNOJ/b4hPfhPkjSS3tO0jKwuB4z+gV0aH2MlQqcDKf0AZjygW0
        FOwv+VuzmQGr8CPJhfhaay48qP0MbO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632137452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikQkQp3ad7eFGhr1aY74rJcYNY6eXXuClwqPBLhBPEs=;
        b=SuRGqbR0pNgA1Xh9fPfRTARcUjrAd1tQsp/2i69HIOYUH8SeniuxXvm1jr4hy98jMI/hVS
        6zOZxc9CK6+EXmDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CFC3CA3B87;
        Mon, 20 Sep 2021 11:30:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89071DA7FB; Mon, 20 Sep 2021 13:30:41 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:30:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Select DUP metadata by default on single devices.
Message-ID: <20210920113041.GF9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
 <20210920090914.GB9286@twin.jikos.cz>
 <e28ecf10-99c3-ce99-f3c1-218175646c2d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28ecf10-99c3-ce99-f3c1-218175646c2d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 06:46:31PM +0800, Qu Wenruo wrote:
> > - no-holes on
> >
> > I'd vote for one version doing the whole switch rather than doing the
> > changes by one.
> 
> On no-holes I'd prefer more feedback from Filipe as he has exposed some
> no-holes related problem some time ago.

Tracked as

https://github.com/kdave/btrfs-progs/issues/405
