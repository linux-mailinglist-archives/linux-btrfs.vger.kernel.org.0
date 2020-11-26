Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4D2C5AA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 18:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbgKZRdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 12:33:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:57319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390083AbgKZRdA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 12:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606411979;
        bh=7FNjG4HNe3QnT7XYf4cwd6n4VaziqjoiXuKFuPvKF9s=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=TLMr3ADr3zfN6Ym2kkSMlS2L5RTWqXJYzHr+OW/m/zN9p9RDEF9v1gTuJbL5YftAE
         +dIbW923ib79QF/As3H/uST+BClXnyM6+cA74G5VOVYUTY7RvfbRS9yGVQ52Skxitc
         VaLi/t1EA6le9+KZOhnGG46qROHadCjUrWocu5VE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [89.245.121.193] ([89.245.121.193]) by web-mail.gmx.net
 (3c-app-gmx-bs37.server.lan [172.19.170.89]) (via HTTP); Thu, 26 Nov 2020
 18:32:59 +0100
MIME-Version: 1.0
Message-ID: <trinity-ca02807b-66c1-46e7-a4ed-efa79636413b-1606411979151@3c-app-gmx-bs37>
From:   Steve Keller <keller.steve@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: State of BTRFS
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 26 Nov 2020 18:32:59 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:7HP5dhICGLs/a2aCbPipXwaKZtYIbTb5NatPNOCmqv4rIRtqgWQY+w8TpOZvTkGalsx2h
 hzFsiBygpcQX/i4nZIw5yeVLoux/AJGCAcQFhH5f0vzQzONQynC7ThTBt0l/lEx5oQmjKJu2+0ht
 srWhAH4+Dtm4+RESu1sSzeD/CYBnlB1KzAc59+p715LCGcDMPQ6Mifgq4/XCwPOpLJUW2TO+mlJv
 8NPJpxGpbtD1AB9pYtefac+rflDLuPiJUL5UdkeGh8T6iApZflvbcoALNt6oMsRHGygMO5BbuWCF
 SY=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JbKEZnp/eJY=:nbk8GuaMY/fPsPXd3z0DHS
 yDwUU6eA82J4fM71jLKGd9/KBmiBS1VAsoy+5cP8O5mB9596uXlrmjZyIUtTi8myLAD1GA5Da
 9B6DLS6h1m30Xp4CUJ3BC+iVKBJHHM/BUBitvpvF1ka+SQkjOPDWcM2WvhY9swC+OKK3Ek+1F
 8KYWgnizyAsQHbk63HQF9zbkNyRH+93Dz9G3SjfyeTintCWTyrW7TeukfcWbj03+RiA00RpBd
 ct00xQfaUlEutJIzdDkMbiyW/rpSy/pbV8c2Tr1zZF8wSfkZ8jF2NGg69+Oop/Ux2e7y3gOeK
 +dW5B/XUPGcoeEE8At8dwGfLbJXDO5luqBv6+jW5eOY8NHGmlvuYmPEsC3JhYpE1LYTi4ISRk
 EZE5KgIMxIjHkP2HaeIvbBc8Zkg/OfyormyINqeNZ//qt8J9CYnwK6b+AGsznKmJsZIQjgNUx
 P6l3YnJpBAlrd44c/17KAiZvt/sOraH1O/M/79WnEeqTzQIKlG1y22AANaElezMH0XRO2uDkk
 vFuT1wNcDs2SOxEWqfQGfiHSXgCr1On02YsfySL8XCNUNkimXHRSGUFn8GSlRp2KrBhpY04UD
 ZrJmfpKQjdlWs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

What is the state of btrfs concerning stability and reliability?

Is it safe to my /home file system on btrfs?  I need no RAID,
currently, as I have mdraid with LVM on top of that already, and I
have an LVM volume for /home.  But I do like snapshots and would
probably use them quite a lot.

Currently, I have ext4 for /home but I consider switching to btrfs.
But I want to be really sure not to loose data or otherwise have
to repair the file system.

Steve

