Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4B4D25B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 02:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiCIBOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiCIBNZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 20:13:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E12253D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 16:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646787421;
        bh=wKhne6KKZJPtM/9UzbDG0DsPhxB3BKH850tAo2onK6g=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ORIE6ftQyBhyW7fLvaJPAw+D5bSOY8mgfh8i0C3zfxancKjFNJQ6PJZ76qjsM/L4e
         tXRw2HqMaLm32j1t9VH4JA5dMgP5tU3Eum8toDp3GQL1sSzTMqd+vt7giyjAA+Dq3i
         S00LiQlwMmC4tzpGT8HaVD1UqkYq/rkiqehnReHc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Il-1oAJJD3BWP-013KwV; Wed, 09
 Mar 2022 00:48:31 +0100
Message-ID: <7a4962a0-b007-59a4-282e-8912b2425c5e@gmx.com>
Date:   Wed, 9 Mar 2022 07:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     bill gates <framingnoone@gmail.com>, linux-btrfs@vger.kernel.org
References: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Updated to new kernel, and btrfs suddenly refuses to mount home
 directory fs.
In-Reply-To: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J2YqXKMZcc76E3BuVop9WaIPCnwKQOylh5+4c49I7xoL84KxnnN
 V3NC03znqzTkkxA5ARcnlVqVlfveCgyFXfeG5/gpFnAiMpCRVi/31Ft6ee8fFtvxibf2+Fm
 gPChKslzs7c9Dh9bbr6biwL4jX+ZkptgyFNKBouVRq6bQRnt8slDMnG0PfuIQ4adfk9aldT
 efIaGVu+XISe6BZO6Pz1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qz7vlbbB7xw=:iSjHLJ88NCkvMUjIPk75Kk
 /SNkDMhKHKlaS4q+ZfbmoruTcefoIqXylIStdW3YivBe55JCsnBNTBtIrmdHLSjXSIzxSqbst
 0xTv2+4qivPxmqwKM8Uicukj9rnvB+2BsgaCCl36HlrNYt509dHMUKZAwOpSY/LwY/ycJ/Yc3
 MwGSHyXTRMYhpqGbO612VcKHty6niq7AtKPClDIRCAvfWvAEZ8f+e5DRsrAuGcS8DbS9GZvvX
 DE1sn+Ce0fntRrrFcVp4ntlRKmmQa5ogVO9s8qCISmajF8uFv8uTDATbEZwi8thUkVKYdIsu5
 x+2jXgqbxpMgTQ17Gkywab1NS3M9JF1fkH2agDrYv5QhCQijaYjCuftRTK7CSVJ8uJLzSKOQ2
 mNYOyKM+me9SKZdrgH+mcNgkln1gJpLyaKcHi+QXK9W+G/hT7dMmuOA5RKyWnY3QBNfqXMvVu
 V7CdbgaJ9qeQpHNf2DjiY3J/856bPQtpRHE/8EpvUpjyaMeypohZ1cvfj1+cnzljrDqTvQBi+
 Tw6u+bCM6SpA1HXNTce750h/6VY1vvBWmj8CaFlwqAVtXFMaghEjrm/0qJ3X8hX+8oNIHp8Qv
 JCWrhuVhWDIm52hrmPdY58wk8RkNOjIMj8sXJodCJlWhRInrvU2Lk8Si+FCxOA8YYISHy2YqZ
 ZwKWKdmDKXN8MYRMkrV/WOsDjVUIiJClXk/Rs9R9xe3aGdX6TbkmoAO/DHHCwuI6/NFTDrpOo
 /k0GH1y2vCX9y1j8iFqyDDOdwKPBRrmSrMRgbZjEJM2C3ljUmAPOTxGm0k3k5Odlog2r6ChnI
 k6/FDCHaF7UljUTtYN1B3jZnNdOIqFPBI+/VBjIhSXYxNnhyXig7TXQe3+RLAjSMviPLhWo6X
 ZVm8VCax+Bjjs5xyi5m0mKQdm1Kjmiq9/KgnfmHt65odw+FBko26Dl1cW83oM1HADzGXN1oOe
 uLsW4TFJBTdketBr0sS3JbKTPcC1+pnnmsTqNoLIA2AOG5epJp9n4L+SFptoZB7j1wlktXV2G
 IlFnWV83KcEb5t8gl9X+uP67L+gTh823ZUOiDmZsuSXtfrrAuaOBJZt4uKBkbjR31J+EzgY8S
 9N489Nwb+UjHdE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 03:05, bill gates wrote:
> So, I recently attempted to upgrade from Linux kernel 4.19.82 to
> 5.15.23, and I'm getting a critical error in dmesg about a corrupt
> leaf (and no mounting of /home allowed with the options I'm aware of)
>
> [ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=3D1
> block=3D10442806968320 sl
> ot=3D8 ino=3D6, invalid location key objectid: has 1 expect 6 or [256,
> 18446744073709551360]
> or 18446744073709551604

Please provide the following output:

# btrfs ins dump-tree -b 10442806968320 /dev/sda2


The error message means, we got a DIR_ITEM in root tree.

Normally that is used to indicate what default subvolume is.
Thus it's normally 6 or 5, or any valid subvolume id.

But in your case, it's 1, thus tree-checker is rejecting your root tree.

I didn't thought we could have 1 as default subvolume (as 1 is the root
tree, which is not a subvolume).

But it looks like we should update btrfs check to fix this case.

Is the fs created using older btrfs-progs? I guess that may be the cause..=
.

Thanks,
Qu


> [ 396.218967] BTRFS error (device sda2): block=3D10442806968320 read
> time tree block corru
> ption detected
>
>
> Interestingly. that 18446... number is a power of 2, looks like maybe
> a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
> check" found no problems with fs on either kernel version. Would like
> to figure out how to fix this, if possible.
>
> https://pastebin.com/0ESPU9Z6
>
> Thank you for any assistance,
> -- Laurence Michaels.
