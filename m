Return-Path: <linux-btrfs+bounces-2852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EF586AC2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 11:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBCD1C2448A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 10:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E155A7A5;
	Wed, 28 Feb 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N36002g4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AF5A790;
	Wed, 28 Feb 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116145; cv=none; b=M+55vD+Ldxh3hXghUtDg1B0/BllcqLOSiPR1Yh90+0zyZHPNlmz+psM6M6V/9cGpFxqSvxCWdg1BJYRUUIzwktZmJlooKQmSv2KpgWHgVdiR+NEfngbYdprle4S4hsYk3IRc/RdwIaV0cwzFtjmop4q1sU80pQ8vC2RHEzZdTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116145; c=relaxed/simple;
	bh=bgXkCNcAwGRsvspbOB+kweA0y59MktOs3ouIM0K6BeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pv6nX7KOoPNXW+iWGAQ1qdoyqKUUiBCi6Jfd2Z5onDbD+2LUkeLIYVz0zfA7ci/Zuf/8CsWwNIShw5elvgqYTNI4MWZqzKvuznhMY1B0ANLAJNaF4GKyQrU/qKCkFvIIavMlANuDUtZSX751jWVWEDLIeIsU1psb11b85TIpjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N36002g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4D3C433C7;
	Wed, 28 Feb 2024 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709116145;
	bh=bgXkCNcAwGRsvspbOB+kweA0y59MktOs3ouIM0K6BeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N36002g4Qok1DN5xOIAvrqkuwvXOUOIdBGbH/O8EHjAA7V2t1WoL2XvvKCci0Ojfk
	 zPgUOz3MtUwe9P/nBQjPFhEaTNq+TbeZ+Opp6K1fjDfSsOoZjocWDeYp+RKICkHPTS
	 GjpdIMr4PqUnmwEI0zk/1bplXwzt+Mqnz+z+urAP11WpGIUb4CYV+3y7NGNqN0YVIH
	 tTFyNK9OGh6tcNhy29LhxZbeqALDbiiHlVenn00MAenfRM05fYcvY286maHaxN9Ozs
	 jYELGb2qOQQHO/8nAjqs/P118NTmaWL6MVpzLQImp3vbx988REV+4UdTbKGu2okd7d
	 T2wsaEzdYjEug==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4348aaa705so419047266b.0;
        Wed, 28 Feb 2024 02:29:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEsc2QoOV8PamS1XP8L4AzitGVjJqRgwMBduaArBTOLZXgiu5bu9HJ4CfTgr6Gl+wsFQ5mQ1KfKIIYNRVZfN8FlTElFzPCR7qEZWY=
X-Gm-Message-State: AOJu0YxqyzHMeBmq0sCLrGrh3dxId45JlBENGyDVhCvUKuVY7xOZ2gNI
	wgMHUWb5uLcCxDSliULPfWGtKpjGgcEbX0sgG5rraxFE5VWU4S9PZUOGGGhoHkSKV/CMJfKsDZe
	21N9E3Ju4tHrdRnSTkUTk/QBtzYc=
X-Google-Smtp-Source: AGHT+IF1omxV3916bXmqwMnDhAXdy32KxWvdcMAkxCh7HgpjTtvjoV0I130Ds20n31PR30bONi6NL/jQqNBcFvM8fng=
X-Received: by 2002:a17:906:d204:b0:a43:da8a:9ec9 with SMTP id
 w4-20020a170906d20400b00a43da8a9ec9mr2154114ejz.68.1709116143741; Wed, 28 Feb
 2024 02:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <3fe54b69910e811ad63b2f0e37bd806e28752e8a.1708772619.git.anand.jain@oracle.com>
 <CAL3q7H4EdcvJm4jAD+5-zm-WVAoaHhyy-9Q_1-P5pOWk_f6m=w@mail.gmail.com> <e4416120-e682-4a43-b79e-a930838bb64e@oracle.com>
In-Reply-To: <e4416120-e682-4a43-b79e-a930838bb64e@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 28 Feb 2024 10:28:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H56eR0BW_BW08i6+sfQ3VHyh2S7DuffNRob6GVEWDSFQA@mail.gmail.com>
Message-ID: <CAL3q7H56eR0BW_BW08i6+sfQ3VHyh2S7DuffNRob6GVEWDSFQA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] btrfs: create a helper function, check_fsid(),
 to verify the tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:36=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
>
>
> > function should do the require for everything it needs that may not be
> > available.
> > It's doing for the inspect-internal command, but it's missing a:
> >
> > _require_btrfs_sysfs_fsid
>
>
> Yes, it did. Actually, check_fsid() would need the following to
> cover all the prerequisites.
>
>   _require_btrfs_fs_sysfs
>   _require_btrfs_fs_feature temp_fsid
>   _require_btrfs_fs_feature metadata_uuid
>   _require_btrfs_command inspect-internal dump-super
>
>
> I already have v4 with what you just suggested, I am going to send it.
>
>
>  > Instead this is being called for every test case that calls this new
>  > helper function, when those requirements should be hidden from the
>  > tests themselves.
>
> However, I am a bit skeptical if we should move all prerequisites to
> the helpers or only some major prerequisites.
>
> Because returning _notrun() in the middle of the testcase is something
> I am not sure is better than at the beginning of the testcase (I do not
> have a specific example where it is not a good idea, though).
>
> And, theoretically, figuring out if the test case would run/_notrun()
> will be complicated.
>
> Next, we shall end up checking the _require..() multiple times in
> a test case, though one time is enough (the test cases 311, 312,
> 313 call check_fsid() two times).
>
> Furthermore, it will inconsistent, as a lot of command wraps are
> already missing such a requirement; I'm not sure if we shall ever
> achieve consistency across fstests (For example: _cp_reflink()
> missing _require_cp_reflink).
>
> Lastly, if there are duplicating prerequisites across the helper
> functions, then we call _require..() many more times (for example:
> 313 will call mkfs_clone() and check_fsid() two times, which
> means we would verify the following three times in a testcase.
>
>   _require_btrfs_fs_feature metadata_uuid
>   _require_btrfs_command inspect-internal dump-super
>
>
> So, how about prerequisites of the newer functions as comments
> above the function to be copied into the test case?

Calling the require functions doesn't take that much time, I'm not
worried about more 1, 2, 3 or 10 milliseconds of test run time.

Now having each test that uses a common function to call all the
require functions is hard to maintain and messy.

Commenting the requirements on top of each function is not bullet
proof - test authors will have to do it and reviewers as well all the
time.
Not to mention that if a function's implementation changes and now it
has different requirements, we'll have to change every single test
that uses it.

Thanks.

>
> Thanks, Anand

