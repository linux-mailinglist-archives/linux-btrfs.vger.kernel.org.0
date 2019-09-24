Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B8BD2E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439785AbfIXTlK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 15:41:10 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40351 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439635AbfIXTlK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 15:41:10 -0400
Received: by mail-wr1-f44.google.com with SMTP id l3so3334048wru.7
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=vnLAZa5IHw1h8VT2+pT4hddFDlu6TDs4cBLZNrQAqRM=;
        b=da27hWwSV2jZAzlvXi7BZlMdp7vPNMICsyEPiSc5QjtJV7VXq1/OWM69cZhbTcbN0O
         SoBTh23MN1P4QY+MQkjHWf07UTcQpHMj/xpXYwlpRs9Zv4DcmqoPLfuZkNlNgLiCwbHX
         E4XoXNMZCnE2cC+Du5Stn2lfFXpWnznrtImwAhoWOf4W4+u2VAbVb3ufZk4H9xvDrlXu
         tnkJk8wQRpd+3SMKaekC5AjjIlIHF2mV7c1BmOs/FZjzF1md2EE1EclT8a4ZpT7BF6WL
         2J/jgZFzqsPZCkFzwe5Jwnl8mxiqpaglZ/KP5t8oWuoLc+cg6iT6zo6LnZyi2g6HSFpP
         bDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=vnLAZa5IHw1h8VT2+pT4hddFDlu6TDs4cBLZNrQAqRM=;
        b=YxZrwYhHc14dzVGpQ/UF2md9FzC6Ar82XkQgCm5EOIM3xDKfXDfROZQ0XpLYtFcMBi
         qQ8xaj1LPr8q6VeXAeRAqafezqm+bX76zJZkUZyYA+dLjdAV5bfPgDHcMWa0yJZUhEFH
         js7X+lnKfMi7dvPXxIcJcoKgrWPtZDVIWrGabRkHWwC85+95grLHdR57jDjVL6pZqTHI
         4p8ZTrLSYQ2LB5Lpl0lWs8B7Vt3DAF0+keSRao5lumpbg5ZULhCq+v4HoRw9GH4DM4wF
         6sA2b4aYqD+bwVDGKGvlnqn3RCPKphrDmewcbTqzBGl36j4ArfV5h6sCWTMOvh+o1Quy
         Ju5A==
X-Gm-Message-State: APjAAAXKPc46Xda1QWPP7qRUtL7PLtGIM6oIq7U5Kz96ItqQny2+rl5E
        kwUDssBZQq7j6ptNYzYXi/Ut9ghXzIc=
X-Google-Smtp-Source: APXvYqzQz6WpSTD+xpOsBSopKnOW8UICCyd5V3X25kcHbpIUffRIUTZ+nWSMxkjaKlyOf+ikxGtiRw==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr4000657wrn.373.1569354068009;
        Tue, 24 Sep 2019 12:41:08 -0700 (PDT)
Received: from MHPlaptop (xd520f268.cust.hiper.dk. [213.32.242.104])
        by smtp.gmail.com with ESMTPSA id d13sm541060edb.14.2019.09.24.12.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:41:06 -0700 (PDT)
From:   <hoegge@gmail.com>
To:     "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
Cc:     "'Chris Murphy'" <lists@colorremedies.com>
Subject: BTRFS RAID5/6 - ever?
Date:   Tue, 24 Sep 2019 21:41:05 +0200
Message-ID: <004101d57310$01e985d0$05bc9170$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdVzEADcqX1uVqXQRhq50DD1WD/2BQ==
Content-Language: en-us
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Chris and others,

The problem with RAID5/6 in BTRFS, is really a shame, and led, e.g., =
Synology to use BTRFS on top of their SHR instead of running "pure =
BTRFS", hence losing some of the benefits of BTRFS being able to add and =
remove disks to and from a volume on a running system.

Is there any outlook to getting this fixed? As far as remember I saw a =
pull request by someone who had fixed this problem (adding some kind of =
journal to BTRFS) in 2017? What prevents that from being implemented? =
Time, people / spare time developers, Linux kernel people, or is Oracle =
stopping it? (to favor ZFS)?

Any insights?

Best=20
Hoegge

