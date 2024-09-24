Return-Path: <linux-btrfs+bounces-8202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D6398499A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666BC1F21B27
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B71AB6F0;
	Tue, 24 Sep 2024 16:28:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563ED531
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195305; cv=none; b=WX/KfxX9EMeAB+T8kx+ZATqxhO1iU3gqULPLynFPs5jqcsQr1COS2Tzy9NNsq/WWZe3DtYFFE1pZZ8Q6oc4fKqgwoJQ2/fU9nZgHl9SLQ2yCsrJPn0bOALaPYjJ9l4OUONYH9zPq+JWPAKFlgQeNTushda/UmGLwy21YgOeC3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195305; c=relaxed/simple;
	bh=PudU6xtUlYYVL7V/4A22ez7pWvrgV5DBkbTs93UaCy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rt31rF5INLEMcwiAF0qnYiDO2TZdzIltkfUYbMu78K2xAhCu/gUk5TYQSzoTRIMOjNLKAeozAObFUwKlfLKHnOdxl/YrfN6c330L2/SF2xcGz0uPYnfyHUt6uo74L0Yrj0OG9U+pLAUtOmiR4b5gMqv9GkcAqgShOkLBW9W2pZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 408C43F330;
	Tue, 24 Sep 2024 16:21:05 +0000 (UTC)
Date: Tue, 24 Sep 2024 21:21:04 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, Fabian Vogt
 <fvogt@suse.com>
Subject: Re: [PATCH 2/2] btrfs: canonicalize the device path before adding
 it
Message-ID: <20240924212104.73963614@nvm>
In-Reply-To: <CAL3q7H7aL-M3dyu7f7w1bBb5zUP00KMp=F-jWV-Q0hZH6LD=yw@mail.gmail.com>
References: <cover.1727154543.git.wqu@suse.com>
	<c6408ea85cd10e4042df528708dd9c2ec1db78c0.1727154543.git.wqu@suse.com>
	<CAL3q7H7aL-M3dyu7f7w1bBb5zUP00KMp=F-jWV-Q0hZH6LD=yw@mail.gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 13:12:09 +0100
Filipe Manana <fdmanana@kernel.org> wrote:

> > +/*
> > + * We can have very wide soft links passed in.
> 
> Wide? Did you mean wild in the sense of unusual?

Samba uses this term to refer to links pointing outside of the particular
network share tree:
https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html#WIDELINKS
https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html#ALLOWINSECUREWIDELINKS

Not sure what is the origin or etymology, guess it may stem from "VFS-wide",
links across the entire pathname space.

-- 
With respect,
Roman

