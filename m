Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFF71040E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 17:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfKTQgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 11:36:43 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41159 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfKTQgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 11:36:42 -0500
Received: by mail-ed1-f46.google.com with SMTP id a21so46922edj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RfO/Gk35SHDBkC7zH0U3/rzlw47EuAFzmguOEhaXBGY=;
        b=mQgkFbkINkJKOivdpAqXFVRijXitU/JBmsphdC4p5iwoLfP02Oe20PNeHShbmDKFHf
         yd4soytCJq+eXckp5rJ7L05nMGbMlgEOxscmix1mR0V1uy6S2Lr1mV6bSOR6tW6iqbwy
         SEJuccalrksgBLUwaqVlP08MV1gzexSsNg3EzcOk6ihYx56Y8W3ttzLfWv48m+6xPzNS
         95s/fuOHX8yNcY0n3a5liHqCpJN0yubQAHaa/gWPZYjg84yRlCB5+D7Ns9PRqG+nmka9
         9KShhjkMqOqV6VeVhNDWbIRVwewL2TrIzXlS1OomBLORApJtBWK6UOtzSjeXgtjO+QkG
         +S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RfO/Gk35SHDBkC7zH0U3/rzlw47EuAFzmguOEhaXBGY=;
        b=IkcSvmepz9dEWMUc1Q+xR8djcNjNkCZO2AFc7dwT0el/KLqTEZO+p8hkufhrbq8C7T
         edPdkGkTgkp4ieaq1qECkSZg2FlmOTu63EMP0VvH1KUPdYUQUMKbGyHlZmaAYItcDf6/
         eUkUTc8gyJdMuZ8jWdU4g+6X03ztPGD4fKKT2ArWrit29QG/Rm+XIAkpnrd26aAycuO2
         35q8W6m/yY5R72ym8kUOJRaD916oAToQCIa8Rk2LH3HRbvrRr+QsuJxb4M+T2nPCM53X
         mLYKhXuX9Wtb0rppLkUZQGQLKeJZgF9zQ5VlF2twt1+RLpLizV2BMK/D+1m/gEsFCD8H
         UAeQ==
X-Gm-Message-State: APjAAAURxksC63lfvLLdNoEddBOIcexmWsFB+2Pzfaf4WVJNXtrxlKNM
        5hyq8RuxgHMct8S3oMknCrExbXQjsHTauRbdJHt6
X-Google-Smtp-Source: APXvYqzrVI3Mry/QxdZ0EAbqIDf6ASJZ52JE2DMO1/37YPHwxGn/5dbSAN2FYNuJSB/ITrvYOIX863dlvpRubfKW3jo=
X-Received: by 2002:a17:906:b6c3:: with SMTP id ec3mr6587932ejb.27.1574267800680;
 Wed, 20 Nov 2019 08:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
In-Reply-To: <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Wed, 20 Nov 2019 17:36:04 +0100
Message-ID: <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
Subject: freezes during snapshot creation/deletion -- to be expected? (Was:
 Re: btrfs based backup?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've decided to go with a snapshot-based backup solution for our new
Linux desktops -- thank you for the timely thread --, namely btrbk.
A couple of subvolumes for different stuff, with hourly snapshots that
regularly go to another machine. Brilliant in theory, less so in
practice, because every time btrbk runs, the box'll freeze for a few
seconds, as in, Firefox and LibreOffice, for instance, become entirely
unresponsive, games hang and so on. (AFAICT, all it does is snapshot
each subvolume and delete ones that are out of the retention period.)

I'm aware that having many snapshots can impact performance of some
operations, but I didn't think that "many" <= 200, "impact" = stop
dead and "some operations" = light desktop use. These are decently
specced, after all (Zen 2 8/12 core, 32 GB RAM, Samsung 970 Evo Plus).
What I'm asking is, is this to be expected, does it just need tuning,
is the hardware buggy, the kernel version (Ubuntu 18.04.3 HWE, their
5.0 series) a stinker, something else awry ...?

Cheers,
C.
