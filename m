Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAFA330B13
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 11:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCHK2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 05:28:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:53296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhCHK2O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 05:28:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC28AACBF;
        Mon,  8 Mar 2021 10:28:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 157CDDA81B; Mon,  8 Mar 2021 11:26:16 +0100 (CET)
Date:   Mon, 8 Mar 2021 11:26:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.11
Message-ID: <20210308102615.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210305133605.13263-1-dsterba@suse.com>
 <YEVeDaWCZR41n4Kg@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEVeDaWCZR41n4Kg@angband.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 08, 2021 at 12:13:17AM +0100, Adam Borowski wrote:
> On Fri, Mar 05, 2021 at 02:36:05PM +0100, David Sterba wrote:
> > btrfs-progs version 5.11 have been released.
> 
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-7-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-7-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-8-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-8-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-Leap-15.2-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-Leap-15.2-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-tumbleweed-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
> W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-tumbleweed-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run
> 
> Somehow, I can't find /home/dsterba/ on my machine :þ

Eh, fixed in devel, thanks. But it worked for me :)
