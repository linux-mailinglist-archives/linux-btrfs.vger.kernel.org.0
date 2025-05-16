Return-Path: <linux-btrfs+bounces-14091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33491ABA2C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC9950427C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2828278768;
	Fri, 16 May 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b="VzpsSMVP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jablonecka.jablonka.cz (jablonecka.jablonka.cz [91.219.244.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181D2E628
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.219.244.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420094; cv=none; b=aZacn2nzU9nnfNbBcttBOQBNpBEKK5jbz+JEDgGcxz2FfjKggGur9n61r+tnKVYyuY1hje2N3tuHFlAmpp1DER+JTpFYJPgiAydXVk2VBxXuyFz2NK3+TkXsvPOJWoZi2ZYsxbzxImErhHBwD6j9933a8PkW5YnWyvi+aa3aSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420094; c=relaxed/simple;
	bh=VJYuJpliv7EwID8kjb1vIjdsS5BbnOFFJalz0WNHOWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjihMuardfdlVQIhdKqGg4aYpeF02rWpSyLjAWcszCpd0HOHujyzdWUmmEWU3CktjN+Qih8J5gk0Q8TuH6CuYUOS3QEIw+WVS/7/XRWzyuXRXXVGwBbcOmPVG1IceHr1uT+9bSS25Vq1E5ztfa5lo0NZ2YQwreesH90chu+xw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz; spf=none smtp.mailfrom=twin.jikos.cz; dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b=VzpsSMVP; arc=none smtp.client-ip=91.219.244.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=twin.jikos.cz
Received: from twin.jikos.cz (twin.jikos.hovorcovice.czf [10.33.87.18])
	by jablonecka.jablonka.cz (Postfix mail delivery) with ESMTPS id CFDDA6035A5E;
	Fri, 16 May 2025 20:28:10 +0200 (CEST)
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
	by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 54GIS9e3016263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 May 2025 20:28:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jikos.cz; s=twin;
	t=1747420089; bh=IS7Y4KRVSBck2bUOpj9VuLlkuP9eZnNUmi6KBG3eRyg=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=VzpsSMVPOLvIFhMHnjzB
	jF0JVf6LgRXxlBdKD9/ZjNmSuUpOy6SPCyszfN8mY9YlTCxhTAHn8bAPQn+8olHjWHv
	WTBxNK04Goq7nWdn/maKWx5tu76BuczQdySIoBKjPf1J9DPI2ZDpO+6FL3334Uk9FdQ
	r1C6+rNIS9H5/8FXU=
Received: (from dave@localhost)
	by twin.jikos.cz (8.13.6/8.13.6/Submit) id 54GIS8A8016262;
	Fri, 16 May 2025 20:28:08 +0200
Date: Fri, 16 May 2025 20:28:08 +0200
From: David Sterba <dave@jikos.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless 'out' label from
 clone_finish_inode_update()
Message-ID: <20250516182808.wxpweqo73ac33jmq@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <a32c6856d38b6f2f9452ddba50627a7acb04cfde.1747419369.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32c6856d38b6f2f9452ddba50627a7acb04cfde.1747419369.git.fdmanana@suse.com>
User-Agent: NeoMutt/20161028 (1.7.1)

On Fri, May 16, 2025 at 07:16:54PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The label is only used once and we can instead return directly where it's
> used, besides the fact that all we do under the label is to return the
> value of 'ret'. So get rid of the label and return directly.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.cz>

