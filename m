Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A61475988
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 14:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbhLONUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 08:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhLONUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 08:20:08 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21AEC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 05:20:07 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id y12so73780447eda.12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 05:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Hlvpl7Xc3rbuf9mAz8+CPV2XNrROAx9D0m1IsfOEy8eAwg/IAg8PL+MpRf50YF37cu
         D2JZjFsPkV8PIVZW4chwuTQGA82iY8ixO1kSxySuRw2yHNJt8H8N4dq9WU0vtXxZ3RtU
         nMHlM3FdfmLsFWGcZVkKi/Q3HqgVvKNU34+aYeFQMp339uTXGZ1uXXJSN7yoDClT0aW6
         ccDVGL1FIVX/gyHazcPHJGlqMlCoWN4xEJdEEvopPIljJpmjhZ0AyLPEi6g6vAUYy5RX
         j6zLmQW16Z6WZWq0JmcNs+/kixAbQm52D5Vb5TnRD9aDRgiyA3Pvq+pMh85JhfHZj62T
         HzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=XdSE1Lez89aG6hS1NL8uuvp5g9jzAFkXJehVAq/B6mW2Tz3csN70xTA9iZCWn+Y+44
         Vxawk6AQccpoVfnUe5TBN+WvReOj6/9Fy6f5L1Vhd+aJqXBzqaYfnn2ybeUUb+vbcJgj
         vcC+6RbcEkuG8M9H3zGluGO5boXfIFxn13l1XBRYcoUdBO1V3bAB4Zqlg3Mf3kSxNsUE
         kqQrDmJmJ2wONVTY23X9EYdp4Zcnx/CrmnHqHVqx3PS/ZwJtf4AXNfQZSq9XM4ML/h/k
         e6vSkD3YvSUOt+ZcirOyRZrYtpczJAhsfowcedKZm+uS3KNQ8cDbsclksRXRzITV4kIE
         bsYg==
X-Gm-Message-State: AOAM530Tn7LoUgSKAt3smtV8SRSIC2vA19HpSMIbucqGM8TkknkJ5kpU
        bhjWkJxCDyms6eeEW0mm3S2JUI8m98MF793qP85LO645e1BdGISDxfY=
X-Google-Smtp-Source: ABdhPJxdk8tHOKpQ5UCideNh/Jd5Abrl+4dyLvWVmZIq/8cmbK4Uj++RxHiVsB/VKqL1TPCSbtsOUN54QFs2bGCBEKY=
X-Received: by 2002:aa7:cb81:: with SMTP id r1mr14397291edt.352.1639574405990;
 Wed, 15 Dec 2021 05:20:05 -0800 (PST)
MIME-Version: 1.0
Sender: sanidosissoufou@gmail.com
Received: by 2002:a54:2344:0:0:0:0:0 with HTTP; Wed, 15 Dec 2021 05:20:05
 -0800 (PST)
From:   Daniel kodjo <klawfirm02@gmail.com>
Date:   Wed, 15 Dec 2021 13:20:05 +0000
X-Google-Sender-Auth: Sy7IpI4baWZIknJ26Z9RU1Sl1Is
Message-ID: <CAE1XpSd-5d9ve+4Z7o4VqTNytqD102Rj_Ri9to83y6Dqfwus3A@mail.gmail.com>
Subject: =?UTF-8?Q?Gr=C3=BC=C3=9Fe=2C_wie_geht_es_dir_heute=2C_hast_du_die_E=2DMail_e?=
        =?UTF-8?Q?rhalten=2C_die_ich_dir_vor_ein_paar_Tagen_geschickt_habe=3F_Bitt?=
        =?UTF-8?Q?e_melde_dich_f=C3=BCr_weitere_Informationen_bei_mir_zur=C3=BCck?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


