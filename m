Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021B247A0C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhLSN7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Dec 2021 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhLSN7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Dec 2021 08:59:20 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73EC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 05:59:20 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id c10so1805801vkn.2
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 05:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8lRUbeDOU13CvrjNfZAWDe+x6O+GDAHKbf5BsZOCy/k=;
        b=JaTzjsQaxlNg6PLyCY5urJnEdO0UdiWrLmTxdks4FRpu8yZqHq4LrF1fA8QMz4l+xa
         zzKKMrPGWbtfkr1soNVjFgdCBgNRcZzgfR0wLsRaHjs9dTVzb9Yn+TBEMjx8vhH5uweD
         /VHRmetoO/2c/WqIan5wKfRZaUyaha6k2+dOf0j6oNwD9RYtr77JcLH3Il46kqa3GQlN
         xD6IhnqWORpjrC8+oMPmfH3vzpPtgJP/u3CjSFeDS/zfjSfSJf/AN7u5LJHJOOo/gGs6
         Hv8NJ0zBucP6XGpVG53O076fLkNw8+Wa7nKxhorPAYJTAigxtQATUMcDp8p56P+kCORo
         kc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8lRUbeDOU13CvrjNfZAWDe+x6O+GDAHKbf5BsZOCy/k=;
        b=GJTFUO8ehWx3G+7Hvp2/Es7OdVh+EFcTbWOHsSL4ZZe87a2l936H/xkbc0KivpIzbY
         4GPFuWSX0ll1FCVZU7BVM+36QUFZwb6hfgFp1UwtNE56mtMfnSje/MijuPFfnVaOBDjA
         1LZCnT1qHsEk51mD5JoBsJr4agp93YaaKFp8jfJVC3OtCiqBH1nX8bBVvp+jCc59/h5c
         1HpF6tozIdeglvl80mA6A6RUfjd16EbmwairBpZTadPAKkaphED12WSCeM77/lYCchsT
         73fTzkhDt1q+VUliKmJjrcqnN8ov9bDPkY3zqqCKMFjjk5LpY1037vOmBpCavZym1AYV
         +b2w==
X-Gm-Message-State: AOAM531HkflKbD1qRL7LhhwEyO6t60Kjpq12rUwVYpimVo1io9+uE8SN
        qa9OweXFGIOUzOYLO2sl7XAz8d490YUnXnfZAOVrwUDOQeU=
X-Google-Smtp-Source: ABdhPJwnz9SdOKbQZkKW1qKVtspcEW2+wNFPaSLYk0zANN9yu7S9j6eBh0uyX8aAMvkOTmIw5Yl47P88jJw/FKE0h6g=
X-Received: by 2002:a1f:d903:: with SMTP id q3mr4456703vkg.37.1639922359570;
 Sun, 19 Dec 2021 05:59:19 -0800 (PST)
MIME-Version: 1.0
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Sun, 19 Dec 2021 13:59:09 +0000
Message-ID: <CAHzMYBQ5zMw=dUMRqn-_qYoAjYKadj6qio=5t3nudiOftTaqOQ@mail.gmail.com>
Subject: Balance metadata
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, I remember reading in the mailing list that we should avoid
balancing metadata, I have a filesystem that acts exclusive as receive
side for daily btrfs incremental snapshots from a couple of btrfs
filesystems containing 3 Windows VMs, it's composed of 5 HDDs in raid5
(raid1 metadata), the snapshots appear to be very metadata heavy, not
much data is changed daily, I noticed that the script was starting to
take much longer than in the beginning, it usually took a couple of
hours or so but I've been using for many months and it kept taking
longer and longer, especially in the last month, these are just some
examples from the last few days:


Script Starting Dec 06, 2021  02:30.01
Script Finished Dec 06, 2021  06:13.50

Script Starting Dec 12, 2021  02:30.01
Script Finished Dec 12, 2021  09:30.11

Script Starting Dec 16, 2021  02:30.01
Script Finished Dec 16, 2021  10:59.36

I'd like to keep this script limited to the night hours, so I thought
to try raid10 for metadata to see if it would help, and this was the
result:

Script Starting Dec 18, 2021  02:30.01
Script Finished Dec 18, 2021  03:52.21

Seeing this, I thought no way just raid10 would make such a big
difference, so I rebalanced the metadata to raid1 and this was the
result:

Script Starting Dec 19, 2021  02:30.01
Script Finished Dec 19, 2021  03:50.09

So it looks to me like that, at least in some cases, a metadata
balance can be beneficial, so I thought to share.

Regards,
Jorge Bastos
