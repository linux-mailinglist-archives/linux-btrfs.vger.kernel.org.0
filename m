Return-Path: <linux-btrfs+bounces-9456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC69C489A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 22:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA541F223FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FEC1BCA1C;
	Mon, 11 Nov 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EoSEoCog"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DB1BBBE0
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362155; cv=none; b=FnReuDHtuT4zj5xJQrYGX3zMmSFZ0ekSXmkj/TlYj1vrlqlhkaaQZoRptU8+cFXc3bEH/ZSN6cnLdChGgues+SJ/njmIEjErL8gwPizc/OjbDpskshV0d5fu6YH6MaxO8YQnX5+mqBwVMDgqVOUBXd1DEysVzpfuZSAolXUfm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362155; c=relaxed/simple;
	bh=SZIQDa8NLYM1ipFkY+LfWhNba2RshbH0DPtK6JH9h1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p94i63tYkz5Gsmt4MzO1nyeNu7s3LI6vdW1PjsOfbh/NxulwjaF0gdI/sOip++Y6OC7S/8YWeFCOPpXdmTnHCdBwIl5qD+r6XySutv3TI1TP38ehDq5Q6ayB8zShuobTpx8FZ7+aRiD3gb2oxxs0zmDNKkybB5wKDiOXQZMKP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EoSEoCog; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d51055097so2975114f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731362152; x=1731966952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yUAbMKFGFD+r6n6bBm/WiyB3YmOPXFQ3bg8vJC1p2Q=;
        b=EoSEoCog0SnIj1X5HfbyxumZ+u8awpO/7mf3viFIucmnBVpP6bewav/EyCK7Iydi5G
         Rn+WxBmh/DCAsLg7EMjIJdLT1GOVZBYOiU7CtM0r4rmtWeV6W0ZmhLiDa7Pc7YJ+6KZn
         Ltm1CiYJCPFsiEqSH2aWzKuWLi0DBNW+UElmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362152; x=1731966952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yUAbMKFGFD+r6n6bBm/WiyB3YmOPXFQ3bg8vJC1p2Q=;
        b=IkIHlHwHhPsNVcfittaaeoYukJyELp15/1rkcQdGmhIHH2aIk2Ja6qAO01VYwVpaLF
         XfrZwDVBajyCl5X4od20go7pSAqJYQTDkaivPODsHFsHbLDjkPdBDVMPKch7z2cTVg+Y
         DTXq5Fcgbv8BryA4KvkAHZRvKU7tIa8ndcSNqgakQB39TJsIoUDPw9Smu4pJxeU+4m00
         3sdrk32TddVeHZjvzASNxEUikYDARgOj4SR4oHjNycenIZoAr1NBl1fPbgquCpCzD+5P
         c3r3Dnt5PgmeoQM8IpH8xacrtQE0gDd1hUXBv7K8aOrRzNYi941uYNSfe8/JbshqNQmK
         GSng==
X-Forwarded-Encrypted: i=1; AJvYcCUElpD9HnUGi1a9rc0XXbh125bjWv9ADgjm25OU8mBNnYAZPMwA48BXTL2YkFWnhAw+kaLSGUrWo3OFyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXekK7ccZsEhf08S/D+Jbd26B9cZYg7vSxPQlIhTTxl4HeBW2
	3AoHEDH2BPXIZjy1772KLChSA4heYkFvu0Qhaoaadpcu0kSUu3z8t0nw/eXwoCN4QnXEWmxBZXT
	1zeM=
X-Google-Smtp-Source: AGHT+IE0JVz1c3BlahO3w0+Ao24nxO1BXkuYz2bR+pSqvyOh7kW8LiLgwX9nSZ48nGl8lvXnBSWmJg==
X-Received: by 2002:a05:6000:2101:b0:381:f5c2:df24 with SMTP id ffacd0b85a97d-381f5c2e053mr7391501f8f.57.1731362152000;
        Mon, 11 Nov 2024 13:55:52 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7ce0asm5280156a12.85.2024.11.11.13.55.49
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:55:50 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a628b68a7so899016466b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 13:55:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5sOBXSoqGOExnST+08WyRPzSkedP8okT8M68nFefVZM2i9MonPpDJdQ3PegQxPywMM/523Nwi5GWqRw==@vger.kernel.org
X-Received: by 2002:a17:907:eac:b0:a99:379b:6b2c with SMTP id
 a640c23a62f3a-a9eeffeee33mr1449197766b.42.1731362149380; Mon, 11 Nov 2024
 13:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com>
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 13:55:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUDNooQeU36ybRnecT5mJm_RE_7wU4Cpuu7vea-Tgiag@mail.gmail.com>
Message-ID: <CAHk-=wjUDNooQeU36ybRnecT5mJm_RE_7wU4Cpuu7vea-Tgiag@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] fanotify: add pre-content hooks
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
>
> - Linus had problems with this and rejected Jan's PR
>   (https://lore.kernel.org/linux-fsdevel/20240923110348.tbwihs42dxxltabc@quack3/),
>   so I'm respinning this series to address his concerns.  Hopefully this is more
>   acceptable.

I'm still rejecting this. I spent some time trying to avoid overhead
in the really basic permission code the last couple of weeks, and I
look at this and go "this is adding more overhead".

It all seems to be completely broken too. Doing some permission check
at open() time *aftert* the O_TRUNC has already truncated the file?
No. That's just beyond stupid. That's just terminally broken sh*t.

And that's just the stuff I noticed until I got so fed up that I
stopped reading the patches.

             Linus

