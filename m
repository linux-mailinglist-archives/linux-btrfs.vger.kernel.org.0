Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7674475F1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 18:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbhLOR1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 12:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343601AbhLOR02 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 12:26:28 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4BC07E5C5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 09:25:50 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id y196so17117864wmc.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 09:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=cJlDUfpq46FBvNkVqLdgj18Rg1pAxJtGFVkJcLJKl30hPbe2xQVyhgQWoW1d2lXEEh
         C8PBY8w63Pt8eeQsGSLKWHKgNOTGT3uZTgPjf15asCS0I8nZhfufl1APElY2ecpKoY9i
         giCxeqg1cduFIgZqbqZxckqJqWozDoq7wngC0Gvq1q8TwPPGWTyH2tSqZpLvOH2qDc5F
         Mm25cIp7AZESyTDNdbQL7PCy/j0OKxCrTiEhSNeJlyqRn7Gc0xm8p+GbK38QekLxArnc
         gVoUT3DAaWi+rLvuKt+q1teZDMi5q1a3FSlupC/coKcc6aGNLcv3PI01yZbZXLg0TY70
         lomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=t8AOw7twSiJvgL4JZ0CoWcFoHWg7kWpRu0WJ2YDrXI75suVDhWgsnvaj4cAWHM24kq
         VfYkzy0jRf3QqW4uuUDGVl3xgujePv1gwD6b5grhMK3eaqox73lp7Qrznqk+6BWckSOA
         ASyb9YIGlAcv0S2iGuk2+R+JRJX/NgFkdzgCwMCcO2OnXDhlA91eYaMleGYD+y6x4dV5
         +VQ/O7z0kwlNEm+hZyMCSjVeouATnxwn+gwmJ2I2+JyvLbaaeHGY4xJRshGdSB1iGqGd
         qRDSPVXZA+BsCqyLctJyBa+eLXrrwx6VQ96uSDwxDSHHo670KRXR4/dr76DwIU6y3qkh
         50tQ==
X-Gm-Message-State: AOAM530aO627/uNcpD9ZVvb7WpMlACrpRodbdYublvBlKmi0a2EY//lc
        J4TZGHdY9xGK6w8iFfD1Ux9JVSlJaHRruGc1394=
X-Google-Smtp-Source: ABdhPJzRnwzQ/5F4rhSxrQnNlB9PpQLBHPvH6HtGcgdhNhce2mo1/jx92j50Qs2H3/Xyc99Lx1SNMoU2jYKvxKmsdBU=
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr962639wmk.162.1639589149481;
 Wed, 15 Dec 2021 09:25:49 -0800 (PST)
MIME-Version: 1.0
Sender: donnalouisemchince@gmail.com
Received: by 2002:a5d:674f:0:0:0:0:0 with HTTP; Wed, 15 Dec 2021 09:25:49
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Wed, 15 Dec 2021 17:25:49 +0000
X-Google-Sender-Auth: kMiTZ3QE85-_xNffHzgb-NGmk9E
Message-ID: <CA+4Ruvsyza7nAVVhc_6qSTrEQ2M1yG7bVS7TUvTqPCD2cft0XA@mail.gmail.com>
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
