Return-Path: <linux-btrfs+bounces-8279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FA987D09
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 04:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0A81C2200C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 02:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0916BE39;
	Fri, 27 Sep 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Xe6xoxzF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EDEAC6
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404140; cv=none; b=ecui4wT8HBePQNFdu8NmUNc6+NSgUB5tLBe6taYatIzlEZZS/JPx8/5rWk4+OV5KGKeDqvFgm9PMrljNQ9NIBjX3fOTI3aZGmDWX/G331j16dGuOHgtwrx39uBMeXXsEmrSWK8hMBL7Is6HoB/CpfUE6TRllYc/48wYPBGA4TeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404140; c=relaxed/simple;
	bh=oq/qtkLpr/+29fU/MlYjAu0Om5azrkqjBpYTbzesl3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFfWlxB3I0/oO2zQpqe4aZP1D2AInm26FY2DGSqQLGcgsWHiXnBWLtIshPCuDVpG1cQzSr3pf/ys9SYQLeZmdmlfCLdBeUHk1NQ2qDEj8R9F2YbJ+sgjKC3zCbG0zZ/D8lYW9Mrg4YP9P94BmSHjKSF+9yBtT6MEuEpCMaxm6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Xe6xoxzF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727404130; x=1728008930; i=quwenruo.btrfs@gmx.com;
	bh=MI1eOm3j7VyBYr3IXFC4sk2liLCt87O7SaD8v7EJDhg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xe6xoxzFFf4SOy12rDztbArYPjZ/UofsW4pZkwq+IRubrajMC97uMpU0vcahCsZW
	 r5lrqZEg7jDeg3x5RMc9RYP5E7eSM7R1Sg/1t+JP/FxXgJrW5PBTYQlefbIbQPaU2
	 kPq7eTCYcZMF32FJtLoz6IlvanoNfLnTBUZ4GC4sD/ZDyDiJMAyJXQpwQisDm/yvh
	 ujyOLVG4IgyQqbmmhmQJi5Rn8Sf+kI4fKY3Xn4hoOLia0Vy6dCXMlpFIKJAGyfBoP
	 17uYJq6u2UW6VAkOp8iDKGqgxXdzf2sxNUcAXchVnWO4MGYyiHH14iHRJAXASz6wu
	 1DW7NEwoFDy8NY/7qQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ3t-1sOTjz0Wf7-00R0cp; Fri, 27
 Sep 2024 04:28:50 +0200
Message-ID: <bd3dc9a3-1134-4802-bfa4-5ba75c9c2bfc@gmx.com>
Date: Fri, 27 Sep 2024 11:58:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
To: Ben Millwood <thebenmachine@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
References: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
 <1171b314-be9d-40cf-b3ab-b68b03a96aa2@gmx.com>
 <f9062d51-946c-4142-9be1-ea8a2701592a@gmx.com>
 <82386baf-1cff-4590-8c94-7a0ffb76aa07@gmx.com>
 <CAJhrHS2n2Fjn+-5e1ukO2cCdH0etRf8Vh7nm-qPHtRYCzG2png@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAJhrHS2n2Fjn+-5e1ukO2cCdH0etRf8Vh7nm-qPHtRYCzG2png@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FpVqFOcTarjmwsWESkUaQs1tTXXkKjxZbnvqI/N6U6eOoYOxSfr
 npxYBj4vbXs8WbHVbVlmZpZBLsWOaeRf1X6np+M3m+wz3zTvVJXsC+HZV6Dp3KQa1qFDBEY
 w6j2Mmta6l81psKI+20qhXqJZHDi33/AzAR5lbHBO5Oa8pNHK0BTzjR9kWzLv1dZM2p9q7j
 3naWPEJ8Bvv2vEDJce2fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ImTGeRmly/w=;cSgpjVPdursetEBCHd4+KDPFDPx
 avPCsBrSdkVDZSQ6Akoln4EaWcLEY4dZ3gLc7jil3BBO/+Z7BSZxA8jNuRc6v/riFwy3r7lL6
 ida3OW5p2MWQvs8NXVx5CkPCxVM/DboYvygjlP1DQKJSIxGnHpOIc8GW1yBxdM20zRSv11B19
 uD2uTkKJoV3KtwEr55RMFo7P1lTbswBS01ilE3ni5GgEq4RCRByJfuuMQ1SBl7tSBIWDTC27o
 DKRxTXw/7njYbtEZEZDHYc6oG4RboawE2Axo0BMeN3t0INd1A5DFg+2W2U/+m/2Y4zFzl5AQN
 CNHVJWXXC91EIXyTvbBQ9FErD4RI+s8YRvVIiUZC9BniJjuXp3j6yqAI2TogkCY/MMSNJzVWR
 dtQYv0wmzW9K+MoqVQUZYIraP0N6mt7/8vYgeseNU0HVlBH4fGnGHFqI4tt7GsxsaN7ow00kJ
 S1MORHETyiE58nM4znpD6Wu7a4mj56KIrEPInMCH2s8/gNEsBN7RUBOR+BJprqhpwAtf0ERgE
 6Na1u4/TbDCTdeOq4kcsAEXMhfway+wTTIPPpzCq6IFvAmTZd5HVB0M3o95m3F2YQwy4i4Gqr
 6OKF26L/Ym3WSBPFcitGA9C8qymdBIqmM4KGcb3IB1NkwprfqjLPYf09ufcsEk5ZazeOnKhoW
 82iDl22HvQTbU8IZ62M5KVT467F7zZZH5FeelqymjSa8MM0JT2ua4CWobasa5E8tZl50gW3/O
 0C0VhTM5XCCdS01hAsuYxcF9tOnCO54v+xIJmidE3zhR7m8jTfW80/i5RrcflmZzEp8u2pPlM
 8szZSP736aRkdlr/k37Wg4Wg==



=E5=9C=A8 2024/9/27 11:03, Ben Millwood =E5=86=99=E9=81=93:
[...]
>>
>> And I believe the source subvolume has been changed to RW, then
>> modified, causing above contents mismatch, failing the receive.
>
> I'm not sure which subvolume you mean by "source subvolume", but the
> subvolume you're showing there is what I'm calling the "old remote".
> If what I'm saying about the send stream being incorrect is true, I
> don't think we can blame the old remote, because the send stream is
> only generated from the local snapshots, indeed I generated the dump
> you asked for without the external disk even being plugged in.

I'm rushed to the old common conclusion, but it's not the case.

It turns out that the send stream (or the way we interpret in receive
end) has a problem on the clone operation.

I can reproduce the problem with the following small script:

  dev=3D"/dev/test/scratch1"
  mnt=3D"/mnt/btrfs"

  mkfs.btrfs -f $dev
  mount $dev $mnt
  btrfs subv create $mnt/subv1
  xfs_io -f -c "pwrite 0 4900" $mnt/subv1/source
  xfs_io -f -c "reflink $mnt/subv1/source" $mnt/subv1/dest
  btrfs subv snap -r $mnt/subv1 $mnt/ro_subv1
  btrfs subv snap $mnt/subv1 $mnt/snap1
  truncate -s 4700 $mnt/snap1/source
  xfs_io -f -c "pwrite -S 0xff 0 4700" $mnt/snap1/source
  truncate -s 4700 $mnt/snap1/dest
  xfs_io -f -c "reflink $mnt/snap1/source" $mnt/snap1/dest
  btrfs subv snap -r $mnt/snap1 $mnt/ro_snap1
  btrfs send $mnt/ro_subv1 -f /tmp/ro_subv1.stream
  btrfs send -p $mnt/ro_subv1 $mnt/ro_snap1 -f /tmp/ro_snap1.stream
  umount $mnt
  mkfs.btrfs -f $dev
  mount $dev $mnt
  btrfs receive -f /tmp/ro_subv1.stream $mnt
  btrfs receive -f /tmp/ro_snap1.stream $mnt

The send stream only has the clone operation, but without proper
truncation before that.

This can be fixed from the receive size, but the send side may need some
enhancement to generate a new truncation or whatever.
Anyway I will craft a fix for btrfs-progs, so that even if we got such
stream, we can still handle it.

And Filipe may have a better idea in how to fix it in the kernel.

Thanks,
Qu

>
> As for the generation numbers indicating that it is modified, I'm no
> expert, but aren't those just the modifications that occur during the
> receive that created the subvolume, before it was set RO for the first
> time?
>


