Return-Path: <linux-btrfs+bounces-15326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54398AFCD9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 16:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C623A48DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982B191F7E;
	Tue,  8 Jul 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StcAdB6x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FD81749
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985060; cv=none; b=NTNHPrgdBAdRI46gAaJl+aFqpdzpLu1aGDr5IJgCw43Ju1JEyGI30dD9bNwItAp4L6EyRE+DkDuBg0WYlBlZiUtyO47uxSB/RtKNtAH0G3yZXcpER1NQOM9euklY3S4UEUBZm8Fpuz6GGp3slcERX+4HxpeDHvBKMVCGhzSVDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985060; c=relaxed/simple;
	bh=cUyR5OQFDCY38l6twou2TAx4XnnHT9alAjIJ4SuHysk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Uno9eJ8r08EWHAZzyARQI5ytxk+5gzjV1D6ncJWpVgWEvZD2+HTJY36bPc3aIb3vVWYKWBKOTEQd72g44xzRWfFuIX16eviHiG36Aht1WiVZboctusIKbfEmAuQPABidKm87Q98Nmm+6kEoUptCPlWWNFduV4Lt8Dvn2ti6K310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StcAdB6x; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34ab678931so3182046a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985058; x=1752589858; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t96yLsEM2QvATmvlhI3WyQBa3zl9UI3Rd/LbO7fnLAI=;
        b=StcAdB6x7FhIObYZz3lWy6lCZeIozraJDsN54OgmfJpDXdQiS6S/M9ieZBRw5RNtO7
         Ra2DegKhUAd+fTgzjDFTvm1zF3uDPD6bSy9n06kOY0uCBrqGcSnqNILTDRw+fjR488M7
         ax2p9lLF/EUAx6Hbr0qjrKqtXoCmCrLF9tEnrBwp+7I7dA1GqQPdhawkc04wv5/T4Vsh
         kL9wC8jhgwz1SCN45Zx7pIF6zmmhFbJT0MCSk/ZCPh2ZmIc9MnSINxrsmSMdzqVKGNnS
         rMmxLXNMPO4APzYrq+Uoj2BgLP/swbXfAh8fjfRVmDB63s8+tfC7L2mYsZqUJDumYwxC
         UMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985058; x=1752589858;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t96yLsEM2QvATmvlhI3WyQBa3zl9UI3Rd/LbO7fnLAI=;
        b=AHTgFtcnLio+5eIDN4lNgDU+Ho0Qh5Y37MwM6zuKS9SulQ15v5v40f208PglWg8JRm
         MC1KGL3208wnXhryeft/SWyPOyp8aFfKkOUEUoSpy8BP+m5GFq5LYjHs15hkcUwP8UkF
         pie44xiFRa/KSmxtbBlv5axtamUxkovrvpV/63S5afPT2le+z8hQFE7afi4tnkUOUEtq
         UspfnBHXL2bfH/fkkC9R8njNkD4LHigygq3L2G/rx5FCzwSEb4+w6c4G1FLfgl9OcosQ
         ry+bVziDqk8l1+ioa4Gt/atRtSHfKzZK3uOxbArj4REzsg1SlfMPXinMvOVVT2jDCG50
         up1w==
X-Forwarded-Encrypted: i=1; AJvYcCVpDq2dkAgcaX+1M2cnondvu2qHxttCpYf+KDiMeD+ZUqqhfv59WxhcKONEaSJRboYxvA7RNWkqTBdGQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ys4CB7bzYYmm4wnqNJSQiQY+PNJcBZSa88iAe76wuZ8sVKIq
	OfvgjLizfWHJCKanL7JmLX0DSXXlAgQyIfGHxvuo/wYXF1JO+Ut/6eKp
X-Gm-Gg: ASbGncskFaunrNdKw9SB2tF7/jRMaA1pemKNUmlpe9/ppynx0yeGYlqigYjB5Jn4T3H
	iSVhOKUaLjdA0IYH0YZUU8j2yH+D4kHxrwFxxJ2001uBVMx0rm1i9lU7XMTAj218KHhcMX8kTOQ
	YHQ1SgPll1Qphm1aoYhRANJyauPXqxNAWsHbzYv6R5V/F5GvIrgLzjbgLsTEp76F2haxIL2rohI
	WwJPW/ADgXuRR2O1JNoLB1ubVtrHihTuzKJMn6K9iXn4jV8rpj+tNizX/VHeXbjgIR+esHj9480
	JfjIYkDYLewKQiU/KPR5dKZ7dfV7LPThz+6eCws7am5t2jimmwDRKkv1
X-Google-Smtp-Source: AGHT+IFQcq/gHpmvA6GR2BWLSk+ooxegC9IYXlkP+2DTrA687PdsZTEUZ43sEGwviJh7Zi2zwbf0AQ==
X-Received: by 2002:a17:90b:2801:b0:311:b5ac:6f6b with SMTP id 98e67ed59e1d1-31c20ccfb90mr5745828a91.9.1751985058371;
        Tue, 08 Jul 2025 07:30:58 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21eaeedesm2287512a91.39.2025.07.08.07.30.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:30:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20250708142732.GM4453@suse.cz>
Date: Tue, 8 Jul 2025 22:30:36 +0800
Cc: David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org,
 wqu@suse.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F07CB4BA-1D94-4914-BEBA-12B53BCC7944@gmail.com>
References: <20250708132540.28285-1-dsterba@suse.com>
 <23A10F0D-C9CD-4A92-AEEB-8AF8E092DB4E@gmail.com>
 <20250708142732.GM4453@suse.cz>
To: dsterba@suse.cz
X-Mailer: Apple Mail (2.3826.500.181.1.5)

On Jul 8, 2025, at 22:27, David Sterba <dsterba@suse.cz> wrote:
>=20
> On Tue, Jul 08, 2025 at 10:18:09PM +0800, Alan Huang wrote:
>> On Jul 8, 2025, at 21:25, David Sterba <dsterba@suse.com> wrote:
>>>=20
>>> Implement sb->freeze_super that can instruct our threads to pause
>>> themselves. In case of (read-write) scrub this means to undo
>>> mnt_want_write, implemented as sb_start_write()/sb_end_write().
>>> The freeze_super callback is necessary otherwise the call
>>> sb_want_write() inside the generic implementation hangs.
>>>=20
>>> This works with concurrent scrub running and 'fsfreeze --freeze', =
not
>>> with process freezing (like with suspend).
>>>=20
>>> References: https://lwn.net/Articles/1018341/
>>>=20
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>> fs/btrfs/fs.h    |  2 ++
>>> fs/btrfs/scrub.c | 21 +++++++++++++++++++++
>>> fs/btrfs/super.c | 36 ++++++++++++++++++++++++++++++++----
>>> 3 files changed, 55 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>>> index 8cc07cc70b12..005828a6ab17 100644
>>> --- a/fs/btrfs/fs.h
>>> +++ b/fs/btrfs/fs.h
>>> @@ -137,6 +137,8 @@ enum {
>>> BTRFS_FS_QUOTA_OVERRIDE,
>>> /* Used to record internally whether fs has been frozen */
>>> BTRFS_FS_FROZEN,
>>> + /* Started freezing, pause your progress. */
>>> + BTRFS_FS_FREEZING,
>>> /*
>>> * Indicate that balance has been set up from the ioctl and is in the
>>> * main phase. The fs_info::balance_ctl is initialized.
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index 6776e6ab8d10..9a6bce6ea191 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -2250,6 +2250,27 @@ static int scrub_simple_mirror(struct =
scrub_ctx *sctx,
>>> ret =3D -ECANCELED;
>>> break;
>>> }
>>> +
>>> + /* Freezing? */
>>> + if (test_bit(BTRFS_FS_FREEZING, &fs_info->flags)) {
>>> + atomic_inc(&fs_info->scrubs_paused);
>>> + smp_mb();
>>=20
>> The memory barrier before wake_up seems not needed
>=20
> Yeah, possibly smp_mb__after_atomic(), I took the simplest approach =
not
> to get distracted by reasoning about barriers.


smp_mb__after_atomic() is only needed before wake_up_bit().

No memory barrier is needed before wake_up()




