Return-Path: <linux-btrfs+bounces-9978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328D9DEDFA
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 02:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10311163E5F
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207DA2AF1B;
	Sat, 30 Nov 2024 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JE4DIfck"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D63171A7
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2024 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732929510; cv=none; b=T6LpLYVhy6R0U2EtBHxfWreMWRWQZ+3mTi28DZiAowdcGDOrOMJ3BhaMCHBB13fBfStnIZNQH9+CsG1Que/izVIeMYNk/NpUJ6WXmesyJt2hPMkIVbLA2LLGOa6jFWET3SaGmGRwk2UYJXRULh6dxak16hNGu4YEjpcXNQ/h8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732929510; c=relaxed/simple;
	bh=4DfTQjexnEh84bP8c0D3unwizHnWuEJQ56SFzSrMpwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nX7rd5i5Fd5WHWdaeiVkYmJHZYAGTa0iY6Qtfj+TffBsOUHFiRaxHuVChcBDeXtI0lMJseWDe8x4YzF2c0sd94GSVwamln32ciPZQ4t+rv+U2oZ444kSP+NL47fLClrotczgVjtKN62LhjerY0BVtyAzy/CFsxyM12eQRve6EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JE4DIfck; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XbbxIwV8xSG1xgLwX12IGD1uBxtNs3DGEOfEzD4ESxY=; b=JE4DIfckdDwdqUZhTmooLeE8ki
	1KZCD167OlECkDCsaf0P0dKr49Onaaf5my3Gzr5xnLzblaUsd1VlXFlWaZ8/lTGTyyRRbON+YaFcA
	lqcblfV/n00AxShMwLJyYHiF/P7XWxzxEXZ9EDXmSERB7x2gZ3WrLZzQVU4ofyYSwAQYi2AXC4EJY
	WSIfj2EZ30ET/givDeGgcN+kHt7f4JZQhmAZq7b0sni6WrSRSVhpqS/q0m3Jk5YKkoAp4k3IFLzAm
	UmzIBB+7C/KJueXFGGthhGu3WR4iyACqHKwZoz5adPMr5kszLTKLkJcOsMSHjyZH6cVOge9J10Rt9
	zIQxZjYA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1tHC0x-00FlcR-Vb; Sat, 30 Nov 2024 01:11:16 +0000
From: Nicholas D Steeves <sten@debian.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Brett Dikeman <brett.dikeman@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: corrupt leaf, invalid data ref objectid value, read time tree
 block corruption detected Inbox
In-Reply-To: <cfc9177b-ab53-40c2-b627-0045e9348938@gmx.com>
References: <CAFiC_bz7QpCE_bf0VdhV1x4NvQbgnxPDrtD=XOupPKA=N7-yZA@mail.gmail.com>
 <1748c8ff-30a6-4583-bdbb-b3513bc3d860@gmx.com>
 <CAFiC_bzov3zete3VabFQQMQ3rUS-TdHikNqRMUW_xggFmrtoNw@mail.gmail.com>
 <cfc9177b-ab53-40c2-b627-0045e9348938@gmx.com>
Date: Fri, 29 Nov 2024 20:11:05 -0500
Message-ID: <87h67pmspi.fsf@digitalmercury.freeddns.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: sten

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> writes:

> =E5=9C=A8 2024/11/27 09:39, Brett Dikeman =E5=86=99=E9=81=93:
>> On Tue, Nov 26, 2024 at 4:30=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>> Inode cache is what you need to clear.
>>
>> Brilliant! Thank you, Qu. It did mount cleanly. Shame Debian's
>> toolchain is so out-of-date. I pinged the maintainer asking if they
>> could pull 6.11.
>>
>> Is there anything I could have done that would have caused the
>> corrupted inode cache?
>
> It's not corrupted, but us deprecating that feature quite some time ago.
> And then a recently enhanced sanity check just treat such long
> deprecated feature as an error, thus rejecting those tree blocks.
>
>>
>> 'btrfs check' thought the second drive was busy after unmounting, but
>> a reboot cured that.
>>
>> check found the following; Is the fix for this to clear the free space c=
ache?
>
> I'd recommend to go v2 cache directly.
>
> You may not want to hear, but we're going to deprecate v1 cache too.
>
> V2 cache has way better crash handling, I have not yet seen a corrupted
> v2 cache yet.

Let's avoid a "btrfs is the only fs that ate my data" storm.  Would it
be sufficient to provide free space cache v2 migration instructions in
our release notes?  If not, would you be willing to write something?
Alternatively, should this be automatic, and in-kernel?  Debian users
tend to have long-running installations and don't tend to reinstall.  I
think you'll agree we ought to get ahead of the thousands of users who
have v1 cache and who ran mkfs with btrfs-progs as early as 4.4 or 4.9.

Most users will migrate from a recent 6.1.x (close to kernel.org's)
directly to 6.12.x (what seems to be the most likely LTS).  Many have
also tracked the stable mainline or have recently upgraded to 6.11.

Beyond that, I'm not aware of any format chances (other than some new
experimental raid56 stuff), but it might also be nice to know if there's
a threshold where it would be better to reformat an "aged" filesystem.


Kind regards,
Nicholas

P.S. We'll fix the ancient btrfs-progs problem before the new year.  The
current issue is where "strong package ownership" processes slow things
down.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmdKZisQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYROLD/9ew/oM7Meov4jAqL4b/9FkF3EIMr7AHAPX
3ow8qpv8CueHgwG32n5g7sx4wVxVC3e6vYcTRc0C6Z3MR1QH5m27ycSE8u2YgTUH
vl4bzDeqGJXfNfOB49/9uwjFUx2vvnxJ7WKi8enxCykM1UP+o7vt3kBccrJwB070
G9qgD/uDTMTR8PHrEb5wx/x/cbcLRQoTUdkSNVfx5w0bHpuq8ygROYAIAdYpK2Hg
L4O2jneKjx79vC2HhK3rdUnU0DoEStTuj3uw4zVaUsRpjCrQWZKdKvKVcyyoYgkl
nPvgXaF30GRnTjslE4IOutD6Rhmlje/+k0NTcP/cI/tkTDtu/zo+eyCIP2ClWx4/
uGvMcX+2f9NHRDm2Zxw9vMiP9Fjrkx9fs65q8EX3S6DYT0IhkWghQ9cIUeGfkh0p
vZ1hCxRzZ/O0CwIC38RLDoc6nCwgZMHEbylvRo0hQfQ3WaZAP55chcg7Qge4tAN6
A8C4Gag1fZ7iJP63GfanCJTB5PXTvM99wEwPFXPVQNGMyTgIzv/vnT16s3eO+Q/U
4t3idN01qShNCWB2FuT7iG+oMPShjQBLCZj9LYPZJBMZ/A2HKEJFHu5LBZHnNgO3
qG9FXGCC4TrRhxaZf1Lxuh1W2C3D3jw2HhBlPqyldc9elaQH4Obhq+yIAbo1siyg
XD8Acop32w==
=S5M3
-----END PGP SIGNATURE-----
--=-=-=--

