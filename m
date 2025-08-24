Return-Path: <linux-btrfs+bounces-16315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65FB3314E
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Aug 2025 17:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CABF1B23E1D
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Aug 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E52D660E;
	Sun, 24 Aug 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TSkV6imA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B278F51
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Aug 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051101; cv=none; b=ksx+D/5cuT78LLulHuQutPug3bsVj95reh9JJriAq1CrAjQGPLTtA7OQWztJbG5NMKdTd87fC67yndy3W/32R2kvjQMhFhiziQRLT0m3CkKOfx/uZ7wC8wPYRCkOHx4CqBYihSuW182oioA9E5a71t3rGMD5NL3YdHYyiL3uA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051101; c=relaxed/simple;
	bh=4JtHlmEpGFJ65CEhyO8NUgg5+13+Xtd98lF+0G0TTu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Taau1UWBD0A++3Q1SNWeyGKJOBwI2Ozw1ZLVpuAJTAzKDzKdQ0cV4NvXysnzXAJ9PKZE0v2s8VOfVhS3+i3eY1CS67j7CudVXIpELUl8+/bTtbeJaKwnNeEq3mJqT7gwngmJeEGgYepFhO/bev+hPGB67MCDFdopWcJyRMI+PjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TSkV6imA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7702fc617e9so1674630b3a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Aug 2025 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756051099; x=1756655899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hAR4o0uUzKHA3BSOkPRonY0nbO9TmFEmpicgSL89uE8=;
        b=TSkV6imAZNFcy43ooNBV5igH/jgkxyABjP/QG8KwDxJxdoC5I4XS60XcGgdNgmYBq6
         lokzArmkyEBxJlvBNgysrBh1eGB6jpkXGFeL4TN49y+2U8egqEc69MMXiaHGCSq4JiyD
         liCrwL25uFouyx8Dp51RUBPbymQTu8x0gKqXrhFquXiRDSxN+kcbFvmFhfIN8G9a0S8g
         6hwBn/jbFlOdyP4ZnExgqaWHp8DofaonEAuK9++xKit9RbQz40RTtOIQBSUY2wmRBrwq
         Y3yNC5M3DhK4bF26D+r3Ajqz3jHbNbHSmZeuz1cpLkZcQ2FmirMErmWxv16bnJE6RQ7C
         JbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756051099; x=1756655899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAR4o0uUzKHA3BSOkPRonY0nbO9TmFEmpicgSL89uE8=;
        b=OLezsfjrHwNcK1i4WX7qRPXsJb10g0hirIlqiMAQG0l1cyZq8jPJlfq71XborSaxbV
         PiD5XZ8VYsQG+SCZPOK+/HurbyQVJCw0N7+AR/R7nF14tJQ97GVIum1nTBA762+bEmzF
         Ggm9byFPIHnyfmOR3TYtjoxlKF75Y/6r049a5SLu2Vp5o74hPEv6DxDNO/5Q+e7IGA6E
         e5zLtKgWhN6S6bhRDs7Kwrs3TyGhbRc6C8F4TCeR74b5qUHkoDN2WiWYvl1BauDvQheY
         UztZtQQaSpiJzyV+Ld/alGCRzanPx8ERSBGDWQ2JEDmHcjeacvLUFn+7g+dFcn1k82ow
         Rl7g==
X-Forwarded-Encrypted: i=1; AJvYcCVEri0khghrpogc3hjnH3Vs6CpOFS8SQaqgYn2mRGr+hSIMpBXbq0ZKwHunK46iunp/JjUQYmjzZ/MMgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyon+bLyeAyJfzdxXKcao9t74cLeqPKvYGa304UnIrrntfM1l2e
	u0wEOnt/uTYd/l9STPAE3qtAIi/MI5D5s6AS+IP9xIhuUFwaEQTXwtGBj66uIdz4wGw=
X-Gm-Gg: ASbGncuVbLtkxUxjUb0sd0uPWCi5pW56oF/hfaXuBvQp8YXESHdSibnBY6xq0+W3cUX
	Ke09IHziYK1OpLWmp5MThW0aRwb5hEWA+ShcFsIpT+z/blFNMojftblTV8T9Xjvvpa4zdAPt9QE
	KTIuyN/+81rgNY39p/7W2iRubkbNzAGYjhkRlyKxv+PqxmBj20bd4LmxATiV8d7/v+3hyU9Ggw/
	iZkWejCne1ByCOpiV+jlK0vS+W31WkRc6Q7+5CAflzDVMFe0Ku+gaM3xG/iyV9627qWiDGujQ6u
	J9sm9YXyIrUgJSSTmoUpcI5ZBEpJ0cJVo1yRpnodZ6HgEKhII+o2iqctBQvPP5w7iOUL8yuamWK
	myebZaImfhk8hd7N6mgkEjav7MwTt+11nD/8=
X-Google-Smtp-Source: AGHT+IG+ZE9QqCE997b5BHkkhjWF9L8cd7mq6CfWpCdGRf/q+uMBgZYZ9UsAt9D+fb3fyBQlXBDnqw==
X-Received: by 2002:a05:6a20:430b:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-24340d02428mr13378311637.29.1756051099176;
        Sun, 24 Aug 2025 08:58:19 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c1b6dedd2sm373163a12.23.2025.08.24.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 08:58:18 -0700 (PDT)
Date: Sun, 24 Aug 2025 08:58:16 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sun YangKai <sunk67188@gmail.com>, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, neelx@suse.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKs2mCRjtv3Ki06Z@mozart.vkv.me>
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me>
 <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
 <aKj8K8IWkXr_SOk_@mozart.vkv.me>
 <9cacdafc-98ec-4ad2-99a8-dfb077e4a5fb@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cacdafc-98ec-4ad2-99a8-dfb077e4a5fb@gmx.com>

On Saturday 08/23 at 09:09 +0930, Qu Wenruo wrote:
> 在 2025/8/23 08:54, Calvin Owens 写道:
> > On Saturday 08/23 at 07:14 +0930, Qu Wenruo wrote:
> > > 在 2025/8/23 01:24, Calvin Owens 写道:
> > > > On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
> > > > > 在 2025/8/22 19:50, Sun YangKai 写道:
> > > > > > > The compression level is meaningless for lzo, but before commit
> > > > > > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > > > > > it was silently ignored if passed.
> > > > > > > 
> > > > > > > After that commit, passing a level with lzo fails to mount:
> > > > > > >        BTRFS error: unrecognized compression value lzo:1
> > > > > > > 
> > > > > > > Restore the old behavior, in case any users were relying on it.
> > > > > > > 
> > > > > > > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > > > > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > > > > > ---
> > > > > > > 
> > > > > > >     fs/btrfs/super.c | 2 +-
> > > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > > > > > index a262b494a89f..7ee35038c7fb 100644
> > > > > > > --- a/fs/btrfs/super.c
> > > > > > > +++ b/fs/btrfs/super.c
> > > > > > > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> > > > > > > *ctx,>
> > > > > > >     		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > > > > >     		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > > > > > >     		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > > > > > > 
> > > > > > > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > > > > > > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> > > > > > > 
> > > > > > >     		ctx->compress_type = BTRFS_COMPRESS_LZO;
> > > > > > >     		ctx->compress_level = 0;
> > > > > > >     		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > > > > > 
> > > > > > > --
> > > > > > > 2.47.2
> > > > > > 
> > > > > > A possible improvement would be to emit a warning in
> > > > > > btrfs_match_compress_type() when @may_have_level is false but a
> > > > > > level is still provided. And the warning message can be something like
> > > > > > "Providing a compression level for {compression_type} is not supported, the
> > > > > > level is ignored."
> > > > > > 
> > > > > > This way:
> > > > > > 1. users receive a clearer hint about what happened,
> > > > > 
> > > > > I'm fine with the extra warning, but I do not believe those kind of users
> > > > > who provides incorrect mount option will really read the dmesg.
> > > > > 
> > > > > > 2. existing setups relying on this behavior continue to work,
> > > > > 
> > > > > Or let them fix the damn incorrect mount option.
> > > > 
> > > > You're acting like I'm asking for "compress=lzo:iamafancyboy" to keep
> > > > working here. I think what I proposed is a lot more reasonable than
> > > > that, I'm *really* surprised you feel so strongly about this.
> > > 
> > > Because there are too many things in btrfs that are being abused when it was
> > > never supposed to work.
> > > 
> > > You are not aware about how damaging those damn legacies are.
> > > 
> > > Thus I strongly opposite anything that is only to keep things working when
> > > it is not supposed to be in the first place.
> > > 
> > > I'm already so tired of fixing things we should have not implemented a
> > > decade ago, and those things are still popping here and there.
> > > 
> > > If you feel offended, then I'm sorry but I just don't want bad examples
> > > anymore, even it means regression.
> > 
> > I'm not offended Qu. I empathize with your point of view, I apologize if
> > I came across as dismissive earlier.
> > 
> > I think trivial regression fixes like this can actually save you pain in
> > the long term, when they're caught as quickly as this one was. I think
> > this will prevent a steady trickle of user complaints over the next five
> > years from happening.
> > 
> > I can't speak for anybody else, but I'm *always* willing to do extra
> > work to deal with breaking changes if the end result is that things are
> > better or simpler. This just seems to me like a case where nothing
> > tangible is gained by breaking compatibility, and nothing is lost by
> > keeping it.
> > 
> > I'm absolutely not arguing that the mount options should be backwards
> > compatible with any possible abuse, this is a specific exception. Would
> > clarifying that in the commit message help? I understand if you're
> > concerned about the "precedent".
> 
> Then I'm fine with a such patch, but still prefer a warning (not WARN(),
> just much simpler btrfs_warn()) line to be shown when a level is provided
> for lzo.
> 
> Furthermore, since we already have something like btrfs_lzo_compress
> indicating the supported level, setting to the proper default value would be
> better. (Already done by btrfs_compress_set_level() call in your v2 patch).

Thanks Qu. v3 below.

There was an off-by-one in my v2, len("lzo") is three, doh.

> BTW, since you mentioned something like "compress=lzo:asdf",
> btrfs_compress_set_level() just ignores any kstrtoint() error, allowing
> things like "compress=zstd:invalid" to pass the option parsing.
> 
> I can definitely send out something to enhance that check, but just want to
> be sure, would you opposite such extra sanity checks?

I have no objection to that at all, IMHO that's a good thing to do.

Is it worth adding a testcase somewhere for the compression options? I'm
happy to do that too, but I'm not sure what the right place for it is.

Thanks,
Calvin

-----8<-----
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH v3] btrfs: Accept and ignore compression level for lzo

The compression level is meaningless for lzo, but before commit
3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
it was silently ignored if passed.

After that commit, passing a level with lzo fails to mount:

    BTRFS error: unrecognized compression value lzo:1

It seems reasonable for users to expect that lzo would permit a numeric
level option, as all the other algos do, even though the kernel's
implementation of LZO currently only supports a single level. Because it
has always worked to pass a level, it seems likely to me that users in
the real world are relying on doing so.

This patch restores the old behavior, giving "lzo:N" the same semantics
as all of the other compression algos.

To be clear, silly variants like "lzo:one", "lzo:the_first_option", or
"lzo:armageddon" also used to work. This isn't meant to suggest that
any possible mis-interpretation of mount options that once worked must
continue to work forever. This is an exceptional case where it makes
sense to preserve compatibility, both because the mis-interpretation is
reasonable, and because nothing tangible is sacrificed.

Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 fs/btrfs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a262b494a89f..18eb00b3639b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,9 +299,12 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (btrfs_match_compress_type(string, "lzo", false)) {
+	} else if (btrfs_match_compress_type(string, "lzo", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_LZO;
-		ctx->compress_level = 0;
+		ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_LZO,
+							       string + 3);
+		if (string[3] == ':' && string[4])
+			btrfs_warn(NULL, "Compression level ignored for LZO");
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-- 
2.49.1


