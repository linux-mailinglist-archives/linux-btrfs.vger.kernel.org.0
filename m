Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B95218E96
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgGHRoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 13:44:11 -0400
Received: from rin.romanrm.net ([51.158.148.128]:57480 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbgGHRoK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:10 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 18970463;
        Wed,  8 Jul 2020 17:44:07 +0000 (UTC)
Date:   Wed, 8 Jul 2020 22:44:08 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent
 transid verify failed + open_ctree failed
Message-ID: <20200708224408.6f392c72@natsu>
In-Reply-To: <20200708174110.GU30660@merlins.org>
References: <20200707035530.GP30660@merlins.org>
        <20200708034407.GE10769@hungrycats.org>
        <20200708041041.GN1552@merlins.org>
        <20200708054905.GA8346@hungrycats.org>
        <20200708174110.GU30660@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 8 Jul 2020 10:41:10 -0700
Marc MERLIN <marc@merlins.org> wrote:

> On Wed, Jul 08, 2020 at 01:49:05AM -0400, Zygo Blaxell wrote:
> > > Sorry, PPL?
> > 
> > Partial Parity Log.  It can be enabled by mdadm --grow.  It's a mdadm
> > consistency policy, like the journal, but uses reserved metadata space
> > instead of a separate device.
>  
> looks like it's incompatible with --bitmap which I was already using.
> I'm not sure if --grow was possible to convert from one to another

At least you can definitely remove the bitmap with --bitmap=none in the grow
mode. Then in the second --grow can probably add PPL (unfamiliar with that).

-- 
With respect,
Roman
