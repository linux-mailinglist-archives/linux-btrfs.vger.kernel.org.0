Return-Path: <linux-btrfs+bounces-2768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E2866BE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355B91C21C1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A81CAB1;
	Mon, 26 Feb 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Iv1w8886"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41111C6B4
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935307; cv=none; b=WcxqMjfRVIhgRFod6BFyQ0rUSYuHedrx9q5oAAyuO727LfDff/HXKY0QuaJYVH75KcRDFND/XIoB57YBj/2XdL5cTxxTblqKIhFJ8bC6oeAs542RTfHLKb22cW9Ex87eu9Zton5fYSKP2gsnuNYq6nAtTHC3IaRvAMvUvaJUGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935307; c=relaxed/simple;
	bh=wc6imTjryGlZEGM8Hd8Jr4/OgAt8z10WVDMkwzjaplg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl5JUWcwloCs+WHkfyMmyxBH5IDk00W7MLXqRs5oxo7Nfc43akaPztO+YMIoggy3zzauNRWigkll+jk2GmWChfImUasQMRKeOBGf/gB/tT17AeqDcHeuH2BXnR6ODGuuJ65PAku+vmuMkvOeFET1iQkZ9OQkzb9mlyQXetLPsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Iv1w8886; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e706f50beso349223266b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708935303; x=1709540103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tXChnYM6jqoevNoB06P78tnxuorT/1Io0Mk4HtClhXM=;
        b=Iv1w8886SfgA19CpcF2knQdSFAMl+enITl8gv1lm9dBe3PwBmUuUPD2vm0BEu+YFfe
         eF9Wn7aQ+52lonyWUn1a0crWNWzTYP8bahasZi+RGlu6/0nyK3b5qWuTEmocvB6FeHMh
         To0jQbVy9polW3MgJemaT4cG4ovUH2+8XuMAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708935303; x=1709540103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXChnYM6jqoevNoB06P78tnxuorT/1Io0Mk4HtClhXM=;
        b=UvoMGgTVkuMaVp8Jc225o2/s0ePtrCt0lMD2gNzEnlnLsSs0E9eFEs6mSifeRNAJsh
         +Olhj0bou8S32rj1Qm1BexD9xplBOfjd0TgeGYnnSkUUFQrFSa6VyIYdrUGAhjiTMlys
         42GfVPHkMQkaNeiabrDlJqIgYBA1EwWIydqL5bwguVVeTmBZ9d4ayV05ieWtsKQbHP9d
         3axrpQTVdSL9FZQoio69GYPg8/u8pzeog946pDF/71+wOGvlXGJKrocaHiABJcN1ujDT
         cDsclsEkq8I15OtjlQwK2rp5xACOfYYeG0CpbzQZWbWpazk/YDTuUnlrqP+3PWM579ej
         QwAA==
X-Forwarded-Encrypted: i=1; AJvYcCUkQLYiKwJxCA/gmgf5cqE7iYFMeYYt06gmSm9a4961DB3c4bMh8aEc/2XLj9ILOmJ6TY5utavPi+P9HzOK+DGOQi6v1nggGgs6TC4=
X-Gm-Message-State: AOJu0YyPmgePmBvQM+ueSpZoO3OfwCwi5PLphNLMKdzLO4m9GS3p4WfU
	J7A32BnjDvVelJTxdlPG6zWB4bu+Fz7hnLolV9dUEzR3DR/rmnfHc7fuvO4yfLOfme39MTMEOdh
	48TpBbreIYBN6gustP8enMCsG2uHZC2+1rOssIQ==
X-Google-Smtp-Source: AGHT+IH2bEcWWKZhtSpcqVfNN3HRnSrKljnvZLVLF3StAQMjpLEdFDMGIoyyE/VYuQFRBAyUtqaGPeKO+HUcp1F2vGo=
X-Received: by 2002:a17:906:3657:b0:a3e:127b:690e with SMTP id
 r23-20020a170906365700b00a3e127b690emr3685184ejb.70.1708935303115; Mon, 26
 Feb 2024 00:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <20240222154802.GA1219527@perftesting>
In-Reply-To: <20240222154802.GA1219527@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Feb 2024 09:14:51 +0100
Message-ID: <CAJfpeguEbd1h96OVhDAPEwoWGrF0Nk7q0GD9W6FhGp+eVgVRCQ@mail.gmail.com>
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
To: Josef Bacik <josef@toxicpanda.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 16:48, Josef Bacik <josef@toxicpanda.com> wrote:

> Right, nobody is arguing that.  Our plan is to
>
> 1) Introduce some sort of statx mechanism to expose this information.
> 2) Introduce an incompat fs feature flag to give unique inode numbers for people
>    that want them, and there stop doing the st_dev thing we currently do.

I don't get it.   What does the filesystem (the actual bits on disk)
have anything to do with how st_dev is exposed to userspace
applications?

This is not a filesystem feature, this is an interface feature.  And I
even doubt that salvaging st_dev is worth it.  Userspace should just
be converted to use something else.  In other words st_ino *and*
st_dev are legacy and we need to find superior alternatives.

Seems like there's an agreement about file handle being able to replace st_ino.

I'm not quite sure fsid or uuid can replace st_dev, but that's up for
discussion.

Thanks,
Miklos

