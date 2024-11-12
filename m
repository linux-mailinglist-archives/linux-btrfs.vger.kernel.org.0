Return-Path: <linux-btrfs+bounces-9564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF019C6573
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 00:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5901281D8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 23:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2021A6F1;
	Tue, 12 Nov 2024 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ekjlnsun"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFEF20ADC6
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455313; cv=none; b=Ojdq5VfyIc9C2yJ2XWUFmqOSVIXgxmctIaXNkQzeP5M9aekAF0xx4A9Xr92bbsgY+6eJsH6oM1m6h68/05KW+X296psRJE2LBPG9PbaQkbryhxp8vtzuh6x9S/pMJ5AolrSpN+C+15yhos15DNUPPXGItoXjHwHxuGL0gDWq0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455313; c=relaxed/simple;
	bh=PtUR7xHG3XzaDOKNcGaWg+AXTkiClAf7xGs2wsblnAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLeKsZy3ozUejTnMSamqxuTczrNmXm3b8SVnh1tCPcfsv13V27xvvWWSp98epvsKlEmXnVuFgtukXOZ6jeSf+baexQPBfDMgvqfosBJY6SH80WVGgwYsxwckXaqlbgkT5N8QTPT2ks8QDlcBPNWgpfl2ipYRoXNJPlJkCcYf9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ekjlnsun; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3697007f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731455309; x=1732060109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/tzxVfR0e9vh4jgAsTIRH0TxinS/T5igog/R3JqgY=;
        b=ekjlnsunHHzsc4JLqj6xj5ribIF0kQVMSrCNlN10H/w0fj13HfpYIMCsHXbawukDWG
         2CdW/E5unjw4BJglLzi7i9GuqQQihM+57ekEkjadjbHKdrMU53Z67RuNMJGZirfY2tPq
         ATgbHGQzL59DBWVTF9c9WFw+L8RfJu1nuqslk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455309; x=1732060109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cA/tzxVfR0e9vh4jgAsTIRH0TxinS/T5igog/R3JqgY=;
        b=e+ApJnxMlm7eueUYzi4OnrgtdE73SnT+9oFcUQ3weMMgppz1X5mevQlMWJrsx9oCD0
         BTyNrXfAvdPuKjNLuR9slYykHoJzdRRMq+fIdyUyWfTTEdJ0xq1OmjL8tjZr4eV61k8J
         BckWDEeudTUVtM1p4Y63Wkz6ENOaZ/f2aQyMiJnSvTBzN4hKG8uVz92O1lsUKBbXiPwQ
         JyuBAWnsnYJ7wUghZ/+fTAAXTdz9rCNrb2Wf8+plOdTiquWYIemCEnfl0pP5h9jkiOPm
         nNZxtsHUO8Jov+9Aeu5ed3kIZRXG6fL6lg/X/dmUjeXEhYm79g6LvounaCu6L1vdLmyw
         i5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCULabBmRoFFx+KfsBRfZOHiPFeqtUVPY5qMt8tlN4hM4mu6Kjzp+ToXq4kFJDGtpjGComfqqG6jGa9sKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjupg2MaGvUkS10k9FrRPO7YMWoeZeS7VsnFhXa2EyiwIMr/Ar
	DRo1J5cfxMEoljy/JpKpdH7VyVT2PwVpB7FpPg0XgygpcrjIob2W/8DYPSob5BIGUou8qv4S5Sg
	IoZPFpQ==
X-Google-Smtp-Source: AGHT+IFWCvV2s5I0sEDG1qOmaRJhrtTCgUOBRsUU7b/1IFlgAI+hr7/D1NcoqAyv8nU8QqYftDO5jA==
X-Received: by 2002:a5d:5f81:0:b0:37d:4e74:684 with SMTP id ffacd0b85a97d-381f1888c09mr15047597f8f.52.1731455309222;
        Tue, 12 Nov 2024 15:48:29 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5dbf0sm6501935a12.15.2024.11.12.15.48.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:48:27 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so8154569a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 15:48:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAWX8nUQdRm4zPqM9Pls9QMwDZdpY5CBRVPU3/hmvh5oNISJbhC0YFS09H994QUMRQeNq8FanmZySkWg==@vger.kernel.org
X-Received: by 2002:a17:906:4f96:b0:a9f:168:efdf with SMTP id
 a640c23a62f3a-a9f0169008dmr1114854566b.6.1731455306729; Tue, 12 Nov 2024
 15:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com> <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 15:48:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Message-ID: <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 15:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> I am fine not optimizing out the legacy FS_ACCESS_PERM event
> and just making sure not to add new bad code, if that is what you prefer
> and I also am fine with using two FMODE_ flags if that is prefered.

So iirc we do have a handful of FMODE flags left. Not many, but I do
think a new one would be fine.

And if we were to run out (and I'm *not* suggesting we do that now!)
we actually have more free bits in "f_flags".

That f_flags set of flags is a mess for other reasons: we expose them
to user space, and we define the bits using octal numbers for random
bad historical reasons, and some architectures specify their own set
or bits, etc etc - nasty.

But if anybody is really worried about running out of f_mode bits, we
could almost certainly turn the existing

        unsigned int f_flags;

into a bitfield, and make it be something like

        unsigned int f_flags:26, f_special:6;

instead, with the rule being that "f_special" only gets set at open
time and never any other time (to avoid any data races with fcntl()
touching the other 24 bits in the word).

[ Bah. I thought we had 8 unused bits in f_flags, but I went and
looked. sparc uses 0x2000000 for __O_TMPFILE, so we actually only have
6 bits unused in f_flags. No actual good reason for the sparc choice I
think, but it is what it is ]

Anyway, I wouldn't begrudge you a bit if that cleans this fsnotify
mess up and makes it much simpler and clearer. I really think that if
we can do this cleanly, using a bit in f_mode is a good cause.

                Linus

