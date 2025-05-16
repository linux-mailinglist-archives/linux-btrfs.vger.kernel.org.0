Return-Path: <linux-btrfs+bounces-14092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A32ABA2C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9570817EDD6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726827AC59;
	Fri, 16 May 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b="oSmi9faO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jablonecka.jablonka.cz (jablonecka.jablonka.cz [91.219.244.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66B1E9B2F
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.219.244.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420118; cv=none; b=YOQQkxl2FBuR3XgK5ESfEi09repW6MjiHXBJsuvPszP1NDxS5pq01MMEY/sfbbLEWQKfvLXGNgD5zLr/F1a2+qAhQT6UNx4iqLJkdeHisJQCxMMnaUcTGk3PvHUDo3MXkB6/QbWQbr6Fw9+3f7MwdJ9HXWGQpmRdfOmoege+Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420118; c=relaxed/simple;
	bh=Iy7KKuyAV9UNpkTBeim9yi0hu+mNMz4gzuZzsSACxEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4Y3T8dYV7PXnyKuwnLi+SYj6OfNIndPVUeUM6JHHyNw5VjjpGKPYlM8ItC/ANYNn/T2LxrzthcQsNSCdGLYE+AWjZd1RwONkKJsV9C4SleDlK4ss7rjAHDcNyAmNwKYr2/667bN8UOkKyEnLILgAQTPQ9zwaP6K2mwbJcSvbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz; spf=none smtp.mailfrom=twin.jikos.cz; dkim=pass (1024-bit key) header.d=jikos.cz header.i=@jikos.cz header.b=oSmi9faO; arc=none smtp.client-ip=91.219.244.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jikos.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=twin.jikos.cz
Received: from twin.jikos.cz (twin.jikos.hovorcovice.czf [10.33.87.18])
	by jablonecka.jablonka.cz (Postfix mail delivery) with ESMTPS id 090E16035ABC;
	Fri, 16 May 2025 20:22:47 +0200 (CEST)
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
	by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 54GIMjQg015578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 May 2025 20:22:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jikos.cz; s=twin;
	t=1747419766; bh=miYnEih+xdItO0CnrJpwfLfH4KOgewJ6Oy40aZmTuAw=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=oSmi9faOO+WMK0a74Nuh
	pfx8YC6vYVay5AVNOJwGaY0d/LFU8MGGFunm3q1bKrLmrK0aqt57DLuiTL+Joohn4ww
	XiXZgKW8w9Pod9KL/1SAXZy6gKX7S6TD7vafHmctA5/fhiyjzXyOgZqyIbeyHATZwqJ
	Z+8h45VIAVak28rPI=
Received: (from dave@localhost)
	by twin.jikos.cz (8.13.6/8.13.6/Submit) id 54GIMj4R015577;
	Fri, 16 May 2025 20:22:45 +0200
Date: Fri, 16 May 2025 20:22:44 +0200
From: David Sterba <dave@jikos.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction aborts at
 btrfs_create_new_inode()
Message-ID: <20250516182244.ion2oo46yahdilco@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <32127d7f66702d0b80132bea776e214077b42872.1747412285.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32127d7f66702d0b80132bea776e214077b42872.1747412285.git.fdmanana@suse.com>
User-Agent: NeoMutt/20161028 (1.7.1)

On Fri, May 16, 2025 at 05:19:15PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when either
> btrfs_orphan_add() failed or when btrfs_add_link() failed, move the
> btrfs_transaction_abort() to happen immediately after each one of those
> calls, so that when analysing a stack trace with a transaction abort we
> know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.cz>

