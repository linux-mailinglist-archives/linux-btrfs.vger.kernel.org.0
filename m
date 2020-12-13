Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B72D8C92
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Dec 2020 10:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405819AbgLMJ5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Dec 2020 04:57:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:44707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405649AbgLMJ5D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Dec 2020 04:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607853329;
        bh=sRy+aVQnX8ef6LzcnBg8dPH4XbTCCq4184TpUk+QnX0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:In-Reply-To:References:Date;
        b=hgl+0B4627BusDh00YDcJasGfYi2zdbTBWMK5t/RlK/kn8irdZw+OGCThC31gT74t
         x6jqZAA9llzaJSQuNqBcDkGqo0L1RPkZTJM7PwKE6fZFGXykW8/a0Aq4p5PrDCcVJk
         rbgY9G2+i9WK1f6sebFlpvY0XvvEyKffAZIQyoY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mobalindesk.lan.lan ([77.10.201.13]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17UW-1k8uZX04SI-012aWW; Sun, 13
 Dec 2020 10:55:29 +0100
Message-ID: <c0aa48c7db8c00efe8dd9a2c72c425ffe57df49c.camel@gmx.net>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file
 or directory
From:   "Massimo B." <massimo.b@gmx.net>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
         <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
         <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net>
         <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
         <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net>
         <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
         <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net>
         <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 13 Dec 2020 10:50:28 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V7RKo5YVmLbOzgi5OtNo9OMu5OEU4jr7pF2eTxNXwFtbKysXcfO
 Px+cKdlBQPJvJZW7pqEcdDk1mi12apOKC8BBpiDBEYy2bEH8tQNXhkbmEWBVKa9yvK8Y3pJ
 U7TCUfuft0HNl1x6UyPojqd7+HnHSjl3K7fZWEMbsejmYsvPtd3OKcZyfbn4RMyR6/cfTct
 WXbiw4b/80XydRWsz3tjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VpbK7T5Kv60=:Xfgys0nKXGByLWkVtd4opl
 Pfz8kD6YlandNFmxwYxUzFrNvLPmLhObPmz0cSYGFgnVKuPiFb8X6E4RBqgMojBeWjFg6vmwK
 BT0pXMFsR0GVY1WNa7wzd4rwAIjy1IKfMmmcvkWxx3zQ0vbyryB5B1z+63vb5PuSJRh5O4P1a
 kvgGzWYYXhg2mXHQ05twoSJGKkkXXDxExR74s3FjfnDduv7BwzculFUgc/d8yR054okWPmp3t
 jzY+n24BwGMBFC7VYRX1dl0Me0NNBAGtZpVTSK+GUaUL3tYzWUONyn+Pz2YmSjpuaWdsIoXFL
 6sdEnzhhGQECtsP4rzek1A+vlsHmAFAkotG8cES0MVBvCsLICRGVyEeoeJNBZWvcWYTOP+krT
 7j2oWFv53ac93KERPRjAq6y+HvDqJ3pj6UnyU0DXMywUFicALAhHKssa87ZK/IF7Eoj/cxiiD
 4OJm3I+qCMAKz/mDCkMbIH8yomp8cUj96W1IlYyurkpKjSuimSzeRLSj1/Jqvigf0E8CjW4sa
 nu1tXHOHeafVrYIJJUCIIkgPkC01nu1evqH1lSFH/cm1/BLrfZ2GuYhHVw08XxCPj0w43hN40
 X0e6JMS3yFBnHIF5L8R0hAaZmSRMUo+E6lR9nyzoqHAQ4S1mqK9Xoht/JK/vPDe2OW1IiAlM+
 MfjvBaSDAKqWEEBj2Oq+UMfO5XAO2Hk/EfBkiQFa+6p+hHjLtTG8b8I6sSflnkjxSTn2JQGT3
 wyHojTwMd4i1tX8H4WMP5erjwWEl9zmlPWaCh816wkfEdwAF0A37lIjbee2kQ69b8Tx1TiizP
 M4eo0tjpjRUa1jAjIpcZ+UVguzQ/j1DPDGOCUBZ0PlOiQO42wgPXo0VozXYxdWQu/LDwDhPXB
 xa1ofDSvLG6ZUmpXV+fA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2020-12-09 at 10:29 +0000, Filipe Manana wrote:
> So to confirm if there are other problems, you really need to let send
>
> and receive processes finish (don't kill them). If they finish without
>
> failure, then check if temporary directories (or files with the same
>
> name pattern) still exist or not.

I continued with send|receive successfully with a lot of snapshots, then I=
 found
some new error. Is this also related?

clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYNC/...=
.pdf source offset=3D20705280 offset=3D20709376 length=3D4096
clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYNC/...=
.pdf source offset=3D20713472 offset=3D20713472 length=3D4096
ERROR: failed to clone extents to mb/Documents.AZ/0.SYNC/....pdf: Invalid =
argument

Best regards,
Massimo

