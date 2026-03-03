Return-Path: <linux-btrfs+bounces-22195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIPXJpIZp2m+dgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22195-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 18:25:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722E1F497C
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 18:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A839F3030EAB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D113537FE;
	Tue,  3 Mar 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH00WyRm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B573264D7
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558605; cv=none; b=SDiysoEMuZbtbcqs6fCto6byhjdTZ/M15F1IEPzlPWs67iE7Y4TbGRRF3Ouctzde3VasKpHlyt1yY73/fBIEp96ghTO9uHW8AxG5EnOpxD0y582E32H9NYCZAQMcQgqgD5/NxdFyjAPpQgjse4DDsRJXyBVqzbjTWcdNnce6bA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558605; c=relaxed/simple;
	bh=PKzPKtYM4sbmzyVq82uGUSsTdLjU7RGTaQnrmWCw9ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJLSpJBPabdj9beWS4M0PFiFOIg747YMXQpBzMU9nxskcYI+WAo8++3gI60o4CB0+GYGWXudehJyZn/3ihX/eEZUSUdyaDX43Y2V5FhfSaKv8TUE3IUtPgnQT85GDXh39jKIPwviobtFiXXt4chzfIV9600VPwKHkwWYDA7pnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH00WyRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8EAC19425
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772558605;
	bh=PKzPKtYM4sbmzyVq82uGUSsTdLjU7RGTaQnrmWCw9ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BH00WyRm8gu1gUIwJdMGGpwcLJfJMw+/yK9wkrh3WdMRhYwlLWdGldIyjXQLxijmr
	 yNQjSNZC9UmGGwu0Pblg5rh4iQts0ZCZfmyWsQI+q3Ggm8BaiVqRUOFAMLulhTi3hx
	 6CAAm39MK5IoxqjVss781+IQDIw+x7x4WEUyUtcWekM4BL0OdVX+Rj4+hU9allx5Rl
	 REr+veY+nqDmNOcMjbyekcV0fVsLxmb2GFRdvrAL6ToFBWtepivLDDaHr14ze2ZXu/
	 ihX5+ShDq0u22GPc4p+EoRTMIQn2QAvbTW7oeYC9WYiRkumUgo0hwf8HVpI/8xoX4F
	 tD5+DTT6Cpy9w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65f8c8c3a4aso10993783a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 09:23:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNk2sL06R9ebyXzNDegf5uVcyoR2qaChUXN95klcA26fwiLuKPWT36gvHjlGGCIet7YsnD9m5miVKFaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2o5FAJ6ylKciKbJANEenI9+YM/gu5BuotPCEGct5qMWwUwDq4
	GfeiTEMtllpuc3Pq3A1OfVE5tVBfa0B97rWqy4jj+VJ0cB3rI2BIhryyRpMdW3gYTOd+G06RzTl
	tYEbnKw579YrgD1OR3pNQNsOmJ4wEtqo=
X-Received: by 2002:a17:907:7207:b0:b8f:a26e:dec4 with SMTP id
 a640c23a62f3a-b9376379d9bmr1054172766b.7.1772558603803; Tue, 03 Mar 2026
 09:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <182055fa-e9ce-4089-9f5f-4b8a23e8dd91@gmail.com>
In-Reply-To: <182055fa-e9ce-4089-9f5f-4b8a23e8dd91@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Mar 2026 17:22:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6a+C43SjrfqR2g_zu6pJ1e_rO3=XexkZzxn_qejRHaOg@mail.gmail.com>
X-Gm-Features: AaiRm52ZONI_tQW0yNy5RLoxfp7TFhIYFDTqgUwosTB0xsn3wsHxbC8qOht8zW0
Message-ID: <CAL3q7H6a+C43SjrfqR2g_zu6pJ1e_rO3=XexkZzxn_qejRHaOg@mail.gmail.com>
Subject: Re: Directory is not persisted after removing another directory and
 creating a hard linked symlink with the same name if system crashes
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0722E1F497C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22195-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:32=E2=80=AFPM Vyacheslav Kovalevsky
<slava.kovalevskiy.2014@gmail.com> wrote:
>
> Detailed description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hello, there seems to be an issue with btrfs crash behavior:
>
> 1. Create new directory `foo`, sync, then remove the directory.
> 2. Create new directories `dir1` and `dir2`.
> 3. Create new symlink named `foo` (NOTE: must have the same name as the
> removed directory).

It doesn't need to be a symlink, a regular file is enough.

Fix here:   https://lore.kernel.org/linux-btrfs/9a367f025abf4ea19c96aead75d=
206e129b2c56e.1772558089.git.fdmanana@suse.com/

Btw, I think you may have sent a message with one of the longest subjects e=
ver.

Thanks.

> 4. Create new (hard) link to the symlink inside `dir2` (NOTE: this is
> also important).
> 5. Sync directory `dir2`.
> 6. Sync root directory.
>
> Directory `dir1` will be missing even though it was synced in the last st=
ep.
>
>
> System info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Linux version 7.0-rc2, also tested on 6.19.2
>
>
> How to reproduce
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ```
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> int main() {
>    int status;
>    int dir_fd;
>    int root_fd;
>
>    status =3D mkdir("foo", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>    printf("MKDIR: %d\n", status);
>
>    sync();
>
>    status =3D rmdir("foo");
>    printf("RMDIR: %d\n", status);
>
>    status =3D mkdir("dir1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>    printf("MKDIR: %d\n", status);
>
>    status =3D mkdir("dir2", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>    printf("MKDIR: %d\n", status);
>
>    status =3D symlink("bar", "foo");
>    printf("SYMLINK: %d\n", status);
>
>    status =3D link("foo", "dir2/link");
>    printf("LINK: %d\n", status);
>
>    status =3D open("dir2", O_RDONLY);
>    printf("OPEN: %d\n", status);
>    dir_fd =3D status;
>
>    status =3D fsync(dir_fd);
>    printf("FSYNC: %d\n", status);
>
>    status =3D open(".", O_RDONLY);
>    printf("OPEN: %d\n", status);
>    root_fd =3D status;
>
>    status =3D fsync(root_fd);
>    printf("FSYNC: %d\n", status);
> }
> // after crash `dir1` is missing
> ```
>
> Steps:
>
> 1. Create and mount new btrfs file system in default configuration.
> 2. Change directory to root of the file system and run the compiled test.
> 3. Cause hard system crash (e.g. QEMU `system_reset` command).
> 4. Remount file system after crash.
> 5. Observe that directory `dir1` is missing.
>
>

