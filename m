Return-Path: <linux-btrfs+bounces-14114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ABDABBB47
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 12:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005FC176EE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7427464D;
	Mon, 19 May 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BN+/bd55"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283794CB5B
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651110; cv=none; b=aBz9aHJhaG/oYINobuzFWWYW7m2mckyLH0q5jd5bXCoPOCvn/3Kugux7mQKRf9IOS19QicC/1JsmG+P2ce+/AA1dqXJ3GCDlnA4aBNWsm90b7G9nEv8gR6FnfYQsBX80uCtvC0BgcjyCoZRF2zYc5oPkpDpn5qoruOs1N6f4DzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651110; c=relaxed/simple;
	bh=jMaPnZKwOPE3vgc3hJWAsxSV7zd3OOy7j51dprH2hI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3vi0Dvpj5SIZjTOoBCPTqAtRQBzG8M2OBRRKvSZKGvFyNnYJ/8hWrIx/dXPdJ7r3wzCCpO9qjxB7/2hlfItPVoXhz60nLY3h+VgKye/ZKrioo6EGrPmrt2t+3SjGcXe2b5Hme5MlKyl3aJ+VEp840owQQL5Izw2AUXbVGd9cLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BN+/bd55; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6019b564d0bso3793978a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747651106; x=1748255906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jMaPnZKwOPE3vgc3hJWAsxSV7zd3OOy7j51dprH2hI8=;
        b=BN+/bd557Ie4jveqEPvuJGnGmiB0AiT41TVrKEJd6NQxy1ZnnrikBYmqe2Qs9lme8z
         ZvnSeqAOa/VciIS0n9N/ql1xEmsezVBcJ2GTHnGebs4LOkARMXVyN2mg0OTaqTPG8Lc1
         EKNP1I74gTFLMOpHOX2KeQPv4uKKNB8muV/HxChBbHftrgX/eCio6niqwDullsnOJH4J
         4RaokbtvSYZYMqGyBl701GdkePC3xkm8ED4sdUA0d7MZAXIzJvmi4Mu3iV3al5Ou0767
         u9MYmaX+Fo8Q6PJG5dH3mn3ekRnZmNdljhyHPkgQcqFfvOGN7DzMwA+Jw7uS3A3AtBDo
         llxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651106; x=1748255906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMaPnZKwOPE3vgc3hJWAsxSV7zd3OOy7j51dprH2hI8=;
        b=KyVI4Kax+FX/YvtGwwqbNsBHO08AbhNbBsnd9Wzg84R2hbTi65V7T3bHtYLXFvwRCc
         D5I+xT8JAIOvxxairGDe+2lQv+ZusSaLl9/YtsVy63bnkm2AzFy10vtm9qn1iTU2A+wb
         laZcoUsWvT/O+cDicLNSfehKAnoWOEXTVFJvTw9b9lEP/X12M5hBg1dR+x8Z5XUs0QUE
         GLC9j8aZ2y8mxURQsHGC13cPHnBznmYm5xJKL7S5FmZliYcFIMceVwRZlrK+/wWzr0t8
         GdNsH6urR9jD/aPUYc0rnZarFlHXC/xLlpfO/uGuBnIq+lxE2exZevfoYGyJJxdMPNd7
         WXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGY+3fV6xge9hjNoe0FNsBUXx41ImANvMiKVUvOB4N54BjLjg3pcuu46dypp/QO4LyyyiBHQ62gs4zDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA56tyVE13LE6RmBAg6PEGvaTFGhJMd6alf/DLrECdhG23eW0w
	LkvlEqa1PzNE/63X/u/r3YKyeMmlNFxEY+DwOG/lTktl4oeGrBH5rOwiNXmO+zCunoGkv82ad72
	IQo2esxgHcZ1gvwbSm0SuHHLfF/QfarM2Z+RdZp+k//Jgvj5/VFhPoVw=
X-Gm-Gg: ASbGncsbjO142+Yq9AHsubczAh0W7mqZ9X/LQaqMmUBrjcistNLBvGmiIdeDWR4++8s
	csLLNxfzJm/VLbgKwgF0IaQfQ6CHpQPdB5QN9GU76zFW11T1t1RLKpzAeZS5hlA+LzTuo720fpW
	fAnONCHcmj4N+Y6t4RIrSJyfDJxYxFiLA=
X-Google-Smtp-Source: AGHT+IERQ6gVNtm2jfGvs7h1VmhPgqmh5s9ctmNSJ0DLQ8IpwfQ2E6YxSes6NyxUZ3WMm8+21WrrQaejiUt8R8VEd9I=
X-Received: by 2002:a17:907:3d12:b0:ad2:28a0:4248 with SMTP id
 a640c23a62f3a-ad52d45aedemr1183024666b.3.1747651106424; Mon, 19 May 2025
 03:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514131240.3343747-1-neelx@suse.com> <20250515144742.GH9140@twin.jikos.cz>
In-Reply-To: <20250515144742.GH9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 19 May 2025 12:38:14 +0200
X-Gm-Features: AX0GCFtZgxPMG4SkO40DEY5vLgn4EA8MNaPg6H0kKh8rB0z0QS2vtUFJzmprWUw
Message-ID: <CAPjX3FcSigbx4siWMvxUFyeQk3u-WwnWTgqikcDB0vxwwZHFjw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: btrfs_backref_link_edge() cleanup
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 16:47, David Sterba <dsterba@suse.cz> wrote:
>
> Please write more descriptive subject lines, related to what is being
> cleaned up, and not just a generic "function() cleanup".
>
> On Wed, May 14, 2025 at 03:12:39PM +0200, Daniel Vacek wrote:
> > This function is always called with the LINK_LOWER argument. Thus we can
> > simplify it and remove the LINK_LOWER and LINK_UPPER macros.
> >
> > The last call with LINK_UPPER was removed with commit
> > 0097422c0dfe0a ("btrfs: remove clone_backref_node() from relocation")
>
> While removing the code is ok, looking to the git history I think
> there's probably more, related to the node linking. Here it's removing
> one half (LINK_UPPER).

I'm not sure what you mean here. I mentioned the commit you suggested.
Checking the rest of edge linking I don't see how it could be
trivially simplified further.

