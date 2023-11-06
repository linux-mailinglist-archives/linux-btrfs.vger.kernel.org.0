Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF727E2E6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 21:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjKFUv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 15:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKFUv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 15:51:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328110A
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 12:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1699303878; x=1699908678; i=quwenruo.btrfs@gmx.com;
        bh=BU/O8SrMzXEhhDUkBd4AGtOOK4T1nRgsJLuo8gZ9cRA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=QNlpIoaP0B29AkFt+cbdVXGL17tBMGEJEkz78PlZAD4Hwv8Z5dAEoitIMK+ByU91
         F7R8ioAHsDSEWqWWnBm+oLsp+TMtze53VPmzXRgrgd9u6j1quXXiziDNE41HJk9FC
         hhhJwp0EZ8pcL3UH3SMiDtwytArvmhcM1exEXYBHfc1ZwTUVkIS9B+NNQFOfblpVa
         SewvGj1VZmeVBojOzTns2O/HCiRh+llu+GpxZ5hN/Bhp1h8xsd7piPcp/CfiL1ayV
         9p3RU6m7iPWlYJxSPI2LuCCCFBHaFVdL7ZGqvvTa11+KTOvjtOhue526s1wcUKdRL
         klNtFQDpczAOABqYiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzuB-1rYd2I47El-00dVz0; Mon, 06
 Nov 2023 21:51:18 +0100
Message-ID: <990cf7ae-a14f-4c6f-8a1a-0a4e6078b58e@gmx.com>
Date:   Tue, 7 Nov 2023 07:21:15 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix qgroup record leaks when using simple quotas
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <2431d473c04bede4387c081007d532758fcd2f28.1699301753.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <2431d473c04bede4387c081007d532758fcd2f28.1699301753.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aRw0/lKGxxoLF/8JkRtw3O8IvCjRXh7W75L0Q1oyw5q2nH+6q3P
 jHKWCiU7XkT5tg4Mq96QAHAABpVQBek42cqDmfmbBJ2JUoB4oHwNAW/cHK8pDvYLBdYhuk/
 4iMkDVdS5XWp1PZBCgatdKC+ZIw93aSPeaY4O9zSSuyuXUNTDD23NRmNV8ROh6HpHobRLU7
 rxkMgZvWPEBJe6lv/bbVw==
UI-OutboundReport: notjunk:1;M01:P0:2gMGg480oTU=;OOWtqTCRtWaltaAyxtmYofn/y7W
 MwHKuhklNva/Ueavvf5VoOsXUOvjTPrr1gzjjwkkcJLqL7rs62Lil+vIdNxiypu7ufzoOa83w
 0K2Q1BZ5vVKH9x+CIgAJZiuIWCXCVecXrK5moQazeOVaPv1UxroIpZfbbGWBfb10U3Y2MNFs+
 8D3eN7o7jM7rffzDYWWDHcjmVgkeI6S32aaXEdC+o8vIMCKO6co8ApdWa0Gqhb8+kzP7ace1w
 s0f0812UuV7nnVERTZa9dZhFpFnW7iRMfVAWB8umrnw+YbKF9OMzTKp9XWinzdfHI/0dB984K
 qRnjzYLxOkkCxZGGYSTIClFuj9kHTr2u5TV6geqlDWh8EqBsA0HfwLunvRxv0Ssx8GBtLSDoo
 EmwLdACHR+qV2PQ9wPhvkNvP6WGVHaXaUEz0sVhZRS+yeWR5xSZ+7Bnls87l7IYI6NWXbqDzB
 jGIDfKZT7aNoohd8u2mXjVGXEtnQX+gia/77SXMINSATNHkQ53f9BBv40quSIddOPmpgz2J6D
 X32nfES67DqQqodhTGcz33WwGVQ3h5STlueOpN64OEFH0hiAoaGWiZleIyoPTCvS+nq8CsI5M
 UMLkczy24+w9UfPPCMVt5MltR6Bq70L8+k5MwdAtjWnEZ5iV1nEdFQRTQoUMBv2PHVz2Q+GOu
 CU2R8gzVfITo6vdgJ9HaC703IyNveUOYPGY1Jk5mMJeRyc7ZGZkAfO/aSDawP8B32PKhevWLS
 pAxHTs6KcSV6Az/Syu78UirAfDCi8s6OmqXbaj4E/eSi5tlt74FufMg2z89wD0W+HWhf2hV6E
 HfA5S1dzCg1VYJjgNYXdg2hsg6PC8ZYGu09uUx/DPIkJAMSslXy9hcdZJaeCLuNLFAD0UcLYi
 2/lZSATIBStnOvAccaUDjXTB44kz82uLXw+qhY08BC29kX/TOx9xiVTVruYeHvjGLxUaacO1W
 /7j/h6q/xH8zL8oQNR8tBEPbOCs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/7 06:47, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When using simple quotas we are not supposed to allocate qgroup records
> when adding delayed references. However we allocate them if either mode
> of quotas is enabled (the new simple one or the old one), but then we
> never free them because running the accounting, which frees the records,
> is only run when using the old quotas (at btrfs_qgroup_account_extents()=
),
> resulting in a memory leak of the records allocated when adding delayed
> references.
>
> Fix this by allocating the records only if the old quotas mode is enable=
d.
> Also fix btrfs_qgroup_trace_extent_nolock() to return 1 if the old quota=
s
> mode is not enabled - meaning the caller has to free the record.
>
> Fixes: 182940f4f4db ("btrfs: qgroup: add new quota mode for simple quota=
s")
> Reported-by: syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000004769106097f9a34@g=
oogle.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 4 ++--
>   fs/btrfs/qgroup.c      | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 9223934d95f4..891ea2fa263c 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1041,7 +1041,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>   		return -ENOMEM;
>   	}
>
> -	if (btrfs_qgroup_enabled(fs_info) && !generic_ref->skip_qgroup) {
> +	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup=
) {
>   		record =3D kzalloc(sizeof(*record), GFP_NOFS);
>   		if (!record) {
>   			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> @@ -1144,7 +1144,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>   		return -ENOMEM;
>   	}
>
> -	if (btrfs_qgroup_enabled(fs_info) && !generic_ref->skip_qgroup) {
> +	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup=
) {
>   		record =3D kzalloc(sizeof(*record), GFP_NOFS);
>   		if (!record) {
>   			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index e48eba7e9379..ce446d9d7f23 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1888,7 +1888,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_=
fs_info *fs_info,
>   	u64 bytenr =3D record->bytenr;
>
>   	if (!btrfs_qgroup_full_accounting(fs_info))
> -		return 0;
> +		return 1;
>
>   	lockdep_assert_held(&delayed_refs->lock);
>   	trace_btrfs_qgroup_trace_extent(fs_info, record);
