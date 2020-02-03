Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1B4150845
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBCOU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 09:20:56 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:37858 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgBCOU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 09:20:56 -0500
Received: by mail-ua1-f52.google.com with SMTP id h32so5369094uah.4
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 06:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qfRO/YXYKxPhwvNFkGiwhlNlgA/kUDt4ytfIGy6NKhM=;
        b=V8BnWGJJ8lsgqAf3U+XQuF65omW+CV+8y2CG9rkyXAMPIdW4mUvNyluZa78f9cV29K
         kh1FP1dSnfBYX/CWpmfmZ79isVrk0uUBFO5hzvx8D1eKbqbMTojKn/I7RSAYEZC8/U1k
         9FmwbZ8fIWxB10ip0kmXqu2u611GILEmvrbmAxVYeXzGhKDU9BRcz7w3x7LfGmd2PEe2
         ulTpe7Yfxbh2o3WBqvI/1UwNtUmd5Qk7jqMg/SHNrYOBzmq72CtuiUIkRXd0M6TWR5Hc
         BWnSvp4wZe2l5qPHOGruYhXAMhy1kPI8bjanhqMlg0ANchAdvR6DHkuuwVbaE2+CzGXq
         wlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qfRO/YXYKxPhwvNFkGiwhlNlgA/kUDt4ytfIGy6NKhM=;
        b=LxPyLlydMxwbVYWFXU94NndnOJ1yiy6hpse1psVLdbD0Rfanp6Wsuyz6U+FR/4aqtm
         Y8V77grdB2TC2FXmw2CYZ2h7vxNtEQD6ejZlCRm42c/X0CmSrBdIk7S0q5w9SaU+zKDF
         Coxw2xfaqPa4AYKmDHxaYGa9/AOvh//2i0EAqXJL9s3XBiDQABqPHXKZtEFd6GZtIX2S
         jIfybyzZUBMi5GSr4NE3wJITfDMQErEhuM+4Y73h1IQLmqEDEHwXlyuzgWVz4ShivrZB
         /JUyKW3G7FF73TTKL2FORn/tahst5hHKixur4vQd2XaeaRUnoKBLj0eKX3sjbok8iFyv
         mAdA==
X-Gm-Message-State: APjAAAVESR4E2RfQSyHASOTlWevmeRflBwHqv6JLmvFtQkinJknvuzTz
        iBKhk6xttjghkh1HPj6uUEWbYzZ46uVaOBMSMImpww==
X-Google-Smtp-Source: APXvYqy+plUJr7ZOMRrYJeri44hG4MGvAGrUDfj8H3Dg/+gr/4mhY7EYcdTp16Trq/ScibUCRWuQFh1TAPX6Mnvgx/I=
X-Received: by 2002:a9f:2275:: with SMTP id 108mr13983461uad.82.1580739654903;
 Mon, 03 Feb 2020 06:20:54 -0800 (PST)
MIME-Version: 1.0
References: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
 <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com> <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
 <1f891d68-ad1e-e303-cea8-b3fff5d21f66@georgianit.com>
In-Reply-To: <1f891d68-ad1e-e303-cea8-b3fff5d21f66@georgianit.com>
From:   Robert Klemme <shortcutter@googlemail.com>
Date:   Mon, 3 Feb 2020 15:20:18 +0100
Message-ID: <CAM9pMnOm1DoXV9mD-t0mW2XQWeKmPQ-Tqz_p_EnSsA7bF_nnEw@mail.gmail.com>
Subject: Re: Root FS damaged
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

On Mon, Feb 3, 2020 at 3:12 PM Remi Gauvin <remi@georgianit.com> wrote:
>
> On 2020-02-03 8:58 a.m., Robert Klemme wrote:
>
> >> If you have an idea how to reproduce such problem.
> >
> > Not at the moment as I did not observe any unusual circumstances.
> > Having the system up and running for a while is probably not a useful
> > test. :-)
> >
>
> Have you recently converted to space_cache=v2 or otherwise tried to
> clear / manipulate space cache?

No. Unless some package update would have done this. The system was
set up in 2016 and I did no FS tweaking.

> On the 2 systems I've seen this error so far, it was shortly after
> converting space_cache to v2.

Kind regards

robert

-- 
[guy, jim, charlie, sho].each {|him| remember.him do |as, often|
as.you_can - without end}
http://blog.rubybestpractices.com/
