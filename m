Return-Path: <linux-btrfs+bounces-17304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C1BAFDD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316CB16AB2C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D42D978C;
	Wed,  1 Oct 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM7JbC5q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F2283C9D
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311029; cv=none; b=NrMfMx7T/NIgTCjtN+hDKURUgrGlDCCtCb8OxNNB/586U7GagNrmjA5BVyGGYSLnjBzqjNXJ5NullRM747xyDYYGInn9KBKtdTQb8j+UYN7cOumqsBCVZGsAPJXzeXmmuyr3u3/ToqqfSicoEIBHLGjBIyxK7RU3FY+WOxgTdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311029; c=relaxed/simple;
	bh=by7N+HHnMNskEYe/in24Qoi6GnbrXfkmltX2igZhzfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJqRJdufV4MCw7wBhPXCJR020ZeTgc70YYiK7+K1g58HcURe7cKmBA0ADOQme+dL23tmLBuCxlGTfC0pl7jjMxedbB/EwxZSxKUSHcyqpSricN/qjFAKwnRCtzBX0r8VEafFUSXVNAPvBZIVrD+AyzEJlomwbM8uEoYOuZfFYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM7JbC5q; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7bc626c5461so768395a34.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759311027; x=1759915827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by7N+HHnMNskEYe/in24Qoi6GnbrXfkmltX2igZhzfI=;
        b=QM7JbC5qoY2ZLKrrSykcJEYH6iDtGoI7E4xHc6aDmRc2YZPIp+TZH6kcVlpnOvJYzR
         BgXveC/PQBNyEWIY2qgaII8bGMAzVdq9jNokw5dO1I4PO3tg1Iy2I3Gt+7CFOl6X8Ctq
         3zo45IAuAoHz+lmhgllIxGlZZLUuGqIJjT+dYWfkmuK3yVIV8FNIoDR5nxaJLcymY4Na
         GmgZjxy/tiuCwfOpqKBmUNELasNUnhrqPFyjCmY2sACR4blj+S80efvtuYC1aCBuc1hz
         ZVtmPiQ/Aw5PK1PAiWYkCncWGJPm2B9Ne1UJeIbGf5omNI+MPOryfIztmuA5IHd57+Qk
         zr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311027; x=1759915827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by7N+HHnMNskEYe/in24Qoi6GnbrXfkmltX2igZhzfI=;
        b=I0Tlaa0QTOnDV1ijpEkhn+LeRfoHeKrWVTMNH6IG4wCyrnPW/oTXxRaCv43KlZa5n3
         k1nxGt0yfQcFUR4TzJpYWqHZ8VK+meLHRZkrEU5AwbiFRVCw/242cAaqEDgja1XTVLHo
         iEHG/q7xH5kQ2nuj3CS3TqES5VRIYpdgqIIb+n2Epq6rCGZ/t+feZ6sFm6SzxpS/zgvP
         17AVURxpq3YB+sfy903DM3xsH6Hy2dgvnSXGbFngXyX7qnOe0mLmQrcnKNn0ozel8aOM
         sl88SXVeest6NDx9z5ePvUBBywRpO6W34N1NZYB6qn6x9Iz9M10hurmoCDMLucHhL2zA
         iBcA==
X-Gm-Message-State: AOJu0YzwxjFTP7EIrCEr92QxXIR0d3O8ftsOE83uHFix9deXB7G+LwCs
	CCWpM9VVLFH1KyPlrTOJMTpWv5k5B+vDsvnWV+tiJJsRbIb8F6H35+YkcIas0859larG2c3ehT8
	PG9X0zUx7yXmqKYFSpkJqUdQTvuzaYQZ96pQjPZaYFN4M
X-Gm-Gg: ASbGnctAdlm9PnqcSNqDuZLZLGJWtRFIO+2Ikj/rG2vjJEGu2zd99p8CEHBWw18KibE
	4ehjKLiUIKm45IQl7aCXsK/VIy07QJ86j1FFs5N2ztCf7eh6Qm2gUmZlMPv6U+cmZYGxktU5mnJ
	yYEHeOptHf4atUrRro3f/GFFzYEjlyYFqfL7R7v3+dvdXRsP8zmrabnWay82kKCUntLQZQXMoGO
	TmE0FpQKxkPoDDB1oM56EMLkNxcJQ==
X-Google-Smtp-Source: AGHT+IH9GEmj9Ifes8SHlEUzKYnl6HK5Cya8cK+5b6N52Vg5OICVwwyOw7jXts8MuBs1Dvxv1apl7Xcy4VmVgyzvjQs=
X-Received: by 2002:a05:6830:650a:b0:746:dbc7:e3ee with SMTP id
 46e09a7af769-7bdda088869mr1421126a34.4.1759311026766; Wed, 01 Oct 2025
 02:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsPW5P16tN2jX7dkL8FiwKOfSMc6bExZZhjuUzBaBwnLNw@mail.gmail.com>
 <ce039910-3354-4054-aa3a-940bdbcf30b1@gmx.com>
In-Reply-To: <ce039910-3354-4054-aa3a-940bdbcf30b1@gmx.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 1 Oct 2025 14:30:15 +0500
X-Gm-Features: AS18NWBSBthRdqWAZJoYsumpU1C6YSqeB2kiCFnF2jLH7G5k9yEnlmzHrPNtyB8
Message-ID: <CABXGCsPA6wmq+hE8DRj7j7J_MAYh95=hR6wqG3+FdFTd7g+b1A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_btrfs_rescue_chunk=2Drecover_aborts_with_=E2=80=9Cscan_c?=
	=?UTF-8?Q?hunk_headers_error=E2=80=9D_on_a_healthy_single=2Ddevice_FS?=
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:14=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
> Overall you shouldn't trust chunk-recovery tool that much.
>
> It's a very old tool without much active maintenance/testing.
> (The existing testing is just to make sure the tool doesn't crash on
> various fuzzed images, no guarantee it will work correctly)
>
> If you found a bug, we can try to fix it, but overall it's not a high
> priority tool.

Hello Qu,

Thanks for the clarification about the current status of chunk-recover.

I would like to be prepared for the case when a Btrfs filesystem
becomes mountable only in read-only mode. In such a situation, which
rescue tool is considered the most appropriate today?

The reason for my concern is that a friend of mine recently faced a
hardware failure, and he tried to use btrfs rescue chunk-recover. I
repeated the same steps on my healthy partition just to be ready for
the future. I know that having a backup is always the safest way, but
with a ~30 TB filesystem it is not trivial to keep a full copy on
another disk of the same size.

> We need a full binary dump (or at least btrfs-image dump) to verify and
> debug.
>

As requested, I=E2=80=99ve prepared a btrfs-image dump of the affected
filesystem metadata (about 30 GB, compressed, download time ~40 min):

http://213.136.82.171/dumps/nvme0n1.btrfs-image

Hopefully this will help to reproduce and analyze the issue.

--=20
Best Regards,
Mike Gavrilov.

