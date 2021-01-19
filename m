Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40A2FADE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 01:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbhASABx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 19:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbhASABw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 19:01:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C90C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 16:01:11 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id e7so19991071ljg.10
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CALTOGGm66NctMq7gjNTwzyvh07Oo6TuNIgujnzIHww=;
        b=jDwN86oITOGXkHWg47SDvKWFWaiekEKdJHhFhe1YhjVVV2yktwKR5wijQRVf5ZUvnj
         egR6yx58Mplcl8aJskR6th5H9iA3Ge8d77uiw9N4kDtuq9cUCsBcoU2MgwzhMKTu7ywE
         +aRsOQSMCOhxeI9EN5y1Pw0zfKx8xHgisBX51zBVhWHWhTLjWp+vumeUnRx7UiWh/Ve2
         35OIbeQkbz5kCozhTI8PqPJ8/9WBP9r7xo+GR42KYnYemLbL0DMVfzh/Qurt6zWGnuWx
         6NEhixCWUA65LB/O4pr1MjjzliuGdaSm00TTbzDnCEmAF1hZNmEKi1xwd8JUIzLBiEHE
         d6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CALTOGGm66NctMq7gjNTwzyvh07Oo6TuNIgujnzIHww=;
        b=DMBd4SJF1ZlknEZgo4Ij4R0IMH58nPOcYPya/D2wIFUl7zFEQnmSHw0ixg0I+B5LDo
         KuNQp4MExf5VVmX6Xm54zZi2SqxtrFy1E3wAzkeqJd/PrUYbbo3Mh4wGS3d5OKmOXP3z
         LTUkpHnVz9IjcvSvt3siJwKZXxR7b9gwVWY25mfNADatf+KvvFT59NlzolK0oq6PiYG4
         n25r4O++A9zA7/y1vTWSimCVJUFbcrrmfcyaAUvrZUFEyiGo1mzNj4tAD//OrzHfGQQ9
         pmLfZ3MITevqf3IpyNce7aw6GKbPicueZTx++EIuMX77jCgEUGqAhBE+PLpbJsBIbrVK
         zGlw==
X-Gm-Message-State: AOAM531rcoaKbsdS8aUnEqFZd8QDj5Gf+4+5ckE+mn1u0F5CG3VquyW2
        TW+DSVF8gqxWbI7jWwIN4mQ9qC0rt1BpQGYM663KcZndFoY=
X-Google-Smtp-Source: ABdhPJw9kTBLIcCXKxk/43fW15PflqWrenloadR/NWhtfpAgo/OohsgMIrI50Vr8nwaHXbzKf2Wlc2Wu1UPqXuKXDaE=
X-Received: by 2002:a2e:3c01:: with SMTP id j1mr770867lja.258.1611014469834;
 Mon, 18 Jan 2021 16:01:09 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?H=C3=A9rikz_Nawarro?= <herikz.nawarro@gmail.com>
Date:   Mon, 18 Jan 2021 21:00:58 -0300
Message-ID: <CAD6NJSxNmWQ42HrC5oUyZtS+MgEn7b=kmV46qx40x9=v6SMwAA@mail.gmail.com>
Subject: Recover data from damage disk in "array"
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

I got an array of 4 disks with btrfs configured with data single and
metadata dup, one disk of this array was plugged with a bad sata cable
that broke the plastic part of the data port (the pins still intact),
i still can read the disk with an adapter, but there's a way to
"isolate" this disk, recover all data and later replace the fault disk
in the array with a new one?

Cheers,
