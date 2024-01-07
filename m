Return-Path: <linux-btrfs+bounces-1291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392D826422
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5FDB212D3
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C0134AD;
	Sun,  7 Jan 2024 13:04:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from savella.carfax.org.uk (savella.carfax.org.uk [85.119.84.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA280134A4
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carfax.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savella.carfax.org.uk
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
	(envelope-from <hrm@savella.carfax.org.uk>)
	id 1rMSPS-0006iW-4o; Sun, 07 Jan 2024 12:37:46 +0000
Date: Sun, 7 Jan 2024 12:37:46 +0000
From: Hugo Mills <hugo@carfax.org.uk>
To: Clemens Eisserer <linuxhippy@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
Message-ID: <20240107123746.GF28171@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
	Clemens Eisserer <linuxhippy@gmail.com>,
	linux-btrfs@vger.kernel.org
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jan 07, 2024 at 08:06:36AM +0100, Clemens Eisserer wrote:
> Hi,
> 
> I would like to use send/receive to keep two root-filesystems in sync,
> as I've been using it for years now for backups where it really does
> wonders (thanks a lot!).

   I'm afraid that btrfs incremental send/receive is *only* designed
for one way backups, as you've been using it up to now. It will not
work for bidirectional syncing, and no amount of gymnastics will make
it work. If you want to do bidirectional sync, you'll need to use some
other tool like rsync.

   Hugo.

-- 
Hugo Mills             | Anyone using a computer to generate random numbers
hugo@... carfax.org.uk | is, of course, in a state of sin.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                       Jon von Neumann

