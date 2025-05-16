Return-Path: <linux-btrfs+bounces-14089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D7ABA2B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC2B4A8840
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB427A123;
	Fri, 16 May 2025 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b="3pZ5BhFo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jablonecka.jablonka.cz (jablonecka.jablonka.cz [91.219.244.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757701D47AD
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.219.244.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419791; cv=none; b=qKXfMGRkQwtjKqb9VMNw3LeZuKpr8cQut5IayzIohikYCG3d6RyWOmz2nK6SCmRcs3a+uQddwDOoYWPHnvdtjSfauWOQ3o1uKIQlznxmNHUuo5enjd/3/jG/NXfO3/d3AwxSczd8Q60UmRB8Z11k3BDp8mJ8Iz00W9tlCtHQ5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419791; c=relaxed/simple;
	bh=GNYihiVEL4KOvMXl8jZTkQ58q4cmAgv2Ywz5hzPvzn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSSA0SqDs2rlrmokh3Sj4cXv2gDYN2PqN3+/GIOh660tOdzOwzabbnTolvRdR7W1pU0YeRfRFM1owJk0DM2IfNcs6T2biO13IhUGFqjT7k+WuYzMJU+ERI27d8ec1yrWFLxOhQuNpkbY/lWk0oLSbEEBrsX1v0/vuMQ5ckA15tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz; spf=none smtp.mailfrom=twin.jikos.cz; dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b=3pZ5BhFo; arc=none smtp.client-ip=91.219.244.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=twin.jikos.cz
Received: from twin.jikos.cz (twin.jikos.hovorcovice.czf [10.33.87.18])
	by jablonecka.jablonka.cz (Postfix mail delivery) with ESMTPS id 46B456035A5E;
	Fri, 16 May 2025 20:23:07 +0200 (CEST)
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
	by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 54GIN5G9015609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 May 2025 20:23:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jikos.cz; s=twin;
	t=1747419786; bh=VEi5V//16G0temx9cp5R2/A/+5xpUHZNP7UTPSR4Fqc=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=3pZ5BhFo/IdMMiL85MAR
	TwWdPbEB4erS/GcWJeUEmuIV4GOSRK3zSSmMmYESOtlWBZTJbWruKHgcC5c9nF0+Yol
	LgDRVSCtDg+C8rHMQb63AUgdXHDYpYDq+VHzxp4QL4ES2HOikk3A8gRJjPCBFOM2RtJ
	wNjWGt3WkdisOpNLI=
Received: (from dave@localhost)
	by twin.jikos.cz (8.13.6/8.13.6/Submit) id 54GIN5qH015608;
	Fri, 16 May 2025 20:23:05 +0200
Date: Fri, 16 May 2025 20:23:05 +0200
From: David Sterba <dave@jikos.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction abort at
 __btrfs_inc_extent_ref()
Message-ID: <20250516182305.e4y2gpc5icmoeyl7@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <56bea892fbeb023b89ac362c3882c80181372f7a.1747412853.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bea892fbeb023b89ac362c3882c80181372f7a.1747412853.git.fdmanana@suse.com>
User-Agent: NeoMutt/20161028 (1.7.1)

On Fri, May 16, 2025 at 05:34:58PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when either
> insert_tree_block_ref() failed or when insert_extent_data_ref() failed,
> move the btrfs_transaction_abort() to happen immediately after each one of
> those calls, so that when analysing a stack trace with a transaction abort
> we know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.cz>

