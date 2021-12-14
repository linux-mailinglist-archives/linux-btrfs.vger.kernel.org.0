Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2130F4746E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhLNPyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 10:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbhLNPx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 10:53:59 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559EC06173E
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 07:53:59 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id z7so3448687edc.11
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=PYd1/kqzGjecG7Si3sFFgwnhpZBBAYqXfjPx6KgYqniPGx1QmH9rBRAZj76dekq8NB
         tFYb4W3nj9xu2FrbwcUIsN1rCU2gcEWPPGYJlpsJ7AAaBW8Rp8BE1Q40jgbkmKGugH5d
         i8eUZaZptAdzkwDgIMCR9qlUc/iP4ixBQMJn3TP0JZx4ls5QbHCcrBpUG4/ZWs1Zwsq2
         Ivzat26GExWH1OzYIPkGphoiQLr4Vr8KqbQdU5hbK3Edl0ZqBt0k9T6EWxx//iiOmHrz
         rqVPb9Sapn5ijcyOf7o6aoaFVJVgcN5wvINqMCCn3kOwAKArF1V8YD963up8vWSEjwO4
         /3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=Qef7RmUWATBLNisZlQ1yWBCtbrGIflHCPjn9lr5a5I8LrASYlDlcQQcklj3xcWMiXT
         xl+3Dz2DCKMqaujRgnTmFWnyMPf7rkB3FDZrNHEmYE519kOl7ZrBSNoLZsyr/fDPm9MG
         vlQiO1TghM+8hNgytODEv2Eu5x6aBp2rNPucZlaV540tD2f7OXFJikjIKywv792lKiNQ
         toWeOrdL9d4aGK//MQRnqogs+aYVDTAs6B98kQ+W06XoPBJaXoo5uG6lxAbsj/HGpgtl
         go4n5+kVJDt1KWXUrsaZ9aCx84Uk4lJ1tfTaYi5iDCiq2JuuYXOIn0RyiYv7u37+Gba9
         TeZQ==
X-Gm-Message-State: AOAM530f8Sxgy0q0rZBwdu/n2hAyksmhIIYFYPUiGtPf7kFwFbLxz/8j
        mwyY3pQijX3K+uWoh+X+UjKXgQQevSaWZCbaPf8=
X-Google-Smtp-Source: ABdhPJwFPdvm1PXPDqs9Nl3K1nXcUbhIIr3SHo32EDi5YAacczz5W6/Vgjvf2ClFkl2S09NjKyTLhLaF0z5nVMQs9+M=
X-Received: by 2002:a17:907:9487:: with SMTP id dm7mr6583778ejc.2.1639497238099;
 Tue, 14 Dec 2021 07:53:58 -0800 (PST)
MIME-Version: 1.0
Sender: wilfredmark1056@gmail.com
Received: by 2002:a17:907:2d25:0:0:0:0 with HTTP; Tue, 14 Dec 2021 07:53:57
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Tue, 14 Dec 2021 15:53:57 +0000
X-Google-Sender-Auth: 4AhTF4jROdwnZ2eVCa17gLYpvaI
Message-ID: <CAOF4qqjLzr3sD1Qm8thUGFM-fhik+Zsif6kRFfog-ewF26rcXA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account.. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina Howley Mckenna.
