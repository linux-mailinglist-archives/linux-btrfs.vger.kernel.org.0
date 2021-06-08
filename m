Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6C39F976
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhFHOrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhFHOrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 10:47:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F2C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 07:45:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ci15so33027603ejc.10
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jun 2021 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5PAJp4qSJC4Thpc64cQCx4iq66tSg7NGOrrTI74y9qE=;
        b=UGl7Bmt//BCI7mlPi3YQ5Y82wxUWezikInMQiurzYG9CF1kM6KJAl0sSel3H1k1E9g
         AOuNftovMqAWcPg83bEVEQH7nks5m9emhjVsG7HU+9GC+7vAWVQNyvenltl0irbBifA0
         WtQBjyyChuPrPNd6dLo/P9Ivhgx0KIWIdVqiMMJkinDQ2WHdp+BxrsdNbKJpag0HrPGy
         hAFu7jLY9x9+0LM7tLgAUa7Nzii4/rUeKGJ0zbSkxyltmEpNUE7OoYW0/rmPxlWG1sAz
         rZ48yuIOJibJPwwrsy0Ul0WJki9Ml2dDVeO3vJ6kMdgjTJVG/yHn2rKlGjVf/kVtkISj
         0vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PAJp4qSJC4Thpc64cQCx4iq66tSg7NGOrrTI74y9qE=;
        b=fpfltfeeAwiDeDonp6/Wrm5nAGhuRPqkqpKJ+nlodBgvPswGTQ3AruPJ/K8/67ScDM
         kZcGqbumaaDq7spR7y+AUA0fmo/RQ+bKIjulz7mOqWcZyWiEgQDhN5zolrFBzL2NK4Nm
         Vq0M7MIMq8pou30aEtohbRBx5A15pViVZ2QojLvCrOakDJMq5cDxUOGtSB6HkK1D/CMj
         j13z6vmfN056aAq6dsh4sH4uowq7hkHKA9MzRvwwviV1U1KDixsRkv6CFPkNsdGarkcT
         5PCr6d96sc04E1Zk9iuPGXK8j9HipHi9opQTcB8KwH6d1DZsEToKqeQZXMSpDc5xOEGh
         9JkA==
X-Gm-Message-State: AOAM533LiY4Cx2yB+rPMRfEC1y7yLm5V5Cnq1fUzcf3K+BiL1pdndhqa
        yiSu7ssy5Zf0CXkaBYpJp9Y6X2xUobI=
X-Google-Smtp-Source: ABdhPJx23K2tOtrFGzPj6mJAsyz3MsWFRU2hBJ51GsHvnF287AqD3qrgB7/DRVNvRPww2BejKpE1Kg==
X-Received: by 2002:a17:907:2150:: with SMTP id rk16mr13577247ejb.166.1623163512298;
        Tue, 08 Jun 2021 07:45:12 -0700 (PDT)
Received: from localhost.localdomain (ppp046176007146.access.hol.gr. [46.176.7.146])
        by smtp.gmail.com with ESMTPSA id gz25sm2066680ejb.0.2021.06.08.07.45.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 07:45:11 -0700 (PDT)
From:   auxsvr <auxsvr@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Write time tree block corruption detected
Date:   Tue, 08 Jun 2021 17:45:10 +0300
Message-ID: <4655545.31r3eYUQgx@localhost.localdomain>
In-Reply-To: <3113674.aeNJFYEL58@localhost.localdomain>
References: <1861574.PYKUYFuaPT@localhost.localdomain> <3113674.aeNJFYEL58@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Monday, 7 June 2021 14:55:10 EEST you wrote:
> It seems that every time free space is less than 1 GiB and I use zypper, I get a similar corruption message.

Correction: I just got:

[26355.330817] BTRFS critical (device sda2): corrupt leaf: root=3 block=537007243264 slot=0 devid=1 invalid bytes used: have 64503152640 expect [0, 64424509440]
[26355.330819] BTRFS error (device sda2): block=537007243264 write time tree block corruption detected

and:

# btrfs fi df /
Data, single: total=55.98GiB, used=43.04GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=2.00GiB, used=1.17GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# btrfs fi show /
Label: none  uuid: 44c67fa4-e2c4-4da5-9d07-98959ff77bc4
        Total devices 1 FS bytes used 44.22GiB
        devid    1 size 60.00GiB used 60.07GiB path /dev/sda2

60.07GiB used again!
 
Regards,
Petros




