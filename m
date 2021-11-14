Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C0744FA20
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 20:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhKNTXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 14:23:43 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:14580 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbhKNTXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 14:23:01 -0500
Date:   Sun, 14 Nov 2021 19:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliethoever.de;
        s=protonmail2; t=1636917601;
        bh=/5sjYB/cDVzQbXqr8+7Oy8sMcFj+rQPhRD5Y1u6TNhM=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=PQFpCcTa3f5Wm+Mt8lS1mf9OxeV9Wm1W0c1HqvyWrECA82XAWMEUrHqhdJWhdq34Y
         lDCKrF10I5XMMkgLsHUBLDvA/oJQ9zHmwkoQ+e5ALSdNwMcYRacrMSGxyunjXuMKyw
         IAz4FkLjoD357etZ1u7sV1SlpivMcqDTJAgq9zSXOPYbXF0FG7zubjqC3iEPjX6xcZ
         dF6sn6UU6yeGLv1nkh/ye97js/BFBjdgvLnwTJodaoIZiuQFULxW2UKOZ7ZRTw3Tk3
         kVL4HYTium5OSKTXx1wCL/gd0AUIGWUO6/oyAERPANcgVopLxfWZM8f9z/EgQ9f2BC
         weNRZlQHGtpxA==
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Joshua <joshua@mailmag.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Reply-To: =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Subject: Re: Large BTRFS array suddenly says 53TiB Free, usage inconsistent
Message-ID: <579afc75-fa2d-3150-9d27-9a106b5c7f30@spliethoever.de>
In-Reply-To: <77924dab-1bc9-ce56-056f-da795998365c@applied-asynchrony.com>
References: <2f87defb6b4c199de7ce0ba85ec6b690@mailmag.net> <b219d9de-ac42-1ec4-0fff-c8be2c36bfae@spliethoever.de> <77924dab-1bc9-ce56-056f-da795998365c@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Holger.
Thank you for the quick reply! The older btrfs-progs version does indeed re=
port the numbers correctly. And also thanks for the pointer to the GitHub i=
ssue!

-Max

On 11/14/21 20:06, Holger Hoffst=C3=A4tte wrote:
> On 2021-11-14 19:45, Max Splieth=C3=B6ver wrote:
>> Hello everyone. I observed the exact same behavior on my 2x4TB RAID1.
>> After an update of my server that runs a btrfs RAID1 as data storage
>> (root fs runs on different, non-btrfs disks) and running `sudo btrfs
>> filesystem usage /tank`, I realized that the "Data ratio" and
>> "Metadata ratio" had dropped from 2.00 (before upgrade) to 1.00 and
>> that the Unallocated space on both drives jumped from ~550GB to
>> 2.10TB. I sporadically checked the files and everything seems to be
>> still there.
>>
>> I would appreciate any help with explaining what happened and how to
>> possibly fix this issue. Below I provided some information. If
>> further outputs are required, please let me know.
>>
>> ```
>> $ btrfs --version
>> btrfs-progs v5.15
>     ---------------^^
>
> https://github.com/kdave/btrfs-progs/issues/422
>
> Try to revert progs to 5.14.x.
>
> cheers
> Holger
>

