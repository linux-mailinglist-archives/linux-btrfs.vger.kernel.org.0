Return-Path: <linux-btrfs+bounces-21748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFPZBpqplWlVTAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21748-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 12:59:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798471562DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38BF53017065
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69630F52A;
	Wed, 18 Feb 2026 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="NnyyPEs0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821B3093C8;
	Wed, 18 Feb 2026 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415952; cv=none; b=IlzbELoi7Dwi7wxf/FrCAiVx78IovcFOGv36E3P6CDBMbh+u0uEsbRKamAWGU82eEte11cHxJ4ak47yi0cu5kLHEu6mD6q/LJAqB9v7o9UeyVPJpiGfeqFWPNIl36t6OY8Ofg93zZwzO30eCy6QxEC7vmFL0/DCuPNUUKD9g3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415952; c=relaxed/simple;
	bh=O7vBxTw0t0r741vhGMYDJdjGQI99bM/OgWuY8gTCuo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROYnvM9GN8HsWh1b9BIFqbtkqgisDz1J7SkjI881nBsH374IPiOL2utQtj7nLeo+n+xDwR2aAcJ4oh79imEDN/QgeRJtmsxp4zeziU8bpqUde+mYs3Ssks7hThldTQv1aRdbPuDzQa10kF1s3dFeROcv6AYBQE481JAJ2RqIS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=NnyyPEs0; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fGFR708h0z9twy;
	Wed, 18 Feb 2026 12:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771415939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BduVbLiTr0Tm40Fw1fA35qNexfJUXCIRB7cdD1SW4MU=;
	b=NnyyPEs0YPSezJ0LWYW/XZtuTVzzboM9HI+FuN6Xi6XxWz7owOzNuYYOAuwBQD+nDqnMRx
	0CJLyujNAf0NVJ8gvLR7Vewh7/C2Sh+i22hIFROio1eBKskwgheLcz4EYPFZav2BQEiJ1v
	BiFDzFmpqLC39fw4PDRSITNhp0BHAUjeSpFqjS+Y3jD+MKvsHOJS79NOtvwsr/e7dQUvZd
	agzGXcn7WIgUD/6GWtdew4mh8lCHi4YCqj0QIjZuTzbtUc1JrNoYgw+WifnQ+Sw+HaDnAh
	PbXDIfDwRqFB3z+PnDmJA7O2ZX2LGBqxijFBqib2Gdz1gPKqDvlEEwG7QAd4VQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.com,  clm@fb.com,  linux-btrfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: report filesystem shutdown via fserror
In-Reply-To: <CAL3q7H4xgLyn5pSToEVj8MiqD4bohDwRYOMPeirqKQgCQ=pzfw@mail.gmail.com>
	(Filipe Manana's message of "Wed, 18 Feb 2026 11:54:28 +0000")
References: <20260216002806.3831884-1-mssola@mssola.com>
	<CAL3q7H4xgLyn5pSToEVj8MiqD4bohDwRYOMPeirqKQgCQ=pzfw@mail.gmail.com>
Date: Wed, 18 Feb 2026 12:58:50 +0100
Message-ID: <87wm0aw9dx.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.23 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.83)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21748-lists,linux-btrfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:email,mssola.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 798471562DD
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Filipe Manana @ 2026-02-18 11:54 GMT:

> On Mon, Feb 16, 2026 at 3:01=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <mss=
ola@mssola.com> wrote:
>>
>> Commit 347b7042fb26 ("Merge patch series "fs: generic file IO error
>> reporting"") has introduced a common framework for reporting errors to
>> fsnotify in a standard way.
>>
>> One of the functions being introduced is 'fserror_report_shutdown' that,
>> when combined with the experimental support for shutdown in btrfs, it
>> means that user-space can also easily detect whenever a btrfs filesystem
>> has been marked as shutdown.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Once the for-next branch is based on the next kernel rc that includes
> the new function, I can push the patch there.

Thanks for taking care of this!

>
> Thanks.
>
>> ---
>> Note that the for-next branch does not include the mentioned commit. I've
>> built and tested this patch on top of current Linus' tree.
>>
>>  fs/btrfs/fs.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 3de3b517810e..92fcebf5766e 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -33,6 +33,7 @@
>>  #include "async-thread.h"
>>  #include "block-rsv.h"
>>  #include "messages.h"
>> +#include <linux/fserror.h>
>>
>>  struct inode;
>>  struct super_block;
>> @@ -1199,8 +1200,10 @@ static inline void btrfs_force_shutdown(struct bt=
rfs_fs_info *fs_info)
>>          * So here we only mark the fs error without flipping it RO.
>>          */
>>         WRITE_ONCE(fs_info->fs_error, -EIO);
>> -       if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_inf=
o->fs_state))
>> +       if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_inf=
o->fs_state)) {
>>                 btrfs_crit(fs_info, "emergency shutdown");
>> +               fserror_report_shutdown(fs_info->sb, GFP_KERNEL);
>> +       }
>>  }
>>
>>  /*
>> --
>> 2.53.0
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmVqXobFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
Za74D/4p3GYGk/2UW94fT9/LFKI0TQPZk5Izx0fgTJMohXCAltaIjGfEeKjOfYLl
TGnxGD5dNcVWkpbUPMY8Jkau9oLbj1fTLYrKISkEblE/w/b/lSRmLKkKJ1wHP3Gb
bbNPrf/7eZyEs/nVIAoRFuiK7xKzRzViQYahqH072S9/DKKkmGwnYPSn0R+2opBN
LA/nvf5vGAfcPcS4N/JQJ81BYYNr3gQndJV4VlfJqf5ekrZV1rXpvfnaeUR+M/pa
baS3JpGz//xMwQYy9jBypc/Hd6eWx5rR3JSZKzYaEJH+d+6uLwfGKVYgZ3MIKvy/
K0zEhAIvlXtTp2zmPXQiaEzsK8enud7yMkE26y7r6Nw8Xi+l8BnhoD3iTrhkrNH5
9XGznJ5fwOlwtgzM4MXQdpMQpOshSNnfepskk+ySPX1wsZ9DRiqvdEWi/DI2e1zQ
5MZycbOrAg0MvxSUB1uXU0bVI8sRHa8dvrhJ1fLTxQWlol6pA6viKnFzEPc1KtQA
3amDwfR4PILGgJOP3vKY9Cap2pQ2TqGnmGd8Fb/9zTchDkNf6kwVApl/aPHxy8dI
l8YaJZukPlxb7l0ZrY2d990fFd92/fR473WaP/m9G79vhPvDTnHgsD7fTd/vwMUC
v5rLuYuf3gzC/8nfV7nL8v7uWCwYPK/Z0UMLFSzJ+7vj2Sfl7A==
=VPhx
-----END PGP SIGNATURE-----
--=-=-=--

