Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120CD40693E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhIJJq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 05:46:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41460 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhIJJq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 05:46:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 957F01FE46;
        Fri, 10 Sep 2021 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631267116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MquZt6ELMXPKDoSiQKnUMxDfRkNGYPbVT9fjQTmEtCw=;
        b=Y/sqw7X4mq8+KU3M4z1y5mykkYOeRzDSD4iHReajmWEUVGwc1gG2alw0XqAaLOKerLZMRa
        C01RcgppFoyZCoHr6mVF+9ibDPxtnuGn/bJL6O9FV5XFeftV4ePsEa2x2MiJDy3nVLYJO3
        2FAuu31mVRFEFuHYCSINQF9VN86htUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631267116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MquZt6ELMXPKDoSiQKnUMxDfRkNGYPbVT9fjQTmEtCw=;
        b=YS+KHDhD8d7TsyDlcxEuKJc4l3k+RWk9YEH18vFF6T+T5Cm1U1cvzLAAr2y6pAAxBbzR6Y
        46KuXmTvEcoYRcDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8E5BCA3B8A;
        Fri, 10 Sep 2021 09:45:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03098DA7A9; Fri, 10 Sep 2021 11:45:10 +0200 (CEST)
Date:   Fri, 10 Sep 2021 11:45:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: doc: add extra note on flipping
 read-only on received subvolumes
Message-ID: <20210910094510.GB15306@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-3-wqu@suse.com>
 <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 10, 2021 at 09:33:41AM +0300, Nikolay Borisov wrote:
> 
> 
> On 10.09.21 г. 9:03, Qu Wenruo wrote:
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  Documentation/btrfs-property.asciidoc | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs-property.asciidoc
> > index 4796083378e4..8949ea22edae 100644
> > --- a/Documentation/btrfs-property.asciidoc
> > +++ b/Documentation/btrfs-property.asciidoc
> > @@ -42,6 +42,12 @@ the following:
> >  
> >  ro::::
> >  read-only flag of subvolume: true or false
> > ++
> > +NOTE: For recevied subvolumes, flipping from read-only to read-write will
> > +either remove the recevied UUID and prevent future incremental receive
> > +(on newer kernels), or cause future data corruption and recevie failure
> > +(on older kernels).
> 
> Hang on a minute, flipping RO->RW won't cause corruption by itself. So
> flipping will just break incremental sends which is completely fine.

I'm still not decided if it's 'completely fine' to break incremental
send so easily.
