Return-Path: <linux-btrfs+bounces-2169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B513E84BE92
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5476B28906D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0983C182AE;
	Tue,  6 Feb 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="QB/8wCXg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54917BCD
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250787; cv=none; b=bXGtdURV9+OQSDvDgBbZ5K39VF2P3PR8wVhfSpXZv2m7snx2KYsI60Mzr0/TGjMQvvUOz2pp1yAeplgaxiU0TzsUUvNcGoXP9h4ZGJ1UftK0oLVaZUvIQAGl4rbC2G6ByJy2t1ORwfKKViOnQQc3BOEC7xgFsO7P9mQCNGjcMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250787; c=relaxed/simple;
	bh=mbW+Okt/j6/lwp15YIoNo8wmn86hKYJ+9sGIGT6t5sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAj+F4Zt6OkiBzFmzej4E/j2A6st7mX+lhI0nl1LwXOVD0VKicEndlkyeg7YtyPtNDO8A6S37GXDmoL+ST1N365CUTDIG41vuGOE3wDbzNfy/uz0pev16Wyw7yrLXFXteyWOPHjh8kBiFOB21+JM9OpkalfGIwXmLVnWW+6JqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=QB/8wCXg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783f553fdabso77077285a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1707250784; x=1707855584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5m/l1S7KAMqFLhe4B861N0JJ3QpE+LEaEuywfNOOcg=;
        b=QB/8wCXg632w8UQ5zXszWcXlRCIUyvAjHq37LGID5AFvJrXQBpSat38dM81Rtyp2Tx
         gnwh427CDIjv5HPjVR4gjI+dm/QGUXa7gRMK/xY3rKhrkF++LKmyW5EHzCXJj04cvaII
         jq1UkcTw8iorkaPvbzlAAiphcx2B3rGTSBoU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707250784; x=1707855584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5m/l1S7KAMqFLhe4B861N0JJ3QpE+LEaEuywfNOOcg=;
        b=Cieq6TjoEF8BfLdjgesnUq5MVNd7LjkcpKMBsGBUAn19rirLkVLMZcDy7UWSCCK21q
         N5/EhHI8MtJdNkl7LpbGCPobIxGHpX7pRNGNZEqnx1lb+wacsX+qQYir6UMICG0evp9s
         vXhoC+sJLGov7LwYGXwmzlPzU1k4lgJhUMer8OCECEVEqH6yOv7D2mLDJBwOCrjln9UX
         gklRrDFnOarWBt/c6a44QmUWJd+C/7TmUQhiif+YYpCSIhI6/V9QHIKT2jXT99wokChZ
         dfuxhl+65RFh0t2WW/z0KZSg/FX1XuzJ4Q64g1eqdx2ir5hzztwLOfMN7WqZz+5bSqzr
         3mGg==
X-Gm-Message-State: AOJu0YwZDsTgNp67DqEBaf3LFxNkKq4Q+BEX8pvcguPAaPo8Bsr0sqpM
	XTO5XCQHlFwM1CRoeCSvN8+VsBZqpSCTkLNn9oa8HmtHAC3Zu8sMHydTHzmDSfIAGoksc2JqY5N
	wu9fqjCmulJ+lImRLLxjqB0bfpmQ=
X-Google-Smtp-Source: AGHT+IEyMB1DVXX+XV21B8UR7GIIEYgySsoMONqzlWFSwNjxcqUmUXOMDuDqUldAuj7wfq0EYvY5ceT9mVpBVHRIXA0=
X-Received: by 2002:a05:620a:890b:b0:785:8da3:5f32 with SMTP id
 ql11-20020a05620a890b00b007858da35f32mr5208671qkn.0.1707250784281; Tue, 06
 Feb 2024 12:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
 <20240206033807.15498-1-tavianator@tavianator.com> <20240206125114.GN355@twin.jikos.cz>
In-Reply-To: <20240206125114.GN355@twin.jikos.cz>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Tue, 6 Feb 2024 15:19:33 -0500
Message-ID: <CABg4E-=dZZ=D2HPQjqNJTTkqFOhx=sNzF0sA+J+W71bhH7ZrSQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
To: dsterba@suse.cz
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 7:51=E2=80=AFAM David Sterba <dsterba@suse.cz> wrote=
:
> On Mon, Feb 05, 2024 at 10:38:07PM -0500, tavianator@tavianator.com wrote=
:
> > On Sat, 27 Jan 2024 10:18:36 +1030, Qu Wenruo wrote:
>
> > Here's my reproducer if you want to try it yourself.  It uses bfs, a
> > find(1) clone I wrote with multi-threading and io_uring support.  I'm
>
> Do you use other fancy tech like io_uring? This itself can be a
> significant factor, other than config, host etc.

Nothing too fancy.  Actually it's reproducible without io_uring:

    $ make release USE_LIBURING=3D
    $ ./bin/bfs -j24 /mnt -links 100
    bfs: error:
/mnt/slash/@home/tavianator/code/android/external/honggfuzz/examples/bind/c=
orpus/9fb9c1f611ea4f2a92273d317a872a69.0000021c.honggfuzz.cov:
Structure needs cleaning.
    bfs: error:
/mnt/slash/@home/tavianator/code/android/external/honggfuzz/examples/bind/c=
orpus/9f40657d9a60bac7a329c42339c31397.00004436.honggfuzz.cov:
Structure needs cleaning.
    ...

The fs itself is 4 1TB NVMEs in BTRFS RAID0, stacked on top of LUKS.
The LUKS devices have --perf-no_{read,write}_workqueue enabled.

--=20
Tavian Barnes

