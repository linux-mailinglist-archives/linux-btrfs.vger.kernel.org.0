Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23C19A198
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 00:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgCaWFk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 31 Mar 2020 18:05:40 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46600 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgCaWFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 18:05:39 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 637FF644EC1; Tue, 31 Mar 2020 18:05:38 -0400 (EDT)
Date:   Tue, 31 Mar 2020 18:05:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: add warning for mixed profiles filesystem
Message-ID: <20200331220534.GI2693@hungrycats.org>
References: <20200331191045.8991-1-kreijack@libero.it>
 <97ec9f13-8d8d-1df9-f725-44a2a0ecc438@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <97ec9f13-8d8d-1df9-f725-44a2a0ecc438@cobb.uk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 31, 2020 at 10:46:17PM +0100, Graham Cobb wrote:
> On 31/03/2020 20:10, Goffredo Baroncelli wrote:
> > WARNING: ------------------------------------------------------
> > WARNING: Detection of multiple profiles for a block group type:
> > WARNING:
> > WARNING: * DATA ->          [raid1c3, single]
> > WARNING: * METADATA ->      [raid1, single]
> > WARNING:
> > WARNING: Please consider using 'btrfs balance ...' commands set
> > WARNING: to solve this issue.
> > WARNING: ------------------------------------------------------
> 
> The check is a good a idea but I think the warning is too strong. I
> would prefer that the word "Warning" is reserved for cases and
> operations that may actually damage data (such as reformating a
> filesystem). [Note: in a previous job, my employer decided that the word
> Warning was ONLY to be used if there was a risk of harm to a human - for
> example, electrical safety]
> 
> Also, btrfs fi usage is something that I routinely run continuously in a
> window (using watch) when a remove/replace/balance operation is in

I was going to say please put all the new output lines at the bottom,
so that 'watch' windows can be minimally sized without having to write
something like

	watch 'btrfs fi usage /foo | sed -e "g/WARNING:/d"'

People with short terminal windows running btrfs fi usage directly from
the command line would probably complain about extra lines at the bottom...

Another good idea here would be a --quiet switch, or
'--no-profile-warning'.

> progress to monitor at a glance what is happening - I don't want to
> waste all that space on the screen. To say nothing of the annoyance of
> having it shouting at me for weeks on end while **I AM TRYING TO FIX THE
> DAMN PROBLEM!**.
> 
> I would suggest a more compact layout and factual tone. Something like:
> 
> Caution: This filesystem has multiple profiles for a block group type
> so new block groups will have unpredictable profiles.
>  * DATA ->          [raid1c3, single]
>  * METADATA ->      [raid1, single]
> Use of 'btrfs balance' is recommended as soon as possible to move all
> blocks to a single profile for each of data and metadata.

How about a one-liner:

	NOTE: Multiple profiles detected.  See 'man btrfs-filesystem'.

with a section in the btrfs-filesystem man page giving a detailed
description of the problem and examples of possible remedies.

