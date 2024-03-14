Return-Path: <linux-btrfs+bounces-3304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A587C232
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2769283FC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B91374BE4;
	Thu, 14 Mar 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="VODHXjQd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83A745F0
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438290; cv=none; b=vBqk7HhPXbtHu1/jWtLnISWJgcu6AQWJqAiHAzEKmS/pInEqk9bkEBq0Rvkz64CdvrzA+Cppr0/a1HNZFd4K2hcYproQiN1ywdHIzj03XhmyTQfhVWhQr/dCqRZIg8p9wC48hcrCrbpxo2xawTbcjEeg1s7/7SgY2bE75ZEP6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438290; c=relaxed/simple;
	bh=L54psGCygvnYflBpfiUGY9c5jVp0kA+1gH6oFs8VSwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb5itI2uWE6d51QJUQWYSEZ8u+e+IPQeiS62m8r2Ft0EI8SyxggimK1RHsLsDcmsWNJrfz5IV+0nhAuBxII7OUuFVrd78hsDE0TCcwEUOe5JdziRVJPXx5fAkcR910SkIIZj2YAclUFS/VhDGpKrn5tivHQNWTQa7VvRLSJMuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=VODHXjQd; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6916bf4707cso938596d6.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1710438287; x=1711043087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7kXWJJOyCxkrhH16fNrlRflwzvYVayFCTPqbGS4Du8=;
        b=VODHXjQdWrboksgeVcV5u43TKF5WAcdwHEvjpUN6SSapbFExwK8Gt9U2MMBw8KX4UE
         Eh22JOMCKQXkP+Lp81aX9kEYQwTI2bZ+dmFKl8gKGKo254duqYrr0ItFKnBhDrGsraf/
         Wu0YNczVprqtus5J+q2BRpL09ps2cru2RfZrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438287; x=1711043087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7kXWJJOyCxkrhH16fNrlRflwzvYVayFCTPqbGS4Du8=;
        b=v9R6EK1nHwWtDtkAbmPLiVSfvkepHFiW3iYFrpLB2bvzgLpdJfZVUAur/EVyDnSFWM
         8WzWBqGEC2hqAAiAWlpAH5KA6wBpVyFQf+vl738eLvZNw9xYsdTIUGSBakKbck0HFOWl
         xEEg/G13mmxDeWzXHVavoXhnwFdWEJDJQlqmPs38SU9zxfk1Xu1tfXDojiCkMxmZb7OS
         qv8TK1QIroTn7GkZbyAssPuOyX5OngVjmyschNrsT4qBS3Ec/f17rZSnRomBOV5KVCvZ
         t6xNXL2msQUxlPLZEjEFEa3RWTFEHJXLn0h6kasizXe0gYL9gheiirk8lYGsT6HhrzXs
         vgrw==
X-Gm-Message-State: AOJu0Yzg33cht64UIeF9HP4SrIXcaGMaDfEr5ck6sBiVq2KZzjbz5Obt
	t2uAB676BOYNotBOoIfblLylS9tyWm53vD0XL3e0oTGT+lpGCXVc18Xdd3R1JfJ8+awJZOHD+6g
	O0IN/vT8SvsGaR/3pP+ItNZUHvptHnwxSD6c=
X-Google-Smtp-Source: AGHT+IE5QGyXOvhzZppMDw4teaj1PDPzxPA5oJAepqEjaNS72382i/jHP2eAKUZPM549cJeObq+KkOdCje2XFCPnn5k=
X-Received: by 2002:ad4:4e70:0:b0:690:b66b:c43c with SMTP id
 ec16-20020ad44e70000000b00690b66bc43cmr1489593qvb.24.1710438286953; Thu, 14
 Mar 2024 10:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com>
In-Reply-To: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Thu, 14 Mar 2024 13:44:35 -0400
Message-ID: <CABg4E-=y_rCMSsA8=T7zXzfHJwNLMROGpVbKOW68jzLqLcTLGw@mail.gmail.com>
Subject: Re: About the weird tree block corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> Hi Tavian,
>
> Thanks for all the awesome help debugging the weird tree block corruption=
.
> And sorry for the late reply.

No worries, thanks for your help!

> Unfortunately I still failed to reproduce the bug, so I can only craft a
> debug patchset for you to test.

Good news: I also failed to reproduce the bug on the latest
btrfs/for-next branch (ec616f34eba1 "btrfs: do not skip
re-registration for the mounted device").  It was still reproducing
the last time I pulled btrfs/for-next (09e6cef19c9f "btrfs: refactor
alloc_extent_buffer() to allocate-then-attach method").

This is a much smaller range of commits.  I didn't actually bisect
them, but I skimmed through the log and saw

commit 0a9bab391e336489169b95cb0d4553d921302189
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Wed Jan 31 21:57:27 2024 +0100

   dm-crypt, dm-verity: disable tasklets

   Tasklets have an inherent problem with memory corruption. The function
   tasklet_action_common calls tasklet_trylock, then it calls the tasklet
   callback and then it calls tasklet_unlock. If the tasklet callback frees
   the structure that contains the tasklet or if it calls some code that ma=
y
   free it, tasklet_unlock will write into free memory.

which is awfully suspicious.  It appears to affect LUKS devices on
NVME drives with --perf=3Dno_{read,write}_workqueue enabled, which
matches my configuration.  So my guess is that all my problems
(including the disk corruption I experienced recently) are caused by
this UAF in dm-crypt, which is fixed since v6.8-rc3.

I'll let you know if I ever see this bug again, but for now I assume
the underlying issue was in dm-crypt, not btrfs.

--=20
Tavian Barnes

