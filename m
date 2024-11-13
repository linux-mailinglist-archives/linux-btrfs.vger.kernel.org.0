Return-Path: <linux-btrfs+bounces-9622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EAF9C7D98
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 22:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBD91F23BE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67B18C013;
	Wed, 13 Nov 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dl6K496/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C461C9B97
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532960; cv=none; b=tCYn578oVN9aVnZauWzVaq7db/SNBPNwcmc6YR0kt2nECmQviqmiILQkjMSnalGu9awff7LOhV0sorkScerjdjrbrqrmaXDWq12E1bEz6J4GnRpYFxA+2SNDtAvdPZKPGKc2+F4UbOJZqqmLp2Eb6hwh7+0U62WQIanjzP8etWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532960; c=relaxed/simple;
	bh=Jvfi6gi0QE67lenDTGKJxQmHEYcTqUzyqhTTUKPYxeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuY6/Npa5JUAjNnBOtNdNRwGxQ0zEpl5+xqsyNFCqnEvaVuxQh+KPSplr27ZlsgAgimkUcBQdMFyMV/bnYJ6PWR+h/kdlS4JGpXplowbTnmzgxeFsgQSxBCzxut53xUN3zSsfIwf/N1529s3XxCeQB016yYR92Yuo1hN9jSqVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dl6K496/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf6f7ee970so1442485a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 13:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731532957; x=1732137757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lgXRlfeexjjlrQuWCwCm2fkGA5K7DLXozqP8RwYmyvA=;
        b=Dl6K496/B+gS5mKaR3mB12ePiLzIS4fhP+D+MOHjajQ3fsOydwT+O8fBShJkDARnbU
         GDdzS9NYpjySVlZ0GhuFMVjEITRheRn2MrBPyIHDcwhpoKEZlY+b64XkewBVSMT9Qq3m
         G1c+EHxZW2HNbTWEkjvarikBLNMkrvm5NDl0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731532957; x=1732137757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgXRlfeexjjlrQuWCwCm2fkGA5K7DLXozqP8RwYmyvA=;
        b=BFJaiJYeGtEl9HABuhTevxv3CvKbsCOXRsAc6mdxh34tskIv7P5V7vTG0rhZD5w0+Z
         460nAyCMXAe7GDtDnzUbDBs6fODNhEMOeSuSNHDSTNNtJq4MWWNNe2Na+Q7lKbr/9UaV
         X5djHq64IBHWWPnBNiKN5jeWk06rJLfHOcXNZsD8KhFYOO8PuNjVz4QEgWrL8EwiuIcB
         mRDIMGvtcQ8RntD/SwZb/j5/tjpNQkxMWAreGnB2xlRPlmsMApnQBIWqKc6FDN9hLiXT
         LopstsvdUXZLfLxWKADQs/P/OGq9gbHB8zBixcKbkhWci8c/dQ+P3Yl8XfLb/yif1mfX
         ZGJA==
X-Forwarded-Encrypted: i=1; AJvYcCXKYSQof4ay/HWH/MP70w8EqSgFaE++qIWGyvoM5ORPEqL5soAdakCalutpfxUFaXJL4l6s3RASjgpPyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDsxQA/bfR3B+vPvXQ0tcUGIX0FC4FMQlbl7l28J6yqyIXCqU
	tWalnGNIR//oiW7mEUe9np5RuDLJrmveNkW5Q6oTc+sGU/O7K38kmCRQc6/pdyixlkupxbJGGez
	qhDM=
X-Google-Smtp-Source: AGHT+IG5sVFZh2DG5o/IQ9U9CNWGkPDuZK5uxRxZnvP1AWkuWGDjvp2lT3PjFhBCpi6ho079RR3nhw==
X-Received: by 2002:a05:6402:2689:b0:5cf:3d11:c141 with SMTP id 4fb4d7f45d1cf-5cf4f3b225dmr6802877a12.23.1731532957136;
        Wed, 13 Nov 2024 13:22:37 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7c90dsm7926182a12.80.2024.11.13.13.22.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 13:22:36 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so2838766b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 13:22:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC8SFbjperZjOfIoxsba1DNTf4C9twSAzSIeW7S6mHzNyEHuuSONLkczT/PG9ZqnHu0fSHPTpL1Bd8Eg==@vger.kernel.org
X-Received: by 2002:a17:907:2dac:b0:a9e:c341:c896 with SMTP id
 a640c23a62f3a-aa1b10a4500mr814204866b.32.1731532954269; Wed, 13 Nov 2024
 13:22:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com> <CAOQ4uxjQHh=fUnBw=KwuchjRt_4JbaZAqrkDd93E2_mrqv_Pkw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjQHh=fUnBw=KwuchjRt_4JbaZAqrkDd93E2_mrqv_Pkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 13:22:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wirrmNUD9mD5OByfJ3XFb7rgept4kARNQuA+xCHTSDhyw@mail.gmail.com>
Message-ID: <CAHk-=wirrmNUD9mD5OByfJ3XFb7rgept4kARNQuA+xCHTSDhyw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 11:11, Amir Goldstein <amir73il@gmail.com> wrote:
>
> >
> > This whole "add another crazy inline function using another crazy
> > helper needs to STOP. Later on in the patch series you do
> >
>
> The patch that I sent did add another convenience helper
> fsnotify_path(), but as long as it is not hiding crazy tests,
> and does not expand to huge inlined code, I don't see the problem.

So I don't mind adding a new inline function for convenience.

But I do mind the whole "multiple levels of inline functions" model,
and the thing I _particularly_ hate is the "mask is usually constant
so that the effect of the inline function is practically two different
things" as exemplified by "fsnotify_file()" and friends.

At that point, the inline function isn't a helper any more, it's a
hindrance to understanding what the heck is going on.

Basically, as an example: fsnotify_file() is actually two very
different things depending on the "mask" argument, an that argument is
*typically* a constant.

In fact, in fsnotify_file_area_perm() is very much is a constant, but
to make it extra non-obvious, it's a *hidden* constant, using

        __u32 fsnotify_mask = FS_ACCESS_PERM;

to hide the fact that it's actually calling fsnotify_file() with that
constant argument.

And in fsnotify_open() it's not exactly a constant, but it's kind of
one: when you actually look at fsnotify_file(), it has that "I do a
different filtering event based on mask", and the two different
constants fsnotify_open() uses are actually the same for that mask.

In other words, that whole "mask" test part of fsnotify_file()

        /* Permission events require group prio >= FSNOTIFY_PRIO_CONTENT */
        if (mask & ALL_FSNOTIFY_PERM_EVENTS &&
            !fsnotify_sb_has_priority_watchers(path->dentry->d_sb,
                                               FSNOTIFY_PRIO_CONTENT))
                return 0;

mess is actually STATICALLY TRUE OR FALSE, but it's made out to be
somehow an "arghumenty" to the function, and it's really obfuscated.

That is the kind of "helper inline" that I don't want to see in the
new paths. Making that conditional more complicated was part of what I
objected to in one of the patches.

> Those convenience helpers help me to maintain readability and code
> reuse.

ABSOLUTELY NOT.

That "convenience helkper" does exactly the opposite. It explicitly
and actively obfuscates when the actual
fsnotify_sb_has_priority_watchers() filtering is done.

That helper is evil.

Just go and look at the actual uses, let's take
fsnotify_file_area_perm() as an example. As mentioned, as an extra
level of obfuscation, that horrid "helper" function tries to hide how
"mask" is constant by doing

        __u32 fsnotify_mask = FS_ACCESS_PERM;

and then never modifying it, and then doing

        return fsnotify_file(file, fsnotify_mask);

but if you walk through the logic, you now see that ok, that means
that the "mask" conditional fsnotify_file() is actually just

    FS_ACCESS_PERM & ALL_FSNOTIFY_PERM_EVENTS

which is always true, so it means that fsnotify_file_area_perm()
unconditionally does that

    fsnotify_sb_has_priority_watchers(..)

filitering.

And dammit, you shouldn't have to walk through that pointless "helper"
variable, and that pointless "helper" inline function to see that. It
shouldn't be the case that fsnotify_file() does two completely
different things based on a constant argument.

It would have literally been much clearer to just have two explicitly
different versions of that function, *WITHOUT* some kind of
pseudo-conditional that isn't actually a conditional, and just have
fsnotify_file_area_perm() be very explicit about the fact that it uses
the fsnotify_sb_has_priority_watchers() logic.

IOW, that conditional only makes it harder to see what the actual
rules are. For no good reason.

Look, magically for some reason fsnotify_name() could do the same
thing without this kind of silly obfuscation. It just unconditonally
calls fsnotify_sb_has_watchers() to filter the events. No silly games
with doing two entirely different things based on a random constant
argument.

So this is why I say that any new fsnotify events will be NAK'ed and
not merged by me unless it's all obvious, and unless it all obviously
DOES NOT USE these inline garbage "helper" functions.

The new logic had better be very obviously *only* using the
file->f_mode bits, and just calling out-of-line to do the work. If I
have to walk through several layers of inline functions, and look at
what magic arguments those inline functions get just to see what the
hell they actually do, I'm not going to merge it.

Because I'm really tired of actively obfuscated VFS hooks that use
inline functions to hide what the hell they are doing and whether they
are expensive or not.

Your fsnotify_file_range() uses fsnotify_parent(), which is another of
those "it does two different things" functions that either call
fsnotify() on the dentry, or call __fsnotify_parent() on it if it's an
inode, which means that it's another case of "what does this actually
do" which is pointlessly hard to follow, since clearly for a truncate
event it can't be a directory.

And to make matters worse, fsnotify_truncate_perm() actually checks
truncate events for directories and regular files, when truncates
can't actually happen for anything but regular files in the first
place. So  your helper function does a nonsensical cray-cray test that
shouldn't exist.

That makes it another "this is not a helper function, this is just obfuscation".

                 Linus

