Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B909412DE61
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2020 10:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgAAJnn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jan 2020 04:43:43 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:46532 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAJnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jan 2020 04:43:42 -0500
Received: by mail-vs1-f43.google.com with SMTP id t12so23793197vso.13
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jan 2020 01:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=q6zxQ7xHPaF801a4XeJFt7MB7VXV4TkhwxAxWJf5/n4=;
        b=wGRB7dQSpzPHc/i4qpVSJvhB4Hj9QivYEgYZEHvazmDpXXtr0DbDUo667zBuy4Dp96
         hbbhLmABmQCOY8TaXrFODRRKG3UI4L33igDsewAnk7GMkswp4eqZ1GjKVxca3PlCb2Ff
         oXu2N052Pqrmse3QQKXheK4w3KO82/zXfmBMPNngz9LHjbAcqYB49IH2BFBPuWboHqrp
         sDhfwHoHRoqLGK0vpGMoomvNYNZsJRKv+tvcKZVAkbAJ2hnkX8ZK/A9zNa4eJfp331RT
         Curcx74V2iq6wmbKggm9m+MMGcgOCgQb2rLaUsRkWcjdXkZR29ekf5dt7zej0pGTtjFp
         ns5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q6zxQ7xHPaF801a4XeJFt7MB7VXV4TkhwxAxWJf5/n4=;
        b=IDtUhFQtaszxyS6NsOXT/Nv4c6EAL7IPz+98pRwLp7SHRcd1AsH4UBmtlMiddevL/T
         OdhJzAAOGalru5IG9WLx/If+sXac2LhQWSGwBixuZJrTcrMlQ8YQprMCCiboxNGBAwqq
         kNdtyzpnjznrd281I+tHn6PGCHj/llKtubqwDJuaM3TXrg0PJFY+1te9hGVeWW5k3Nzs
         3JXzrRnOP1O49LK3hVh5HEOs7iqY+EQk3Au9+/YV2+Ps/jwRgg8Vtjl4dsQrJCZEQaj2
         d9nw8inhqVn3qr284zUd+Xu4JS/tMYFyzKcLhlNDugywqnCTVjY/8VoV3N3DlaMGNlQQ
         EvNw==
X-Gm-Message-State: APjAAAXr+Vjpy8e7t1LVNlBNHU8hypGHvK/bGx6IKEUZAh8y3eJDc1w7
        Ci2s4Mexssb5YDf4SgaIJ03SX5byZBUQ/k1XBMy5VghBGSc=
X-Google-Smtp-Source: APXvYqw7DyQz5rnMWpzC9zuFDXaes6f3aYZaKLwLX/P2+k4ulB97PpWdWsLrqPRNO4g/v///dfuXRWC35Xo7gL/wh30=
X-Received: by 2002:a67:3187:: with SMTP id x129mr36434762vsx.23.1577871821421;
 Wed, 01 Jan 2020 01:43:41 -0800 (PST)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Wed, 1 Jan 2020 12:43:30 +0300
Message-ID: <CAN4oSBf7qU5nD0NH+Ds_-+Tv4kr8JqcGjRK9JG_zRto5VfE8VQ@mail.gmail.com>
Subject: Scrub clogs system suspension
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reproduction:

    btrfs scrub start /
    pm-suspend

System won't suspend if you don't cancel the scrub.

I expect "btrfs scrub" somehow listen the system events and cancel on
such events and resume when it can.

btrfs --version
btrfs-progs v4.19.1
