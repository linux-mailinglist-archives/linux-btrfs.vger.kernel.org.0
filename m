Return-Path: <linux-btrfs+bounces-18182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F4C012E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 14:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0903359BEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14434221542;
	Thu, 23 Oct 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCn7pzAX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F862F7AAD;
	Thu, 23 Oct 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223246; cv=none; b=ARBLRSrzNwFwV+U0bq4Thkawn24zKG1KMsOL2BXX1778icsY/NB+OjYLMOswNIHV6Cb55ShqxwQnzetOZWweIZqtttx1JmrgYubWOHBTFQtCEO762jbCgzsSBV+iueiVB1otvtABkp9FXqEtXadJeoSJb0AzVC13aH2a8sHqNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223246; c=relaxed/simple;
	bh=OwgX4A4nUsjXLvlUNNji3awVIq48IsYKIpns6jEsaF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAp3lknwKiYgiMbiBRiMNuhASdnusopuKUO6RnBeWRjoAlTllMvFT89nhCEXT6ZtjxLKwykQ+kM6bVuHVicQ0wyb+6t7DSid4A1moPgv0LVHDJ/QYqXEfLcX95bVYrOohQS6Xu7lwaV+jWN2NSVcuZj0DxFEamt4AUrlbfHkvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCn7pzAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AEAC4CEE7;
	Thu, 23 Oct 2025 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761223245;
	bh=OwgX4A4nUsjXLvlUNNji3awVIq48IsYKIpns6jEsaF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCn7pzAXwHtLrzaa/YhuJfPNCVP6Pnu/nAAMiKfwQSsv06J6Jd2HXehsvFVS0r76s
	 n6zNsF/60LjlqGkwHg8F/NO27HDRdVEzaH11spxxsB37a1jSubPqFVvvvbfxweF6v8
	 ngSlwg3RzgdGV4HpUc19eq0cbF5y7EClQHeDC/bX9ORGYQ8lP6Z7J1+KgaSt0I5y6k
	 Lgc6mbCOQTBAfdpl1jwJNKX47OQF6MaRwszTh9uUw8aJsQiOH2g+G51qMIsxCnOUw6
	 pssOa5jT4DoTQJFtTNSuk9D4EExRi1ZOKqNFAId7rDtgSzF7YUZUsbBO8QiyirLKRw
	 a3fly7zNWieag==
Date: Thu, 23 Oct 2025 14:40:41 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Kleikamp <shaggy@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org, jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 1/2] Kbuild: enable -fms-extensions
Message-ID: <20251023124041.GA739226@ax162>
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
 <20251020142228.1819871-2-linux@rasmusvillemoes.dk>
 <20251022161505.GA1226098@ax162>
 <CAKwiHFiMAm-DX3aERH_F1UooiM1YUiMaax51exhRg2=1ND2VCw@mail.gmail.com>
 <20251022211133.GA2063489@ax162>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022211133.GA2063489@ax162>

On Wed, Oct 22, 2025 at 11:11:38PM +0200, Nathan Chancellor wrote:
...
> > > > +# Allow including a tagged struct or union anonymously in another struct/union.
> > > > +KBUILD_CFLAGS += -fms-extensions
...
> I have tentatively applied this to kbuild-next so that it can spend most
> of the cycle in -next to try and catch all potential problems.

One side effect that has been found in my testing so far is clang's
'-fms-extensions' turns '_inline' into a keyword, which breaks fs/jfs:

  In file included from fs/jfs/jfs_unicode.c:8:
  fs/jfs/jfs_incore.h:86:13: error: type name does not allow function specifier to be specified
     86 |                                         unchar _inline[128];
        |                                                ^
  fs/jfs/jfs_incore.h:86:20: error: expected member name or ';' after declaration specifiers
     86 |                                         unchar _inline[128];
        |                                         ~~~~~~~~~~~~~~^

There appear to be other similar keywords (ones with KEYMS in the linke
below) but my personal distribution configuration does not show any
instances in the build where they matter (I did not test allmodconfig
yet).

  https://github.com/llvm/llvm-project/blob/249883d0c5883996bed038cd82a8999f342994c9/clang/include/clang/Basic/TokenKinds.def#L744-L794

Something like this is all it takes to resolve the issue, so I will send
a patch for formal review/acking but I wanted to bring it up ahead of
time in case this is unpalpable and we should throw these changes out of
-next instead of forward fixing.

Cheers,
Nathan

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 10934f9a11be..5aaafedb8fbc 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -76,14 +76,14 @@ struct jfs_inode_info {
 		struct {
 			unchar _unused[16];	/* 16: */
 			dxd_t _dxd;		/* 16: */
-			/* _inline may overflow into _inline_ea when needed */
+			/* _inline_sym may overflow into _inline_ea when needed */
 			/* _inline_ea may overlay the last part of
 			 * file._xtroot if maxentry = XTROOTINITSLOT
 			 */
 			union {
 				struct {
 					/* 128: inline symlink */
-					unchar _inline[128];
+					unchar _inline_sym[128];
 					/* 128: inline extended attr */
 					unchar _inline_ea[128];
 				};
@@ -101,7 +101,7 @@ struct jfs_inode_info {
 #define i_imap u.file._imap
 #define i_dirtable u.dir._table
 #define i_dtroot u.dir._dtroot
-#define i_inline u.link._inline
+#define i_inline u.link._inline_sym
 #define i_inline_ea u.link._inline_ea
 #define i_inline_all u.link._inline_all
 

