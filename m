Return-Path: <linux-btrfs+bounces-6235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E257928C13
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD71C24629
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D613E16C692;
	Fri,  5 Jul 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMcPYHzn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F113A88B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195596; cv=none; b=liBIMRGAuHMKsTgtPezJmdXonNd+R1atefglxDBtjZjwaYwtSHh4kosIc9frl4ptrJggWAr5xni0F1fvTvFrXy90qtnAk5hNkmXkMSHdD30mCgXOLmov1ZtYak+C7J0b2c9KgJvKop1F01Ia8wXwZ28ACAlk3iUCTEye6LBPjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195596; c=relaxed/simple;
	bh=UDfY+ZTmjs4JTEQozWFEDAjC4hZgoMzXodT6sQMnqqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7f5ACiySiq5O8pC37i6t2ZAHJtH8JWLtqFhNstT1H8XVAzwq7Pqxk7I9/lXYpNaBRe3FGpjXNpwl/dnt5hz7dLtJXFLwpiyX1/P9QEJsDxt0QXGqBRcyP3n/h0AwmbpyIbTdp/fMoEZnUjpP19QjMqZ7sJabF938FCtoKv86ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMcPYHzn; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44634afb2e7so14439671cf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2024 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720195593; x=1720800393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDfY+ZTmjs4JTEQozWFEDAjC4hZgoMzXodT6sQMnqqs=;
        b=cMcPYHznCuFuoP/0iwY8ogm81ESwFwUmM3iAmv3QYCy1vsYv9ii1PXe7GgugDOsnrJ
         vhREp5RSO/n8dA6rrIygsGrOfMGKplj0ayHNUZjiEI/jJ5tdzmJh3rDMHc8WNneHTcye
         myFt1mFQzh5A8Fb/i2qESlxXhjZLzZTxfS4ICL2XLyhUConNGALA2MkO+Xzdz6Pq7c5C
         otfAki+CMVFo7orBQ7ilE5MtPyP0xsov+Z25j2hysgfOe++qeYj40meoDYoet013qYyq
         85oeRApUg4FVT9GDTt/dNDg/2v6bFmMOTOcL4x8vjFMJt+HyQteNdRRpEZ3N15TswfXt
         FCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720195593; x=1720800393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDfY+ZTmjs4JTEQozWFEDAjC4hZgoMzXodT6sQMnqqs=;
        b=wPkXSE7eBfDgVnxpHywINTeWpLrxjQlhsKPWktRtEzFl8yernjUq1KCzQTDtGk+nRB
         0nqF5NMghU+1TxsHX5fXeqPdclvz5987KR/n5YF7ujajoSWAVCFSA3P+tspaUedj9T+/
         Nyh3p4c/9WvH+xINg/HwDIzhxxPeGmjeAR0qGkXsRtMStcLRE8Pw8Cc3u1/0VtkZtiBC
         9fguAB7MJoMhh1nxnfBuoHYr2wPFvkZJJTAYQIjHV4QhkvQsl2CdwB9rJD/BL9HtrlaZ
         A6Zz5ETxs9gsaDcDcDKI7e9KYrcZ9lDTugEXXaLS4EF+WcHxdqb6OZ+7KoNZsqvl6hNu
         +PpA==
X-Forwarded-Encrypted: i=1; AJvYcCXcrsRKnB9xKUNHhmwiPWTDXFcrBRbcypwRt8R7jnUI19KfVNkLRc5OmZpaTsIvY3AV+siyU8V18bQQwIowr9BFqpNZaijALh1coes=
X-Gm-Message-State: AOJu0YxNSRwQ6ai4weukoq20wuzlOSNj4FBT5gSbAWOP6une0AqqY/6R
	k6EDenr+ML7c5ojbzLJN86oAHDzbp5ZFIJqYOBcQKCaLNTinyoT8clPj0/aWOwkomy465ZdwgqR
	aTkop5RyTUZM3miFytI7KMEcsEdo=
X-Google-Smtp-Source: AGHT+IHK04dl3Ba04O+zjMjDYnztJj6yCYXaPat58Wrmq4BvSHTE5Lb7B2HGkZBfyj1R18RFjznibbBfHCUn8KrVwF0=
X-Received: by 2002:ac8:7f42:0:b0:445:32b:df03 with SMTP id
 d75a77b69052e-447cbf3cc92mr59920671cf.33.1720195593563; Fri, 05 Jul 2024
 09:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720028821-3094-1-git-send-email-zhanglikernel@gmail.com>
 <af92c238-a5d0-4023-8001-042f17085198@gmx.com> <20240704001309.GV21023@twin.jikos.cz>
 <d7e06214-0166-4db2-836c-36b2abde054b@gmx.com> <20240704002253.GW21023@twin.jikos.cz>
In-Reply-To: <20240704002253.GW21023@twin.jikos.cz>
From: li zhang <zhanglikernel@gmail.com>
Date: Sat, 6 Jul 2024 00:06:22 +0800
Message-ID: <CAAa-AGmb8fbMtaUSLkMPLnc1q=4fBUZQV4xdTCpoxfEuBmqncg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-prog: scrub: print message when scrubbing a
 read-only filesystem without r option
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I think it's a good idea to get the mntent before scrub, but
my first thought was to write the errno to the status file
/var/lib/btrfs/scrub.status.{fsid},
since today we deal with read-only files System, there may be other
errno that need
to be processed in the future. It seems more accurate to write errno
into status, and
we can also get the scrub status in the scrub status command. But I
wonder if this
will cause backward compatibility issues.

Thanks,
Li

David Sterba <dsterba@suse.cz> =E4=BA=8E2024=E5=B9=B47=E6=9C=884=E6=97=A5=
=E5=91=A8=E5=9B=9B 08:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jul 04, 2024 at 09:49:52AM +0930, Qu Wenruo wrote:
> > E.g, setmntent() and getmntent() used inside check_mounted_where()?
> >
> > Since mntent structure provides mnt_opts, it should not be that hard to
> > find if the destination mount point is mounted ro?
>
> Oh right, it's in getmntent. I was looking there but expected a bit
> mask, the options are strings and the convenience helper for checking if
> they're set is hasmntopt().

