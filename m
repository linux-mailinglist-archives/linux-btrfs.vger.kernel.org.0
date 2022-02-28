Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354A4C61B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 04:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiB1DRz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 22:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiB1DRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 22:17:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752EC51E51
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 19:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646018228;
        bh=FvXKmajJAwxPxdosoamJ7faUqX18Mw6o+hqWlQv3AbE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=KU50mi+Ko/bgdtvIe5la7sydJz7ZAfDByr07r40jz5sWL+Pu+mM0jl6vwNWW8iaJ6
         VI595o6lQc0vCHrqa4mCRYEDawttghTVUtbxTxSo9OXil193M4OQEJtIGylSS32nmp
         1xLPY3dmXZ+3pikdQ5SW8UOPT2rfmUDNnPRr+R+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbEp-1nY72O1TFL-009geL; Mon, 28
 Feb 2022 04:17:08 +0100
Message-ID: <75c0e9c7-165f-3a4a-dda1-ebd0cc092392@gmx.com>
Date:   Mon, 28 Feb 2022 11:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <ad2279d1be9457b5b0a7dc883f7733666abb1ef8.1646005849.git.wqu@suse.com>
 <264cfb18-70ed-c20f-ba28-3fad002ed645@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: repair super block num_devices automatically
In-Reply-To: <264cfb18-70ed-c20f-ba28-3fad002ed645@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+O9DB57N+/6+ZfD3sZ7/E623ooMwkwO7TG6FWzb+gvTdOv13G9q
 mnTgyw1COn2m+nEVLif2lQWXQG0wzqAGSX8/UxwFOH+VxYi8fFtd+4Zf31Vol5K2nUgNWPR
 1veirPkL4NnhV1gZbO6cvEDsSLqEP9cy71hHP2kwMdyrUw6/dYGNpeqlNMLcA5YcO6GUd+p
 i+9ud7o3FKbg989HFjsBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S9tn5qC8ZVc=:01I4fkM2h+s5Dn+pC/ngXP
 5dRz7OzpANQWbIszxJy0tIrPC/yQDQB8Y8jdQ/jXLcog49agpVBEZdisKfdeJjrkZGQVXqzdz
 FUDkYSRme1PqZOIFmcaYvWtwUaJ1ZmxpaaXbNHWD3AWThjqPeT8tZIdRfueWz+Tna/Cv3N/4c
 eLSqM+zZr3NGJ158i6UWektJxSg8xNf2PBO01sF61VRHqncPmVGJKkTVB8EVH02xW1C4+0o0K
 4mpI01wvTYkbjlbjcX1KFAU+npAxynsqk2Y7PqU4+mvfUDHYcYBBgKGP7z+cInLFv6k2BSzy7
 bR9UKEe/lhy8V1iipmoMLHuOD0CT/r0unLtOJ53aI1fk5waZNOFDp4uy8ASn2ZWXbNN6ZJfPK
 tJxAcMjF8epj/pZclrInXawyzaXIKawAOfLyle9mHExLpXJ5475JXWUrMbiujv88B2G4P6fDO
 8/7CepWLOEmezyJ6RTg0hjZoY3cVtptNDycD+bLKToYoupLtcevwNjYSBC/S/lPDTV7hrf73Q
 DoMoXor6We7uCtZjWbOIPE7tMAjT9jYJEbXiRuRx5snf15v0omquiPnRTYyxAzTBN3FIaNZZr
 nvxca9bFnICviiXLyAPePlli3U03IXBI2teyVb5uFEGWYmRXdslotBBiYXX0V2N3Q3tURSF/x
 VFs6qXAY0Cufvn5yvNMQ8XTT+gcqIGR8eXKWp1j6W0ImOpS+7C7yW3sH+ngQM8xf1MceFu+iF
 T7N6/7k31PJRhFJW9GbzcC0cbFX9benZWKkdolcLlx47V2rz9UuZ60m5sr36ON3ZgJFrPJOEa
 59NmhgUVuI5ceHf+0QsWHn5GT5TT1ph6GuJCWOLNDDcxeLoSSVLDrsjGD/hXHvCcVJ9F6yKfL
 4u63i2kKmX/xmYBsRYyRQuXP2rZldoM5Y9GPmDzbad0O8pkQrhE/O+5iY50QjnsN5KOn062XB
 VLccCNECJPO+ObBjX/3RKyfQCCfYQsNLH/K3aO4cut2BYbOkhTBaff7pWy/1IIR4C1e/rK1xz
 HJPfAglS2Jh7L3fU74PNI6YKClYKKRP90fQ7ENSeBG6kiPKmua4PsaKsHbZ+RLodg9rvDdU/x
 W32tICbtxtffc0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 11:08, Anand Jain wrote:
> On 28/02/2022 07:51, Qu Wenruo wrote:
>> [BUG]
>> There is a report that a btrfs has a bad super block num devices.
>>
>> This makes btrfs to reject the fs completely.
>>
>
>> [CAUSE]
>> It's pretty straightforward, if super_num_devices doesn't match the
>> deviecs we found in chunk tree, there must be some wrong with the fs
>> thus we can reject the fs.
>>
>> But on the other hand, super_num_devices is not determinant counter,
>> especially when we already have a correct counter after iterating the
>> chunk tree.
>
> Cause analysis is incomplete, given that SB write is the last. The root
> (and thus chunk tree) and super_num_devices will be consistent always.
> Do we know how the miss-match happened?

Sorry, I should provide a full analyse on this.

In fact there is a window in device remove path that we first remove
device item in chunk tree, and COMMIT transaction, then decrease the
device counter (without commit transaction immediately).

In fact, there is already a TODO comment in btrfs_rm_dev_item() call
inside btrfs_rm_device() saying exactly the same thing.

Thus if we got a power loss/reboot, like what the reporter is doing, it
will cause such mismatch.

Thanks,
Qu

>
> Thanks, Anand
>
>
>> [FIX]
>> Make the super_num_devices check less strict, converting it from a hard
>> error to a warning, and reset the value to a correct one for the curren=
t
>> or next transaction commitment.
>>
>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.com>
>> Link:
>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_cWCOH5=
TiV46CKmp3igr44okQ@mail.gmail.com/
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/volumes.c | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 74c8024d8f96..d0ba3ff21920 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * do another round of validation c=
hecks.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (total_dev !=3D fs_info->fs_devices->=
total_devices) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatch =
with num_devices %llu found
>> here",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_warn(fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu mismatch =
with num_devices %llu found
>> here, will be repaired on next transaction commitment",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_super_num_devices(fs_info->super_copy),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 total_dev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_devices->total_=
devices =3D total_dev;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_super_num_devices=
(fs_info->super_copy, total_dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_super_total_bytes(fs_info->sup=
er_copy) <
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_devi=
ces->total_rw_bytes) {
>
