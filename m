Return-Path: <linux-btrfs+bounces-9554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5509C64F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 00:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F9B3C3B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18473219C82;
	Tue, 12 Nov 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lveu7iQI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DADDBB
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440778; cv=none; b=ZthUrHqOQylMFTLzhpktXRg3ne4XpESmsQG178rmsYzsWKCp6p0SMM5pYyrjMPvkwqp84Xq3etsViNFr7m46lEWY894fxngi1YZZjoXfOIFTU4TEzrB5oJDrtlJkYvP8RsYA9/dniU5TylTTr+3RSO/V9Dg167hhgNblb8+HnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440778; c=relaxed/simple;
	bh=bna1DQ543WyJHuuqATngsHU2aVkAWd+Y+jUOxH+XtcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvtGPfhwof5QsjsRtZu343cSMHENhecedR/g1IWPoepz1SaG+lHZBXzWaILzyIs5fPRSxq0vTTipW9nwoz9jBkVn6Y+968joL5p+7SzDFj5okx7bN/qTg4Z8soHE7OxxNIHBnHzvxtOJpYNt4a3rW6oRcwRdJMYVq8snGNkJzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lveu7iQI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so80209e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 11:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731440774; x=1732045574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlJJ+zcJgVAM09bT3idZLHPWsiy7qwqX02nyVSrJZ4I=;
        b=Lveu7iQI7eX26SWfzv31kmpJusYUgmyr9TbpHaftVL0EWgProWcfr4eEhWRH5CzsgG
         AN+aazW90Y/uSjWhxEhEhE95BWfK8MwatGvsJD+RfmSLIpN5eDr/UDj2r1l7OrqtNvPt
         DgXPXc1IVEHK8r7OFZMPWvA6F3urRIpL1wiDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440774; x=1732045574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlJJ+zcJgVAM09bT3idZLHPWsiy7qwqX02nyVSrJZ4I=;
        b=OKRFafH/HSAjO2NoSGyyR3y2KeLGnGZ80KY/9tPTdeKdgkXEG/6rGMvdNKOfiHdFr8
         aGM3TbOhPDeP7XolMzDj8G/4TmrOPTTfggsb4PMkvHbH42K2Uxu/Jg3s7muXZM8nGJ8w
         T3BTC0hrnXCVyumKUzL62mjtYn/UvTkLi1nk00RY6WT+9YlgGGK7QZbgkIIxn/PNsQjV
         nmME4oB9k60PtcJHzAY36LYwSKQUj2HaoAX9IYBEoCfqN9Gv5dZuscHi18c+mIQ+fHU+
         9FTGD6Pz+3aYXjrxFoDfMXbF7rdZtb2Aqlw2HUMbA+hR0/IdI+Nfq2iwXWMpCtBhtX8Z
         3ukQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlVDWedJxfqM4tZEu+S+f7JcojP2OlFdQiL48RgjsnUKRttIBDpjN4I8HP7Vbbi/RlyrBwTs8z1CyjqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxwIl4E4s05Cji95N2qMZd5Kd0/Rjmkyd/OLK0XZy6xrm8xL9J
	4HBHAYUQnBjhlZvYjaZKr0LRI66TbbRraZC8JzzErVTvJ3HDT1F16Z9VOfIbjH35WF2XnUP3tpY
	6pB9n2A==
X-Google-Smtp-Source: AGHT+IHVpGfSevsb/UbjSd85B2f0Pd9KvFWis1yNClVLe2GOJP0U8YWuqmqq20v+jQjt3tYThPT+4g==
X-Received: by 2002:ac2:4c4f:0:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-53d862fded1mr7909354e87.42.1731440774013;
        Tue, 12 Nov 2024 11:46:14 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d8c614c51sm1217802e87.14.2024.11.12.11.46.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:46:12 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so80151e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 11:46:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTKxwTnnZreDiZXpmcwH7JKJfyxeddscttYHYGlHnq7cO8AZ2/nZGnvRa2xWKNn9cJ+u4HUlei9CIaeg==@vger.kernel.org
X-Received: by 2002:a05:6512:3d89:b0:539:d870:9a51 with SMTP id
 2adb3069b0e04-53d86302f33mr8492323e87.48.1731440772062; Tue, 12 Nov 2024
 11:46:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <8c8e9452d153a1918470cbe52a8eb6505c675911.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <8c8e9452d153a1918470cbe52a8eb6505c675911.1731433903.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 11:45:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFKgs-to95Op3p19Shy+EqW2ttSOwk2OadVN-e=eV73g@mail.gmail.com>
Message-ID: <CAHk-=wjFKgs-to95Op3p19Shy+EqW2ttSOwk2OadVN-e=eV73g@mail.gmail.com>
Subject: Re: [PATCH v7 01/18] fsnotify: opt-in for permission events at
 file_open_perm() time
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
>
> @@ -119,14 +118,37 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>          * handle creation / destruction events and not "real" file events.
>          */
>         if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
> +               return false;
> +
> +       /* Permission events require that watches are set before FS_OPEN_PERM */
> +       if (mask & ALL_FSNOTIFY_PERM_EVENTS & ~FS_OPEN_PERM &&
> +           !(file->f_mode & FMODE_NOTIFY_PERM))
> +               return false;

This still all looks very strange.

As far as I can tell, there is exactly one user of FS_OPEN_PERM in
'mask', and that's fsnotify_open_perm(). Which is called in exactly
one place: security_file_open(), which is the wrong place to call it
anyway and is the only place where fsnotify is called from the
security layer.

In fact, that looks like an active bug: if you enable FSNOTIFY, but
you *don't* enable CONFIG_SECURITY, the whole fsnotify_open_perm()
will never be called at all.

And I just verified that yes, you can very much generate such a config.

So the whole FS_OPEN_PERM thing looks like a special case, called from
a (broken) special place, and now polluting this "fsnotify_file()"
logic for no actual reason and making it all look unnecessarily messy.

I'd suggest that the whole fsnotify_open_perm() simply be moved to
where it *should* be - in the open path - and not make a bad and
broken attempt at hiding inside the security layer, and not use this
"fsnotify_file()" logic at all.

The open-time logic is different. It shouldn't even attempt - badly -
to look like it's the same thing as some regular file access.

              Linus

