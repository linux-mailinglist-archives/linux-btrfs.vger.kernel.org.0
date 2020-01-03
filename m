Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE612F568
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 09:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgACI00 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 03:26:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40040 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgACI00 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 03:26:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so41623727wrn.7
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JJQxreXgv1LQSkDylotVWWUXSpXtwdDP4DeN74/aFW4=;
        b=ru0TEqmHgqHybOn1yZ0pPvLzqXVv6FeuzfxKvlzlJUZutqYp9XRpfmIad8ABHvK5Y6
         DUMDbxQywWmuYudgAm2Nta7EXxk8Io4D9gfyEMPYusxxiQDBQRheLxmxC+p3VPuqlmpm
         dJ4laEttAXz9bH91L9PKVs7cEDiXFLpryqDJqQWZD+QmTeTVYGq9z33vWoyMiNPHITT6
         GI/avzLdGU5I8xAk8MENmWlpoXf9Xuvh/uka0VaM9m5fX99DpWju7ppcAHA3ptvsNjED
         J8Owzh47mqbVFPGa8D2XqVnuQTwdKjox5RZB4/eDerKIFcwCOFUaAoobgoOHv7Emz3JN
         GlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JJQxreXgv1LQSkDylotVWWUXSpXtwdDP4DeN74/aFW4=;
        b=O7VcIQghP2n4McK4UrlrdMeIgnQPkDAGg9ekxSxQthuVgcBQ3RxfZwm4GDwCk+cUce
         yXG0kSp/SCO2Gvp55kTvNsGO3yN0YmXOBixVrO+Tua216jiHMNpAHS3fgP551UB3vRb/
         LKwU8nI5FUAX/hP+E6tPcs3sSDIegv2wcvG1jJFoI6S7WI8JUDzoO4/SXO0rEevzADSn
         Xe5czlasEoRqzZk4BWzl/OB+/Ba7tb4bDyciFbAz4HPvX3l7yyaq8hA7+dZ8pD3salBR
         CCMufcxP888e87FOXHvoow2qdmKqWDzlymDQKPuDtHml1MBXmisMoHlxxUff73V31pGq
         TVMw==
X-Gm-Message-State: APjAAAXckM+KXc/PsWcFjwqhOd02eaVCB+XAjVgwtqsNwAU/ariLz7wq
        2YfcUkBPQJfmx6GMXid+DKJWu8QTTiPZQwYyROBz8t41tVk=
X-Google-Smtp-Source: APXvYqyMZ1MEKWuETaa8yoS05eQRFlQvgB8JRwmL5VHYJlNylOh5ap2GIa1OpH5+FAnSevfQjT8OM45Z1uDHYkuGaD4=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr87666317wre.390.1578039984080;
 Fri, 03 Jan 2020 00:26:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
 <4eca86cf-65c3-5aba-d0fd-466d779614e6@toxicpanda.com> <20191211155553.GP3929@twin.jikos.cz>
 <20191211155931.GQ3929@twin.jikos.cz> <CAJCQCtTH65e=nOxsmy-QYPqmsz9d2YciPqxUGUpdqHnXvXLY4A@mail.gmail.com>
In-Reply-To: <CAJCQCtTH65e=nOxsmy-QYPqmsz9d2YciPqxUGUpdqHnXvXLY4A@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Fri, 3 Jan 2020 01:26:08 -0700
Message-ID: <CAJCQCtTC_nJmBZmv2Vo0H-C9=ra=FuGwtYbPg41bF8VL5c9kPQ@mail.gmail.com>
Subject: Re: 5.5.0-0.rc1 hang, could be zstd compression related
To:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTW, I hit this with lzo too, so it's not zstd specific.

--
Chris Murphy
