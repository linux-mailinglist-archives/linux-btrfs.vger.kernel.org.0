Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7421F8110
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jun 2020 07:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgFMFUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jun 2020 01:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMFUi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jun 2020 01:20:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA3C03E96F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 22:20:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c71so9675223wmd.5
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WwQwIKtYADqIDZvDdHclK1btKAsFgXsDvWccMeSMZB0=;
        b=hb8xL29jtSHfJTn+X9jlxDf389Zp/mG1BfDmS9vK7pRtJJBS2Ux6nGAGa7fMVNoK+A
         2MXfXm55+/fqYVjKIpb67JA7mH5JrM/1GExI5p8zBDLwLCfloWErxO19ZZSVhR7HKV5F
         5mkFfX5ugokLpQjJMZyMTp558EMHSPp3Q9FWI3v621bUWfDaJ7xqX5F1n6elH3dxQnMY
         n1zCUCh+/N1JKsh1atFQQQzZeXlPQTUvxyG6vVoRO749R34Jm02nLIgGXQcOc8F4zFUW
         bIpkBS7qoo6srlzbPWzSJnApusDMehG+XiWuNC0rud2GWfZJHE3RMwprnkFqbXqSdHkY
         BGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WwQwIKtYADqIDZvDdHclK1btKAsFgXsDvWccMeSMZB0=;
        b=rZcTjSlmaG+pxOG6P0cgD4dRhdXWR9xScqdnuDHX4TJLIKCpmZse9zJDIPNU0PmQbS
         6DJbZmpV4mU9DjCS7YYnyMgUPLq3jKfXSkelfg/mUMPrALdADyKwyLspriphn40/9ZH8
         ZrJJRo0UJqJdAnyc892qbDSzbIGDWqb9Ro9ZB2QhSU64YRTzPMdd5XAq8ZpZGKlJhtHz
         4zAEKroYezbWSmN0CBWLunA3L43xRZsIEQVzoVXQiZOM4q0em2shRhVH0P2C51Q765hg
         QhvTUDQ1KrtbDP/tdncLGAHDKlJq0DVxhj/IttY30jsnWR6UBQ7PgY8VyEYRaHTksd1x
         kHWg==
X-Gm-Message-State: AOAM531w5akgCVMf4I4HY/wPdLAGyzx2x3hOEjRYEdwaTbl7pIMn7tMm
        YX/1ICM8V+yELNmH51VjUP5pUcOBIKrBnkrCBJwaU1B5
X-Google-Smtp-Source: ABdhPJz+6FhbEaBxDIqus/sc2hks8sLGBVMZXlpVv6qwdQQQOzKDulTDWSIK3nXSas5vS2pVoiMxD6wmQ67FLbZqGlk=
X-Received: by 2002:a1c:5603:: with SMTP id k3mr2317506wmb.116.1592025636723;
 Fri, 12 Jun 2020 22:20:36 -0700 (PDT)
MIME-Version: 1.0
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Sat, 13 Jun 2020 15:20:25 +1000
Message-ID: <CACurcBuLnsLKB1qgsOyU+W8TecZEnfoqnLziA6ynT95DEvNdDw@mail.gmail.com>
Subject: Does balancing also defragment data?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is something I've been wondering about lately. The defragmenting
tool has known issues that break reflinks when run on files with lots
of snapshots or copies, but balancing does not do this. The manual
states that running a full balance without filters will basically
rewrite the entire filesystem, so does it also defragment as it runs,
or does it preserve the extents?

Robbie
