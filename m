Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E37AA47
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 15:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfG3N5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 09:57:30 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49693 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfG3N5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 09:57:30 -0400
X-Originating-IP: 37.165.108.244
Received: from [192.168.43.209] (unknown [37.165.108.244])
        (Authenticated sender: swami@petaramesh.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 547A3C000A;
        Tue, 30 Jul 2019 13:57:27 +0000 (UTC)
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <daeb4767-b113-f945-da67-61d250fa1663@petaramesh.org>
 <d9ea9623-657e-0315-7166-b7f58b32d4e0@gmx.com>
 <4776e0bd-83c2-44a1-4403-3a155fe3f6c7@gmx.com>
 <508c6378-522a-ae24-6c33-83c8efc64ae5@petaramesh.org>
 <83294063-9f98-71ab-428b-e2251b96e5b9@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Organization: Secte des Adorateurs de Cela
Message-ID: <bc23aa4a-2240-80d6-c2c2-d060191f884b@petaramesh.org>
Date:   Tue, 30 Jul 2019 15:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <83294063-9f98-71ab-428b-e2251b96e5b9@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB-large
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Le 30/07/2019 à 09:21, Qu Wenruo a écrit :
> Unfortunately, transid error here helps nothing.

Now, each and everytime I try to mount this disk on the original
machine, or another one, I get :

systemd[1]: run-media-xxxxxxxxxxxxxxxx.mount: Succeeded.
kernel: BTRFS info (device dm-2): disk space caching is enabled
kernel: BTRFS info (device dm-2): has skinny extents
kernel: BTRFS error (device dm-2): parent transid verify failed on
2137144377344 wanted 7684 found 7499
kernel: BTRFS error (device dm-2): parent transid verify failed on
2137144377344 wanted 7684 found 7499
kernel: BTRFS error (device dm-2): parent transid verify failed on
2137144377344 wanted 7684 found 7499
kernel: BTRFS: error (device dm-2) in btrfs_drop_snapshot:9465: errno=-5
IO failure
kernel: BTRFS info (device dm-2): forced readonly

(It first appears to mount OK, then the errors follow a few seconds
afterwards, and the it remounts readonly).

The "7499" displays seems to correspond to the most recent snapshot
created on the disk (using btrfs su li).

Is there any way I could repair this several-TB FS, ever if it implies
losing the latest (or a few of the latest) created subvols and snapshots ?

TIA.

Kind regards.

