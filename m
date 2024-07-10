Return-Path: <linux-btrfs+bounces-6344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0172292D76B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C021F230A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837DD1957F2;
	Wed, 10 Jul 2024 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="ECLKA3aw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA9195FF0
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632497; cv=none; b=q21wDreZw15bxUd2gi5OovSdNxeRKaCUPuZIGFTki5iuWsZIOObBu5grGsnlTSJDp2f4rfhTWu4nv2SKIqQ9KSouEshuNjkS9FZlBiC2bQEiHMovO2U2MLM3chBtBdSBTe93je9x6jaODsPxncFODU9zAr6zN8Kb5t26ywU3+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632497; c=relaxed/simple;
	bh=oRcUCHntRbgLgb24blmDLtgXNXQpg+k/pzlQ1lH2hls=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V8gGHGYehq2w3lOfm3PX2voeJxvLpnLKWdt+3EXHDinvto88iwZIJUGLopVE4GAa8nHSpTjREol9WIIP/rzEjT8eB+YH969Eps16lQMLe1hlSDOPn8IhrmAwagrquXRjsQ0S24sHeYZwrJEoxUt1Sgr7Xm0pERovS7oDrFeE46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=ECLKA3aw; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id Rb4EsgbMBVxa0Rb4Esz8eZ; Wed, 10 Jul 2024 19:25:23 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1720632323; bh=BUtjxGvHPiU5rtvdwaW4AUxJ5JsbzAhlFWen5tWRsmY=;
	h=From;
	b=ECLKA3awNg85Zxduv4YKN9BNjZJ30CzbNtXkBl9J2STPLIQsZtmfD+r0Hk5aizwbh
	 x9V9frwL6gx2lz89jjD6E0POoyVQxh4rOHThm2xwO1icYcRke8BL0Gz++DLiyU8Kao
	 cvm5qyXuA78EXz0e4xosiEF6EH019CYm0YzkHlE8yL4L7wpk0xEtIJHZy6pUS8pl92
	 /56SLJ5albLQR/UGtG0S7v8zHdkh9WgkNBA560SIQllSByO5S+v0wZyBTH7Lc0rz9b
	 IwX4Mt1kdshpfWZie6w0D+wzHvWvh00UjY4HwreV5EPE1UIdGD89WZ8ikuWK9+IPuw
	 aVnwTFHZH0+lg==
X-CNFS-Analysis: v=2.4 cv=c89gQg9l c=1 sm=1 tr=0 ts=668ec403 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=L7JBU_Org0ZnaVwsq8MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <be618a2c-ee72-4dc6-925a-cce52596df3a@libero.it>
Date: Wed, 10 Jul 2024 19:25:22 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: "Replacing" a subvolume in presence of nested subvolumes
To: intelfx@intelfx.name, linux-btrfs@vger.kernel.org
References: <1a4f5b2e4bb24978e8839e943faf364c1232757e.camel@intelfx.name>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <1a4f5b2e4bb24978e8839e943faf364c1232757e.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHgjT8NOlooLg2s0H+0lBanosM5lyYTCMKluQ2j8yn8Wu5mc27dhjPZG7dLlObUTmmSsH711+xM+rjg3SJCKHX2IqUa5k4JFz/Y22M61PZOiFYdJro61
 Hs9WcTNaXlVuuqXd4O8dLjt8lzm//CMSFMZWtHoEMQZXiRlWCH3xTtKIoOSJCqeGQ5166vpi3CLRy3I8Q23dwl0jaiQZNeWfdbjAWBpc5PYfaiReVsXXXWga

On 10/07/2024 06.35, intelfx@intelfx.name wrote:
> Hi,
>
> I'm currently developing a sort of high-level management CLI for btrfs
> (loosely modeled after zfs CLI) and I believe I've hit a pretty crucial
> missing feature in btrfs.
>
> Given a subvolume tree like this:
>
> FS_ROOT
> ├── foo
> │   ├── baz
> │   │   ├── foosub1
> │   │   └── foosub2
> │   └── foosub3
> └── bar
>
> Does there exist a way to atomically replace (or exchange) `foo` with
> `bar`, preserving the nested subvolumes at their logical places (i.e.
> beneath the new `foo`?


There are two basic models: a tree of subvolumes, and a flat lists of subvolumes that then have to be mounting using mount --bind.

The latter requires a lot of userspace activity to mount a FS, but it is more flexible. It allows you to swap a portion of a subvolumes hierarcy umounting a aubvolume and remounting the subvolumes in a different sequence

Regarding the word "atomically", this is a bigger constraint: assuming that you are able to swap subvolumes, what about a file opened in the "old" subvolume that doesn't exists in the new one ?

For now the best thing that I was able to find is to perform a reboot between the swaps of the subvolumes


>
> I'm pretty sure the answer right now is "no", but what I'm wondering
> is: what would it take to implement something like it in btrfs? Or can
> it be emulated with a clever sequence of VFS operations?
>
> I tried to mess around with bind mounts to "emulate" this
> functionality, but I don't see a way around it — if a directory is a
> mountpoint, there is very little you can do with it.
>
> This feature (or, rather, its absence) is in the way of implementing a
> sort of "rollback" feature (in the hierarchy above, imagine that `bar`
> is a snapshot of `foo` that the user wants to restore).
>
> Now of course it is possible to take an easy way out by saying that
> nested subvolumes are broken, but I don't think that would fly: nested,
> user-creatable subvolumes are a very useful concept, docker/podman
> creates them when used with a corresponding driver, etc. While for
> system-wide docker/podman you can get around this by creating a top-
> level `/docker` or `/podman` subvolume and mounting it into `/var/lib`,
> this won't work for rootless podman.
>
> Thoughts? Ideas?
>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


