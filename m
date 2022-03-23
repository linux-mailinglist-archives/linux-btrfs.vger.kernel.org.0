Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7647C4E4DB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 09:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbiCWIBu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiCWIBs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 04:01:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21575717E
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648022406;
        bh=TZTdjP29zqXlqjdozA9Hc+MB0bK+YJDCSEc0XvBdqh4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hAg2fG5AlyQYpSHeXBDSqiyMsHCZtIh2+2so1Qsg8GQ/inn8aGo9Axb5vV7nzNU1O
         FHC9rHmzLcPPInRz696Nj/AgPWHCNa9H1te6R03KxOAG5+KSet6zmwAAfJAvfT8PXx
         yaHVmU6brwFrj0JA8kxViqrK+Z/opXBuimcUCFG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9nxn-1nTtVm1hA5-005qCe; Wed, 23
 Mar 2022 09:00:04 +0100
Message-ID: <f1d69286-52d2-cf67-5942-b92d838f0c82@gmx.com>
Date:   Wed, 23 Mar 2022 15:59:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: prevent subvol with swapfile from being deleted
Content-Language: en-US
To:     Kaiwen Hu <kevinhu@synology.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Cc:     robbieko@synology.com, cccheng@synology.com, seanding@synology.com
References: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
 <20220323071031.1398152-1-kevinhu@synology.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220323071031.1398152-1-kevinhu@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ufTugWCdRjJg2mqYsGhtmYmMNHj8vyPKF7bGi63tQ3jZ9QroOkw
 N4Yp/iw4Y8WS+SBe8tzYLAyYaGHjsV+8i31+E/ZsSvE19Jnno1kc2qUXgzRqLK5u8tPXHM1
 bG0f5rBuEv29AtwKzo2PWB861AmhmoZO97NU44BoZTBV+AzCyfaXgGOYWhm4F2NtjpWuwXG
 R+sU8K8PVX5Ly42ieZTbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T0zx8drkU7E=:M83ncNygS6lMgXD78PaiFG
 wiAF1+0bdRTNbop7fhhM7CnEtoa/s7y+hPcI9ey4cf6yzpRNINWKPJ5BsW4nJbTzDr5ZJjtiU
 XYsGfYS35+M4VcgHMhMc2vQPG2OpzANIwXmKFdKIJNueI3DS3X03INYNS/4hOlAnlm6R+6NPL
 No7ETc9wWnFni6xC7CVCH1NmFcLvTlVLH/dU+WJfab/8/y7XZO+8iUXxBhO4N0cpSCaR+tp7K
 Z9hMIptS4p/8Q8ZeEJ5kamC/urScwseAnpKkZeUOjgZpGAxaqquF7eCULAh1MNR7/SXA/rRwc
 xBccYRsxT9o6wrtF/VuvagT6wRLok8RyJXKmplmZELVfdOV4lVE4c2tE0Tl7w9NvZsPdWYG/6
 6Su+FA8uW9LO7kDmktI0amZ0CDXOeHRpM2WifQy/yZMAae1Y/gEV4LqaZ5GdErvdgFM82BSpD
 DMa5jlzQci7Kkf5RCa1a//4YlolCxDDY4VNFPlueBKLNmsLbegBxeUPTdGaw6L3AxGAKBIZpn
 mkN33MCYCaY700E3RcSKe1ql9qAOsNyLdjtoz5xTe50B5UaRf/0GBNpDv+dozs43Zi0eFpHk8
 Shr+0OgjgCvm/VmaLhTOFOc0LKo3dbzLMLB+vMPbo0SxmUBlzAPgllbgafBmQN24vAyqmMC6e
 Rjo7zA48a6Y1NvrXk66AZNMrdP2zbPz6lm+4heLNi+H2xlzAh+M2Gz93GR4yi7QCGadpInUnh
 gInS1tlTuI+452k+gaj/XONs4EBaO9Tgw3yidWhzLOrd+4o+JPDwgkPf0aE5zu7x+cArBLkqZ
 95tEgFMHAu/mJfeEnUS8n7PS8vvPqyLZfb+hB9OssRI9v0pgc7nVpx+osEH/M8S0F+KlTsRK9
 T10pwV/rfKABXgb5MQvaxbQA7o2FnI88LWLOueU8SpawGzbcdJWESgDO/ZaxO0sAZkh4FjxHs
 FPo1i505QBiKOyh5Yo02jOsFpF0ssdK8G+bcLE/wNr+bYCAltwIokw1mLTNk7SK1FFQt3fVtz
 LQRFpycSsn7xrbMMwpk7bs/AGteS2cybZOKqrlkr2HITh31Y5SHD7lvbfD9FsdNmSdADL8Vzp
 p6L0KYvpP1MCso=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/23 15:10, Kaiwen Hu wrote:
> This patch prevent subvol being deleted when the subvol contains
> any active swapfile.
>
> Since the subvolume is deleted, we cannot swapoff the swapfile in
> this deleted subvolume.  However, the swapfile is still active,
> we unable to unmount this volume.  Let it into some deadlock
> situation.
>
> The test looks like this:
> 	mkfs.btrfs -f $dev > /dev/null
> 	mount $dev $mnt
>
> 	btrfs sub create $mnt/subvol
> 	touch $mnt/subvol/swapfile
> 	chmod 600 $mnt/subvol/swapfile
> 	chattr +C $mnt/subvol/swapfile
> 	dd if=3D/dev/zero of=3D$mnt/subvol/swapfile bs=3D1K count=3D4096
> 	mkswap $mnt/subvol/swapfile
> 	swapon $mnt/subvol/swapfile
>
> 	btrfs sub delete $mnt/subvol
> 	swapoff $mnt/subvol/swapfile  // failed: No such file or directory
> 	swapoff --all
>
> 	unmount $mnt  // target is busy.
>
> To prevent above issue, we simply check that whether the subvolume
> contains any active swapfile, and stop the deleting process.  This
> behavior is like snapshot ioctl dealing with a swapfile.
>
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: Kaiwen Hu <kevinhu@synology.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>
> Add comment on it.
>
>   fs/btrfs/inode.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5bbea5ec31fc..b32def311f44 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4460,6 +4460,12 @@ int btrfs_delete_subvolume(struct inode *dir, str=
uct dentry *dentry)
>   			   dest->root_key.objectid);
>   		return -EPERM;
>   	}
> +	if (atomic_read(&dest->nr_swapfiles)) {
> +		spin_unlock(&dest->root_item_lock);
> +		btrfs_warn(fs_info,
> +			   "attempt to delete subvolume with active swapfile");
> +		return -ETXTBSY;
> +	}
>   	root_flags =3D btrfs_root_flags(&dest->root_item);
>   	btrfs_set_root_flags(&dest->root_item,
>   			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
> @@ -10418,8 +10424,22 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
>   	 * set. We use this counter to prevent snapshots. We must increment i=
t
>   	 * before walking the extents because we don't want a concurrent
>   	 * snapshot to run after we've already checked the extents.
> +	 *
> +	 * It is possible that subvolume is marked for deletion but still not
> +	 * remove yet. To prevent this race, we check the root's mark before
> +	 * activating swapfile.
>   	 */
> +	spin_lock(&root->root_item_lock);
> +	if (btrfs_root_dead(root)) {
> +		spin_unlock(&root->root_item_lock);
> +		btrfs_exclop_finish(fs_info);
> +		btrfs_warn(fs_info,
> +	   "cannot activate swapfile because subvolume is marked for deletion"=
);
> +		return -EINVAL;
> +	}
>   	atomic_inc(&root->nr_swapfiles);
> +	spin_unlock(&root->root_item_lock);
> +
>
>   	isize =3D ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
>
