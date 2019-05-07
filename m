Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D916161
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEGJsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 05:48:51 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:45482 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEGJsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 05:48:50 -0400
Received: by mail-pf1-f171.google.com with SMTP id e24so8362482pfi.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:mime-version:message-id
         :content-transfer-encoding;
        bh=Al2BrFw2SKeELmCyZz2SU0fiiu1kjXsBNhknAp7geiM=;
        b=TjxDCMd1ftGQMX4FLL9s7pkMEdR8r97/4DXZU1VyRKygtrnnEXsiS0dpqhwK2JRC+S
         XzVe6coG+NSwONc6DjE1i06tbIyPtZzr2ov+IjYVvfHgUMXebTwSvarnPYuCWYLr2SR6
         ZYwnAbLaKS2P80pNBkaI8zLCbz+y9izzrWR01vPnxQjCvm0sHMU5Mw/DDGvU5FxevzVw
         5c0GCRXSyaroBRi2FcVlB4SfkvJBjucztfuRoQjjElmfexE4CpSTXNCKgZZOleY7Xhol
         QdY35tXPPfWpFkAPnawgiNUuuVojYO9yy5wyPr0atI8NXgxZDtq009DHp7yr0X8NoiKk
         Sciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:mime-version:message-id
         :content-transfer-encoding;
        bh=Al2BrFw2SKeELmCyZz2SU0fiiu1kjXsBNhknAp7geiM=;
        b=gN9Nftj5fI2LDroY/peltJCpd2NyN0mURfs0RImHUVreSAEbiwH4hE8hxDyYoEPZUd
         eOpodo7EswXvNgH8KL4ePIGXkd5TgTiEHVi6QXUnDXb8wuSpohKvKkXmn6nAtjFd+fpk
         mCmZMLyBwirRaWQkDM8A5tSsZ5z+hZjxO/VWBkQ42iratyd3Uf1QGfdYB5/sF8fMrE32
         xSHB3WI6buzHJi3VZxnKZi37ZP5AwYUkzRNNet0zh33EnapmLPvSSLXR4+58US2A5Lj9
         PrPnvJl5m2nis7uFsDHmR6fUsDKgQLgHsOi0XkN+//b+bGqQ4cZRRK0X+6r6lzFnXZIi
         ExHA==
X-Gm-Message-State: APjAAAUvYMpi9sXZ3Zqew11wu/klvv5QUMelSOiSj7BGphKlP7P5lhWK
        Yp1h22ehirzuUP+WYFd9RcBb3ZamhT8=
X-Google-Smtp-Source: APXvYqyrdLOpgu1tzFzpCC9JXPdv8D0J4lKwksEX8W93Qrd/773NyP25tVsQ4nZAnuhzRqGX3CquOQ==
X-Received: by 2002:a62:2b4e:: with SMTP id r75mr39635419pfr.131.1557222529779;
        Tue, 07 May 2019 02:48:49 -0700 (PDT)
Received: from NJ-MILI-T480 ([209.249.181.2])
        by smtp.gmail.com with ESMTPSA id 132sm17464619pfw.87.2019.05.07.02.48.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 02:48:49 -0700 (PDT)
Date:   Tue, 7 May 2019 17:48:47 +0800
From:   "litaibaichina@gmail.com" <litaibaichina@gmail.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: can I change NAME_MAX limit
X-Priority: 3
X-GUID: 9B9576F3-8017-4DC5-AD33-99F1685DF88B
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.156[cn]
Mime-Version: 1.0
Message-ID: <201905071748449682914@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

CkhpIEd1eXMsCgpJIGFtIHJ1bm5pbmcgYnRyZnMgb24gYSA0LjQuMTc4IGtlcm5lbCwgwqBJIHdh
bnQgdG8gc3VwcG9ydCBhIGxvbmdlciBmaWxlIG5hbWUsIG5vdyB0aGUgTkFNRV9NQVggaXMgMjU1
LCDCoGNhbiBJIGp1c3QgaW5jcmVhc2UgdGhlIE5BTUVfTUFYIG1hY3JvIGFuZCByZWNvbXBpbGUg
dGhlIGtlcm5lbCB0byBzdXBwb3J0IGxvbmdlciBmaWxlIG5hbWUgPyDCoEkgZ3Vlc3MgSSB3aWxs
IGJyZWFrIHN0aCwgwqBidXQgSSBhbSBub3Qgc3VyZSB3aGF0IHBhcnQgd2lsbCBiZSBicm9rZW4u
CgpUaGFua3Mu

