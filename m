Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA61DC1F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 May 2020 00:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgETWPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 18:15:19 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:36330 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 18:15:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id D3A4D2A7C2C9;
        Thu, 21 May 2020 00:15:16 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fn4tyce-d8cf; Thu, 21 May 2020 00:15:14 +0200 (CEST)
Received: from latitude (x4dbe0cc2.dyn.telefonica.de [77.190.12.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Thu, 21 May 2020 00:15:14 +0200 (CEST)
Date:   Thu, 21 May 2020 00:15:08 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Justin Engwer <justin@mautobu.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: I think he's dead, Jim
Message-ID: <20200520221508.GA28789@latitude>
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
 <20200520013255.GD10769@hungrycats.org>
 <20200520205319.GA26435@latitude>
 <CAJCQCtSU9EyFDodLvpYMF+AU=i=-EFZNJw7h4vWL98vEz1jkvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJCQCtSU9EyFDodLvpYMF+AU=i=-EFZNJw7h4vWL98vEz1jkvQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020 Mai 20, Chris Murphy wrote:
> On Wed, May 20, 2020 at 3:02 PM Johannes Hirte
> <johannes.hirte@datenkhaos.de> wrote:
> >
> > On 2020 Mai 19, Zygo Blaxell wrote:
> > >
> > > Corollary:  Never use space_cache=v1 with raid5 or raid6 data.
> > > space_cache=v1 puts some metadata (free space cache) in data block
> > > groups, so it violates the "never use raid5 or raid6 for metadata" rule.
> > > space_cache=v2 eliminates this problem by storing the free space tree
> > > in metadata block groups.
> > >
> >
> > This should not be a real problem, as the space-cache can be discarded
> > and rebuild anytime. Or do I miss something?
> 
> The bitmap locations for the free space cache are referred to in the
> extent tree. It's not as trivial update or drop the v1 space cache as
> it is the v2 which is in its own btree.

I still don't see the problem. Free space cache is needed for
performance, not function. If it's not available, this can be
ignored. 

-- 
Regards,
  Johannes Hirte

