Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD5407A67
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Sep 2021 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhIKUm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Sep 2021 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKUm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Sep 2021 16:42:27 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D4C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Sep 2021 13:41:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bd1so8340310oib.5
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Sep 2021 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E1gGnD+4VzjaN4fKuWiIUIZt6QJcH1BElULlRGhd9uE=;
        b=RfoKERdRNu34CbvYb3kMhsZhXiUxV8yoIFe0uID8Yz1NGJPVBN+3BNy7Ybj/aCrYnl
         3TomONs1tYkkmC1ZiQ1x/KLssvv278t2DE/KpfLx1uBLMePvp3zFQ6Vax9OoSWuSAgmZ
         X/9l7jVn6XsB4xc1EFXyGj9IvLJe1jsWKWxfLEmvFCQH2xjQjL3gk+H7duoeNJIUASnY
         eOHJNmHtYCFjpZS0P/ahPA9HPwOb93XLj+k4TXlRsee4AlQS0o46Q1Vawnn+FgzHO/uS
         B2OLNysLro0nQt/dBDuhNgb1JS087TvqM4Bngf2VPsp2bx8X+kP481zLbylEzz7WfM4T
         tAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E1gGnD+4VzjaN4fKuWiIUIZt6QJcH1BElULlRGhd9uE=;
        b=wCi/0atXplEbqHkYbE6fCh926sedYMRNZnyNr5cmBgO0e5Uv/Le2uu/F5GZzw+596Q
         N+iIncwee90XzgxwSwlM7ulYRNVIjeOflTy+daxTt23pJcNgt6gKzn1TeaXZGIxxtLZJ
         wsfW6PbLqZVq0hQH81DJSnG6y7YylhgKu1hBNKL4xn+/dvMyJV1rqSB+zGUA15Q+EtZF
         nLwq3UdgVQXvQ2iaEY1bi2szCmeJooD5yv2xfqVuQ+cjvB2Y3K1vodN6+ibsEXmWca3D
         UclFxSkJlocO9VMHomY0v6AJQNlQunZhbOHTA2RoPdakb0De4zcGHNOrvJKhoUoEtYVZ
         d4bg==
X-Gm-Message-State: AOAM531bKEUXFAQMYZ9wkw2in/xcBRn678A5k6Fnd7Ph0Ut9t4HuBkd6
        Vw2TkUTvGF3Lgf82FkNpI2TcsPJwmwE8Buj98PI9jYfOd6c=
X-Google-Smtp-Source: ABdhPJzatIdmgopeplGGMdM1/lnsuA6rbdqmxrC0/M3A6legjIkQ6xpc5rlTJJcS8hD4sVllcu6h/nBn1LvVCmej/PE=
X-Received: by 2002:aca:b80b:: with SMTP id i11mr2770767oif.26.1631392874074;
 Sat, 11 Sep 2021 13:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5i2QumFah3aCxC7Zwg1TPGMS-_7nsPxeuJu+JZ-bGYew@mail.gmail.com>
In-Reply-To: <CAGdWbB5i2QumFah3aCxC7Zwg1TPGMS-_7nsPxeuJu+JZ-bGYew@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Sat, 11 Sep 2021 16:41:03 -0400
Message-ID: <CAGdWbB57aE9fmuS3ZU1oBxK3Gqd+7YMRL2oGYzwhvT3=s=45MQ@mail.gmail.com>
Subject: Re: seeking advice for a backup server (accepting btrfs receive
 streams via SSH)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello. I have a server on a LAN that will act as a backup target for
clients that use btrbk to send snapshots via SSH.

After my initial attempt, the backup server became extremely slow. I
don't know the cause yet, and I'm starting to investigate.

The first thing I would like to know from this group is whether there
are special considerations for configuring or managing a server that
will receive many btrfs snapshots from other devices.

For example, do the general rules about limiting the number of
snapshots on a volume still apply in this case?

Thanks for any input.
