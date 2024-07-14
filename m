Return-Path: <linux-btrfs+bounces-6444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42066930B70
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA57328157E
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48113D28F;
	Sun, 14 Jul 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mMXjyqOp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97813B586
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720987242; cv=none; b=BgaSzbcfE8G07uB0XocmXRBaZenxjMsFSc84OGwDpeIUBgObod2iRuTNdkphSHvFcJqwD0QCtNH6o29IkDcW+NDt9lXR7ct7fIWcwSelSriRmhoYZCiYz2ZK6T+K8IlxQ2113EI/piPe7s5e7yG0Uis1WMLnSN3sTPCeZfq8c0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720987242; c=relaxed/simple;
	bh=kodX9gLNjcHwzSpbqgwjBjFe3DlpgrS/xs6zr9tENB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6vDawtBuuea5UnYhPsOFk3P3xzrwwFIOhfI0POpo+J4upAd4nN6oub+uYG/YMdgWgd7YdXwtupNLDSsGxxchsYVivMoj8vP+frqA40NMVrPaZT1XH6mo3qd5pWgiMjivcHYjnS/f5dAYGJ3dKd2U6mJ+ojqOo0eL8BTvr/KRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mMXjyqOp; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+d79987254280f6484dd2@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720987238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DE9/KmBPldiR5jPtC/hC52/zoM7GOm6shUj7s52U40I=;
	b=mMXjyqOpZ8plRPurgiIGeFYjHpfGtVqSfcDbkAWuUxnKOxOg0yZRsWAq65uE5DUW9Nf2zB
	54m0ehgibsPBIlt1i1z+9Q8y3P9Ofa2kGV+f10wEKmreEx/rYbfF1/r6odNxSQxN8PpQNs
	xhLemFQZC6ePJ2rKHCvNhs6P0nhlGOg=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: clm@fb.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Sun, 14 Jul 2024 16:00:34 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+d79987254280f6484dd2@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (5)
Message-ID: <2fx4cek7oejg72jbsd77fl7bzibd4of7zgzvucpufqac3chmhv@ag6fl2kk2md2>
References: <000000000000d4795d061d36d825@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d4795d061d36d825@google.com>
X-Migadu-Flow: FLOW_OUT

The issue here is that bcachefs can lock many more btree nodes 
simultaneously, more than lockdep can track. The fix is to switch to a
single lockdep map in the btree_trans for "we have any btree nodes
lock"; it's going in this merge window.

#syz fix: bcachefs: Add lockdep support for btree node locks

