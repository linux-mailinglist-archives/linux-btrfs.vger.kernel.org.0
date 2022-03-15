Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5894D95D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 09:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiCOICr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 04:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345756AbiCOICn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 04:02:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97AD4BBB4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647331285;
        bh=JzrsB6CtptmJuSushM5Zdx35TjzQtLia3FCTJWUvvh0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VnJKg8qekHDNbwGb1Z6TpzOWKYyNdCvnthd46zaIa773axuEhWMdmlJntOGbUCP68
         sFxEIalWr4/QrU8NOlNTfmX8veP4ixS/VgyvmyBg/oqKZMLYDAsUJ7iJUmLd+o//Ze
         Bhq9I5huql+pOkVtDy2RGWeyQmIyb9BidlAR+HQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRQq-1ng6Om1rNE-00TovW; Tue, 15
 Mar 2022 09:01:25 +0100
Message-ID: <edde24da-de09-b62f-2f1f-722bf7bbaa0c@gmx.com>
Date:   Tue, 15 Mar 2022 16:01:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 13/16] btrfs: allocate inode outside of
 btrfs_new_inode()
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>,
        Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
 <24d8818e1152a8fb31e2d78239ce410d2a0f8cd4.1646875648.git.osandov@fb.com>
 <CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com>
 <Yi/a7a4C9zT/c+KR@relinquished.localdomain>
 <Yi/odcN1e3QUiWU0@relinquished.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yi/odcN1e3QUiWU0@relinquished.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Qom8us5uyOBjTVxlT5zaVuv46hyGgwfSmFnP/r8No+ay1WYNy+
 +d+cZZKrimpHNbFo84UDyJjxwSjiUJLF/T8LF0JDa98Zy9jJMQkgRI9TqW6mcB0nLEi5Hmt
 x8nfG76SxUgwnqHArHUIJGOfOhKf7qwV+bnH3cMu69XHWw6C2x5jUGT2roJxUqo5B02DcA3
 ImkmWjy9VZF/fetyCHR4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:84KdNChX2Qk=:YzCYG+I3nJ6LOzscvyDCeK
 dBr018ZhiEoItSi3hthtlBkdS7SeNpcdtl4AD9zjq2L6Ff1KLOo6+GMmewrn6qLjJFMnHpNKL
 rGdZGjEY3PTwOu5nza2QjWbg9yP3/XG2t9r0p0jIvWTar9U49ftYwf/QD/tITIIjCqNfocXLk
 l/mUxbBCydOH78rfH+0h8XT10PyzmsuTXxJ6kEs1AdFqOHman5/9tC/LdjziMLSweFrD+uMw7
 GKebfLRiYhTJ08TdfiQjmTwQLN2CY8FDdeV2ACsHENqrd1agz5eoK5jLpPlRxdDT21c7QNPso
 TGZAjQ1gN2gNNAKPyHsHxnNDFYUsLeQjVVqZKXXTqi81oeTZH4ZzLRlfvdOP6SHT/B6LdCMbs
 50iSj1XRDD4v8e8/hI5M2x14jjGfGH4hp3HPOWizSjmLfS2heStkKRKW5xmk9cyvfM9HseJu/
 jpppE8YynxTk0wfWdzptys2SAbzM+rprVtzdo0pUM6hNHNkULWzG0Rf2gzbJBalM426Rd7IXR
 2qoyfvq6acZlLN/E7fnM2bQoHzy7CDfB9wPj8HjHL9czCbHA4Enwbo9N3RuzD88in3s/CvLge
 ePAKGEKUgtFoykS7Hp0tXI5umnhrRXeOMbETMDdPtP6k6ODN2WlF83DWJOb3qNKvh3bycNmrS
 vbf9OZ/MC+LG6hnzx5j90a7PON+tRHsDOAk6R1CHgMzgnaqfQhK9k7jvIo+P4tzSVnZKQqD0B
 8ErdtTA2XbSwpz+fu2xfc5SXAsHG3qVzY0iNdSiHVoAaSLf4i7AN06GKhGQCk68uH80smre6y
 lSpT4XSTIo3qNaU8Y0FMW57Y8aAukRnuSJpQI9od46aumj+w34iF3324HEdWFfZnVKs5H1q3F
 uk/lY4A0ZLuNdb9WFFHd7YxrSdHzRMZmLFE/wUeSj5/D8QEWe8tIh4i0MVp8buG9zNPLU2BUT
 sHMcJ4CKrHKCCCXWOltj3rvIXVARUzc6xThIi2GM5SDmxwf5UA8fBUxd0wtRYWz9gAmCvu2vL
 ihY44C5EmEglkqxd44Tm3hiEYk7n1QQeOb3aBzD9pJFSyGI1r6LYysJ/uHAGgIxq9PHkdhhTN
 40fauLZGTBKjWA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/15 09:14, Omar Sandoval wrote:
> On Mon, Mar 14, 2022 at 05:16:45PM -0700, Omar Sandoval wrote:
>> On Mon, Mar 14, 2022 at 11:33:51PM +0000, Filipe Manana wrote:
>>> On Thu, Mar 10, 2022 at 4:56 AM Omar Sandoval <osandov@osandov.com> wr=
ote:
>>>>
>>>> From: Omar Sandoval <osandov@fb.com>
>>>>
>>>> Instead of calling new_inode() and inode_init_owner() inside of
>>>> btrfs_new_inode(), do it in the callers. This allows us to pass in ju=
st
>>>> the inode instead of the mnt_userns and mode and removes the need for
>>>> memalloc_nofs_{save,restores}() since we do it before starting a
>>>> transaction. This also paves the way for some more cleanups in later
>>>> patches.
>>>>
>>>> This also removes the comments about Smack checking i_op, which are n=
o
>>>> longer true since commit 5d6c31910bc0 ("xattr: Add
>>>> __vfs_{get,set,remove}xattr helpers"). Now it checks inode->i_opflags=
 &
>>>> IOP_XATTR, which is set based on sb->s_xattr.
>>>>
>>>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>>>
>>> There's some leak here Omar.
>>>
>>> misc-next is triggering tons of these on dmesg:
>>
>> I reproduced the "page private not zero" messages on misc-next, but not
>> on my full series, so it's probably some mistake I made when splitting
>> up these patches that doesn't exist in the end result. I'll fix it.
>
> Yup, this patch needs:
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ff780256c936..d616a3a35e83 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6143,7 +6143,8 @@ static int btrfs_new_inode(struct btrfs_trans_hand=
le *trans,
>   	 */
>   	BTRFS_I(inode)->index_cnt =3D 2;
>   	BTRFS_I(inode)->dir_index =3D *index;
> -	BTRFS_I(inode)->root =3D btrfs_grab_root(root);
> +	if (!BTRFS_I(inode)->root)
> +		BTRFS_I(inode)->root =3D btrfs_grab_root(root);
>   	BTRFS_I(inode)->generation =3D trans->transid;
>   	inode->i_generation =3D BTRFS_I(inode)->generation;
>
>
> A later patch does this correctly. For the sake of git bisect, I fixed
> this and sent out v4.

It looks like the current misc-next doesn't has this code applied, nor
the later patch to fix it.

Thus it's causing tons of failure (using btrfs/065 as a reliable
reproducer here, dmesg will be full of eb leakage.)

Thanks,
Qu
