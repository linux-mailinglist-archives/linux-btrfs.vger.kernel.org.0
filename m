Return-Path: <linux-btrfs+bounces-1292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1755B8265F1
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85831F21497
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2011714;
	Sun,  7 Jan 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkWJSd7E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D611702
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7cc92a83200so181604241.3
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jan 2024 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704659390; x=1705264190; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwvMUnb+jp/Ho7pkgi1eGBzvJcINxJlplKWuW8zhDf0=;
        b=TkWJSd7EnIOlA4C4ZguG/y33Hrct5yxeIBPKTycvXnAMZ2z9nrQgVRPJXK9qX/cTKm
         GP0/lpKt/Tx8sPkCPJVKZAbCwruY9S6Fd+42pniKIf2cQ7fti1IQPp7cuqjeXN/x7nL5
         DijQFJPYC+9PE40FfSvdHgFyZdpYgIcKk8682fO67dvdBVrnlHz+/sgtUwzEKbIWKpg7
         ff/vjTy47a++rDY3TcuPGD5kVh/EC6TWfoE7QvCJvkglFKPoZ0krimYwfUrmWPC0T1TG
         e0ezTPvppDOjOgDMlOO2Y27X7G8fh25MsZiDg8mG0azrrnH+xT/OOfzoRwpXmOr+j4wJ
         Wdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704659390; x=1705264190;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwvMUnb+jp/Ho7pkgi1eGBzvJcINxJlplKWuW8zhDf0=;
        b=Ps45CSgIOBECtXlaL317mO+yXgM0ni6bPmLMrmGJLcdieZ91fKjp18e8pNpTSVzkgd
         uRxm63k92ZNEENPSltlmlPAPjOXg87KE2nTydj0xt9Cz5RBprbTTNV+UUBjBBvNHqsbX
         +DybAHc0NFoeF2VxQO4fdlzty7uuXsKksRrh6t1UYMZuummuG818wydJ+tFLOKQvWOQ8
         1VqOYN5/BBeH9jbAfQ5JL8Athzm8p58rkj21jQ3rwZCNUsE7nr9jvBmv/VHK7gk0+uXE
         /tknazzZyYUKibD8EklMevuebhbLrHUIVxVqZwPkXdZ0CfE3kF+hgUo113q/Bpji09ZN
         lBWg==
X-Gm-Message-State: AOJu0YxKpdpwj49HFmd9yGAjWlfg4m1us0MwSYzEb6SsOpM4eFaIl7TD
	51cOzl/DNDKE6uy1hAn4y4jW6ZBFf2ATe6jsKzG0Jpw/+G0=
X-Google-Smtp-Source: AGHT+IHHuljcjMFcNICeWsNwzPsqxf/6u/gSg8JeOdQkM5XxpNp0qMb0fyX7ke5HyG6zUKczrNWfiRgzSUcJLKcwl48=
X-Received: by 2002:a05:6122:999:b0:4b2:dd80:4db0 with SMTP id
 g25-20020a056122099900b004b2dd804db0mr286882vkd.32.1704659390030; Sun, 07 Jan
 2024 12:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <20240107123746.GF28171@savella.carfax.org.uk>
In-Reply-To: <20240107123746.GF28171@savella.carfax.org.uk>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Sun, 7 Jan 2024 21:29:38 +0100
Message-ID: <CAFvQSYRWiy57QxFfHu6g7KRt20Lc87KTTZByUdRSDchtpk4Amg@mail.gmail.com>
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hugo,

> I'm afraid that btrfs incremental send/receive is *only* designed
> for one way backups, as you've been using it up to now.
But it seems to work perfectly fine as long as I don't actually use
the subvolume as rootfs.
I still wonder what is so special using a subvolume as rootfs...

> It will not
> work for bidirectional syncing, and no amount of gymnastics will make
> it work. If you want to do bidirectional sync, you'll need to use some
> other tool like rsync.
But why?
What is the technical difference between on-way backup-style transfer
and using send/receive for bidirectional synchronization - isn't it
just applying the diff between two snapshots in both use-cases?

Best regards, Clemens

