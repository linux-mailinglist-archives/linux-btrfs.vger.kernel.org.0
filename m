Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C241A1347
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 20:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDGSCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 14:02:48 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40259 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGSCs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Apr 2020 14:02:48 -0400
Received: by mail-wm1-f51.google.com with SMTP id a81so2797519wmf.5
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Apr 2020 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DxI5zLPJfSNzdp5IhGUdAWD1wqdNfWSlBmfrT+7/roM=;
        b=biGoMUWlbNUOXzG0AIjEsOfuGX9+MUSkNzDK3LaB2OzpJ4zZ5hU6taleNH8rHfEMZD
         Vb4L6ojujHuTtgFCfbLrWHQffEZS6tmm+x1pTIV+KcoMjlcf2dKC8t1ae9mRHXPsgdVu
         cDS71y7acmGXD9oXxHyqVweUFn8Barh6CA7jWUahAYADdLZdWCyaI90lt+vrEVHLQ5XS
         cdxLG5mCsAo/uc6MTyyUB6yayze0dXlZ9fvaEBpF5+Qkf9nHo6N4TLdolYZuxo2cnybT
         tVh1WlFv0d37+s4ijnU+GC68CZ8805rwicKXH5NHlHZHJkXySKokYLQnP7u1vcFILG3A
         FtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DxI5zLPJfSNzdp5IhGUdAWD1wqdNfWSlBmfrT+7/roM=;
        b=pgqwHknFGd/WJ7K7BMHjs3njL2HxTR8ZTGHZdvcptO5ECoREkG1W2TwSgTAnxykMw7
         t6fzW/M8ojQdDtKn6U2AxnOT2xt3JkCR62hTfEAVN2XWC5cTzELCp1tZWKvbpW/LDRTX
         57GmTWfJThn0OSKjp7CBZrtH2snK6SpRWeo5b+gNyMpofmeI20ZLKGXjy8xIKRS+beVI
         FMque0c2mFKFmti5iDzPJrZhjjXQZUC3e69ddHohZ2y4jbp4BDgdXIrFR3HCH1ZDlDWy
         9b3bJ88ascj+oiL+ifDlXqbDmiE5bDBr5QwJgcSi5V0U107EZ3kGyGk1DNxF9k75EzJ5
         ZY5A==
X-Gm-Message-State: AGi0PuZoeCVx/HwGhhWvzhHWXIqUs/zRQCPz8v63bXF8tIC3t9346xwh
        KdXtqlZ2PvldYqiTtMSahMm79uULmVxzV4n2KAqeTnaoJzQ=
X-Google-Smtp-Source: APiQypI1jN+cFU4z+b4tHmq4WBuLlEm8pbwfMP6z5uJtvQsknv7f/J0yA6GZfQpcasWr5MMYo+Tgj6dASz8Wiuc1l0c=
X-Received: by 2002:a1c:2d41:: with SMTP id t62mr473007wmt.128.1586282566496;
 Tue, 07 Apr 2020 11:02:46 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Apr 2020 12:02:30 -0600
Message-ID: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
Subject: authenticated file systems using HMAC(SHA256)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     jth@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

What's the status of this work?
https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@suse.de/

Also I'm curious if it could use blake2b as an option? It's a bit
faster I guess.

Thanks,

-- 
Chris Murphy
