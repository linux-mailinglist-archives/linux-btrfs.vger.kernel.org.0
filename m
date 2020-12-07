Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7322D1D47
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 23:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLGWZL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 17:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLGWZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 17:25:11 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE5C061793
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 14:24:30 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id w18so8484772vsk.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 14:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UulNqKmyToGbdwW1+2Vfz4vmqiRUxnEcGfImZTM7vD0=;
        b=HCxUQT5UY6sQONwIWkWJt9K3LUeFtGKXZyY6TItxfp5HIrpQDtx71OhvEMANHe/H5Q
         wiFDlsGJa5ro45/JtV1rqE/a77+NmF+LUkhwEAjkNAmd7JZBtXPQjlhq8LtDxk0l3RzK
         xa+gJ74/E3VDqtkNgA7eiglBR2H3ibv+wkNHBgLznliasiHa0uZL/5MvoYxpOMvdvxsL
         yHj9zgszre5TQdSgD5wwTqIc3S/PK8jhV9eFPT6cR2sWLylkKmSewhhvj9Nsipk8Ahrf
         p5tyR/wJQe+fZ51+Mgr1/NSBWZ7irdhcHXIJfovHIRHNQ2qlXYsQt9ZEm/PY9/YtkFgP
         4MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=UulNqKmyToGbdwW1+2Vfz4vmqiRUxnEcGfImZTM7vD0=;
        b=rfzJ94W3lYjGpILiN9gvkEhPFHej9LNb2dRbrS6TdY56M57RHVzzEM+K4xv2+VMPGJ
         mhbuc//V2bgSh1Ajj8kTNXefxdjt9oXFrNA081YZlC56U44P3GFZy9KY1eo9PbxhEHkq
         Mw8+dwU/PRm19BICKDS+5OQoxJkYeiGKScYWsruR/rIM3Llvmb9tGXQccYau/DIqtLj1
         it3IFhGB6z+8WliyxklAUKbap25pEL0ssvmzDRoTcL3Vq5DZsXazFgvo68S7PwdLHxaj
         jbNJvcqFus6N4JmNGajflSgbLyJ8UBOOPQUjaMeu+Bk4sxjBapK0h0ls85dim51ph3wT
         /LEw==
X-Gm-Message-State: AOAM531F7uf/89h8VxR5LdqUwpB9mMVuHEZ+Cmg04n0+QY+g0gl+gII1
        eybhLL/0iDRftXl3wR50SInA6pvft66G7s44BA==
X-Google-Smtp-Source: ABdhPJwSbobxb2007S3lb/sT+Wm6JZIUfrEafE3cMXKlQFbwfexAUcK76t8vzfUI0/i3d4oLv7fpSWYiZeO0HG6iXB4=
X-Received: by 2002:a05:6102:3111:: with SMTP id e17mr14724097vsh.3.1607379870109;
 Mon, 07 Dec 2020 14:24:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:176:0:0:0:0:0 with HTTP; Mon, 7 Dec 2020 14:24:29 -0800 (PST)
Reply-To: carriganedwards26@gmail.com
From:   Carrigan Edwards <alexanderthomas427@gmail.com>
Date:   Mon, 7 Dec 2020 14:24:29 -0800
Message-ID: <CAO+LcEa6H-OU7UPO3ph5nAdd2jQkmprBbx7Q8CDSmus1w6Tbsg@mail.gmail.com>
Subject: =?UTF-8?Q?Gesch=C3=A4ftsvorschlag?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
Hallo,


Es ist mir eine Freude, Ihnen auf dieser Plattform zu schreiben. Ich
habe einen gro=C3=9Fartigen Gesch=C3=A4ftsvorschlag und m=C3=B6chte Sie fra=
gen, ob
Sie interessiert sind, da dies f=C3=BCr beide Seiten von gro=C3=9Fem Nutzen=
 ist.
Ich brauche eine freundliche Zusammenarbeit von Ihnen bei der
Durchf=C3=BChrung eines lukrativen Gesch=C3=A4fts. Bitte geben Sie Ihr Inte=
resse
f=C3=BCr weitere Details per E-Mail an: carriganedwards26@gmail.com


Carrigan E.
