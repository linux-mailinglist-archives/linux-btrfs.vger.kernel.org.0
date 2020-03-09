Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5E17EAE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCIVKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:10:49 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:37514 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIVKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:10:49 -0400
Received: by mail-yw1-f48.google.com with SMTP id i1so7379267ywf.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3kzEpzh2hKVAT32x/E22CBCBM5gWuaXo+Sele/oClSI=;
        b=jOXJWQTO4qQNV+DimBoz+WEQES2JRFILvrbLftLHpWNhI6z8msKgDjzeHG2lliVrSp
         C6dcxYnn5LPACwaBqWOuBUCUSPLE/Q6py9NfuypAixt61Re1gL77mjyw8vW2piqXSg9R
         fmG4Gh7q9XG9+i92OI1SNqi6cde63Avrqw/62/h6LL2HIaN1lx3PhSUgD2pXrRsZgVji
         ZpgUb+/YxsEn3PMEm/qxr9PO+RZtzKUTu8OrdJ8yAjdfdlTIZ3a0hmGG4pT4DcnRjdDE
         NUCl9zXeUq7Nn4uRW6OJ+MOxVuJ1/oas4m8UIEZURE5jYt/keQvzEUCI12PdfXKt1BL6
         thJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3kzEpzh2hKVAT32x/E22CBCBM5gWuaXo+Sele/oClSI=;
        b=gf2oEC0wneqDqgRs1mxm67ZYL3A/JYoRO+Z13rJFCHll/UELgKEMJMVHhbog1Qh1Ao
         Bx/XEbPNBqcOoHnefmXYIucUs5mMTiTeAndW6t2SbNDSKf6zguTQkdXf9dMpw4dP1kFt
         axCNE2kPlTV8DR+ZcDPltkRkeSOXef5N6X8lIM1UJN65siBwn07ywYTV5nxsHL7gNto8
         1YfgAvFrTZMBA8TWgQJ076hblFEsGidDFE5+MXWaVf84+LDvuhfi3z3/GLsvxs5E6XCu
         Ueo29Bw/ntADv+Ob/SLXauhiKXfrwUyOCbfmfQvUuqmUHQ7z4p4plblmYaltupnnFoeF
         RtMA==
X-Gm-Message-State: ANhLgQ2O9KiXttHfbkr88ndLidAp9IPAnE26TzI9m/2MTOYME9MmjGd8
        Rxh/y/vJVMv9cjKZ8BCQ1F2qEAcLMDWMezOTnQhAvg==
X-Google-Smtp-Source: ADFU+vs2xuvMfEM5vwqII4eUkKYpyhtzhqFpcm7jtb6jcni48wQ7/6Z3EjN2GkhUp+teUdvfZgoyLrJDbW/GzyguXFY=
X-Received: by 2002:a25:c055:: with SMTP id c82mr17665674ybf.387.1583788248685;
 Mon, 09 Mar 2020 14:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAAW2-Zd4jGOBK6jxpqbOfwACTYkDg6Ep-EZ9Ejy7RuJEQn9F7Q@mail.gmail.com> <15ec9ccc-6bad-dc04-5008-7168ced1f7e4@casa-di-locascio.net>
In-Reply-To: <15ec9ccc-6bad-dc04-5008-7168ced1f7e4@casa-di-locascio.net>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Mon, 9 Mar 2020 21:10:37 +0000
Message-ID: <CAG_8rEeEDcJLa3PjwLsri-yaE+wUvdMCLWPxkMtgM37M-XY3uw@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     "RooSoft Ltd @ bluehost" <roosoft@casa-di-locascio.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the suggestion.  I ran memtest and it found no errors.
This is an HP Gen8 microserver and according to the spec sheet uses
ECC RAM.

On Wed, 4 Mar 2020 at 21:05, RooSoft Ltd @ bluehost
<roosoft@casa-di-locascio.net> wrote:
>
> On 03/03/2020 15:42, Jonathan H wrote:
> > Update:
> >
> > My most recent scrub just finished. It found a few hundred errors, but
> > many files that were not mentioned by the scrub at all are still
> > unreadable. I started another scrub and it is finding new errors and
> > correcting them, but I aborted it since I do feel like constantly
> > scrubbing is making progress.
> >
> > Much more interestingly, I ran `btrfs rescue chunk-recover` and it
> > reported that the majority (2847/3514) of my chunks were
> > unrecoverable. The output from the `chunk-recover` is too long to
> > include in a pastebin. Is there anything in particular that might be
> > of interest?
> >
> > Also, I take the existence of unrecoverable chunks to mean that the
> > filesystem is not salvageable, is that true?
>
> I would suspect memory corruption at this stage then. Run memtest and if
> it finds anything wrong switch to ECC and don't use that memory for
> critical anything.
>
> --
> ==
>
> Don Alexander
>
