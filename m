Return-Path: <linux-btrfs+bounces-3374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1387F304
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 23:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782C3B2117B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CD75A4DC;
	Mon, 18 Mar 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2TvRFCde"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF15A4C4;
	Mon, 18 Mar 2024 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800107; cv=none; b=cxR9+zc96uS9SAkW9D2FFz4fuEMrhcsjBJkeQ0cMOd92xdRsQxtyyPKMojI+h8TahT9dmq3q8qqU1J4CzbaPhH+FQ9eIZAeWzD6BV2xchNiewf7AJc4HnsOlzsGcW6oJr+fRghRPbt451Coev5kMdwI0zUKNHfssT3awMIBU2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800107; c=relaxed/simple;
	bh=bI2NtKh+J6UzI0Xp/b74zkVmqiR/siFKLRM0VOefhAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSU0zgODYFIxc2FIdbR+Pvay7iAQDAv5mm7siJgtfOP7Xbcep3w+9UUnREX0Dy8exw2aPV6119myrLdMAvBxbBJNRQ8YJ3P/sYE+l4HWHXTMGLm7kanTZkkEBCZpPMvS3v3zKlLULcpeIu951/1WuQlKxTg+iiUYfhTi2p5GMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2TvRFCde; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NH4JLc+bKP90Ou5f5S5hjIGAvDOHDUHp//01GKRBB8U=; b=2TvRFCde9PfkYoepee3ewlVaM/
	aW4NtRlWMDNouyxaxxgJpy71+6wQY+9JeaDpjEMUCcc+yBIsCblTsmAE2zng6mX4G1dH/hd3sZfzr
	usIyxKSN9fgrNzLrxPTgb4FT4Kl6gILGrW6e3+qBEG3XmPX9UQyeG9hVDzYNqCm4tncUvDzgZxokq
	C1lZEJVMiWXzj1n7Cdr/0v6G8Ipa2eUU2yKfnwsuf0mJrLiTFd8P7oP+0jWlcJfo9jxeAKVzt0xbU
	and6QVrYLDDUi/ogVK5ooTnkT56CkqFQMtrXEpxM0Ym+zG6l7tBKUec6BIQN7zN1jvbhz1lBLaBZ3
	S9HtZYpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmLG4-0000000ALPM-04GT;
	Mon, 18 Mar 2024 22:15:04 +0000
Date: Mon, 18 Mar 2024 15:15:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <Zfi854MLq_8yhWl7@infradead.org>
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318220219.GI16737@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 18, 2024 at 11:02:19PM +0100, David Sterba wrote:
> What's the purpose of shared/ ? We have tests that make sense for a
> subset of supported filesystems in generic/, with proper _required and
> other the checks it works fine.

Yes.  I'd rather get rid of shared and the few tets in there as it just
creats confusion.


