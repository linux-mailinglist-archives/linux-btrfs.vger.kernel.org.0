Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8F11CE38
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 14:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfLLNYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 08:24:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:59147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfLLNYQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 08:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576157054;
        bh=0zbV5cJcXEPh1HT1v3yJrepWPeJqxewnDMMVNFt/Xc8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VnEdcPbIITkStjxflfzk/OLVtlncrLsIIrFGdGJwL3h2Pmz/ztLV3UAykB333/KkC
         bpqqAkBFWptUiJa0WibLip8ZDWqH1LzjxogEt14pDqwz5yqL3hGb0SpvIAwyus4658
         0J5WlOt5Z9HRxYKfDkZTX0WNtK7nqZw+ru/xwMdY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.176] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1iG7my2YOS-00RXhn; Thu, 12
 Dec 2019 14:24:13 +0100
Subject: Re: [PATCH 3/6] btrfs: split-brain case for scanned changing device
 with INCOMPAT_METADATA_UUID
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-4-Damenly_Su@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <88fe5f61-dbcf-8fff-77ee-6fa89272ff13@gmx.com>
Date:   Thu, 12 Dec 2019 21:24:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212110132.11063-4-Damenly_Su@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T4d76hxjIfdW7waFPpmn3jHoLbRLPnk2AHS/jFsvs7KlSOHHrCx
 oij0DeQ2Jh1KnaFLjTrfNVd82nQdywcBYA+4CYxUsCcD8K4qioEeIDo6PSW9MUgi14JFMnG
 7ZQ5eu8rQ/fR/vMWwXwqWKlbOXhkKOVFXLK4E0A2k6y28gLL14NkOmqmLZFlfeDbXigDGxH
 VHmyoQkiBvbVJpIKZUMdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYxQ6QSMpyE=:/IEgryI4fo7PQxBt2zNbD3
 efpBnXROgRqSlG/PFzzIjMXMtyYSdOFRoYtqdh6M9K8usAuipPjHu3cn3DTT4nwF9+Teb0AOF
 spVHrrbdf4zo0nABkSNxAMkSfnMPhA6CVvtq9aEq7SskMvip2zFY6tgdOnpLoptgROh5uKnVC
 QK1099gIlvOdeXUgpTqmowK4Z5o7zfUgV3p/wTufjEEJ/Sgo1O2xCPAVCb+kiZQnEmL5sK1ot
 RL55xakDtGI19OMFQ1SlVp/LVHBBXpOIVEe1+byMSnCn3RLQ4Lwj1xgeYEwCrDH2FoQ07AVc1
 cRrzlwv+B/stmzlx9QJJOn3cZONtOKSHYaRQ3ypyIRSs29vSIiSB8JOhag7HuXX97Q+mSK5xd
 4GJBGHL5cKgV8uEoC/mDktLWXLPwtFTEyme/x5lp9mQEnjb93onfafdhqZ1VyyhTP+azx0Otm
 FOTgWJbM9a8GUv+rQtlqLl7plhUCxtomf907ERx9dCdttvh0IIEVUfpG9JabMGjTBHulmZJnU
 wbaMhR++JOX5P2Keaj6dgHKb9bHgB2nX2bxaibW3gHKbee9iItdNy7B7is/J5Qn4yW66hatI+
 LBdbZioAyoT51F+ZgQCcuuzF03eZVzHI/7ViVDDdHZDV67Gj+vx+4yLdcamHfth0WM4X61dww
 AFCSQDIDJUlUFDqOGXAebb99hsGrTS56v1+4u8e610Kpb11rUVLNYxyKYa0gnn3TdTEV2mRvP
 gzSFIBSWGpRMdxE6nd/2YLeOvL1kNuVcWjkTnyUKvGzkPGX01/TMF4UvpQLEe9gvJLDXp68xE
 aW9li0zRcbs7Ah7HWTTtMnTKjc3qg1aJ5xf6jxaSNd48UxV4egl3QA+Y0lCNByQ3eNlEwQcMc
 d/ARLMuSpnnJsIX2A5sEWLWtKv7Wvt4JC4hAq668jzlzCAAL9OPC7a9szFjJHVS8MH4W5ZGZy
 4wEyFpKmUPGi2AvqIxuVW4mq8x0mkwfYrDS03XvigPcqz5trI7HpxnEIQUiI/r2P7wNCpREU6
 Fl4chGguh9Ey9m1JjGayR0A69bGJ+9/qgGXRYj8+t2ZPIG3XU1/Q9MHOkqY3cAOugpUO6U8PG
 d/7mQ/BzoN7fuDJsN8/Kf8nMg9FZw4gu1jY+vVIzF2b+5ezVJgaszZJxEZojhwCA59M07y2/n
 BBWRsXs2DWB/hyFcYbyeJpeJ4VtUykO5gFNGv1XeDZc3gcnfwVYXdkJiMcK8UfGjNR0hV4HMO
 FtKW32ZdIr5LjjwnMX/Q2X4sQrlOG77qvG9OueDvkmF8qi3t1ouFQMKGMRl8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/12 7:01 PM, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>
> This patch adds the case for scanned changing device with
> INCOMPAT_METADATA_UUID.
> For this situation, the origin code only handles the case
> the devices already pulled into disk with INCOMPAT_METADATA_UUID set.
> There is an another case that the successful changed devices synced
> without INCOMPAT_METADATA_UUID.
> So add the check of Heather fsid of scanned device equals

s/Heather/whether/g, blame my spellchecker.

> metadata_uuid of fs_devices which is with INCOMPAT_METADATA_UUID
> feature.
>
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>   fs/btrfs/volumes.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b08b06a89a77..61b4a107bb58 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -654,7 +654,6 @@ static struct btrfs_fs_devices *find_fsid_inprogress=
(
>   	return NULL;
>   }
>
> -
>   static struct btrfs_fs_devices *find_fsid_changed(
>   					struct btrfs_super_block *disk_super)
>   {
> @@ -663,9 +662,14 @@ static struct btrfs_fs_devices *find_fsid_changed(
>   	/*
>   	 * Handles the case where scanned device is part of an fs that had
>   	 * multiple successful changes of FSID but curently device didn't
> -	 * observe it. Meaning our fsid will be different than theirs.
> +	 * observe it.
> +	 *
> +	 * Case 1: the devices already changed still owns the feature, their
> +	 * fsid must differ from the disk_super->fsid.
>   	 */
>   	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +		if (fs_devices->fsid_change)
> +			continue;
>   		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
>   			   BTRFS_FSID_SIZE) !=3D 0 &&
>   		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
> @@ -676,7 +680,26 @@ static struct btrfs_fs_devices *find_fsid_changed(
>   		}
>   	}
>
> -	return NULL;
> +	/*
> +	 * Case 2: the synced devices doesn't have the metadata_uuid feature.
> +	 * NOTE: the fs_devices has same metadata_uuid and fsid in memory, but
> +	 * they differs in disk, because fs_id is copied to
> +	 * fs_devices->metadata_id while alloc_fs_devices if no metadata
> +	 * feature.
> +	 */
> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
> +			   BTRFS_FSID_SIZE) =3D=3D 0 &&
> +		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
> +			   BTRFS_FSID_SIZE) =3D=3D 0 && !fs_devices->fsid_change)
> +			return fs_devices;
> +	}
> +
> +	/*
> +	 * Okay, can't found any fs_devices already synced, back to
> +	 * search devices unchanged or changing like the device.
> +	 */
> +	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
>   }
>
>   static struct btrfs_fs_devices *find_fsid_changing_metada_uuid(
>

