Return-Path: <linux-btrfs+bounces-14296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9F8AC7C67
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFC54A34D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CBF28DF33;
	Thu, 29 May 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RnG8Gbuc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15F21CC49
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516928; cv=none; b=Tew8YTyp+BzoO+3hclursaC6suf0ir1MvDaUUHt/cI98IeUcUSy6OjKbS7NCLoUwI+6sZYlvQZDXjNIBkb+nxykZ4Fpxbo0kQFntPaYSvCY0SP4XjA+l2W2WIeD5qQTS3tS+eT4lqawZxa0IhZV0HzK+W774jVItYxmFhvNXU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516928; c=relaxed/simple;
	bh=XVa9woNrLUt97Wit6cRgelwx/2u0YAHXuPpLeqbpSoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el2WThj09lUk2pK01E4tDN6XVtU/+TKVcnGw54W55AlosM2m7mPl7/3AFGrTFypM6qp3a00PbdFb7LjAY7JzGXSllFxsoZuWEyqndPZMUSFUX7nWq3sLbdfpmMZokfkExh8QarwXUQpMwgdz2XpOAt8NPPr/dYG9B94sJ5i7cbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RnG8Gbuc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so136427266b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748516924; x=1749121724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sT64iYh9T6gI9ke4PINAxZKF0uA34cvjONuvC9XYLjo=;
        b=RnG8GbucKVwldEQNcADkXKfgdvVDwj5bXAyyVtzNXlqHCAqBEV/5ZQxUtU6TecDaLu
         vJZlAjvHZbM1nbw7n28iPFWRag6EiF8TKQeYQnYvXUTpcVflIRwuIDsaxT5sr20/v0BW
         CZH9ub9A7dnga2E+dI1ubCbP7dZQMTkXWg1FRFbjpXISVqUvfI0naKbuERMK3F7OaURG
         +H207XS8k2bROWCj7zMPXwr0Hl1Y/CzF7C3cI8KTwb/i19p8LuuwoO2Rr88w77GsSKNk
         lJY3iajHMsP0E96ZwUk/s+deGb18i1jDfJYLElrzqRLwl2zlZ2nd6pz0nagoEu4Wmapr
         sjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748516924; x=1749121724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT64iYh9T6gI9ke4PINAxZKF0uA34cvjONuvC9XYLjo=;
        b=X8pYF3QrsDE6UUKkDF8toz4nowmNVcIUE0pLAh5/G+es91vta19sWK/EChnfv8Ps5q
         /Q7l6ogTo5E7sWrjUw37dM48BLlVpaAnz3YfNzIbvqP7/p2obHQPtVKWYDjX1yemdN5t
         iZrQuTH4VwBGPDDFxqQ1C8WY8CB04ixEjNKkhbUMDIwPRPapzu+pVXbKe0mWNoln4led
         gv3m7ituGHj6F2Vy+1HFWJWl1IuXwL+yMMikWCDfjzK6YKNkBzZ9DFh2R08/5BtWQ3m+
         AlJ9x1NgThPSFaC3rQ2/hQN/2U2RUr1+A9Bd0h8DQ45v7INieOsBpC2YH5ALo21vK7rB
         tmeg==
X-Gm-Message-State: AOJu0YzWNNStl6bhBuAk/+mu295c1dhFHSHt+fyu8yT9YCv5lY/Lzdm9
	p9wsnNZ5J5ei6UoOSb1EVu6wjT3xQXKZ25K/PEH9GvG/lO9RK5pZCLSSYdZVmVgVLCUcKed659B
	PzHD6aoVrVPDutuW1pNP7dm9yfu3LCk8wTH1204Txd1CVCUOfrvr5UcUkPA==
X-Gm-Gg: ASbGncuFfkJUApwbz0GNmfCsqlKR6lL6BIyzI21oCOA43ALIEWR6KjKefVo4Z3oAfmi
	Zk25yEFYN/qbAD3sESyqElRMYvaO8Od4D0hLJsoHN/sXvAF32DDlFUhYBgpqNdZ3Wrj4KZ93fMc
	qu7bwf3PbZxoOGodNaGDcI4oRARw+JPcg=
X-Google-Smtp-Source: AGHT+IG+bv4zW/SGZVx+fTM5u0C30tIh9WVmtkAtw2RQwgmqFisnmCD617g6x1OLpiOYDbjZR0ryPuaI4g+mgi+ktQM=
X-Received: by 2002:a17:907:d28:b0:ad8:8529:4f94 with SMTP id
 a640c23a62f3a-ad8a1ff3339mr449366166b.49.1748516924195; Thu, 29 May 2025
 04:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
In-Reply-To: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 29 May 2025 13:08:33 +0200
X-Gm-Features: AX0GCFseHTUFY2-ecAgIM43dulR9wBRTP2sRakn01gVEAlHz0QMtUZ-5mrglMcI
Message-ID: <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
Subject: Re: Portable HDD Keeps Going Read Only
To: Matthew Jurgens <btrfs@edcint.co.nz>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 04:08, Matthew Jurgens <btrfs@edcint.co.nz> wrote:
>
> I have a portable HDD that I just use for backups (so I can lose the
> data on this drive if I need to).
>
> It keeps going read only. Sometimes at mount time and other times after
> a small amount of usage.
>
> The dmesg and btrfs check output is large so I have made them available
> at this link https://www.edcint.co.nz/tmp/btrfs_portable_hdd/ (I tried
> to attach them to the email but it seems it never got delivered to the
> mailing list).

It did hit the ML. You may have missed Qu's answer:

https://lore.kernel.org/linux-btrfs/3d1c4611-d385-4d31-96de-3a617e02c94c@gmx.com/T/#t

>
> Steps:
>
> 1. connect drive via USB. The system tries to automatically mount it.
> The drive mounts as read only. The result of this is in dmesg1.txt
>
> 2. umount the drive. Run a btrfs check. This results of this check are
> in btrfs_check1.txt
>
> 3. mount drive manually. Drive appears to mount ok. Run a find over the
> drive. It starts listing lots of file. Cancel the find. Start a scrub.
> The scrub aborts within a few seconds. The result of this a in dmesg2.txt
>
> This is now the 2nd portable drive that I have that has had a problem
> with data on the BTRFS file system in about a month. I just recreated
> the file system on the other drive. But this time, I'd like to see if
> anyone can help with finding out what is going wrong.
>
> uname -a
> Linux host 6.14.6-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri May 9
> 20:11:19 UTC 2025 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v6.14
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
> CRYPTO=libgcrypt
>
> btrfs fi show
> Label: 'PHDD_WD5TB'  uuid: 83f64b18-a2e8-443b-bfa8-78ff90dc86de
>          Total devices 1 FS bytes used 3.67TiB
>          devid    1 size 4.55TiB used 3.69TiB path /dev/sdb
>
>

