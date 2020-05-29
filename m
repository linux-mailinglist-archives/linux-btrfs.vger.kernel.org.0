Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC2D1E88CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgE2UVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2UVB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 16:21:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A23C03E969
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 13:21:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z5so3324285ejb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qxa3M/MvhiqYKdmf/w4n6AgdA8qRvXt1CZdlD0nn0dE=;
        b=Wory6WK+oDlOWEcRoDt+0+BwTOy9GvA8rPYpGJf8Md+2mJDLoyrIRamSFm49MWOgkH
         6kI/VGCheyNUiLm1mGksOMEn5Hfk+u47SldEZriTLqyOx2/+bdV6MfmfliLjLvcy4xXG
         H6Mjp9r3x5NU+Cn/5qOosfg+qFT2I3eeq9JQEHjP9xeaYlHHXt2Odc8s0Q5AuuohOAJT
         zIerFBFT9frPC+uIhaMokKO6MmQOdcguwT+hLZijH+NfO5HJdQkLeU00J90ylWpb2OiF
         Z/wECX8NPBbW0fBqVH0uZUMTCA77/82fcq978xxFcMgXXI5A5AoYEd9nMEirErUipT0v
         lenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Qxa3M/MvhiqYKdmf/w4n6AgdA8qRvXt1CZdlD0nn0dE=;
        b=Fb8Qubm2eOFXPxw8Wd/C8h8pZ22+aofEttV4abt13HALDVM8dQIYi2RZLXZkO4IJNI
         nzPnbom3hJUS958vjyMe0zeAi77XMH4HZQc8xg6yi4XgQKEWs0boc9wAqEvcypmXaJwT
         VuTjgzlHeeGkutUzbOCRtBJZUj1GK3BKGFijr/bsG6Z26e5W9V5zyUIXC2IdMiLAztxX
         a5S+wYjzrDgiyLD4ZAH9vZHsKMG1Pb0QBVCFXzJlpDWHrKnHYisyIy5Unqlm3PC62Kzs
         1hyR9QHcwURFrkN45Gk1Z3TgSWdwAHIUaZsJSKrWHBx8nXs3Y+zEr4dwKy2VjxOiJiL9
         VuDA==
X-Gm-Message-State: AOAM530RC/1+MKYfEXAypZt2drJiIBqXKcPY4CgF5UybnkMKLUi8QkH1
        HQeQ/5ZfQtRwU6qjpqdbFlEDTMWlTsE5J6WPN8/ik4Rm
X-Google-Smtp-Source: ABdhPJwytCaqiE6GGyfoOO8fx7FpHpuYt93xGN2qNM7gsjAOGrZQHeYQnsFc5AcaCGBHFW52mqggvSLA8Fd20lp6wYw=
X-Received: by 2002:a17:906:aac8:: with SMTP id kt8mr9495236ejb.460.1590783344288;
 Fri, 29 May 2020 13:15:44 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rmst227@gmail.com
Received: by 2002:ab4:9cc9:0:0:0:0:0 with HTTP; Fri, 29 May 2020 13:15:43
 -0700 (PDT)
From:   "R.Mustafa" <rm2568590@gmail.com>
Date:   Fri, 29 May 2020 22:15:43 +0200
X-Google-Sender-Auth: yH5ZOE3YJ5k9xnBSH0ASf0mU1UA
Message-ID: <CADxkk6VA=UzauhmZ1Hi1tnBZb_7joZrWMZg0VsOC4GXs4rVV8Q@mail.gmail.com>
Subject: Assalamualaikum My Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Assalamualaikum My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is
not a hoax mail and I urge you to treat it serious. This letter must
come to you as a big surprise, but I believe it is only a day that
people meet and become great friends and business partners. Please I
want you to read this letter very carefully and I must apologize for
barging this message into your mail box without any formal
introduction due to the urgency and confidentiality of this business
and I know that this message will come to you as a surprise. Please
this is not a joke and I will not like you to joke with it ok, with
due respect to your person and much sincerity of purpose, I make this
contact with you as I believe that you can be of great assistance to
me. My name is Mr.Rasheed Umaru Mustafa, from Burkina Faso, West
Africa. I work in Bank Of Africa United Bank for Africa (UBA) as telex
manager, please see this as a confidential message and do not reveal
it to another person and let me know whether you can be of assistance
regarding my proposal below because it is top secret.

I am about to retire from active Banking service to start a new life
but I am skeptical to reveal this particular secret to a stranger. You
must assure me that everything will be handled confidentially because
we are not going to suffer again in life. It has been 10 years now
that most of the greedy African Politicians used our bank to launder
money overseas through the help of their Political advisers. Most of
the funds which they transferred out of the shores of Africa were gold
and oil money that was supposed to have been used to develop the
continent. Their Political advisers always inflated the amounts before
transferring to foreign accounts, so I also used the opportunity to
divert part of the funds hence I am aware that there is no official
trace of how much was transferred as all the accounts used for such
transfers were being closed after transfer.I acted as the Bank Officer
to most of the politicians and when I discovered that they were using
me to succeed in their greedy act; I also cleaned some of their
banking records from the Bank files and no one cared to ask me because
the money was too much for them to control. They laundered over
$5billion Dollars during the process.

Before I sent this message to you, I have already diverted
($10.5million Dollars) to an escrow account belonging to no one in the
bank. The bank isanxious now to know who the beneficiary to the funds
is because they have made a lot of profits with the funds. It is more
than Eight years now and most of the politicians are no longer using
our bank to transfer funds overseas. The ($10.5million Dollars) has
been laying waste in our bank and I don=E2=80=99t want to retire from the b=
ank
without transferring the funds to a foreign account to enable me share
the proceeds with the receiver (a foreigner). The money will be shared
60% for me and 40% for you. There is no one coming to ask you about
the funds because I secured everything. I only want you to assist me
by providing a reliable bank account where the funds can be
transferred.

You are not to face any difficulties or legal implications as I am
going to handle the transfer personally. If you are capable of
receiving the funds,
do let me know immediately to enable me give you a detailed
information on what to do. For me, I have not stolen the money from
anyone because the other people that took the whole money did not face
any problems. This is my chance to grab my own life opportunity but
you must keep the details of the funds secret to avoid any leakages as
no one in the bank knows about my plans. Please get back to me if you
are interested and capable to handle this project, I shall intimate
you on what to do when I hear from your confirmation and acceptance.
If you are capable of being my trusted associate, do declare your
consent to me I am looking forward to hearing from you immediately for
further information.

Thanks with my best regards.
Mr.Rasheed.U.Mustafa.
