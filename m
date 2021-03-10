Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880E63344E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCJRNe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 12:13:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:39207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhCJRNY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 12:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615396399;
        bh=Kf7KcCVNu5ww7LNUBQeOnC9x+iN+5kuNQNcn/2TDLMc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ailTpRkQtqHy0SBKcdFxnX5xpPIi6G2m1daWozQ4imV2uJ0Gxz+imm0fR/bcSAWCK
         opwps4Bviatz4b1AhGxQGtJXqUTMIvuY76mry3MG7i2uyEteAJp1miOXoxxLMExhQx
         S4cQbLVgSU99UtcT6V47trvp1zsxWBKpFyJTqYw8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [77.11.30.192] ([77.11.30.192]) by web-mail.gmx.net
 (3c-app-gmx-bap74.server.lan [172.19.172.174]) (via HTTP); Wed, 10 Mar 2021
 18:13:19 +0100
MIME-Version: 1.0
Message-ID: <trinity-5225af7d-0bb6-4294-896a-dad632c3b789-1615396399491@3c-app-gmx-bap74>
From:   telsch <telsch@gmx.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Re:  Re: no memory is freed after snapshots are deleted
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 10 Mar 2021 18:13:19 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <13a7fd3d-d304-94c0-97bc-8b2411019071@georgianit.com>
References: <trinity-e300b8c5-315a-4823-8664-4f663481461c-1615378067176@3c-app-gmx-bs66>
 <3f1ef2ea-04db-479d-d1cd-f64892de6ef1@cobb.uk.net>
 <trinity-a0ab6866-d05a-4626-8bb3-833e89b6d5cf-1615391386529@3c-app-gmx-bs58>
 <13a7fd3d-d304-94c0-97bc-8b2411019071@georgianit.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:PrOtaK/YnJlt9DXCHtAZGBNT++qoNX/brB4I1VBZ4lq9S4FRmFVCGaelhzoomfId+cd0R
 iYREqczOD6NegeY2BvDvssaNrHWENi3YwZsH5Gye/Yna2Ld454QClE1KeARvOBE+wgcJwl6A66ob
 9cBNzl8wePPVzQYtOg9tQmOfmd0QrwXfhkHbo2cVN8FroS6Dh5GaUduu+OGtCd0uRyyCipj3kAAb
 orK29DGMfjdkqYM0Kua7LcQYHW5J4AhITlsDRLYheQtw5TM9SAQ/E6kYP0L9EhGd3mS2+abW5w+9
 TE=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qqTg6kps7IU=:tavimodd4waMA51HyLEWOv
 kd9E4rElOBkOgQYXzG0EoO6OexyeHCeYercWMNVHh8H2uUAUTiyJPvQrZcGzRDQ2jBcRrIa9U
 CFqkw82ydAl5RdfhRXvkfziLB2i983NFSn6LbEah7n0sVyA1AbNuj7/cgGTCwa2cYFaQYrywS
 W6ZGKcYUjRrMk3dJHTOnVVz8rKcpXSZarIsWYjdWx0k5lWx+zC5NXfbEt3+fM3ZQ7nPE8urGw
 GrJZexqzJWxOSBmgzcweJaPUBRqwfMIz+RqpwFwcjMKGO7lQ5GeahbUxnozzVkLlW78So9Vku
 It9E8JQQBD3ivf57wIO71fp7Qj2BCINaZIMlV9IO4m//uZMvvBkyPpCBefseNLZvexZkL2ElQ
 A6Ex28VTcaf/i3BsosoOsoKdDjxuSfE+ZKV46zheQCYYLiob928jmRPqPd9fdeSRCZse6VxVf
 3pIBUgpC+tVcNzWxI8DT3tviu/FO1I6/WofmxRAB7YpzSjbtnMlgYpHC8oUfax9ZBQ5LLqRCx
 ke4NaUCR+3Dunvt6LcqtyGg0VNtIgqcYA49G6sMhfkVA61YXtCqGNhLPnUrmVIkjOnksqBA06
 djH1oGmHZLC+0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> We can check that there are, in fact, no unexpected subvolumes.
>
> btrfs sub list /
>
> In particular, I wonder if you have subvolumes/snapshots hidden behind
> the mounted subvolume.
>
> Also, I don't think it's really the case here with only 16GB reported by
> du,, but do you have any large, heavily fragmented files, such as VM
> virtual disks?  Without defragmentation or compression, I've seen those
> consume more than twice their reported file size on btrfs.

thanks for the hint! i have only considered snapshots but no subvolumes. s=
ince them considered as file system boundary and i had set the option -x, =
--one-file-system, it is clear where I waste my storage space.
my fault - thank you!
