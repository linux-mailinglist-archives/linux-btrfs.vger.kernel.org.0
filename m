Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C448813AC8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANOnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 09:43:10 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:44776 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANOnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 09:43:10 -0500
Received: by mail-il1-f179.google.com with SMTP id z12so11669944iln.11
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2020 06:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VWoCqKsvG+50ID6i0tu5JOrPYIOm/F+p9EzpQVObZio=;
        b=rikZrFnOsbzjnXw1wkADCEyLKIQxpwlRPs2QSjNqgRPQw84ZAhU3aEQWaQkl7K1O74
         EWfLcBZRA0yBIaIQaIY7TdH6Xof8YFdnZ2kZMnoer7O0hPMLMg2g7gYd/uGnBFhhLm6t
         Avg6VSeNYzblW+M1PBVYUs3Dt5X5/1gXXj+EvI7ZEe9cuayl7dlWgpZ0hMf6PxUYaZmD
         NVr2l+s4AszSzbifNpwrbUDQY6tnvnOvFEhG1iFocYVSCqxifvcLIa+uzpNxuQNl8TgT
         bE6yMH0f5stVQw/vBCBZ55zFFDzGOC521e6OS2/mIkKvo7JGPiETNs/jDL6IVL9svRrf
         4lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VWoCqKsvG+50ID6i0tu5JOrPYIOm/F+p9EzpQVObZio=;
        b=ay+bLiFbmtJossLP16AOPoyT6v/0jslJuGsbocdeISt/EqMPn4MUrWFuWVKii80VO6
         yI44TPWKjYRdzrDVkAdm3e8RBUdsvGBxTRMPpQoxxdDuGV03jGlsl6gSSh2P4q6Ap+eq
         EHUVAHP5obY3hHyz2sQNFswYcol/aP2fDMJi8tg0Sza/16Elh0zEQrh0map5m2nx8SjL
         HEhRz3Ukp9DyN0aJSOe0cvWU+NnmW49BEquOIZz9t09oHxHhb45ip4Mux6jzQUp+UlIs
         Sq7sI4mIP1eFyXC6mz4S/D8sdVnNwb4XhJWdIRmMKzFepgfg1p0ERiOKMieh9IYgGzzx
         Xbpw==
X-Gm-Message-State: APjAAAUCTTI7+aBot2JY+vfjLtMwGkP4iD++nwDs/CjztyLxyiV7UYR+
        /KLBZW8JY2cvOqt/JNeCCuCwGxFQCZtH68zgpJ4rtyxx
X-Google-Smtp-Source: APXvYqyBLDxyLFk6ZOKwfA49VJfdufXTn8AI9QWxIUAZR1qTBKCHEl/kfjAZ72giYVycWUKust0hCZy/uzfWON183q4=
X-Received: by 2002:a92:da41:: with SMTP id p1mr3923226ilq.113.1579012989514;
 Tue, 14 Jan 2020 06:43:09 -0800 (PST)
MIME-Version: 1.0
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Tue, 14 Jan 2020 15:42:58 +0100
Message-ID: <CAJH6TXh+0QM_hzJhn7bQOxkuN964dbr=XK5HmY2DGR9ROr+_8g@mail.gmail.com>
Subject: Updates on RAID5/6 ?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's been a "long" time since i've checked the BTRFS development.
I've checked right now and apparently, RAID56 is still marked as red
(unstable) on the wiki.

Any plans or ETA to fix this feature ?
Disks are becoming more and more bigger, RAID6 it's mandatory in some
environments.
In example, ALL of my servers are RAID6

Other than this, without using RAID5/6, can BTRFS considered stable
and properly use on critical system ? With or without RAID1/RAID10, in
example
