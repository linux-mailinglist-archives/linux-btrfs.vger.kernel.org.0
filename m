Return-Path: <linux-btrfs+bounces-176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1357EFE70
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 09:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6061F23241
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDCFBF1;
	Sat, 18 Nov 2023 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTQmjxvp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8054D51
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 00:05:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so5208294a12.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 00:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700294729; x=1700899529; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DY0FHTcMAh1OFYh90a9Sx8VtDkeLZwJ8/9NkbWKndqs=;
        b=jTQmjxvp7ewv34stsrLFI69omxp7ZICUjBRrvypBYFgDpit5Ti7PBX+lV0/MIBm/eG
         7kM0eGkb3Q/UDxL1aQn+YUsm8e2AJ+dldonP9IEEubafSrlnbXhTBgE7mnpJNz1i+GTz
         +fUeRE0/gh+i/axHgJmIW+AvPG0ThVJNoJmiUFABplI+5W35OaGPLZuz1ry1KGz/Ybna
         YqIpG7BaFTUzUC5WmF9ZSvyo5d5Hk/AFcERoyAKEJgbX1UbXaUjcdDu2oPFkClh6M+ir
         XabZQ7EEbey7EVC3fzteg5ceLSB/gXydelWS4RUy2lG51Qtm4q9KQAK8HIPe0z6eRNUc
         hGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700294729; x=1700899529;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY0FHTcMAh1OFYh90a9Sx8VtDkeLZwJ8/9NkbWKndqs=;
        b=hnw2Ruu6qc60OEbi3gF6PW5usZ0vc7rOyzrt9+Z+GrWRDudG0dnPBFk+zmayI8Q4ma
         q+sNyUZyKB5hy895ZBiN3yj50dBWrHdj7v4i/s9B0T7BVuF+WpP7F6nqVfApGnfeJs0h
         Nk4nlPFRxQeD6e6bqa93SzasLfvlum1wrG+saexODr+rLxaS5IIVm4dwj58dtqo5++9I
         iCjamszmpdMy5+JLd7+AhB+Ke3F9o7rZE3fpp8QGYXKjgAkpA4dOiS9BMU3K6bbyVmUF
         6pty1GXZx1hoVB9QpbPt/TNneN990Ii9mIdT1yyEhD+ubm+9LwXYZbSOfhl7UuK+GNy2
         ArQg==
X-Gm-Message-State: AOJu0Yw4oaTCpvnKs8oQiGnFv5ZVYi8T79mpaGDbzPUW7sgku1ypCCl3
	x4xHH8eOPoJS6BGgosjSvqN4vju2EkU37mli2OmQ35fa16M=
X-Google-Smtp-Source: AGHT+IGMGOoPXC2GYsQX4DUejtBls3KTZ/7mmTwKEkjMcnPZn/SDe/1A7vXADuWRsotyRoirrM7Ay99jFUB+jVxV8UI=
X-Received: by 2002:aa7:dbc3:0:b0:546:d6e1:fbf3 with SMTP id
 v3-20020aa7dbc3000000b00546d6e1fbf3mr7125089edt.1.1700294728859; Sat, 18 Nov
 2023 00:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com> <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com> <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it> <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
 <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com> <4bf1d0d4-6fc3-434f-8166-7a628d48d52f@libero.it>
 <9f955c4a-82be-98cc-6f61-ee5469c32ba2@georgianit.com> <cecd43db-da2c-4558-b343-4faabacdf0d8@inwind.it>
 <CA+H1V9xqZT7L0tj3JTyJscXLKw-tpSE0qNULbg4hn0wYq4fhxw@mail.gmail.com>
In-Reply-To: <CA+H1V9xqZT7L0tj3JTyJscXLKw-tpSE0qNULbg4hn0wYq4fhxw@mail.gmail.com>
From: Matthew Warren <matthewwarren101010@gmail.com>
Date: Sat, 18 Nov 2023 03:05:17 -0500
Message-ID: <CA+H1V9xA8_3-BYkhR2ip0v1_-bKxWY1hHW1kRwoxhaCNu88PYQ@mail.gmail.com>
Subject: Re: checksum errors but files are readable and no disk errors
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> I think that we should put everything in the right order:
>
> - COW:
>         preserve data and metadata even after an unclean shutdown
>
> - BTRFS with NOCOW:
>         preserve metadata even after an unclean shutdown
>         data may be wrong
>         depending by which disk is read, the data may be different
>
> - EXT4 + MD (with a bitmap)
>         preserve metadata even after an unclean shutdown
>         data may be wrong


If you put MD on top of dm-integrity you remove the issue of data
being wrong since you get checksums for each block of data. Since
reads of data with mismatching checksums results in an error, MD is
able to determine a non corrupt copy. There could still be corruption,
but it is reduced.

