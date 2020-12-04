Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475642CE897
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgLDHYK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 02:24:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:53743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgLDHYK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 02:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607066557;
        bh=vwSwRh22541oSFHqe23ZWJUb0wuaANUNJh62Nz35prc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:In-Reply-To:References:Date;
        b=OgXX4vkZ8o/KMDYy4mOmp4aC1SKQqVlkE0EVvotrCMTYGjHm8BKCbc+AXjOdXplxL
         ImwTn1vFzD33oSvaQYM7XJqRWQfODITbwFn5/mAQzr1DQH2CqaOSAi9gc1yzFiXAHe
         9TieFpjBrjay5j7FgdOpMeuyZ4spsLwCc2PHtFog=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mobalindesk.lan.lan ([95.116.59.52]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1kUWVd0WiS-00Ine9; Fri, 04
 Dec 2020 08:22:37 +0100
Message-ID: <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file
 or directory
From:   "Massimo B." <massimo.b@gmx.net>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
         <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 04 Dec 2020 08:21:37 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V3knFMXvd31hliMYubZ3n350shL3lSwlJfTJBnq0IomdVqXuVub
 PrwXB+rHmTfMofeZprjJCNb3ZmzY6kIVS78YpT1OyxML6Cc7Cbr8pSpo3SUAB1X7Pjo1Sn0
 n0ptXWnHp5660kc9zcPX2wSnbynvZXIuKNeivbnTqJMzyt4ZEycHyFSPrrqqe/0Lfv9H12g
 vzcEAJUwqzUHl5lWqpDBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ZIaHNKrmLs=:taFjUnUiP+uMrO4jGrzwbu
 mGKRo5/M6pvK8ZTy7xeuSQuMu+wg/8DoCAM5NUWPO96u/sndg51ppULBrdhTR/aDiPAoyvKB3
 wWnF8T/iLQbRWUfuO1pNzSsXbrpJ3PyR//xvVR96e63OyrnX8HNdtzoIq4/lWvVS2wWWf/R7n
 T7535jXI8bjSjwGBMFVSzBGBE1OO6B0seaZwHqQnMgWJWxWCflBYG0URDtH7s40BQrjvUDj86
 On6mSgVarB/sEeAhtjFhodkJ6exrt4xHZbg9QVlzm0v/rBn+21ZGJFwcz33GM5y5ZdLg65aI3
 hAH47DNDZsziNajYI5m+rpn27qdX2O3tQzd0+w1xyh6iN1OEdb725Mb0cgnwA6/eScFaz0pAi
 gCvcjLQDZltXo64AgdLWGpk6izkeZ8M43lkczs2AbUBmMDal39ST8HSTuzQWqXt4x9lj+qaOP
 Ogl+1SVrw8XfgmKYL/o3FWERv4qPIaGtjEcjvytEim1EyBybAjvWr928zWdYo5QXT+gZe4D1i
 I1lyKb11RnL94QA0cifBKnIlpHkaw1TwBA2kDUk1vFCvhY0dzxB7bt3EH2hJ2rY6tmVgfxyld
 7tUgoids3QZA0/IyHLW56H/cWl/AcYd1fdouDTkFllQRiL4Qn2EWdZ3ugSAivJRNwC7XM1vmg
 xuGg83/SKvH3ANpdygKmZOhUNvHa8ZecUpJIcQO4zBWEI+xw7bg4WsLb9NWf4wY8WayoGgBJk
 uX0kdXvuIJcKcaqqnYKyfbDXjjkptZJXeROA2VvlAjhj5bdAzYC9Cg8tMAGXVBn1ttMCAEKx8
 7B0OVbt24dCppKLNV/5WlC5svKJ2wKgf0sLr6iC/LlrYSFrD7LmtsmxUZdpEGIbTQVmR8zYyG
 g4qt1pRqcW8FhXeHtTEg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2020-12-02 at 11:04 +0000, Filipe Manana wrote:

> Yes, it's a btrfs issue.

Thanks.
The bug report on btrbk side is:
https://github.com/digint/btrbk/issues/295

> There were two such bug fixes in 5.9 that are not included in a
> vanilla 5.8.15 (dunno if gentoo picked them into their 5.8.15 kernel):

I just switched to the most 5.9.12-gentoo and it's still the same issue.

> If those don't solve your problem. then the output of 'btrfs receive
> -vvv ...' could be used to help debug the issue.

# btrfs send -p /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.202008=
03T060030+0200 /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.2018011=
4T131123+0100 | mbuffer -v 1 -q -m 2% | btrfs receive -vvv /mnt/local/data=
/snapshots/root/
At subvol /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.20180114T131=
123+0100
At snapshot root.20180114T131123+0100
receiving snapshot root.20180114T131123+0100 uuid=3Ddfd895bb-8f3e-ae46-82a=
5-21e22453a258, ctransid=3D542345 parent_uuid=3D95819f51-40a4-9745-9661-78=
71dce44e19, parent_ctransid=3D542414
utimes
rename home -> o257-359797-0
mkdir o257-1571-0
rename o257-1571-0 -> .hg
utimes
chown o257-1571-0 - uid=3D0, gid=3D0
ERROR: chown o257-1571-0 failed: No such file or directory


Best regards,
Massimo

