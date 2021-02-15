Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D131BB71
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 15:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhBOOyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 09:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhBOOyU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 09:54:20 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BAC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 06:53:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v24so10616966lfr.7
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 06:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vlad.hu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=owA/1V73gS1toc+f7sF75sb8DDCSGjEM0MgCe+GiEo4=;
        b=Qt0pqvEiVPZK5g5n3YO50hXfsrT0LBa727y1Qtz1VfGSP3iK6o8o0fwt9NlsWc5i6g
         lnc7LZrz3Sk5mdrz4wYiWKebiiYNYvijspQynw7/+to4379C2kVxNd+W/UYD+s3DhShd
         dKkyy+yorcXMNMeR3faNmUPq0+FqnW1RGeo4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=owA/1V73gS1toc+f7sF75sb8DDCSGjEM0MgCe+GiEo4=;
        b=EJteP+jIY+o7LQKJlQdlT41e81aUPUEtFuRTTP/h06+uYqp3Hd9m45bGlU+WKwYA0Y
         IBgjIl3dQw3nSsLxZ+Hr22hR8eq4II2M73C7U53qr8qkYwGmGL6E4PkjwxXJC0HRiopo
         vuCt9N6IrI8CR5TVu6ATK9qt084IPt5oztfKdK4TpDvuLK6lF8Jgq40T7AuuaQH6UkAO
         X5MxV/3Opd4dCOWQ4onWaiA8dXMfkCKZqtN6K9pwrGX0EHERACQIiVc9RiADAQ3dfvah
         h9ugl2NEN5Bn1m/d5UAw6MmtyLKntXAdOG6H4HelHj/w3xcGGero88UI1OmOXWY2vwEf
         ncqg==
X-Gm-Message-State: AOAM533T64pN3YBkmbNqij4M8MVDbE2EUXI52ldH9E1Ex2wHBYNRp3ap
        fE6KgNVzZAvnbxUMR+0qRYCmJnfOzDUFhpYe7n6Lmx3LEG3aQegY
X-Google-Smtp-Source: ABdhPJxmxHhL5IfTpC0UgTlo/G2XeGVnCpeJw9TRQnOwMu1xpO3X1X29JR/E9X4StWp3NwAFd7dnqbagOMFVSPdGnAA=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr9152347lfe.200.1613400817988;
 Mon, 15 Feb 2021 06:53:37 -0800 (PST)
MIME-Version: 1.0
From:   "Pal, Laszlo" <vlad@vlad.hu>
Date:   Mon, 15 Feb 2021 15:53:02 +0100
Message-ID: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
Subject: performance recommendations
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm not sure this is the right place to ask, but let me try :) I have
a server where I mainly using btrfs because of the builtin compress
feature. This is a central log server, storing logs from tens of
thousands devices, using a text files in thousands of directories in
millions of files.

I've started to think it was not the best idea to choose btrfs for this :)

The performance of this server was always worst than others where I
don't use btrfs, but I thought this is just because the i/o overhead
of compression and the not-so-good esx host providing the disk to this
machine. But now, even rm a single file takes ages, so there is
something definitely wrong. So, I'm looking for some recommendations
for such an environment where the data-security functions of btrfs is
not as important than the performance.

I was searching the net for some comprehensive performance documents
for months, but I cannot find it so far.

Thank you in advance
Laszlo
