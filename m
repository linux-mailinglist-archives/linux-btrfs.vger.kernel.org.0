Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0A4B066
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 05:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFSDUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 23:20:39 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40508 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 23:20:39 -0400
Received: by mail-wm1-f47.google.com with SMTP id v19so84651wmj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 20:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FgWpfjXH32DD//PvuhcjR+qMjwnD6ACbnNYTHvIjVPI=;
        b=wxEtlcgpsqId+qgF6+8b4E1lr+p5898aBReE5yN6dhNnif9QnQXZ+HLeeyWgNyNkRz
         6DVzRP2/0yOL6Q4++eF8DPRWDkDjbMryO9J6AGk+UFvFKAlS5Pzj2A+W8X5szatcYH1l
         uYVldNJ+8x3oZWfPpymyaAJCM/8KrLfUY51mw+LH7dpQCKbxzQmfT8bDiJSynLHHuaWV
         yWPsQY9ev8cMBxKSrFf0OQdAztwqhzgGHh1+7vz0wXTh3zg2MkiS1jxNN5Hk+lBZTJsk
         fMmJWPW5wQNvGVcaz6LCGQdMeOYZknil0gi1PnebkxzirRyZn85sWAF3CeWVxHsUz8yS
         bF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FgWpfjXH32DD//PvuhcjR+qMjwnD6ACbnNYTHvIjVPI=;
        b=aHvNo8osCS+WaX1JDF/AV3ZWesutZv3TsHd8DD34XGi439vEcXjqal82SpGixqu9+S
         qRxBmrFHWcQFtkqIz4bIy5wfslMlPUm57eCy6K4UOsgSacKWz/UTsCUnUarT9WIQoScZ
         pQknsrbMMENisr66ZWVEZgFWwd4IFUMp2VgEUCNpw5QjmwirgcWPs8yQOn6WPDvMLlRI
         bRjWUFKlNoJRr6EeWvdrC5ncpG0X2Ctsy9PwwgrX8PDvh+pR1Mxu1y+gFrphf6K/6ngh
         6DJFoAAC9jp3pqhBVDAlk2po3re/KOIvMPVFRIqi6GovEFeSFg6w6KckvlpEyp8K617w
         /SCQ==
X-Gm-Message-State: APjAAAW+fSp+IbHsEPC81uBPCHE/NCRTQKfdqvTkyEL7stw6/KwOhT2H
        rWm6JZPtHjE36+SFlDoOkKsldmQa/KUZDfWEE6I31J4mquE=
X-Google-Smtp-Source: APXvYqwYXiYshWCtarG9bXgduBFG0pmJpF4pPZ8di6Ty42hhO4KxL25kRvSZvesLc7XSBFj+KgMJXHyZ0tuvEcp2WdU=
X-Received: by 2002:a1c:f018:: with SMTP id a24mr5756689wmb.66.1560914437353;
 Tue, 18 Jun 2019 20:20:37 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 18 Jun 2019 21:20:26 -0600
Message-ID: <CAJCQCtSE2VbeGFs9o=KhPTeRGwZJ=RA2uzc3xG+sU0X-SXbRuQ@mail.gmail.com>
Subject: updating btrfs-debugfs to python3?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is on Fedora Rawhide (which is planned to become Fedora 31 due in
October), which no longer provides python2.

$ ./btrfs-debugfs -b /
/usr/bin/env: =E2=80=98python2=E2=80=99: No such file or directory
$

I expect other distros are going to follow as Python 2.7 EOL is coming
up fast, in 6 months.
https://pythonclock.org/

--=20
Chris Murphy
