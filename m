Return-Path: <linux-btrfs+bounces-109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D71E7EA350
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E890CB20A2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65A23742;
	Mon, 13 Nov 2023 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OrrCkCNw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AB22F02;
	Mon, 13 Nov 2023 19:09:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A410D0;
	Mon, 13 Nov 2023 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PRaP26uLRIaPUrqCO1u+n8xWlzTOZc8MxJaS8V8h730=; b=OrrCkCNw20xRbhRNOU25FUUF+h
	tSAGAQvoF7CbCxtxcmg8GoEVsUAuMT/tW2YsT48IzTnFv9p08lM+jyrbiMAAyx4jkHqdvWsvivjB6
	JfBnItjIV4efAdAUamlDy5wBmg67+vz1EQNJsynuiqGF1KPJqiWU3MNr/c7IkbCq4K40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2cIa-00065F-Pu; Mon, 13 Nov 2023 20:08:40 +0100
Date: Mon, 13 Nov 2023 20:08:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com, ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] linkmode: convert
 linkmode_{test,set,clear,mod}_bit() to macros
Message-ID: <33967a01-9ed0-43db-a615-907abab989b7@lunn.ch>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
 <20231113173717.927056-5-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113173717.927056-5-aleksander.lobakin@intel.com>

On Mon, Nov 13, 2023 at 06:37:10PM +0100, Alexander Lobakin wrote:
> Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
> on compile-time constants"), the non-atomic bitops are macros which can
> be expanded by the compilers into compile-time expressions, which will
> result in better optimized object code. Unfortunately, turned out that
> passing `volatile` to those macros discards any possibility of
> optimization, as the compilers then don't even try to look whether
> the passed bitmap is known at compilation time. In addition to that,
> the mentioned linkmode helpers are marked with `inline`, not
> `__always_inline`, meaning that it's not guaranteed some compiler won't
> uninline them for no reason, which will also effectively prevent them
> from being optimized (it's a well-known thing the compilers sometimes
> uninline `2 + 2`).
> Convert linkmode_*_bit() from inlines to macros. Their calling
> convention are 1:1 with the corresponding bitops, so that it's not even
> needed to enumerate and map the arguments, only the names. No changes in
> vmlinux' object code (compiled by LLVM for x86_64) whatsoever, but that
> doesn't necessarily means the change is meaningless.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

