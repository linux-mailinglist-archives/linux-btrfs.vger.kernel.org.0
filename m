Return-Path: <linux-btrfs+bounces-16310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9866B324AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 23:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93ADB6241E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 21:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41B285C85;
	Fri, 22 Aug 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="XmQJZXv8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877C221F09
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898966; cv=none; b=oxyyM9wVVSGy7edvoZZfshel9oFBSxPSlvyswFJ9pitrB5CwwQRUI9d6y2OCO8zpKfgVCnjjDyFliiIE/ZEfeuFnt0b+eWb+0CGsMKzYW3+YcBghLVHKmYw8z45Wo9q3RCt+zEyfstwNlEox3RoTYHmSyfxzsO1tpoW/pBJHu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898966; c=relaxed/simple;
	bh=cSAoYlhEharbCXrFRdBZlGV8qlrCICwY5tJACo9Nzb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y63mJuc/4BIPpxtAgaJktlI+6LHGLuqkX0CmNeuIWKwlxV6QgaOJYgTuFpfp9RMW2vhwfV6d6Sf934ua3k9zHmMymNnQyJFZxSFnJ0pu5wIJCot2wwuizU9Iin3uLwnbBCVUuKwQUbHQ1Jsmy0Za3Dhl79r8rAoQmdvuQmxcnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=XmQJZXv8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so2992520b3a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755898964; x=1756503764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRyx1vVcQ/kgaVUrmb8N/jhUWIpSwlGJJb8HvB3gHGM=;
        b=XmQJZXv8Zw4HTyY1XWfCZ8CJDcyEN7Fv5xu/EddKJkIsiE1dnW7RU3v/nnlJmUS+mO
         Ul54tF0Lkhl6DL/nfTR1qONwI1nrGNBBoKoxN1nvEoi0/9tGVgKBrU+Tgglpam95o7GJ
         5GmF37ae69EBYcSJ+9T8DQoqMk4puAOeoUmBsXjRVlEu4mgnbdiXIWhT7eEuuzLKarjL
         adc8sUdWoVNZaqnCCDlQTlg7Ggw5w7Xl7aqfke2tCYmhuBXYkovin6228Xq7P7LMTgx0
         YFKKoDSVXoh2PoLGY/IrOEQTw719W5q5jcmUOZHqDtJo4u2+r4pUNeaznNYwcxObfR5N
         Iv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898964; x=1756503764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRyx1vVcQ/kgaVUrmb8N/jhUWIpSwlGJJb8HvB3gHGM=;
        b=Sn2Kh9OHfgk0SPDbihn+PJjviElMssGP4fSmKhEEU5F5hnKm27Ha000faE+BaxXp+f
         JbCH7IWWnhQavD2Zyqs3vWGnVBdrAFIZykmCQEvQKyrNKv2gKUojMHKR7y14XYRny8Jj
         xNVTytlb5PcTjvhRj9xPtd2rrMNc0Mf7PdgY5fvA2gpc2DPDzIzBklC4mGuVl6ILcNwJ
         YrJ7gpx5smO1DIfvIXj3+MdmWStEcPQ+Uuy9LeGIrpjzCYRQy5wgX/V/SOT+W9S4OpzQ
         dvbE8Zykmwk9RauPC0FQClVbyu2PodFEFxgRDG7JhJcVp9m+e3umEqUJAqSAz6WUYJj1
         Gxrg==
X-Forwarded-Encrypted: i=1; AJvYcCUEdPkfh7z/lkqMVPKGLvIAGB6+NdD0n0Jyvkl6sZbruqIxP/EvFieHsFaI2MHqYi32S3LJJKHKO5y6WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkotHB/bHXMAVHT1NsW7q0i8JdBuhaLpW7h5pVWza6pllioFA
	eokTG16SFpDvYcwkqQ2BWwEh5mqjTPok83VChfTV8SRQmgzXakjdhSCvuuOC/5v2FwNhGsqXUqC
	6xPcz710=
X-Gm-Gg: ASbGncsiNBY762RadHnV+x9lU6SYgOxr7Jji7b4UTJOZ5gztdLSvkPPmQ5EtfsU0oaq
	NR40sBmOJ2GM3iEAupf1407V62idCbOdQSGoAavsEqvJVrc8k7PrfmMBqXDE/pWqOKUjJHD5lLa
	FZeS6PcQT4BcrYocGh9lWGrI4QREkmwnm3q1mW15x7YBPjwOMQoxLoDqby9aGQLa7kVNrqHRRXJ
	Qzjmy4futNYShc0siZJFDlXzJsD91AmlDFKZJl845X45PjvY2D6zl2It75g3icLzb+3WQdNI7iE
	KOBTQqbBa+FaGcpuk9ZfFAYH3UEEhlfoPJ809V+yu9gJ0lWZ2pKJRG7PmxybXoxIG3QQv1MeOFH
	3XZ3N+P7NsbHkQcvNegrE0CKQ
X-Google-Smtp-Source: AGHT+IGp1WPtwGaTO+4dSwDCCL62mQofhBOZ94x1PTLRce8TE0h6K4r+nXiIWJq/OKRPebLfXVgPoA==
X-Received: by 2002:a05:6a00:a87:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7702f9cffc6mr5723521b3a.3.1755898964296;
        Fri, 22 Aug 2025 14:42:44 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040000c8bsm809347b3a.44.2025.08.22.14.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:42:43 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:42:41 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKjkUSL1zxL0VNGC@mozart.vkv.me>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
 <aKg4PcgUCvXblVCY@mozart.vkv.me>
 <20250822184547.GX22430@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822184547.GX22430@suse.cz>

On Friday 08/22 at 20:45 +0200, David Sterba wrote:
> On Fri, Aug 22, 2025 at 02:28:29AM -0700, Calvin Owens wrote:
> > On Friday 08/22 at 17:57 +0930, Qu Wenruo wrote:
> > > 在 2025/8/22 17:15, Calvin Owens 写道:
> > > > The compression level is meaningless for lzo, but before commit
> > > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > > it was silently ignored if passed.
> > > 
> > > Since LZO doesn't support compression level, why providing a level parameter
> > > in the first place?
> > 
> > Interpreting "no level" as "level is always one" doesn't seem that
> > unreasonable to me, especially since it has worked forever.
> 
> As it currently works, no level means use the default, which is defined
> for all compression. For LZO it's implicit and 1.
> 
> > > I think it's time for those users to properly update their mount options.
> > 
> > It's a user visable regression, and fixing it has zero possible
> > downside. I think you should take my patch :)
> 
> I tend to agree this is a usability regression, even if LZO is a bit odd
> with levels, accepting the allowed values should work.
> 
> The mount options and level combinations that should work:
> 
> - compress=NAME   - use default level for NAME
> - compress=NAME:0 - use default, while accepting the level setting
> - compress=NAME:N - if N is in the allowed range for NAME then take it
> 
> The syntax is consistent for all three compressions.

Thanks David.

Maybe the below is a little more palatable? Letting the single level be
a detail so the branches in btrfs_parse_compress() all match?

But, the compression level ends up being printk'd as '1', where it has
always been '0' in the past (and still is in 6.17-rc):

    - BTRFS info (device vda state M): use lzo compression, level 0
    + BTRFS info (device vda state M): use lzo compression, level 1

With my v1 it's still always printed as zero, if that's preferable.

-----8<-----
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH v2] btrfs: Accept and ignore compression level for lzo

The compression level is meaningless for lzo, but before commit
3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
it was silently ignored if passed.

After that commit, passing a level with lzo fails to mount:

    BTRFS error: unrecognized compression value lzo:1

Restore the old behavior, in case any users were relying on it.

Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 fs/btrfs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a262b494a89f..bbcaac7022b0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,9 +299,10 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (btrfs_match_compress_type(string, "lzo", false)) {
+	} else if (btrfs_match_compress_type(string, "lzo", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_LZO;
-		ctx->compress_level = 0;
+		ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_LZO,
+							       string + 4);
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-- 
2.47.2


