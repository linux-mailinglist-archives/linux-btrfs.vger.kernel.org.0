Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9ED2CBA6F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 11:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLBKUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 05:20:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:53013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLBKUP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 05:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606904324;
        bh=P5qGdB6mFGYWuYuPz5UFlkROJoF6jvmf91otleKmxIE=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=MNz6eT7cEmum1GDILSW/T7tWe9iFB6raH9EVKKV6FChPVu/izdH3Zw9R3wiLYbMn6
         E8BZbWsLrhInvf1scel5emPvVRKLcLOEbwrr1wOOIIkrTXE1DmKa6nYybPhOjgJqDI
         /tIoveaNF3cmNdeK4mmfIm4qXzto/zNrjxuWawIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mobalindesk.lan.lan ([95.116.199.250]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MS3il-1kcrvs3rJL-00TUPp; Wed, 02 Dec 2020 11:18:43 +0100
Message-ID: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
Subject: btrfs send -p failing: chown o257-1571-0 failed: No such file or
 directory
From:   "Massimo B." <massimo.b@gmx.net>
To:     linux-btrfs@vger.kernel.org
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 02 Dec 2020 11:18:34 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q/gvBfXQgbQD/y7GCCkqcavchrrrxCqYxSH111q/4xfJhZprZag
 p7v/uOfsNhqwP5QWn4fBjkGJlIUMpXLzH7XlCLHfJZSN78WoPQ+qrGiYjCy4YDspvHOAj6f
 qGugDOkieKYIAzK+wHgz0tAIxj81W2bqO3xX04fH5vD0KrTt2vizGgfN7RNXl9Jo0HtuNbA
 P0maOuJfPepBVCtlgUaFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bWOSzHk0PcI=:ZxBsSa0qFIOMrQ5AcQ1t2b
 vGdjXpwPTbdJaWQOmMGvI+RHVNwg/aplAPna642UDY1n4Ze8IPGNIjRdzb/iZG9mFF1uDCOFK
 /dYWe1lAwGN7fBbf8DGAadnQQh/C43x0sAs/nI9e5j1G36f36rUIZXarfFPrwMDYnppYBRzih
 RHBZ8JxLZcVWpu92MddXv6jc5No6C9uSjk4CwG47Vmb+tHyECepKgR60eA+YWLBuTtM/wxsxY
 a5vDJ9Gjwh7FAl41dDXtnF0KL6kfp6fpvw+byPIsHTl4quPKv1XzMcv+zs+UPGAvDj6t+fUOR
 1IUj8270C7nvfLKxm4vMpPnLOZGHo+foNqrgRsjLERfpOPr1HBEZMMsbpdnEtgA05vD1IVibW
 o9LtP6YQasx4vbxm9GgzkSzfSSSUcWgu+N1bsndc4SEV7LdhC8rqeUb+BJt0LtdjRHzLgR/C+
 FdadcU/G3CVmUqkksbSEGJlvE/uvTYGkpHm884ZGAtdRT4vaiPYN+zpjSVbx1q5BIFD69eEtz
 XoqkobcQBInzmnuu+EVKNDXIY7UmxaGhb7CLkPN5cOX6DTd2P1Ol6PdZBo45vWPu6zqRVkLlT
 rVG368gXK8UqDyJbIUaG8L4tHhLO7YXw6YOezFhSlUf8fv5vNxfkElXrrBKOpHD81ccuUYyI2
 SqHQz4Q4IE0xBAm1iMSfvthwew1kDThapqnb5NZUHl9V7PY0PeNNDz0GMCBwEOv5c2gDthuSh
 uoV1Kwj6bs0PpXiMjPuMie8O4RrbWgXvRjBBwoKt25XXtENjEA2Qutxcc64CzSTCg2pu9uMaK
 8PBN3x1kwrulPrpUROfPFcPaxYVJO3Lg12IN+u5OJdokHpYStddgwHjq1djFDZqIYnqUeDZz7
 jEKQ8HyqyQ30y6ash6Zw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everybody,

trying to use btrbk archive, it's failing with
chown o257-1571-0 failed: No such file or directory.

It is doing a btrbk send -p... | btrbk receive ...:

The command is:
btrfs send -p /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.20200803=
T060030+0200 /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.20180114T=
131123+0100 | mbuffer -v 1 -q -m 2% | btrfs receive /mnt/local/data/snapsh=
ots/root/

So it takes some newer snapshot as parent to send the older snapshot missi=
ng on the target.
Maybe btrbk just selected the wrong parent?
Doing the same without -p is working. What's failing here with the parent?
I tried sending other snapshots with the same parent, but also failing.
We had several discussions about that in the btrbk tickets with the result=
, it's
a btrfs issue.

I have 3 btrfs. One is my working one, then I have a local backup and a re=
mote
backup. Local backup has less snapshots than the remote backup, so I like =
to
send some of the remote snapshots back to the local.

Kernel: 5.8.15-gentoo
Could bees have corrupted something? I'm running it on all 3 btrfs.

Best regards,
Massimo

