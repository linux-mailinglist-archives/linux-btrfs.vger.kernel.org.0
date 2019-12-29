Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62F12CB2B
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 23:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfL2WgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 17:36:14 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34068 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfL2WgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 17:36:14 -0500
Received: by mail-ot1-f48.google.com with SMTP id a15so43986228otf.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 14:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8e7cjnuyI5g+mY9aoUF/4FfbwHBARWUU2b2upKX+Ug=;
        b=Io81CBBx+4a2zEUe06m0hhKpfRw6PKSSQewL566ll7vqgJqrXZofbxg1PIsntVRaNk
         jYmcqsHW+HUur9122Yt9fv80qEWZ6byTzM1tQhf6bqG10H6knKV2HdnCThl+v8Gblile
         +rtQ258uzoD/R+HRQnFfJjPmBcU2LiEW4w8kDGyts9TpEsWknsdtyDoOKgMYiKsvMOHa
         v47EOrEYDbb8oyhsktl2gfG/0XQozCGl5uu6+XvRj9sS1ZMIx3hfXWRzjiGp3F03PH4L
         nXetc6dpQRF30PDeyxfDnT22nVuH3VsHsB+KtKcSlxWxlAW5BJGSlsk9nXmA82BDTzMD
         MtjQ==
X-Gm-Message-State: APjAAAWM6hMMK0P61xoL3Pze9hGH09qftZFlV4q8y9yIeWNsSRA5TVj2
        mwCvAfP2fQEShHBBoW4pLJXQAUTIHVbF0xNdVXDHkw==
X-Google-Smtp-Source: APXvYqwR9pAuYszQNA+1nbdKCbg50Uk1SOzKFjA2E/yBs9AzhkiYgkn8RjGx/MzA45p5RZDl6W1tS17BYm+hG7Iqo9c=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr72653135otq.75.1577658973692;
 Sun, 29 Dec 2019 14:36:13 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com>
 <CAOB=O_hLvVaSdnvXwFeC5h6=AySnb4Fh9Fzx-zjFmw92odSLzQ@mail.gmail.com> <CAJCQCtQogopy56foRdqb6+3ejYL=gofVyYKwoAWFjYRgyaVZew@mail.gmail.com>
In-Reply-To: <CAJCQCtQogopy56foRdqb6+3ejYL=gofVyYKwoAWFjYRgyaVZew@mail.gmail.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Sun, 29 Dec 2019 14:36:02 -0800
Message-ID: <CAOB=O_jmoMJ=Tt7wRqv6btofDQCxefYC7LaNKye7MOiQ98Djbw@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

K.  Gotta roll a new initrd with btrfs 5.4, then will reboot into it
and grab logs of btrfs check (both iterations, against each of my
volumes).  Probably be a few hours, so don't expect another follow up
until tomorrow.  Thanks for chiming in.

Would it be worth creating an image of the drive while I'm in single
user mode for faster analysis/iteration?

On Sun, Dec 29, 2019 at 2:32 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sun, Dec 29, 2019 at 3:28 PM Patrick Erley <pat-lkml@erley.org> wrote:
> >
> > Should I --force it while mounted, or run the checks from RO mount status?
>
> Check isn't reliable when the volume is mounted rw so I personally
> wouldn't bother trying.
>
>
> --
> Chris Murphy
