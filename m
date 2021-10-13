Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A6242BD3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhJMKlt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 06:41:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60804 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhJMKlk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 06:41:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DDD182233F;
        Wed, 13 Oct 2021 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634121575;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMfmUnnDiiRwUPC72IhH/LGZs1UnwQrGiJea/NvMqbY=;
        b=rbxbextxEZXqNZ8os3PycUyRXczLgzg3KXPGwCGcZN/DJGBC3+84uCmnwPVZaR//hd79ha
        Nn21kbyPXDO4AK2U8V+x3oGoyjPKE7us3FvH7AnXBijfU/6sEJIN7d4qr9SDcqF+evuM1y
        gQqyUT0ar+CsoTumIyLLn/zbv9v38Do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634121575;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMfmUnnDiiRwUPC72IhH/LGZs1UnwQrGiJea/NvMqbY=;
        b=isD1+BpctGGzJoGKi7OOXSXZHsF6ZGsUxyVntD1t46rxYPy+C5WNcELOghgcPySIB75KRR
        fwGt0mAdwZ/mYoBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D6658A3B81;
        Wed, 13 Oct 2021 10:39:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD597DA7A3; Wed, 13 Oct 2021 12:39:11 +0200 (CEST)
Date:   Wed, 13 Oct 2021 12:39:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
Message-ID: <20211013103911.GD9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
 <b331b0a3-8119-d66e-c49e-742262ad4a9f@suse.com>
 <504c9584-e760-54a4-7ae4-1c4f26ec5323@suse.com>
 <32c39029-8434-e3f9-0d72-740fe6f44bff@gmx.com>
 <a643cdea-5130-c44e-ce4f-dc8fa23e7481@suse.com>
 <0fbd2076-2b6c-4531-01ea-84db37abf621@gmx.com>
 <1dea2507-5dfb-75ca-7bcb-f1114f5929b6@suse.com>
 <7aad61f4-1b47-eef7-82c3-52ed3ff5dc48@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aad61f4-1b47-eef7-82c3-52ed3ff5dc48@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 07:53:48AM +0800, Qu Wenruo wrote:
> >> See, if we hit SINGLE profile, we won't populate @profile array.
> > 
> > Fair enough, I had misread the != 0 check ... However, I'm wondering,
> > since this is only used during output, why don't we, for the sake of
> > consistency, output SINGLE, despite not having an exclusive bit for it?
> > The point of the human readable output is to be useful for users, so
> > instead of me having to know an implementation detail that SINGLE is not
> > represented by any bit, it will be much more useful if I see that
> > something is single profile, no ?
> 
> On the other hand, this breaks the consistency of flags output.
> 
> We only output flags we have on-disk.
> 
> Showing another flag which doesn't have on-disk bit can also be 
> confusing, and break the existing output format.

Agreed, the dump utility should print only what is on-disk.
