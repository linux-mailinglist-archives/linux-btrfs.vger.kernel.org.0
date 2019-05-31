Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C22D31633
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEaUiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 16:38:23 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:47483 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfEaUiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 16:38:22 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 16:38:22 EDT
Received: from mxback15g.mail.yandex.net (mxback15g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:94])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id AEF9294021E;
        Fri, 31 May 2019 23:31:39 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback15g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id NSNA6E8kDg-VcHaliMO;
        Fri, 31 May 2019 23:31:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1559334698;
        bh=aOESg6dc3jbmPoXHPMF+s4E+BmTMe8uF7HOOkbnQtDE=;
        h=References:Date:Message-Id:Cc:Subject:To:From;
        b=v5/9XNiapzgSOdFGG8jyLT/DIzELyaVf4t4w7spq6rg8HbjtKxp8BF/qN78qE7sPp
         AMKxWuZkP0rspkDlKk03cjwPLK/NV/k2pBEMST2c8bcCg4pjrJUmNSfEhWlfTbW2dr
         IriyRwed5+DUabngfPbCo2OgheVZgLei28FiA690=
Authentication-Results: mxback15g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-add70abb4f02.qloud-c.yandex.net with HTTP;
        Fri, 31 May 2019 23:31:38 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     Joe Perches <joe@perches.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190531195349.31129-1-st5pub@yandex.ru> <a7a2a7c70c2dcef122ddbe86eb84820fc4384c7e.camel@perches.com>
Subject: Re: [PATCH] btrfs: Fix -Wunused-but-set-variable warnings
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 31 May 2019 23:31:38 +0300
Message-Id: <14843931559334698@myt6-add70abb4f02.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



31.05.2019, 23:05, "Joe Perches" <joe@perches.com>:
> On Fri, 2019-05-31 at 22:53 +0300, Andrey Abramov wrote:
>>  Fix -Wunused-but-set-variable warnings in raid56.c and sysfs.c files
> These uses seem boolean, so perhaps just use bool?
I used int because you use ints (as bools) everywhere (for example there is only one bool (as a function argument) in the entire raid56.c file with 3000 lines of code), so with int code looks more consistent.
Are you sure that I should use bool?
