Return-Path: <linux-btrfs+bounces-1410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B9882BC75
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 09:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB3283869
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E55537E5;
	Fri, 12 Jan 2024 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUfRe1xg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BA4F60B
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4b9302191a2so430311e0c.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 00:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705049084; x=1705653884; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYMHmJtQdAgoROXZgLeOt+c8griRT7pjgpkzSRhbPRE=;
        b=FUfRe1xgxqqdCYP+AXViFOAtjYX/oFejRnuukKHtnLfvSQAKTy8KOyxU1sD/hCxlzY
         W0xcTfBZMpJbrb0+9oQeHpdRPjOGC24yOB8WRVTA8ZHQvfVTSe17ACHYNfwmfuqs1MOd
         9MhXO1MpFau/j5zhLmBSW8cCP18tTbuuOrl54QGeQE4B0KNMupqNnVHTThLpnmoIBcQ1
         dE9gLDHIntfjErDB81FC3M/eb0VcYyvu9+n87pBcfw2OmejqpDuh79l7Cfe1JmqvZheb
         F/C+B1RLiouDsL2PxF6P5wdr6lSUjyl2XHZokTRJzbJIsYlNLvaiCs2gKtel/Spyey4e
         6X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705049084; x=1705653884;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYMHmJtQdAgoROXZgLeOt+c8griRT7pjgpkzSRhbPRE=;
        b=AAayV0SC4xPMK9nGMAMHKu4rAYv4tG/j2eob6oSEjmOg3lPUQccoC/prgfQmRcSHOY
         SdbTJtlWZhRyy9Lwt0pGaK8p4pPXIOiY3oj0hJs+aO6RimZ0ZIHtwKWrsoPeFWDxD1L8
         PxCciGBVgzzDs6o1L4D3DYiKT9upmZPKEquahz+rpRS5+anSqT7f+rejfzdPQkBFA1qs
         KYs/et/ab/qeRtbVdBGtN3ss5fdHtyGaOb835IRhDExs6L5+FJy7CN0LqanqShAQ4IQV
         2RfnRlVE9WBd+7MJFWpk0f20mUFM/64cNWQUtMCgHjoBbKNejlFbhabeIeTRq/mUypEP
         I8ow==
X-Gm-Message-State: AOJu0YzDPnLb89LmUGoZ67KY8s4uJmF6evgQI+XTvqavhUfwv64Me1lf
	Gsiu1izNmH/XhoRC5I6EBjn5g8asSGlPh7Zaig8=
X-Google-Smtp-Source: AGHT+IFA0g/n91+eDT0aYTY6HQzC0CKsdP5XS2Hhhx55b2fsUlIVdcK2AOTMWl7ei7/fbfn5nxgth2Fsqaq3JBy38FA=
X-Received: by 2002:a05:6122:1997:b0:4b7:51e6:1276 with SMTP id
 bv23-20020a056122199700b004b751e61276mr793127vkb.16.1705049083485; Fri, 12
 Jan 2024 00:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com> <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
 <354d852c-0283-4008-ae20-e00788b8d5eb@gmail.com> <CAFvQSYRHFkjDEyd7rBUnpZm4oQe0MKd3jgkR8WPuK_2KPvSDwg@mail.gmail.com>
 <c81112ab-3111-4a1c-8740-2641f3862e29@gmail.com>
In-Reply-To: <c81112ab-3111-4a1c-8740-2641f3862e29@gmail.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Fri, 12 Jan 2024 09:44:31 +0100
Message-ID: <CAFvQSYQwa-=xPLK+DXzacHtL6u6LdNLa4Qsp+F1V_SDL0HYj=g@mail.gmail.com>
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrei,

> Correct. Where "btrfs receive" fails is cloning extents from the parent
> subvolume. The difference is that rebooting performs much larger
> modifications of the root-rw subvolume which triggers "clone" operation
> during send/receive. Your test runs basically do nothing. Post output of
>
> btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive --dump
>
> I do not know off-hand how to trigger "clone" operation.

I've uploaded the receive dump to:
https://drive.google.com/file/d/1aluawM35xFxm7Au4dWtUzBcXbM3hyK-P/view?usp=sharing
The dump contains 4 clone operations, seemingly caused by an
in-process database used by some kde component:

At subvol extern/root-ro-new
clone
./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-wal
offset=4096 len=61440
from=./root-ro-new/root/.local/share/kactivitymanager
d/resources/test-backup/database-wal clone_offset=4096
clone
./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-wal
offset=65536 len=147456
from=./root-ro-new/root/.local/share/kactivitymanag
erd/resources/test-backup/database-wal clone_offset=65536
clone
./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-shm
offset=4096 len=12288
from=./root-ro-new/root/.local/share/kactivitymanager
d/resources/test-backup/database-shm clone_offset=4096
clone
./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-shm
offset=16384 len=8192
from=./root-ro-new/root/.local/share/kactivitymanager
d/resources/test-backup/database-shm clone_offset=16384

This would also explain why it worked for the first boot (fresh
profile, db-files are created) and fails the second time (db files are
modified leading to clone).

> It is definitely "btrfs receive" bug. Either it should fail from the
> very beginning due to missing received_uuid or it should consistently
> fall back to subvolume uuid in all cases.

Do you have any idea why the received_uuid is missing in the first place?

Should I file a bug-report against btrfs receive?

Thanks a lot for taking the time for such an in-depth analysis!

- Clemens

