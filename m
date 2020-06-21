Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24DD202B8E
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jun 2020 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgFUQcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Jun 2020 12:32:42 -0400
Received: from www5.web-server.biz ([185.181.105.105]:33179 "EHLO
        mail5.web-server.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgFUQcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Jun 2020 12:32:42 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 12:32:41 EDT
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail5.web-server.biz (Postfix) with ESMTPSA id B159B47E4E
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 16:24:19 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id s18so16979336ioe.2
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 09:24:19 -0700 (PDT)
X-Gm-Message-State: AOAM530qGb0Y0LZOZY9A1Xnl8aqq8QBQ0oJKo0lZ0zFxryxkbaZUpPGZ
        Ciu6CtoGyucSinBfhxjgFpOZrbo4rVS5It7s+PY=
X-Google-Smtp-Source: ABdhPJy4DUvtyKdETRal+YQ47PbRryqyKwtxNPk8D75FhDonzAH3dLeMokQLwSfQmw5sBWUE/phyDbT0AD16/pS/xd0=
X-Received: by 2002:a05:6602:2dca:: with SMTP id l10mr14970154iow.163.1592756658286;
 Sun, 21 Jun 2020 09:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
In-Reply-To: <20200621054240.GA25387@tik.uni-stuttgart.de>
From:   Lukas Tribus <lists@ltri.eu>
Date:   Sun, 21 Jun 2020 18:24:04 +0200
X-Gmail-Original-Message-ID: <CACC_My_ZnU5R3mByqhe8wdwXGpPubTGyoRa5GvUnR2JeBfkAkw@mail.gmail.com>
Message-ID: <CACC_My_ZnU5R3mByqhe8wdwXGpPubTGyoRa5GvUnR2JeBfkAkw@mail.gmail.com>
Subject: Re: weekly fstrim (still) necessary?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On Sun, 21 Jun 2020 at 07:42, Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> On SLES a weekly fstrim is done via a btrfsmaintenance script, which is
> missing on Ubuntu.
>
> For ext4 filesystem an explicite fstrim call is no longer neccessary, what
> about btrfs?
> Shall I call fstrim via /etc/cron.weekly ?

Unless you mount with the discard option [1], I'd say yes, the manpage
suggests so.


--lukas

[1] https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)#MOUNT_OPTIONS
