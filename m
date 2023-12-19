Return-Path: <linux-btrfs+bounces-1050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D38182E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 09:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30245B232C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF53111C88;
	Tue, 19 Dec 2023 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPhoypVS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B158F4D
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e3803643cso484647e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 00:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702972831; x=1703577631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNj6siMS+J9hF6dAp+cyvLWWJQ6EtIt8Ys3LHD1houA=;
        b=aPhoypVSOKoy0TJUlJhHIUl9jEmhBV0pafbBF94fe4E7X9Sw531aZJdt2S9yHYrUhJ
         HNnMc/FF7FlQ1AguM/E9onv7M29UhgaODSK43dBOFDOobqJmG43t88q7IN4YOaFMP8Hh
         rmwmKah2qK4DTQxHExwIS9q2gdTL+l4HgKHCKrlstCoQex3LWj4Gjt4F2Yi6ajgqMTNY
         A3m21H8UmOTE1fRWLxhmIYMHaLSbGN9arKppMaC67FzhgPJoRl0nzNTCi5p3ocXVtvcw
         2eNYfCGczpdkbgS+Afzbvrn5u/5FikkbiQIshShgM9Str+0xzFWQjCIURMhyxRxJdQ86
         WA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972831; x=1703577631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNj6siMS+J9hF6dAp+cyvLWWJQ6EtIt8Ys3LHD1houA=;
        b=k5GGXZqT4qk5qbZd/hmHgD/liR2Wy5RsArkPyg/xJIWoYXlX5oXCo7ujb6U4TGSJeX
         yBv6bLvqKt7T6ibjv4ZBth58z5gtcWZBaMWk/Z7B6Z4ShchJ4w0cpmzWIMyBRZMsYw5J
         YfI+F3kfvpLT1uS/jLvocXW34J8T5gRHpbW/obE1CgAZMP1OOYoREPN7//8YNo3DEt78
         BNjnOkG5dL4BusKJODPqkkaOgGCLhTDd+iNlqP/Vh1eclvvtiViNu5nAKCY3xpmFvrDR
         LlgPBU7KCWmyPPkq9maTTrOkEjcE30BmFkWDYffZ2NPhFOzJVahGbKKDbm5J3v9Z8f6g
         9Tgw==
X-Gm-Message-State: AOJu0YwNIa8JUOsqWEaLN4GUlgyYPoBR1iTZHeXEj71bZb0ZpWQBWOwN
	Oq+kUZ+RudDmlT5BblRLO+ixC7cRj0l+81pCLKI=
X-Google-Smtp-Source: AGHT+IGZGNewYHiJbtc3eFCCh7rnorMGp8GQSuE4JlB/C2FZ5oxarlvUglA1vxMsSOa5CQs0l2yd3WFobT4zP/VjU34=
X-Received: by 2002:a19:7604:0:b0:50e:3fc6:ef3e with SMTP id
 c4-20020a197604000000b0050e3fc6ef3emr1663386lff.4.1702972831134; Tue, 19 Dec
 2023 00:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000a01da32ac$ee868d10$cb93a730$@cdac.in>
In-Reply-To: <000a01da32ac$ee868d10$cb93a730$@cdac.in>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Tue, 19 Dec 2023 11:00:19 +0300
Message-ID: <CAA91j0VOftw9z_7Eoms49idvF9NWqu4eRk6MqZRj=B=SQmJ6Lg@mail.gmail.com>
Subject: Re: Logical to Physical Address Mapping/Translation in Btrfs
To: saranyag@cdac.in
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:18=E2=80=AFAM <saranyag@cdac.in> wrote:
>
> Hi,
>
> May I know how the logical address is translated to the physical address =
in
> Btrfs?
>
> I have read the official documentation of Btrfs available here
> (https://btrfs.readthedocs.io/en/latest/Introduction.html). It is not
> covering the address translation part in detail.
>
> I have also gone through the Btrfs source code
> (https://github.com/torvalds/linux/tree/master/fs/btrfs). I could not fig=
ure
> out the address translation from the code also.
>
> After referring to the following functions, what I could understand is th=
at
> after getting the logical address of Chunk tree root from the superblock,=
 we
> need to convert it into the corresponding physical address for parsing in=
to
> the next level.
>
> int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices
> *fs_devices, char *options)
>
> int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>
> static int read_one_chunk(struct btrfs_key *key, struct extent_buffer
> *leaf,  struct btrfs_chunk *chunk)
>
> Any hints or pointers to the documentation on this is greatly appreciated=
.
>

Current btrfs-progs has

btrfs inspect-internal map-swapfile

command that returns a physical offset on the device. You could look
there for the implementation.

