Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2F13E40
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2019 09:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfEEHuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 May 2019 03:50:20 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:29432 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEEHuU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 May 2019 03:50:20 -0400
Date:   Sun, 05 May 2019 07:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fomin.one;
        s=protonmail; t=1557042617;
        bh=NFEGfeuPshF+Y+E0aTekkv+05ePnmBfttqXZFkfZ0Kk=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=PgLHVpTKROyp7DhHDo0pVcKcePrQLIyUY+3piONNwLxI9Rcds5U3/Oqq5wntS6oVu
         jxgxS/2+4mzSFpzQu6PXqJv9sNrKx96LmxZD//QpKWruX1zUWzU5EjaTCDlVL0av6/
         Fjlc+Cill3TLkfV7Vi5npQ8AMr9ZJgkeKfKXXaAY=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Maksim Fomin <maxim@fomin.one>
Reply-To: Maksim Fomin <maxim@fomin.one>
Subject: Hibernation into swap file
Message-ID: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
Feedback-ID: KdoJEVg5m21Zx-ZSt0YICttvNlCPIx4ISbXx_ujMcsAL9BeL-sYmJMAlEoWM-R55KO6tZ96oLFF00uPgMM7IOA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good day.

Since 5.0 btrfs supports swap files. Does it support hibernation into a swa=
p file?

With kernel version 5.0.10 (archlinux) and btrfs-progs 4.20.2 (unlikely to =
be relevant, but still) when I try to hibernate with systemctl or by direct=
ly manipulating '/sys/power/resume' and '/sys/power/resume_offset', the ker=
nel logs:

PM: Cannot find swap device, try swapon -a
PM: Cannot get swap writer

After digging into this issue I suspect that currently btrfs does not suppo=
rt hibernation into swap file (or does it?). Furthermore, I suspect that ke=
rnel mechanism of accessing swap file via 'resume_offset' is unreliable in =
btrfs case because it is more likely (comparing to other fs) to move files =
across filesystem which invalidates swap file offset, so the whole idea is =
dubious. So,

1) does btrfs supports hibernation into swap file?
2) is there mechanism to lock swap file?

Best regards,
Maxim Fomin





