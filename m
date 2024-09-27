Return-Path: <linux-btrfs+bounces-8309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9774F988AC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 21:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88771C21F20
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AF1C1AB6;
	Fri, 27 Sep 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="XqLrrt+U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA7136354
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465773; cv=none; b=CgW1SSKtqB8C2AqNc4eg4UFA3pBUB9bGQ5Aki8DT8CJ3AOw6WLjrEsAft7nfI0O9KPLu+9HD/bD5Ga25bbIPyWyE09Qqpn04tCfbRtLD2QisiW3K3+ooe3BDS2nCsE7MiWqgqWbAJyJG7bvBQ0NKsQpNsYbKbTklKuQPIP7BywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465773; c=relaxed/simple;
	bh=wPchPAvtTSx2xQJS4v+aB/JvqUAm8K3b1pUN+FHiPRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rsklkr/TcBBQ44ehjmctGsV/lsOxlZoqjZ1NWabh5/rGAOBP3cJ3QejDdxHm4JevxhNhoBx+EYX61Y165EErdwOfOuI7Yy08bU6nKuJKH1g7JHJozbajNWzbO3Xbns7OK9eoJyYmH/TNL3+Z1v+kkmwtnsj2e5O/vqDOHRWnDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=XqLrrt+U; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v2uqAx98jBKM8KjSgCOCnavtEAzOIFCTLIGj1s2Av6w=; b=XqLrrt+UnrnpxmyaqtlYxv6cu2
	A9w5vPkDxtzflPp8wunaS7YVH0dDeD9EVdVqTNiW5m/KJWWpK1X5GCB42RAP5RD51tSwjKS7VadPS
	jKAGvx9mvC+y+tlOirNs8GN0Gnhdvu4aPTUJTmES8YZlWNAEtqY9gMCI7VlBhAxs/Y6CD9KuTyJYQ
	owg8xzIMeHILQntn04FvWS4BKOCIRx9K81TA0loUIAytw/YzyHtAuEp0prz16pCCEkK65hP13zrYB
	voipoZJVGHQdFFSdLGAUx7JfI+EVDdI+GBr8HCHA0IOkAmzvgF+tFHuoAZdHwIyZA9hm0AZUEd01k
	xia0dArw==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1suGDz-00046A-C9
	for linux-btrfs@vger.kernel.org; Fri, 27 Sep 2024 19:01:55 +0000
Message-ID: <28059007-9d87-458d-ab4e-a498977d8268@zetafleet.com>
Date: Fri, 27 Sep 2024 14:01:54 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS list of grievances
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <20240927212755.5b24ecd4@nvm>
 <03de7723-0be2-a153-d264-a1024be3c2b8@georgianit.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <03de7723-0be2-a153-d264-a1024be3c2b8@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001 autolearn=ham autolearn_force=no version=3.4.2

On 27/09/2024 13:05, Remi Gauvin wrote:
> 2.  Any files that are stored on on the device with CoW Disabled will
> not be fixed, and the two copies will be different, with no real way to
> detect or fix.  There are packages that disable CoW on files by
> default.  (systemd log files, but probably more concerning, and virtual
> disk created by libvirt, for example. (Some amount of divergence can
> happen at any unclean shutdown in this scenario)

For reference, there is a longstanding open request for enhancement to 
detect mismatch and enable manual recovery[0].

> 3. I don't have exact math at my fingertips, but with enough failed
> writes, the chances of a CRC32 collision of the stale data leaving
> unfixed/corrupted data behind gets fairly high.

It was mentioned to me that CRC32C 12TiB stale collision chance is 
75%[1]. Given that there is a proven alternative with no risk of 
collision (write-intent bitmap), I would say relying on checksums here 
is the wrong thing to do.

> For reasons of 2 and 3, the only way to fix this without increasing
> chance of data corruption is to replace the previously disconnected
> drive to a hot spare. (with the -r option to btrfs replace.)

Furthermore, if a lost device ever mounts rw on its own, it will cause 
permanent split-brain, because btrfs doesn’t track lost devices so will 
happily rejoin all devices again later. Compared to everything else that 
btrfs already solves, this seems like such a trivial problem, as my 
understanding is that it only requires storing a bitmap on each device 
that indicates which other devices were present/absent according to that 
device, and if the bitmaps don’t match, then don’t rejoin the devices 
without manual intervention.

I wrote about this exact thing already a little over a month ago[2] plus 
gave a dozen citations to past discussions, and didn’t get any feedback 
from anyone working on btrfs. btrfs developers: short of implementing a 
write-intent bitmap myself, which is not possible, what can I (or anyone 
else) do to get some developer time on this?

Thanks,

[0] https://github.com/kdave/btrfs-progs/issues/134
[1] https://github.com/kdave/btrfs-progs/pull/863#discussion_r1710574045
[2] 
https://lore.kernel.org/linux-btrfs/55c3f03d-a650-4193-8982-ffcb70575c2e@zetafleet.com/T/

