Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D815DC461
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409989AbfJRMHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 08:07:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:41914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409959AbfJRMHc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 08:07:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5677AB4D0;
        Fri, 18 Oct 2019 12:07:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C92EFDA785; Fri, 18 Oct 2019 14:07:45 +0200 (CEST)
Date:   Fri, 18 Oct 2019 14:07:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Merlin =?iso-8859-1?Q?B=FCge?= <merlin.buege@tuhh.de>
Cc:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: small fixes/cleanup in Documentation
Message-ID: <20191018120745.GB3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Merlin =?iso-8859-1?Q?B=FCge?= <merlin.buege@tuhh.de>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20191017045006.130378-1-merlin.buege@tuhh.de>
 <1201273d-8051-b65a-51bc-6e4c12cff7f2@suse.com>
 <20191017111805.GE2751@twin.jikos.cz>
 <20191017164731.48111095.merlin.buege@tuhh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017164731.48111095.merlin.buege@tuhh.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 17, 2019 at 04:47:31PM +0200, Merlin Büge wrote:
> On Thu, 17 Oct 2019 13:18:05 +0200
> David Sterba <dsterba@suse.cz> wrote:
> 
> > Well, for documentation patches and for progs it's not that strict and
> > I've applied many drive-by patches. My sign-off will be there and the
> > original author is usually mentioned as Author:, so the credit is
> > recorded.
> 
> I'm fine with that.
> 
> Sorry, I'm not yet really familiar with the email driven patch workflow
> (actually it's my first patch via email). I will include a SOB line
> next time. If I should resend this patch with one, please tell me!

No need to resend, getting documentation updates should not pose any
barrier as they can be sent by anyone who found something to fix and
insisting on the formalities (that are otherwise a good thing for code)
would probably discourage people.

> Q: How would I go about updating the patch? Just completely resend it
> to the mailing list from scratch so a new thread gets created, or
> replying to the existing one?

Replying to the same would be better in this case. If you don't have
more updates to the docs resending is not necessary, unless you want to
exercise sending patches by mail.
