Return-Path: <linux-btrfs+bounces-16683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14B9B46375
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 21:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A307BC183
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB3225A29;
	Fri,  5 Sep 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYQKnnl8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C156315D34
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099932; cv=none; b=CeecYXYbAmZSlw/uRK8WGpNsxxJVZst/axuE/Yx6YFU12YppiswUDNyz+lV2xNFeSBj8+Prw4ndhlAVyq1oNywQw3eaxOprfiKTSlV+0qjFERlrzkgwbNWeA4Fp9pGzwbqxNj3NkN7VvikM1aYHQnA5SBCXwr3G9q9jq4salsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099932; c=relaxed/simple;
	bh=1M/7xkcbFfINk6fD8w/UjDmniGW/uYILZAVvut7l1Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFauygmMZmEuDlztlh7Hf7kMSMsdzZtdU5K2geDsHOB4qg6+C6hvwExnJimnvul5w96u80+8izYgDxnEXDCKKGSdIBVUmINuCIr63hZeogDDKQKuODKhjqX6n+OKzAeKWX1Oy22LWllhEoCqMB0J9A+GUtX/zrmHl0zvZ9z425o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYQKnnl8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6aef1a7dso2639441e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Sep 2025 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099929; x=1757704729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0doefFCdQ7re4YcEg4ldg/y03Caac6S76xmyehZ0/w=;
        b=QYQKnnl8ovbg0f1VTvHUBfSbmxaz7RSbYuEFT/BrTuLLCZ5/lf7OnJPNZXSUFc/s9K
         A2m54wOUEWfhrGd7629Kpkc7GFzFCw1RVpcyigH0AjIloKqlmnIeLir1xtHhwORbUNhw
         XiNDr1NGMj1xcChiyefsMcTGu+vUjOfdsi+4Ht/EJ087btnpEGsk0vXaQKk6zZMdUOLK
         wFFcUyJp4zKOT5CZtXyihc1ZV5Ia4ZV0hYWr1PX4Jv+2vck1gKoknV9u4sZM8faqIE3R
         ZATW8rufre0tOyCXRfcn3/LuEOh8YebMbFhIbtz2hQYGkIG8kL68b9q9h6y7HfR2XpkY
         U20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099929; x=1757704729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0doefFCdQ7re4YcEg4ldg/y03Caac6S76xmyehZ0/w=;
        b=Ge0ktPEFIgqbw97u6lhXl+2Wmv9FLxALnzmBf+YuSrIORkaGiIkuAgJVC71UuYblkw
         Ctt4jN3nj4yaim5KxpHUVwYk2GdrE9GAtsNCnLMFmpouW03uT6QpYoE1pSoThe6uomzC
         3dlusywxdTGM29KIKXNy0U09rzrRyEiJfzIffhUpeIL4ramXHyiPbxLYN8LXUxeZAkKA
         7sAgyHOQT1pfrZ+YzDD3jJDL4ld3GtmLlLceGSZZwC8lspo8pH6Zj6Ws7j5embORL+Ma
         XP3PqPVWAEsNt1iAIZjpZzZFbzOL7I0ALfZ5/NE2T112Gc3SYnvwlu7wbH+UaYgPMYwu
         suWQ==
X-Gm-Message-State: AOJu0YynpwgMjF7ikKzvES6quHsViYBt9htOyPhB9AsYnLBGuy44vpEv
	zU6SozuJErX+ibkIHJt4noM52ixracEMfkiVznWbv0KppJPWErq886obm35hxHL7PVsU4UEcHwI
	hxrHWG3Uhhqkz4sJY49RIaXHeteDyoLxliEMI3Z4=
X-Gm-Gg: ASbGncvWomgRAomkDCItIVvf/3X/v1/JjJRy3zawKK28u6wzdRA0t1UHmioR4JFoBj5
	ZWVLNRFJXpCQnAFI29B05RiIv8UH3rZDJcZtYESKlz3KnIp8tsLQTvERxWzmefGZsVNNYWzdpQ2
	vf59au5mv39m8eS0Fbpt5lRF5jRosu+K92jmuY/oBRvBBD7ZLSRe5Gaqrq0h5FAZz8sR9Emlhp8
	5uV8cKCoDeq+eQn5g==
X-Google-Smtp-Source: AGHT+IHF6nTYLvODbzOGIJ1LxfhmCz/Nri7Cx+Ov+PYZS5wOAbFCO9QbiBXkR1B/31djsz2d7CNT9nFLQcwxEblB7IM=
X-Received: by 2002:a05:6512:3da9:b0:55f:4c1d:47f3 with SMTP id
 2adb3069b0e04-55f70995af4mr7613649e87.28.1757099928984; Fri, 05 Sep 2025
 12:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALRiM0xL5A70zuTgBFwCW94RQB7JV5ssaigwg7jxh6=tfEZyhg@mail.gmail.com>
 <5b037515-42da-476f-bcf3-d6c50f70f07c@suse.com>
In-Reply-To: <5b037515-42da-476f-bcf3-d6c50f70f07c@suse.com>
From: Charlie Kernstock <cakernstock@gmail.com>
Date: Fri, 5 Sep 2025 12:18:37 -0700
X-Gm-Features: Ac12FXydpO85NXmCnlRkUCv0vn33xBKZOb19uRMp_-PN7hDTlLRxKzo08n7RYVY
Message-ID: <CALRiM0wd-B2PkY2uxCosFnPra3mbN2bAYg0P5y7fWyZ1gp_c8A@mail.gmail.com>
Subject: Re: Need guidance on btrfs: uncorrectable errors from scrub
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:41=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> This is not a good news, metadata checksum mismatch normally means the
> metadata is damaged.
>
> And it's a subvolume tree corrupted, data loss ensured.
>

>
> Because it's not a data block, but a tree block of tree block.
>
> Strongly recommended to go with a liveUSB and run "btrfs check
> --readonly" on the rootfs.
>
> If the scrub is to be believed, there will quite some corruptions.
>
> Thanks,
> Qu

Ok, I've run this and captured the output to a file that I've been
looking through. I see a few hundred-thousand lines starting with
"unresolved ref" each with a dir, index, namelen, name, filetype, and
errors.
As far as filenames, I definitely see a lot that look either like
files that would be included with an installed package (such as
"application-exit.svg") or they are 62-character hex strings followed
by ".file" or ".dirtree". I don't know about the latter, but I'm
hoping the former isn't too difficult to restore somehow from my
package manager? I suppose that depends on what rpm-ostree can do and
if I can get the filesystem into such a state that it is able to do
it.

If you know of a way I can determine the subvolume of any of these I
could figure out if any lost files were in my home subvolume and
restore what I can from backup?

The entire output is 93MB, so I'll just put the end of it here:

ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p8
UUID: fb00ec73-302d-40b5-9a71-4a0953084453
The following tree block(s) is corrupted in tree 258:
    tree block bytenr: 320173096960, level: 1, node key: (54090, 12, 534)
found 944146264064 bytes used, error(s) found
total csum bytes: 916577720
total tree bytes: 4966449152
total fs tree bytes: 3382689792
total extent tree bytes: 485736448
btree space waste bytes: 929096928
file data blocks allocated: 1247096827904
 referenced 1100989444096

