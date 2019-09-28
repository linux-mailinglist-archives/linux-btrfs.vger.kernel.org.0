Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160D5C10F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2019 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfI1NXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Sep 2019 09:23:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfI1NXY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Sep 2019 09:23:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FC4EAC84;
        Sat, 28 Sep 2019 13:23:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27BCFDA897; Sat, 28 Sep 2019 15:23:41 +0200 (CEST)
Date:   Sat, 28 Sep 2019 15:23:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nicholas D Steeves <nsteeves@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs wiki, add Parrot as production user
Message-ID: <20190928132340.GY2751@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nicholas D Steeves <nsteeves@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRtJ5LjO4vseJCP1zANF7dbjDtcsnoTTNs5YAmHt=NWRw@mail.gmail.com>
 <20190827124611.GG2752@twin.jikos.cz>
 <871rw1du17.fsf@DigitalMercury.dynalias.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rw1du17.fsf@DigitalMercury.dynalias.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 27, 2019 at 10:38:44PM -0400, Nicholas D Steeves wrote:
> Hi David,
> 
> David Sterba <dsterba@suse.cz> writes:
> 
> > On Mon, Aug 26, 2019 at 06:55:47PM -0600, Chris Murphy wrote:
> >> https://blog.parrotlinux.org/parrot-4-4-release-notes/
> >> 
> >> Looks like they switched to Btrfs by default for / and /home.
> >> 
> >> I think they should be listed on
> >> https://btrfs.wiki.kernel.org/index.php/Production_Users
> >
> > Added, thanks for the tip.
> 
> If this is the criteria for Production Users, then NeptuneOS can also be
> added.  This distribution was an early adopter who defaulted to btrfs
> since sometime around 2014, using linux-3.13.11.

Can be added too.

> By the way, would you please document that the Debian kernel team
> backports fixes release-critical (eg: data loss) patches to their stable
> kernel, provides a recent mainline kernel via stable-backports (or
> $codename-backports), and finally also provides recent btrfs-progs via
> that same stable-backports source? (I've been responsible for
> btrfs-progs backports since 2016)

But this is too detailed for an overview page. Each
vendor/distro/company should have some sort of documentation about that
(wiki, product landing page, etc).

> It might also be worth noting that the Debian installer doesn't yet
> support installation to subvolumes, the Ubuntu installer doesn't support
> configuration of subvolumes, and I think neither does Calamares installer
> (@ and @home are hard-coded like in Ubuntu IIRC).

Same.

> Also--to my alarm--the upstream Calamares installer defaults to
> compress=lzo, with no way for the user to opt-out.  IMHO this should be
> documented for the benefit of conservative users who wish to avoid the
> once-a-year newly-found compression bug.

Documented yes (and perhaps reported) but not on the community wiki.
