Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBF68F1E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjBHPXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 10:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHPXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 10:23:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CE460A6
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 07:23:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qw12so52075398ejc.2
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmvqp0Xlc8h8V1QdpDAXAuUo85aw7JqvRi/7aFjIyyI=;
        b=RXJj8lixrIcXrgdJOcBcrW0fX8CkZ8zwmnyN/Am6IXdWnC3wmeekmbPOqWJSqtQ8mb
         lwl2r++3d+qcOEL1j5PPM5nhQgPjsO8XPS13Q57rEXO7tfdT20nBJtRgjjjcuE1zjGPf
         /ZZ2LlLdVOkWGq+qovREA8uSa+aM7yoSUR4+vtrCX3EbEALgK/uhlEkaQkTywDH7WKc1
         I90Pup2t7xVtmFK2/ERJc7fr/FTsZl46JB2MI5LR7qNT448fGU0Pq6gwafiviP1q0JXF
         /B1cn6ZH5UhUE8qYL4s1hiYTmMXlvmvNSCchyDNy1mXxN6Cr9tAHqpa2YMo93NRmb9h6
         8clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmvqp0Xlc8h8V1QdpDAXAuUo85aw7JqvRi/7aFjIyyI=;
        b=UG6mwzrgviH1j5Hqnm/e65W7BdicHXkpDcp9JgzkazKiGc8LfqjTYBRkZB8vrwsNMz
         AZt0TzSm++vmShPXDZ20zqxO7h5I7h/KGjJ5lBNDB0/SrTgaCNrCXqfnSBplkfI6nIZm
         0w4XUAWY1Y0a5UX7snFZjF3hiPJY3QUYHZHGZe2xWnRZ/+ZxEMxggcrTpeO+RInSFlA6
         3DDmyeI3WUC6XsM+RlP/FP5Naj5v+4k4423Bj0hoVwwBYzLnttN69PSc3Te68SiP9rQ9
         GOiywzkG0PMsv1kD6mAfPfUSq5ICC9eoodrbPIYf65bk7FEOtOQAQhOC5QX0YgKs9koL
         BPjA==
X-Gm-Message-State: AO0yUKXZeXROfY22cJh6IPSebMM508xnF/mKUbrG2p2FpyNPyLYi9A/e
        k0YFoyY/BOa0DGC9DqON+q64M+dg4LjblNOytwOevFM6liA=
X-Google-Smtp-Source: AK7set/NKje/ZBpyY24hugunZodi+rvkCI7u2xYnUeMY0mnaSA+tkq8sTWFM9Ivmu/wUAG5/LXZDkO0VvP1p9Lg5yyg=
X-Received: by 2002:a17:906:f6cb:b0:87b:d26f:eb49 with SMTP id
 jo11-20020a170906f6cb00b0087bd26feb49mr1815987ejb.176.1675869794334; Wed, 08
 Feb 2023 07:23:14 -0800 (PST)
MIME-Version: 1.0
References: <CAKH6Scdg_BXDo9MR9O-RosM-VbR2Uz7Or=d_5-x3FSMSu75ziw@mail.gmail.com>
In-Reply-To: <CAKH6Scdg_BXDo9MR9O-RosM-VbR2Uz7Or=d_5-x3FSMSu75ziw@mail.gmail.com>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Wed, 8 Feb 2023 16:23:02 +0100
Message-ID: <CAA7pwKPtkGH3HbJBWj7KA==Vwm+k8V4Q8j-Askxn9C7ZkSWbwQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Leap_Guest_OS_in_Vbox_parent_transid_verify_fail?=
        =?UTF-8?Q?ed=E2=80=A6=2E613771_wanted_613774?=
To:     Paul Boughner <paulboughner@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 8 Feb 2023 at 16:03, Paul Boughner <paulboughner@gmail.com> wrote:
>
> This is in a VM so I am not sure how to get the log out and everything
> is in images.
>
>  I did a dumb thing and hibernated my Win10 host with the Leap guest
> still running then woke it up, then hibernated again, repeatedly 3x.

Loopback mount the disk image and run btrfs check?

https://superuser.com/questions/158908/how-to-mount-a-virtualbox-vdi-disk-on-linux
