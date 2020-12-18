Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA82DEB3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 22:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgLRVns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 16:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLRVns (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 16:43:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8340C0617A7
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 13:43:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d26so3795725wrb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 13:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=BVrnFOBNITYCKeO+wqy8Hskrwvb905EF38c/ZDeiUw8=;
        b=2EG5xq487GYrhsL3YlMH1Yd/2+Cc0WOUgjtSJWbPQPwsApakQXOHrXqcrcGQTPDOBI
         al4YjEWnxT+MGbGLnanYDEOgGP4VNdbAC2ji93Q3HKUcYkyMpdJ2Mq31oTDEuD/4pCNq
         zKadZ89R+4Ck9bm4+jEKxd9cRWiTe9aXa09daPNtCsWC5LnmAr5Py7+ViDjAy+h43r22
         b0Y7wAMgFyV+ylahDJbJpjvO3uL6rZD4kfDotjvjvpJtfN32T4aIN1Jn8isCYHuX4Zt0
         JSWD6/Ak/vgwKivC1zE3ztUQ5RdNi/jM9Rf0twXwp7V4rovDn5n7xftUIAQuO2aZFHtQ
         IhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BVrnFOBNITYCKeO+wqy8Hskrwvb905EF38c/ZDeiUw8=;
        b=JrkOCHGn2NunkHcoFtt4qc+hX8R7TMReWje1tWfXDUMmptgegFYnF2dTbwJRGEz6Kk
         9v1cwJLmNv3jA479V09E7yzWEtJr0OBdc0axFK3smz6TVPxQiz9Z8j6YD1C7R1ufqxoN
         Ld4ZNRoV3lYZx40w6NOPAeSkiL+qZWsrMuYhu0b7OIgUTNrw6FeKkKF2Gq5OKXKKIGa+
         Nm3+lN6d5K1kRjvN8j+j7wGneCkZF1EJ6/+eaiJeOXlb8GhdkEvlOY3CTYnBoTCfAam8
         DypGCv9YiiPphyiluXSSbTP63jqZe5MzAuYXIOrB3tj60CnSuaoj3K69b9PeFgi94g+h
         0wvA==
X-Gm-Message-State: AOAM530Kq57bODyYH83dKmVJIe2TkgeV0uqP+jOeZwOEGHth/Ad+ZmR+
        6EIN2YNv1k8j65V3FZng1rp9Fk0Y5hpKn5594YtWTnd8BEr0iajW
X-Google-Smtp-Source: ABdhPJzHzcXlaYNkGPakGHZzxZN+dKOTaFURjErLkpDOgPfvP2if9zULBf0tRhg4aiuETDwQC+JPVHJC2NLU2mlPMaw=
X-Received: by 2002:adf:e2ca:: with SMTP id d10mr6534600wrj.65.1608327786366;
 Fri, 18 Dec 2020 13:43:06 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 18 Dec 2020 14:42:50 -0700
Message-ID: <CAJCQCtQiaAvNGKUiz28jBiw67rSJWp+Ei2uGet2F=xyaziu0nQ@mail.gmail.com>
Subject: what determines what /dev/ is mounted?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When I have a 2-device btrfs:

devid 1 = /dev/vdb1
devid 2 = /dev/vdc1

Regardless of the mount command, df and /proc/mounts shows /dev/vdb1 is mounted.

If I flip the backing assignments in qemu, such that:

devid 2 = /dev/vdb1
devid 1 = /dev/vdc1

Now, /dev/vdc1 is shown as mounted by df and /proc/mounts.

But this isn't scientific. Is there a predictable logic? Is it always
the lowest devid?




-- 
Chris Murphy
