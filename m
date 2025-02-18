Return-Path: <linux-btrfs+bounces-11534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A172DA39D2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F401884824
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1177D2673B4;
	Tue, 18 Feb 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXEyiuTm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AE14B08E
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884458; cv=none; b=WmVaDNZxAvPWbOD3a88TngSQUxaUTuI4QsBgZbNvxHcofs+qHlAvvEnzS/iuvDAKIwSpkNb2oud8vCwH4ZGaxJuYcDOZynnPNok+Ba9ew9bz/U3UHiViICmlaMjPzXr1VMUUZbcnJ19nUM5ZLAXTC7Mo9XDXKzGSuHtetx+aX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884458; c=relaxed/simple;
	bh=fOJVsEULWhq7RiZwLDSqcTOyS1QP8wG+ioXchM4oYV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFwHaCIROKcx2VA0ICRCDr/WTJDQ7gtNBfawkTpjmry7ki1oY3DXHoc/Whdw0zqDM4UZBNZjL1gqYs6SB8/86nBmLQMlpjW1LPJHYNoj2VSH4g7jTMYQTbJPlipdCUZJlnU4icjj02Bb9tyAmrGulqO/GYDbR+ftzGfkwRvbqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXEyiuTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739884455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MprWw7ALX0sbGvyh/z63I/8/+N/AKAjED3g0e5IFNqo=;
	b=NXEyiuTmHwr8HfQt6QLcFGW9BAQ69oFsSmQJQxrY35ao4JTdNDXZGYNXah0jniCdx2P8PI
	62k/TlbcNMxXZ2DwKXz8hyL5KRcX9cadIDNz0dtA5ZYrpsE2YNOYwATft5c8ko5ihiMlPJ
	ZK2mNQE2dCEbjxgAlQ4YfVuWwy6ZrL8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-LKSU1zHWO4CEqp26Y-LSAw-1; Tue, 18 Feb 2025 08:14:13 -0500
X-MC-Unique: LKSU1zHWO4CEqp26Y-LSAw-1
X-Mimecast-MFC-AGG-ID: LKSU1zHWO4CEqp26Y-LSAw_1739884453
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220ec5c16e9so87549035ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 05:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884453; x=1740489253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MprWw7ALX0sbGvyh/z63I/8/+N/AKAjED3g0e5IFNqo=;
        b=nN6CdyzQb1lOTKkKwMQ8jGc7NJXjlI+i7L7ql5t4hO1U0yrBkLBerhPYXJFeZxyFH5
         KhwuGGEJbJCEFOg1yPb9hJUgRAzsHh+rnCHcBVZPTs3bdbioYhSKg10dPvkZzsRvSrka
         SMFLuTV7qIK4SqMqWVXATv5VMRorwp66HMwJxDl0uW8iy1uCqTN4dcFonpSdlnVWyMdB
         FhngY8XvbQeX4n0P61bf5c/uT+hPmfLvFzUOBiEtG4uGLSfv6ZbINV76Z9+FgCK8q9vh
         mWTaoXxAktDpktrsi68168yVm7UqWO35g/c/cCJRVjBJoEIl7KSnd5el9T0xU19OROWI
         DZZw==
X-Forwarded-Encrypted: i=1; AJvYcCUGZWWYLL+LWgolRxgZaIDnOA1g7dSt7MlGjh0ChPFhbxwVDLZMrQwrSEh1tHp4i/mQO7Ef0x8kL4ocBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyazGahmJa/fi9YuE1+rIj1DbRme6lz6sxWz0FqNT9bdeVhvV/r
	ceQVLyDSakPKfFC5If5HGFbJPaIUqcvN3hKGWBrIaRZdgjDKSdXzB69pJMiBKSZvnpsiZ/+XsxP
	pm78akuS3mPRApcJfswzHUdYAjdC9sbayhAof7S35LbhMJNDkjqlN5PUnI0sG
X-Gm-Gg: ASbGncvlcuXupePcZn9E6LSr+mi/LYVPM+4mNRHOCW4bGFNpzU3XsENSUWZCukBOdLb
	2hX9bUCBFNM9mrrNISHOZ+/ZMkUDSBOo+Q8NvFLP+ApMC/8naGKZ6jFjF7HdYuvMHvW0Z4LRJgC
	9nTerjXZlenwRSLsMVvEH19Qjb9zOSUqAthHjmpTQkfxcvsnDwquX7JE04/+NbBEtcU//bm2J40
	yDVEb0RuADZhGUWHs5iSka8YpK/xd/JKG/e3X682WFzAfI3S53r6NWrjHCntXq9c38C641CO3bc
	JWo0KKWOxLpo2TNu8s4TbHyaW8FR+2QBrYtn3Od9Kz0l3g==
X-Received: by 2002:a05:6a21:8802:b0:1ee:bf5f:81fc with SMTP id adf61e73a8af0-1eebf5f83demr6494442637.27.1739884452505;
        Tue, 18 Feb 2025 05:14:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdqbwMWub2rZiWUpq8eWWW7uZt4Xey/8zRCM8YHbpiF685U/L3NHtEPr9UKn+nmdSNolhV6w==
X-Received: by 2002:a05:6a21:8802:b0:1ee:bf5f:81fc with SMTP id adf61e73a8af0-1eebf5f83demr6494406637.27.1739884452099;
        Tue, 18 Feb 2025 05:14:12 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a92d1absm7862670a12.66.2025.02.18.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:14:11 -0800 (PST)
Date: Tue, 18 Feb 2025 21:14:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for master and/or for-next
 v2025.02.14
Message-ID: <20250218131407.nqb5dasvwqozvs2q@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250214110521.40103-1-anand.jain@oracle.com>
 <3b2a541f-da83-4658-a47b-8b8a1ea75b83@oracle.com>
 <20250218035111.vkdtzkjskutvpvqa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <5b0f6e62-128f-4410-9b45-90eb70b8f5e3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b0f6e62-128f-4410-9b45-90eb70b8f5e3@oracle.com>

On Tue, Feb 18, 2025 at 02:53:05PM +0800, Anand Jain wrote:
> On 18/2/25 11:51, Zorro Lang wrote:
> > On Tue, Feb 18, 2025 at 08:26:20AM +0800, Anand Jain wrote:
> > > 
> > > Zorro,
> > > 
> > > I wonder if you've already pulled this?
> > > 
> > > The branches in the PR below also include nitpick suggestions
> > > and fixes that didn’t go through the reroll.
> > > 
> > > For example, commit ("fstests: btrfs/226: use nodatasum mount
> > > option to prevent false alerts") updates a comment that’s missing
> > > from your for-next branch.
> > 
> > Oh, I've merged this patch from your for-next branch when I saw
> > you said: "Fixed. Applied to for-next at https://github.com/asj/fstests.git":
> 
> 
> Got it! Moving forward, I’ll keep the `for-next` branch up to date
> so it’s ready for you to merge whenever needed. Does that sound good?

Do the patches in your for-next mean "I've merged" or "I've tested/verified" ?
I think there're 2 ways we can choose:

1) If you hope I merge from your for-next each time, I'd like to merge the
   "tested and no more changes" patches to avoid the issue we just met
    above.
2) Or I only merge when you send a PR to tell me which patches are ready.

> 
> Also, the fixup patch for the missed changes has been added to
> the `for-next` branch.

We'd better not merge patches in private. Please send patch to the list,
even if it's simple enough:)

Thanks,
Zorro

> 
> Thanks, Anand
> 
> 
> > 
> >    https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/
> > 
> > Sorry, I saw you used "past tense", I didn't notice you changed it after that.
> > Please feel free to send another patch to do this change, there'll be a release
> > this week too :)
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --------------
> > > diff --git a/tests/btrfs/226 b/tests/btrfs/226
> > > index 359813c4f394..ce53b7d48c49 100755
> > > --- a/tests/btrfs/226
> > > +++ b/tests/btrfs/226
> > > @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
> > > 
> > >   _scratch_mkfs >>$seqres.full 2>&1
> > > 
> > > -# This test involves RWF_NOWAIT direct IOs, but for inodes with data
> > > checksum,
> > > -# btrfs will fall back to buffered IO unconditionally to prevent data
> > > checksum
> > > -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> > > -# So here we have to go with nodatasum mount option.
> > > +# RWF_NOWAIT works only with direct I/O and requires an inode with
> > > nodatasum
> > > +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
> > >   _scratch_mount -o nodatasum
> > > 
> > >   # Test a write against COW file/extent - should fail with -EAGAIN. Disable
> > > the
> > > --------------
> > > 
> > > 
> > > Thanks, Anand
> > > 
> > > 
> > > On 14/2/25 19:05, Anand Jain wrote:
> > > > Zorro,
> > > > 
> > > > Please pull these branches with the Btrfs test case changes.
> > > > 
> > > > 
> > > >    [1]  https://github.com/asj/fstests.git staged-20250214-master_or_for-next
> > > > 
> > > > The branch [1] is good to merge directly into master. It’s been tested,
> > > > doesn’t affect other file systems, and has RB from key Btrfs contributors.
> > > > But if you feel we need to discuss it more before doing it, no problem—
> > > > kindly help merge it into for-next. (It is based on the master).
> > > > 
> > > > After that, could you pull this branch [2] into your for-next only? as it
> > > > depends on the btrfs/333 test case, which is not yet in the master.
> > > > 
> > > >     [2] https://github.com/asj/fstests.git staged-20250214-for-next
> > > > 
> > > > Thank you.
> > > > 
> > > > PR 1:
> > > > ====
> > > > 
> > > > The following changes since commit 8467552f09e1672a02712653b532a84bd46ea10e:
> > > > 
> > > >     btrfs/327: add a test case to verify inline extent data read (2024-11-29 11:20:18 +0800)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >     https://github.com/asj/fstests.git staged-20250214-master_or_for-next
> > > > 
> > > > for you to fetch changes up to 429ed656f99c06f8036eff1088d93059d782add4:
> > > > 
> > > >     btrfs: skip tests that exercise compression property when using nodatasum (2025-02-14 18:35:16 +0800)
> > > > 
> > > > ----------------------------------------------------------------
> > > > Filipe Manana (7):
> > > >         btrfs: skip tests incompatible with compression when compression is enabled
> > > >         btrfs/290: skip test if we are running with nodatacow mount option
> > > >         common/btrfs: add a _require_btrfs_no_nodatasum helper
> > > >         btrfs/205: skip test when running with nodatasum mount option
> > > >         btrfs: skip tests exercising data corruption and repair when using nodatasum
> > > >         btrfs/281: skip test when running with nodatasum mount option
> > > >         btrfs: skip tests that exercise compression property when using nodatasum
> > > > 
> > > > Qu Wenruo (1):
> > > >         fstests: btrfs/226: use nodatasum mount option to prevent false alerts
> > > > 
> > > >    common/btrfs    |  7 +++++++
> > > >    tests/btrfs/048 |  3 +++
> > > >    tests/btrfs/059 |  3 +++
> > > >    tests/btrfs/140 |  4 +++-
> > > >    tests/btrfs/141 |  4 +++-
> > > >    tests/btrfs/157 |  4 +++-
> > > >    tests/btrfs/158 |  4 +++-
> > > >    tests/btrfs/205 |  5 +++++
> > > >    tests/btrfs/215 |  8 +++++++-
> > > >    tests/btrfs/226 |  5 ++++-
> > > >    tests/btrfs/265 |  7 ++++++-
> > > >    tests/btrfs/266 |  7 ++++++-
> > > >    tests/btrfs/267 |  7 ++++++-
> > > >    tests/btrfs/268 |  7 ++++++-
> > > >    tests/btrfs/269 |  7 ++++++-
> > > >    tests/btrfs/281 |  2 ++
> > > >    tests/btrfs/289 |  8 ++++++--
> > > >    tests/btrfs/290 | 12 ++++++++++++
> > > >    tests/btrfs/297 |  4 ++++
> > > >    19 files changed, 95 insertions(+), 13 deletions(-)
> > > > 
> > > > PR 2:
> > > > =====
> > > > 
> > > > The following changes since commit d1adf462e4b291547014212f0d602e3d2a7c7cef:
> > > > 
> > > >     check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE (2025-02-02 21:28:37 +0800)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >     https://github.com/asj/fstests.git staged-20250214-for-next
> > > > 
> > > > for you to fetch changes up to dd2c1d2fa744aa305c88bd5910cce0e19dfb6f41:
> > > > 
> > > >     btrfs/333: skip the test when running with nodatacow or nodatasum (2025-02-14 18:37:09 +0800)
> > > > 
> > > > ----------------------------------------------------------------
> > > > Filipe Manana (1):
> > > >         btrfs/333: skip the test when running with nodatacow or nodatasum
> > > > 
> > > >    tests/btrfs/333 | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > 
> > > 
> > 
> 


