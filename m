Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7D157606
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 13:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgBJMrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 07:47:32 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:41690 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgBJMra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 07:47:30 -0500
Received: by mail-vs1-f48.google.com with SMTP id k188so3989003vsc.8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2020 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qO8cNrH/FxbTdDGsAcNYzmgOpn5dSXwX/z6vgQre3JM=;
        b=sja6o1ZAl0QvPhADDdJCvCIOvldmckLi8YMILFUgtvXeUg1eqlo46o9vje3UqXVISZ
         /c3AiiVB0g98KxGZqMBkUFBcOLV2PvpXi7fmWn3XDJDuva5mif3DA5mJ5yHtStZREKS8
         jpQvQDQ2N5hDdpVkEymNuxwCL/Z7IbiltB1jpDlTrHkH+7cPWaOFohCxr2KNZeLRbNl+
         DnQNdA/yhs1LraptllB7sIcgp6nqrdKgIXrF7GRZQB8y9Ah+051iMJ0IvnRAHdhxVZeO
         a/WIWL3fJFWtUJeyr0GACZb3O6WGjlcbXyUJP+d5TxwO6F3J9uSU77RIzSoAOGJehb36
         Qw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qO8cNrH/FxbTdDGsAcNYzmgOpn5dSXwX/z6vgQre3JM=;
        b=ew7HZN+dT4lE0w9+Sx+G7mileFc/ek0FXISCqP1Gak8YmO0be7RjM9KGRjCqSaGaHG
         osf78Svpc9biJnuh0W4fal3+9n/zJXkTOmpH8IoVpfIMl9KVUsXlYS8jCTAJVphgk56T
         SSAZkU6ZySOlSKdIXR3aANkrGw/GlAltWgK1lQsQgtpFdKEjGb7jzLYD+ZYYdN0ufJTd
         zSwL42jIPXctS/hek7uqN5WRWPWLLEx0j/P5iTgkKS1HHFUxawXeiWZmY9MwvdVcWgqW
         Ufr5Q3SYe3lTw6oSbakKlCiAP9f8foY/qWJ/NR2+NrGf0tRSjDib5UHgVcYnT9gv6++P
         EVdw==
X-Gm-Message-State: APjAAAUD8WfZKxYHr4+AkU0EjgIJls5MjPUL+V95BOgVyGfxy1tFZdvI
        VLVdrzlpLQ2YE+FhdAec52e/dYIuWD/JzoOAbT1GQrGP
X-Google-Smtp-Source: APXvYqweuk/ju2wLmest+EoZj9cOYwZErqy+nUxra4WzY6kpcnd/15tnzoPVHfrE5YTwnzOh+xVtvjckdm8Q/0SR9KI=
X-Received: by 2002:a67:e3c3:: with SMTP id k3mr6190654vsm.137.1581338849637;
 Mon, 10 Feb 2020 04:47:29 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_R=C3=A4del?= <christian.raedel@gmail.com>
Date:   Mon, 10 Feb 2020 13:46:53 +0100
Message-ID: <CAH6ZjHo5swYz6U3+9XmE07MYwcaoPb7J-yuxiDnCRof=BWvE+g@mail.gmail.com>
Subject: 
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

subscribe linux-btrfs
