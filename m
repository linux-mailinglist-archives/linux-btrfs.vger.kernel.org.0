Return-Path: <linux-btrfs+bounces-21116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNtyA//IeGmNtQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21116-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 15:17:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D76C957B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837FA302DA09
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12629DB61;
	Tue, 27 Jan 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnlcNa0s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D31E3DF2
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523328; cv=none; b=AYmmTXl4R8ag13KFr0wyMYwWfS06XqX0SE5kczuCVd2wDwj+Dc269UU7zMjJ6NMblyFsKvZRm0EU8LItnvWRFs2ndMFU//F/ppnD9RLoiXuuTluUMZjPA5axYVCM1W439ulGAUGZEftzz26oK54mVagLdgABoWbkUmi8H+dpWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523328; c=relaxed/simple;
	bh=aDjsM9iSJhBqQB7fdZuo4gHJBMU/kbqKFproLooAFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOtDQFaJgY2Tw8vp0H6PMG8jzjDmz8UMRnJm1Uueq0du8HdtS8c+ES9us22ft23DgXRRVa7Ac1aXGPLYJvgWWSq5lePzom5n/PAY9wk/a0LhMmqNcJA3/I6i5OGb8yYXPT1HN8hEVXUy2dKmKKuZ75cR2xe2ZDvzWHRgJRVAw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnlcNa0s; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a08c65fceeso9471455ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769523326; x=1770128126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDjsM9iSJhBqQB7fdZuo4gHJBMU/kbqKFproLooAFDk=;
        b=TnlcNa0sYoFRz5WVmXLPRv7k6mL1MawHGm6Kl17gkD2BQy54xNEsjdJ6kZHtjVB2uR
         /V7f5Zd6irKmciL7T0b5tHKox7B2q0hvdvVHDGz5noBCkjzs2hOADBISbCJmErsPK2Jb
         DZoEs/XS8TCfZmJS9ZoMGb7ZfC7zaTfq7wuaRMcD1Q0UH1SOa12CjXYeuyyDega0/a9w
         IM51nTIYZCP3RSotbZdA++4R488gEWkVTWIRPFGcJAUxGu6G1b2K6XikDL5e9s8ul0o2
         0bNuSzL+fO9MWQY1dCYGx6Dna0U9u1svyEKra0LN/Xp/p3CDMfGbhxHYAGM/kVprqpGL
         Z50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523326; x=1770128126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDjsM9iSJhBqQB7fdZuo4gHJBMU/kbqKFproLooAFDk=;
        b=eVA3sbP+cQZ1aY1sJXSATOLnjVd4OlndlhY+Y4Wo7ts1WlCoOpUpTYBSk4wLoGV5w2
         WXDwvP2UVlnDLHe1RuT+LBEM3OtJ+Z8TYriwjfRq4bVvIw3rt828e2+NtyS5BGbT+M4s
         qCCLy9tdKqHj+IqUXz0d6LoAIMPIJsiZjbqJV3e/zNHKFPwcX1JPek9wtmzsGA466GA7
         iZY5+AFTTM8n4SzsG7Zqm/eUhF9WZMUJLJ5Ps8DHyxubbT8okXD0ktr4jE4lAWXc+vxa
         Mvn3ksPF8jAhNh+hFU3dJW3/TlEqIJWJHjSOdMeiJY8zbcsSaQcjEgM+P1l11TWsMpoG
         lE+A==
X-Gm-Message-State: AOJu0YxTST/tjUdRcVg4uFIJtCYTE9eFT4NbcMBeR/CHGrZ3LEderKi/
	vXkmfUZi89JMsc8MyVvZtczN32DtAj3dHPzxJVMsEAlrwUOr8P9gu6IFbhVR/CsR2MTtxQ==
X-Gm-Gg: AZuq6aLnBm0kSyHhs8pqh8O/n1n99Bs6Ew48HOdzb1MPABGDJoouV0cOxhE6mkk7+bO
	IewamZmUbZ3oeGOqoXlhFwz6uXnhnzW3cHElIswnx/UHPygB/lIbWBTPzcize5UnOBMSki0KM1C
	fCsn9oNqBBPlkVktZVADXRtNt1VybbqdkQooe3JZNd5CZBCzBYQhYkBbQhzu9loGLJ8LyGUnQCb
	6wRTborUkN6EcChQF7/QqMJ992fgbwW2lCuJz3avI64sWj6pdgfov5yP5TkfEVSePb1zpsOpR5P
	Y73k5BloPKkpLBFEKHp0PwfDMdPUnwOBKZOUzOJ1rJWdnKwAA6HM2N2SDnKQqYTJ7b8W7KUy+Da
	ZzO2k4HJrecnXo53+KqWhw6fMrZmqkflomFe66iV7l44NYZwXHZAjyrwY3PMmToterdKsb0lvn4
	YGH2ah0X29vKIaYeu2RIiEel521g==
X-Received: by 2002:a17:902:fc44:b0:2a0:c495:fc05 with SMTP id d9443c01a7336-2a870d57bbemr15520035ad.2.1769523325603;
        Tue, 27 Jan 2026 06:15:25 -0800 (PST)
Received: from [192.168.1.13] ([175.143.94.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fb07b6sm118247125ad.86.2026.01.27.06.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 06:15:25 -0800 (PST)
Message-ID: <4f2af29b-6720-47fb-814c-e6f8b0327c30@gmail.com>
Date: Tue, 27 Jan 2026 22:15:20 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: initialize periodic_reclaim_ready to true
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20260126113104.9884-1-sunk67188@gmail.com>
 <20260126173450.GB1066493@zen.localdomain>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20260126173450.GB1066493@zen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21116-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D76C957B4
X-Rspamd-Action: no action



在 2026/1/27 01:34, Boris Burkov 写道:
> On Mon, Jan 26, 2026 at 07:30:52PM +0800, Sun YangKai wrote:
> > The periodic_reclaim_ready flag determines whether the background reclaim
> > worker should process a specific space_info. Previously, this flag
> > defaulted to false because space_info structures are zero-initialized.
> >
> > According to the original design, periodic reclaim should be active from
> > the start and only disable itself (set to false) if it fails to find
> > reclaimable block groups.
> >
> > Now that the reclaim condition has been fixed in a previous patch to
> > properly handle reclaim_bytes, it is necessary to enable this by default.
> > This ensures background reclaim logic kicks in as soon as the thresholds
> > are met after mount.

Hi Boris. Glad to receive your reply within hours :)

> Is this problem practical on a test/real workload or theoretical? If we
> never free net-1G, I don't know how much reclaim is gonna help anyway.

Yes, actually we don't know how much space is enough currently :(. It would be
a lot better of we could find it out when failed to reclaim a blockgroup ...

I have a test case for periodic reclaim like this:
1. mount the fs with >10G unallocated
2. filling the disk to nearly full (< 10G unallocated)
3. free up some space(>10G unallocated) and umount, preparing for the next
test

I expect the periodic reclaim kick in when the disk is nearly full (during 2)
instead of after freeing up some space(during 3). This let me started to think
about this patch.

In real world workload, we may have a fs quite empty when mounted, and fill up
to quite full and expect periodic reclaim will happen to get rid of running
out of space for unallocated. But periodic reclaim will not work without this
change.

And this patch is the simple and quick fix for that "edge case".

> If the "net 1G freed" condition is not the actual condition that we
> want, maybe we should rethink that? We can enable it on 1G total freed,
> regardless of allocation to give it a chance to run even if the net free
> is 800M or something. I was worried about workloads that did actually
> allocate and fill in the gaps.

I agree. It's not reliable and may trigger too often than what we expect.

> Or we can just use the total available space
> as a proxy, like "if we do a free and the total free in the space_info
> is >1G, enable periodic reclaim". The reclaim loops aren't gonna be
> costly and we don't expect them to do anything when the fs isn't full
> anyway.

Comparing current free space with a target free space instead of tracing a
reclaim_bytes is a good idea. At least we don't need to maintain an extra
counter any more. But the fixed 1G target might cause some problems since a
reclaim might fail with a >1G free space. With the fixed 1G target, we might
trying the useless work again and again. I suggest to set a target larger than
the free space we have when setting periodic_reclaim_ready to false so we'll
not trigger periodic reclaim if there's no "enough" free space freed.

How much the target should be larger than the current free space? Still 1G, or
maybe we could find a better value, taking more factors into consideration?

And at mount time we cannot find out a proper target value so just set
periodic_reclaim_ready to true. (BTW, this is why I use "paused" instead of
"ready" in the previous fixup patch: to make the default value fits the default
logic, but just set it to true as default seems enough :)

So even with this redesign , I think this patch is also necessary, or at least
no harm.

Thanks,
Sun YangKai

> Either way, though, I don't think this is harmful, so we can probably
> put it in. Just curious what you think about the other ideas and why
> you decided this was needed.
>
> Thanks,
> Boris


