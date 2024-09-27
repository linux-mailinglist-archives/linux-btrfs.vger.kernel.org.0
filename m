Return-Path: <linux-btrfs+bounces-8306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C398890B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395C9281AA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7A1BBBE3;
	Fri, 27 Sep 2024 16:28:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FD23B0
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454491; cv=none; b=J4eiPwCZFOTeYR87Vx7juzNxmzpk11FcbIDnsvpj9/yJoUoBqv8GM8fUYeAczH2FFVWZNDe37H1TIwXs3EFoKqQeSnizsPck4eLJsT44faS8chc7jgHEgGp+O6Wz6ZQtkozOncL2YWdHwn9JNsMTmwfd8jLrwW4Zsna3TWB5BhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454491; c=relaxed/simple;
	bh=hHvOjpcyq5PoaAwQRHi81IXQXwqfLH7lqJkxmlfM/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REUiRYoNoXr0RMZOeM60rr2w/poG4jhcAAdEf0eddTY5awzMhWtG9KxnRhobm8w3HWnHiVmJ5g27NH2M/AGQlJT96lSe+BBd3uwYAHKcFUUxDGXD80W2czB0FFShnhyzSmawvbQi5M9J+SUieQIt4cuxOhU7md23waNkmK9F64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id D322D3F8C8;
	Fri, 27 Sep 2024 16:27:56 +0000 (UTC)
Date: Fri, 27 Sep 2024 21:27:55 +0500
From: Roman Mamedov <rm@romanrm.net>
To: waxhead <waxhead@dirtcellar.net>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS list of grievances
Message-ID: <20240927212755.5b24ecd4@nvm>
In-Reply-To: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 13:20:14 +0200
waxhead <waxhead@dirtcellar.net> wrote:

> 1. FS MANAGEMENT
> ================
> BTRFS is rather simple to manage. We can add/remove devices on the fly, 
> balance the filesystem, scrub, defrag, select compression algorithms 
> etc. Some of these things are done as mount options, some as properties 
> and some by issuing a command that process something.

I will add my annoyance or rather a showstopper.

Consider a RAID1 of two 20TB disks. One disk disconnects and the system
operates on just the remaining one for a few days.

Side note: will Btrfs even agree to operate in such state without constant
stream of errors to dmesg?

Then the disk is reconnected to the system.

For a start, are we even able to cleanly forget an abruptly disappeared drive
in RAID1, and then re-add it back when the same disk it reappears (under a
different /dev/sdX location)? Without remounting and reboot?

Secondly, it feels like you'll be extremely lucky not to die a fiery death of
"parent transid mismatch errors" right away with Btrfs, after this.

Or if not, then how do you get from there to a consistent state? Run a scrub,
make the system reread the entire 40 TB of data, correcting errors and lack of
duplication where necessary.

Meanwhile, mdadm RAID1: thanks to the Write-intent bitmap, after a re-add the
RAID resyncs just the small changed areas from the continuously running disk
to the temporarily-absent one, and the array consistency is almost instantly
restored, in many cases just with a few GBs read and written.

Or maybe I underestimate the current Btrfs capabilities here?

-- 
With respect,
Roman

