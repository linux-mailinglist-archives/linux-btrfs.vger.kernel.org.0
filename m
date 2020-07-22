Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE82293D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGVIpL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 04:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVIpL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 04:45:11 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D90C0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 01:45:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so1374148ejx.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=akV/dRYzdAbVJUqudH2g82YqoeLVqbQtmqc5P09QKO0=;
        b=GcF+E3W4K8vOpgmizEKcG0Sd6FgZP5JZ/cDx4TEt8l8dxFxFT9riuLYiNCvFZKMC08
         yM4t1elPwuY1WjsRuyv+vNhg5Xjfxb0fEf81PX9TNjNhYyYj+K8a9IQhLx76Ct4fghZp
         iv9lsgfVrYKo/z+D4aQr0I6zGUrHh+nF1Rx36+mNbM099gRPboYO6Xh8kjYb2CEdDI1T
         UO8+FNDN73PfqNLyEJvDCfrQUZyrsMBh60FTFejOfRlJeMwtvvk4rlExugsY/9uQFuhp
         u8/JbaLN99pu86QANpDM2PJM7UclxPUu10isfxqe72rheEOaFtIzgcv4Cvy9wo/oWcDT
         L25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=akV/dRYzdAbVJUqudH2g82YqoeLVqbQtmqc5P09QKO0=;
        b=gbUpdkL/bNEMGwPGO2z/U3Q+QuvY0hDF3IBCDMJmoBMxwcQIfiX5YqtRrNCmWKR6jK
         qElfaPmj7ut1if+qc2ckx2tHGlZ5ro6JxUtDXX6lSnTh5vl/OMNhugVVsnZ9PxnAX59V
         MsQExm+ocB+Ha4EdOAej8Ci+oCGBzdlN0f7b1XH0OUOQyAqAya6KbKSuTtN8b4LpqAAb
         AMY8YyHH1BqntlpjFemArvK3DAXcV3tt9KWiKxGb7Mi44qlbLgUDRDWJvHmfrdLP7dYq
         1Y7DkmknTlZZgHHDuu9Liup+jSsr+HNWcucxIk5uChiaonW7z1+g1ZsiIrB6Vb4m3Jil
         mdcw==
X-Gm-Message-State: AOAM533VXfvkAlPL1t4nTGigX6QMEl+Ml1kXomCw+4Asljp6SHyZqk9+
        oOJIEMot3EjjqkTQed4rcUz8t4Tv
X-Google-Smtp-Source: ABdhPJxLbNRnwqKeInbHjQXO7pBpj+PFybGPVAiouq2ovIXuRm+KW1s1YhrTMYenQr2ZJrA9Nn9XeQ==
X-Received: by 2002:a17:906:8542:: with SMTP id h2mr28700929ejy.517.1595407509355;
        Wed, 22 Jul 2020 01:45:09 -0700 (PDT)
Received: from [127.0.0.1] (178.115.129.56.wireless.dyn.drei.com. [178.115.129.56])
        by smtp.gmail.com with ESMTPSA id u13sm18765591eds.10.2020.07.22.01.45.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 01:45:08 -0700 (PDT)
Message-ID: <bb7c5ff8ee271c53d34c41026c6faab6@swift.generated>
Date:   Wed, 22 Jul 2020 09:25:17 +0200
Subject: Re: media-style.de
From:   Karl Geringer <ggeringerkarl3@gmail.com>
To:     "" <linux-btrfs@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Guten Tag

media-style.de wird nicht mehr ben=C3=B6tigt, und deshalb zu=
r Feilbietung ausgeschrieben.
Vielen Dank im Voraus.

Mit lieben Gr=
=C3=BC=C3=9Fen

Karl Geringer

..................................
