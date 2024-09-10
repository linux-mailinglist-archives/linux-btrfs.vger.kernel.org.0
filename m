Return-Path: <linux-btrfs+bounces-7902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24608972B33
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 09:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FF01C23FED
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0D181317;
	Tue, 10 Sep 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4jwK1a/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116252F71;
	Tue, 10 Sep 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954764; cv=none; b=gwAXwirP1V65dgTds/7WPJlGcQomph9vHzKLYZu4C6BLSeiHKELIOFMmzewzfI3JDZoeR3PxOkSttIPVg5b1OszT0Hx6DmqhPGvZOieMjbS9u33M0hiIO9WiuYEUDZp3mAFsHC0vzfJIRmACxiuQn2bPGSPvJUy/Sd2biMafKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954764; c=relaxed/simple;
	bh=y9UYcgB1uU+awNBkj8r2Alu86FrSrPnnSkLmGQrvwac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TitRIOECI99YiFt3Y13qhVszc0UnfJrOaiT1E+8vnss7cdcolU0guJbzUz54BfraBab58ydNJxCHsRnX5nFPaeEGyYMt0IB3C2DTXJy2SinbHt/OjovuqKsvFKuLygLQeG/qE3cj8aq0sWsFOgZ4SsiTII/mvSqAFTiZw7G+Ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I4jwK1a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E4EC4CEC3;
	Tue, 10 Sep 2024 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725954763;
	bh=y9UYcgB1uU+awNBkj8r2Alu86FrSrPnnSkLmGQrvwac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4jwK1a/Ti97f+VOZ9BbX2ARqkkSlbA29HxGsC+mIA8AEn3x50lICD30Yq1XMM9i/
	 hsJzhMi7Rg9+H9x0iDfOmR6A17LbnB01JqYga1YPmqH8QJL0WEFsBmSveFORBpoo07
	 PUfXUneA/04klvzdcRJaHyIYNh/wdFGfVHhwzk2U=
Date: Tue, 10 Sep 2024 09:52:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: fdmanana@kernel.org
Cc: stable@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Paulo Dias <paulo.miguel.dias@gmail.com>,
	Andreas Jahn <jahn-andi@web.de>,
	syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH for 5.15 stable] btrfs: fix race between direct IO write
 and fsync when using same fd
Message-ID: <2024091032-defacing-timothy-40e9@gregkh>
References: <fb9d3a6e7b2f6e69cbc98d9e22c5f0430c6f86cb.1725888308.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9d3a6e7b2f6e69cbc98d9e22c5f0430c6f86cb.1725888308.git.fdmanana@suse.com>

On Mon, Sep 09, 2024 at 02:31:02PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit cd9253c23aedd61eb5ff11f37a36247cd46faf86 upstream.

All backports now queued up, thanks!

greg k-h

