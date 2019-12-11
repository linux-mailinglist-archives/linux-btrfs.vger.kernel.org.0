Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC47311A35C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 05:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLKERA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 23:17:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42949 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLKERA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 23:17:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so973322wro.9
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 20:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PQ5rQ3wik2ixjrnLCweqtH51YItg+G/tGkSEH/Bd+Yo=;
        b=GVzEL5EqPxao4ATXBC1uVCO2PZIvALYAVuqVMLM6V+m5cuD8kvlemT76jeSoYoCDHT
         dpRTFFiRSzCcgUHReyhfNcZDnp3KFmgfpa4l+/z0pFX9Ck4DLsx5Br7HOegBp41QZWYz
         3pE8gqCV8V4g14+3KFP1sK9L53UxAzrwCflAv9VtxPQWOCeM1Kl+MxFfnijJRupWtPmD
         EF9aG86Vk/Nlughme+BmHSaLZnYAxA/0BxBPLBmdXR5QI4h+rH9F+w0d3zFn94hTkAPt
         VNfJiMDfe/wMl4wDIGx+I8GV6OKwQTTcF3Oi1nGfhJXmMQS204j81yXGK/C4tmYDO2nx
         6E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PQ5rQ3wik2ixjrnLCweqtH51YItg+G/tGkSEH/Bd+Yo=;
        b=PNE/9fb8gGoPSyLj2K4rRurDu9lpQY2sk+BcGpgv0g/M0MyTjHXLEWWqR10xq4IJcl
         Zlbc1dwy01ZpMNyPQwhwaiAo+Akx9yrIQ4e1me2uBLYonc5apLu1Xfd1FzkqrOpWXVXi
         5bDBwBQXYU6ILm519ZZ5IDEcetTzc+w9kqPhQyqVi2oMAnPdHkbNnKPFm9Y8IcH0GmEn
         8s7ayGTZpAqo2XHId4yFsmjqwVhW9WoW8Q0I4nXI21kO2WLKD9V+xLlRKI4RPGDmcKE0
         4phcPB23hAiNWHAqsNWLHlLUE5Z4PuufT3FHGXrmkFw1ASyB8SRQcRe9gpNry5tgHrsC
         oquQ==
X-Gm-Message-State: APjAAAXz2pKvUgeU1eTQe8nWLQ6QbrR/c7tbnxr3UVw2Is69LT2IzI+3
        B4l+Mdq3udDKS60wapfdU3IJYDXiIQiI2BAc/O2eZfiIfpc=
X-Google-Smtp-Source: APXvYqwl6qFn1LVxKBJzKSwhIs7tv8ZzsrrES/IkSkJvGkgvu8ob4nnFpE1dLC5qRAZ2qqo5uc5n8QHPUULTf4uJ6cQ=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr1105457wrp.167.1576037818100;
 Tue, 10 Dec 2019 20:16:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
In-Reply-To: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Tue, 10 Dec 2019 21:16:42 -0700
Message-ID: <CAJCQCtRSQgptZ7_Pez8FjHN6cErShOG1F7BRdYciGq7Fb=fL_w@mail.gmail.com>
Subject: Re: 5.5.0-0.rc1 hang, could be zstd compression related
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK this is interesting. It took 7 hours to hit it the first time. And
the consistent reproducer I've now run into twice, is 'dnf install'
any little rpm, which is what I was doing the first time I hit it. I'm
not sure what about dnf or rpm is triggering this,  I've got other
things doing a bunch of small file writes including Firefox - yet
those don't trigger it.

Next, I tried a couple more times with compression disabled, and the
problem doesn't happen. So it does seem zstd related. Maybe.


Chris Murphy
