Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1617D6EC
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 10:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfHAIHy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 1 Aug 2019 04:07:54 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50393 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbfHAIHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 04:07:54 -0400
X-Originating-IP: 37.173.91.251
Received: from [10.137.0.38] (unknown [37.173.91.251])
        (Authenticated sender: swami@petaramesh.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DEFD1FF803;
        Thu,  1 Aug 2019 08:07:50 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
 <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
 <6fb5af6c-d7b8-951b-f213-e2b9b536ae6a@petaramesh.org>
 <d8c571e4-718e-1241-66ab-176d091d6b48@bouton.name>
 <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
 <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
 <0bba3536-391b-42ea-1030-bd4598f39140@petaramesh.org>
 <a199a382-3ea4-e061-e5fc-dc8c2cc66e73@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swami@petaramesh.org; keydata=
 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
 BtUAN08OPA==
Message-ID: <e73421f5-444b-2daa-4c28-45f3b5db007c@petaramesh.org>
Date:   Thu, 1 Aug 2019 10:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a199a382-3ea4-e061-e5fc-dc8c2cc66e73@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-FR
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/1/19 8:36 AM, Qu Wenruo wrote:
> Could you give more detailed history, including each reboot?
> Like:
>
> CASE 1
> # Upgrade kernel (running 5.1)
> # Reboot
> # Kernel mount failure (running 5.2)

No, it never was a “kernel mount failure”, it was more of :

- Running 5.1 OK

- Upgrade to 5.2

- Reboot without noticing problem on kernel 5.2.1-arch1-1

- Performed usual remote rsync backup using kernel 5.2.1-arch1-1 WITHOUT
any error at 23:20 on july, 16

- Quite unfortunately I do not backup /var/log in frequent rsync backups...

- Machine does its usual cronned snapper snapshots auto-delete

- Turned off machine for the night

- Next days, boot machine as usual (without paying attention to
scrolling messages)

- Machine boots. Cinnamon GUI fails loading. Wonders. Reboot.

- Notice BTRFS error messages on console at boot. Still no GUI.

- Reboot in systemd rescue mode. Run "btrfs check -f" in read-only mode.

- Get LOADS of error messages.

- Tells myself « Jeez the damn thing screwed up ! »

- Reboot in multi-user.target console mode

- Notice BTRFS errors again.

- Connect external USB HD for performing an emergency full backup of
what can be.

- Lack enough space on external USB HD. Delete a load of old snapshots
to make enough space.

- Perform full backup (rsync onto external HD). Everything goes well
except for a few recently modified files that fail. Either temp or cache
files I can live without, or files that are OK in the remote backup
performed the evening before.

- Wait a few days before restoring the machine - lack of time.

- Reformat and restore the machine, reverting to kernel 5.1.

- Want to perform more backups onto the external USB HD.

- Get BTRFS errors on the external HD (posted here previously).

- Eventually decide to reformat the external HD completely as the FS
seems to be beyond salvation by “btrfs check”.


- The machine and involved disks seems stable and have been checked
healthy now with kernel 5.1.

- As you can see, the damaged filesystems have been reformatted, and I'm
afraid I don't have useful logs available.


> (It's a really pity that the original corrupted leaf kernel message
> can't be preserved, that could really help a lot to detect memory
> corruption or things like that

Well I'm sorry..

Kind regards.

-- 

ॐ

Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E


