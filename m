Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C574B710
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 13:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfFSL3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 07:29:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbfFSL3w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 07:29:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3548AD3E;
        Wed, 19 Jun 2019 11:29:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5893EDA88C; Wed, 19 Jun 2019 13:30:38 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:30:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: updating btrfs-debugfs to python3?
Message-ID: <20190619113038.GA8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSE2VbeGFs9o=KhPTeRGwZJ=RA2uzc3xG+sU0X-SXbRuQ@mail.gmail.com>
 <08aa27af-8a9e-cd0c-20ab-55ce630085f4@applied-asynchrony.com>
 <b619d96d-92b1-fad0-4911-a1d8080470fc@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b619d96d-92b1-fad0-4911-a1d8080470fc@knorrie.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 12:21:34PM +0200, Hans van Kranenburg wrote:
> On 6/19/19 12:13 PM, Holger Hoffstätte wrote:
> > On 6/19/19 5:20 AM, Chris Murphy wrote:
> >> This is on Fedora Rawhide (which is planned to become Fedora 31 due in
> >> October), which no longer provides python2.
> >>
> >> $ ./btrfs-debugfs -b /
> >> /usr/bin/env: ‘python2’: No such file or directory
> >> $
> >>
> >> I expect other distros are going to follow as Python 2.7 EOL is coming
> >> up fast, in 6 months.
> >> https://pythonclock.org/
> > 
> > I just ran it through 2to3-3.7 with -w and the new version seems to work
> > just fine for me, so it seems there is not much porting required.
> 
> I don't think you want to ship that program at all, for end users.

Agreed, it was probably just some helper script for developers but it
never got enough features to be useful.

> It's
> quite horrible, and the -b option even downloads the *entire* extent
> tree to userspace in a very naive way.
> 
> There are way simpler, better performing alternatives...

There are, so let's use them!
