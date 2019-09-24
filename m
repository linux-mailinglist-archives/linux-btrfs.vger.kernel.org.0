Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67F9BD0D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395332AbfIXRng (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 13:43:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:33018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732249AbfIXRnf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 13:43:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F376B048;
        Tue, 24 Sep 2019 17:43:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E29ADA835; Tue, 24 Sep 2019 19:43:54 +0200 (CEST)
Date:   Tue, 24 Sep 2019 19:43:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     James Harvey <jamespharvey20@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for...
 (forever)
Message-ID: <20190924174354.GD2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        James Harvey <jamespharvey20@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
 <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 10:58:08AM +0100, Filipe Manana wrote:
> However that's a large patch set which depends on a lot of previous
> cleanups, some of which landed in the 5.3 merge window,
> Backporting all those patches is against the backport policies for
> stable release [1], since many of the dependencies are cleanup patches
> and many are large (well over the 100 lines limit).
> 
> On the other it's not possible to send a fix for stable releases that
> doesn't land on Linus' tree first, as there's nothing to fix on the
> current merge window (5.4) since that deadlock can't happen there.

In exceptional cases it's possible to send a stable-specific backport
that's supposedly equivalent to the code that's in Linus' tree. As
you'd analyzed it and concluded that it's not necessary, we don't need
to play that card now.
