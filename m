Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405C319E75E
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgDDT37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 15:29:59 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41037 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDT37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Apr 2020 15:29:59 -0400
Received: by mail-il1-f193.google.com with SMTP id t6so10790563ilj.8
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Apr 2020 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gBRFyq97Ax2QZom76Mv65qaBRRDw+HDRsM4yPNK71e8=;
        b=V1u4h1HmMecjp7xWWOetAUfA9LPqSJIC4p7ejtoTLpQcBWO0MprdMxmUTmPGgRFwNe
         mrXqZVvZm8/YbZOVNlRygdPjOhauECqU5EC5eVIRuGiGoZknW7ddyIWCyhfwl98hYnEu
         5Z23ZTPwlBhkIUy3DvDfvhYAcn/PAFj7ge/+04la7FcSWmjKSlHdnHGgrf3b77WyiAOH
         77JTbdZawY9TWL9D4KVlscnFUWpc/n53e5/hjzkL1mtDCzfv+f7ePQajeDIQvWKSyuMu
         86jkwNW93FlBVsUiEDvX3KdOQYOlxGAy7Hxn5HiupqZXP0+aQLz1s7hJ5XNT75Z7Tm+b
         FAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gBRFyq97Ax2QZom76Mv65qaBRRDw+HDRsM4yPNK71e8=;
        b=EJ2tM5RqG7uUnle1xz/XnlB7iEhH3z5ZyRGBcs+R2gfvaxGBblFeaAAwnFso+F7ADT
         I/RaAvq+2X+lpAkVSJmGky+DQl81mF9W8Uvwv7Uah5Dll94G+IATZvMfbhC0ztj9nU/i
         vs+2VREbu//CEjSM07eCLhs5fy3DxgP3neLA81GQx3NojvUcrRgE8UVFFDZ+6QcPuQAW
         SlD0HPsYmD7Sj5A0GMZLSY6RpuF7znuW7m/0ZQObDBt8wNZwnayHbvE/zxj0hAJSfqT8
         MS1OCLkraV6F6ZLokQJea/IvFPRUwkQ9lYy7S4Yzlk7FSyMQcmYcGaIMqekNZZBcOA3f
         jrbg==
X-Gm-Message-State: AGi0PuYJgGte4htJ0BM+C/EoxbF9p/s5HBXb8hojQ9sMQDetgRFkJgo2
        Ok40+8vFAMV+BkkcFjvZlK2QPlE3SNsPcBe4iWg=
X-Google-Smtp-Source: APiQypJG/AVBtba1bTKFnoWwgP5YoZn96STviSZL5///xkZ+y3wV2B3Lshzz3r/jRsiTudrYDpn1DNy3vpkDLE1pgs0=
X-Received: by 2002:a92:1d4b:: with SMTP id d72mr14414119ild.14.1586028599078;
 Sat, 04 Apr 2020 12:29:59 -0700 (PDT)
MIME-Version: 1.0
From:   Torstein Eide <torsteine@gmail.com>
Date:   Sat, 4 Apr 2020 21:29:48 +0200
Message-ID: <CAL5DHTFjgJ-SErJoAuweA23QCCUH7M8iosvPxGpQVvNjdQ6qpg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
To:     danglingpointerexception@gmail.com, kreijack@libero.it,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I like to see all improvements get push upstream. As a user of raid5 i
like to see BTRFS be the best software raid.

This looks like a good improvement to the unfriendliness of  btrfs fi us.

I approve this patch.


- --
Torstein Eide
Torsteine@gmail.com
