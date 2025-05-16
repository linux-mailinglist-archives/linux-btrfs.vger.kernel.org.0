Return-Path: <linux-btrfs+bounces-14090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C5ABA2C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0386A20464
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205127B4F2;
	Fri, 16 May 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b="n6Xg0v/2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jablonecka.jablonka.cz (jablonecka.jablonka.cz [91.219.244.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435519938D
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.219.244.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420065; cv=none; b=W3qWLMp/Mxt2PyQDmZDk7DkQzvBwUAnqe+Ut4gYkwZJlsOr/C47zoTsCgTbZosuX0yTHlKkzmFFwAF1AkcNXvCqHFr8CBMNp4jbcRbtTgwiBwbrLP2bgD8bsBvFw7p+b7Shr9DWg8cBfylKTGLhipO4IxZJxOPLKtLtaHHVF58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420065; c=relaxed/simple;
	bh=1b6MAGnaHARy3ik1q3+bN1/1pkJykfQGJqM9psRGLOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Wi67bmdN5zGyjse6AjQ8yNwHvUdT3nZzCwlndjaRYLVkY72PAVyecEbM0xGRXZkqAmcL4Bw8Pk9bnLST2gzMxvtHeh53KtlIGu46AKaWPi5mXGWLq01+jfyrBtBU/2vR2WyKPZPB9g9afGiEf/AewjYx+uwIhPXCh3b9cwevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz; spf=none smtp.mailfrom=twin.jikos.cz; dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b=n6Xg0v/2; arc=none smtp.client-ip=91.219.244.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=twin.jikos.cz
Received: from twin.jikos.cz (twin.jikos.hovorcovice.czf [10.33.87.18])
	by jablonecka.jablonka.cz (Postfix mail delivery) with ESMTPS id EB6A26035A5E;
	Fri, 16 May 2025 20:27:41 +0200 (CEST)
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
	by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 54GIRePK016223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 May 2025 20:27:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jikos.cz; s=twin;
	t=1747420060; bh=CrC7LbGChwmGM1oo0da6tilc6l+gNWN5N5L1+iHw+8A=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=n6Xg0v/2ED95/PAK1rMr
	9wfrHPCVMfSfVUbO3HNSpMUWn5zqE7Ti7qS6rprGaq06YLMYYU9UNJjG4Rsu+DS/fzI
	UO9EFcUuE1rwayE/G7duEsfLZ2KxFwemG5Gqpbo/L2fo4cCqCCLzKvTd2JvQ2D5id5F
	6ATNtlxBEbFGH705g=
Received: (from dave@localhost)
	by twin.jikos.cz (8.13.6/8.13.6/Submit) id 54GIRdi8016222;
	Fri, 16 May 2025 20:27:39 +0200
Date: Fri, 16 May 2025 20:27:39 +0200
From: David Sterba <dave@jikos.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction abort at walk_up_proc()
Message-ID: <20250516182739.tuuvbtr3dt3olzt4@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <abc8c07f10bb3565627533a7140b2add7f6b5e00.1747413241.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc8c07f10bb3565627533a7140b2add7f6b5e00.1747413241.git.fdmanana@suse.com>
User-Agent: NeoMutt/20161028 (1.7.1)

On Fri, May 16, 2025 at 05:35:53PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when any of
> the rwo btrfs_dec_ref() calls fail, move the btrfs_transaction_abort() to

                                               btrfs_abort_transaction()

> happen immediately after each one of the calls, so that when analysing a
> stack trace with a transaction abort we know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.cz>

Nice, the remaining ones will be harder to find, I have 2 more to fix in
add_block_group_free_space() and remove_block_group_free_space().  In
total there are about 280.

