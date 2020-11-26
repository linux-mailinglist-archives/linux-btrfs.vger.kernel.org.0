Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3D72C57E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390224AbgKZPKp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 26 Nov 2020 10:10:45 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41578 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbgKZPKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 10:10:45 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1AA458C7FC9; Thu, 26 Nov 2020 10:10:44 -0500 (EST)
Date:   Thu, 26 Nov 2020 10:10:43 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Snapshots, Dirty Data, and Power Failure
Message-ID: <20201126151043.GD28049@hungrycats.org>
References: <b58c6024-1692-7e43-c0a5-182b1fae1cca@panasas.com>
 <20201125042449.GE31381@hungrycats.org>
 <60820e39-5277-7d16-f3c2-bca7c3b44990@panasas.com>
 <5c7e5a89-08c2-bf61-9adc-0f4d4695bd4b@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <5c7e5a89-08c2-bf61-9adc-0f4d4695bd4b@panasas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 26, 2020 at 09:15:34AM -0500, Ellis H. Wilson III wrote:
> On 11/25/20 10:16 AM, Ellis H. Wilson III wrote:
> > On 11/24/20 11:24 PM, Zygo Blaxell wrote:
> > > On Tue, Nov 24, 2020 at 11:03:15AM -0500, Ellis H. Wilson III wrote:
> > > > 1. Is my presumption just incorrect and there is some other
> > > > time-consuming
> > > > mechanics taking place during a snapshot that would cause these
> > > > longer times
> > > > for it to return successfully?
> > > 
> > > As far as I can tell, the upper limit of snapshot creation time is
> > > bounded
> > > only the size of the filesystem divided by the average write speed, i.e.
> > > it's possible to keep 'btrfs sub snapshot' running for as long as it
> > > takes
> > > to fill the disk.
> > 
> > Ahhh.  That is extremely enlightening, and exactly what we're seeing.  I
> > presumed there was some form of quiescence when a snapshot was taken
> > such that writes that were inbound would block until it was complete,
> > but I couldn't reason about why it was taking SO long to get everything
> > flushed out.  This exactly explains it as we only block out incoming
> > writes to the subvolume being snapshotted -- not other volumes.
> 
> One other potentially related question:
> 
> How does snapshot removal impact snapshot time?  If I issue a non-commit
> snapshot deletion (which AFAIK proceeds in the background), and then a few
> seconds later I take a snapshot of that same subvolume, should I expect to
> have to wait for the snapshot removal to be processed prior to the snapshot
> I just took from completing?

Snapshot deletion is a fast, unthrottled delayed ref generator, so it
will have a significant impact on latency and performance over the entire
filesystem while it runs (and even some time after).  Snapshot delete is
permitted to continue to create new delayed ref updates while transaction
commit is trying to flush them to disk, so the situation is similar to
the writer case--transaction commit can be indefinitely postponed as long
as there is free disk space and deleted subvol data available to remove.

> Best,
> 
> ellis
> 
