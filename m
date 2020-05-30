Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFA1E90EA
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgE3Loi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 30 May 2020 07:44:38 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47662 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE3Loh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 07:44:37 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 22BEB6EAAF1; Sat, 30 May 2020 07:44:32 -0400 (EDT)
Date:   Sat, 30 May 2020 07:44:31 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20200530114431.GG10769@hungrycats.org>
References: <20200528183451.16654-1-kreijack@libero.it>
 <8f85f920-b0d0-3c11-3fd2-2f831efb37f4@knorrie.org>
 <f1982b10-2b02-5a6c-a613-c961de4fa6db@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f1982b10-2b02-5a6c-a613-c961de4fa6db@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 29, 2020 at 06:37:27PM +0200, Goffredo Baroncelli wrote:
> On 5/28/20 11:59 PM, Hans van Kranenburg wrote:
> > Hi!
> > 
> > On 5/28/20 8:34 PM, Goffredo Baroncelli wrote:
[...]
> > > The patches set is composed by four patches:
> > > 
> > > - The first patch adds the ioctl to update the btrfs_dev_item.type field.
> > > The ioctl is generic to handle more fields, however now only the "type"
> > > field is supported.
> > 
> > What are your thoughts about the chicken/egg situation of changing these
> > properties only when the filesystem is mounted?
> 
> The logic is related only to a chunk allocation. I.e. if you have a not
> empty filesystem, after enabling the preferred_metadata "mode", in order
> to get the benefit a full balance is required.

Ideally this feature comes with a balance filter that selects block
groups that don't match the current preferred allocation policy, so
you can do a balance on those block groups and leave the rest alone.
There are existing balance filters by devid and stripe count to work from,
so it shouldn't be a lot of new kernel code.
