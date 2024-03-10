Return-Path: <linux-btrfs+bounces-3158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B2C8777B0
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 18:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07201F2160A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE3383AA;
	Sun, 10 Mar 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chngrsgl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE71D6BD;
	Sun, 10 Mar 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710090546; cv=none; b=knYI0GzGzgMZrmE+55m1/MAywR+HM655NJ+9IOVIqb33Ll18/T1HDvcLUuDGUPR3m0EkRBD+pATJwMyHWVPKEQOOmqmloCXMTkf6NVWl6j8OdfivncRS1T0Vq54REQp13J4y+L+hRhENnjRy4L1cPEmz0JLHV40zjtt4FHo1n/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710090546; c=relaxed/simple;
	bh=QeBArc98gNceVCiAzt+Zh+AJ56g7clTlWkaToNoAZYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNe82R1sB15v2M5DVeE4IgEIB7bsqkKNGFDhqCXnVOJG2IKSDhoOaSzywg5vQSWG1V+LhlqMZvApRnIPpOO3FOVMCJJIpSjLk4DEYnv5jo+UzdlRoxKxJM6NU68BkyzJ2ggnaZz1+Ic0FE1Ks1KTrV69YjJDMgKB68B8knlFzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chngrsgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76719C43394;
	Sun, 10 Mar 2024 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710090545;
	bh=QeBArc98gNceVCiAzt+Zh+AJ56g7clTlWkaToNoAZYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Chngrsgl6PofedBkgopm/G9T8pYO/NwBIfoCJ1vUtmJK5pM3OfYAIjSmuuDoo72Mm
	 BsGlNW63T6iLoVDXqxx4pSfKZsYgO25vbMbCoESomypY/FLZqCE/JUjdegXSnuLvTZ
	 151qNTTkEJZafxk5VJrxNPT5l3ereZVoWLQ+ieIyNiln1TyWepiv6SIXdZfq89aIUy
	 976jxGPKQiZV2iQvi15CVK6N6Kbzw6zflZZ4cfbtDzUBO/V6+Y8pWcXfdt1mztKY6C
	 LWjHZOjAbnfN7WCM/DIzYMCskri8FIrxsxCNZdTQE/b5gED5DWjmFS5giw7/z+3A04
	 gXrUtTTAxGnGg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so338081066b.1;
        Sun, 10 Mar 2024 10:09:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVun47M/AKSruMBkLqYPyVh72Wz9KzmOXmxUeZwJlOvzb2yfjqBBz84acxlTCAZzchhhPKrGzystBHSXP7kJLDeSMPEfi28gjuRZyMqcOMdXew9LiqAGqybraUO0ZQejj3oBKR1
X-Gm-Message-State: AOJu0YwIpVhD6LxrzJ+qnBS7kRXHxqWh6qT1xuV+LPLkaBp/YcE800lM
	zzhCnrChIMoUwnr5XfflYoIMlCqSy5TdY1XrVXHknNHDlFGOjLoTjYXsPiqSHsEmU7/c0NAcY7t
	V4mjbU6u3Si1Wv6AeL+ul1ODJvbU=
X-Google-Smtp-Source: AGHT+IHydvY/oyoXkMX6CDqu3RBRMsHeek7U10tjVF1swbiJP75o6SIGVqt22m3MGWcAMEW9ZCHXBUBh6TUFZiY4pCs=
X-Received: by 2002:a17:906:7084:b0:a3f:804f:c1a4 with SMTP id
 b4-20020a170906708400b00a3f804fc1a4mr3074617ejk.74.1710090543839; Sun, 10 Mar
 2024 10:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308144537.16995-1-anand.jain@oracle.com>
In-Reply-To: <20240308144537.16995-1-anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 10 Mar 2024 17:08:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H69ec3URubLKdqFUiWfjRjQ=CaYtN=75eq4jMDggudtJQ@mail.gmail.com>
Message-ID: <CAL3q7H69ec3URubLKdqFUiWfjRjQ=CaYtN=75eq4jMDggudtJQ@mail.gmail.com>
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.03.08
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 2:46=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
> Zorro,
>
> Please pull this branch containing bug fixes.
> This changes are based on your branch for-next as below.
>
> Thank you.
>
> The following changes since commit 9b6df9a01ac8ee3f28a2a24d71e45792e21b6d=
48:
>
>   btrfs/016: fix a false alert due to xattrs mismatch (2024-03-01 19:24:1=
6 +0800)
>
> are available in the Git repository at:
>
>   https://github.com/asj/fstests.git staged-20240308
>
> for you to fetch changes up to 9a03e88a04b6cf6e161c8902a3a523ca22601277:
>
>   btrfs: test normal qgroup operations in a compress friendly way (2024-0=
3-08 22:31:51 +0800)
>
> ----------------------------------------------------------------
> Anand Jain (1):
>       common/rc: specify required device size
>
> Filipe Manana (1):
>       btrfs: fix grep warning at _require_btrfs_mkfs_uuid_option()

David's review tag is missing for that patch btw (and it came before
your review and cherry pick):

https://lore.kernel.org/fstests/20240307095908.34913ff0@echidna/


>
> Josef Bacik (8):
>       btrfs/011: increase the runtime for replace cancel
>       btrfs/012: adjust how we populate the fs to convert
>       btrfs/131: don't run with subpage blocksizes
>       btrfs/213: make the test more reliable
>       btrfs/271: adjust failure condition
>       btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
>       btrfs/291: remove image file after teardown
>       btrfs: test normal qgroup operations in a compress friendly way
>
>  check               |   6 ---
>  common/btrfs        |   2 +-
>  common/rc           |   9 ++++-
>  tests/btrfs/011     |   9 ++++-
>  tests/btrfs/012     |  14 ++++---
>  tests/btrfs/022     |  86 ++---------------------------------------
>  tests/btrfs/131     |   4 ++
>  tests/btrfs/213     |  20 +++++-----
>  tests/btrfs/271     |  11 +++---
>  tests/btrfs/287     |   4 +-
>  tests/btrfs/287.out |   2 +-
>  tests/btrfs/291     |   2 +-
>  tests/btrfs/293     |   6 +--
>  tests/btrfs/293.out |   4 +-
>  tests/btrfs/320     | 107 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/btrfs/320.out |   2 +
>  16 files changed, 164 insertions(+), 124 deletions(-)
>  create mode 100755 tests/btrfs/320
>  create mode 100644 tests/btrfs/320.out
>

