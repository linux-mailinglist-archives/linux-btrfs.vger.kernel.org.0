Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3078E2E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 00:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjH3W4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 18:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbjH3W4M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 18:56:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E68CF3
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693436113; x=1694040913; i=quwenruo.btrfs@gmx.com;
 bh=j3lSKjylnPs/kJ/R2jWYQLgqxGy38/Icb74i1oKUrew=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DrbE7/WvCa///LrcntdkeDbCZmmhap/cwM/IiYiyFCiuNsP1/JstISav6CYdY1tXLtVYEl7
 kbWU2DzneppsLcyD7JLt+3O+7GkL5KIB4Q+4Akubi9hK82fnOQeSzujO+b7rcjWmV1liR2alU
 BCRdkQuygepnBnKlwW2A4mi0IcxH2DMeY7llEmGnjALl8GkCKZFs1POvwPKmRXvgFJfI3xnbO
 iyULi98h6PWhgQZ8F3DvIUlqy+LK+ZHxWCOX7AzDWR882UxPDB2nufhASMAM2ad8BHc74w7yv
 iOKbXvjA79C+jrWy+CC+8UHGLIHDY+nuStimkCF3/+ua/lFSHbGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7K3i-1qcb5I198G-007nKf; Thu, 31
 Aug 2023 00:55:13 +0200
Message-ID: <74b442b5-23fd-4edd-81e3-58fca98d8b48@gmx.com>
Date:   Thu, 31 Aug 2023 06:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] btrfs: qgroup: use qgroup_iterator facility to
 replace @tmp ulist of qgroup_update_refcnt()
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1693391268.git.wqu@suse.com>
 <e6d30c5f77867f20ca19244e5c37881188855d6e.1693391268.git.wqu@suse.com>
 <20230830220920.GC834639@zen>
Content-Language: en-US
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
In-Reply-To: <20230830220920.GC834639@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORG0POaUr+nnraKNfAMs7gM31JFJpGFftmHh23BE9lBYgqDnmoH
 auaOAWhm2/I23bNy3Z9grxhM71SvAwFzwteWgOSGLXmQC+JhXHURkYQHh5eUn40zxYy7Kvc
 OaOMaK3ZLSsS8jB+ibXlW4b/yqsCFuuqFFctreG02zn1+9XIByoTcxUuhLowog/aR/jVZjw
 OuNam08++KHTjXHmMrxSw==
UI-OutboundReport: notjunk:1;M01:P0:+23OorgPOwA=;xM0K9HAcl2V0mnGfdJywYuYyg2j
 /PJUZ52RmyQgbs//RtSP4GLg1QFYXyg951I5LKjaMADHAh17d1FYCrL2nUZ47LJq3i4bQQ0JZ
 DcD7Wswgjjt/dpANH6P0w/fEkq8xcvGW4QxVHPHumx2qWc6SdAvj2vAfZWjgYkqwCumhZV4sr
 ZwCQni18AH+2KopC2c+d2GbNxCSaHdkQuEDpPklr2Q0u6JliuzJqr/fW1fSLZHC0+QNPeBj9m
 7W3oiJTCq4Upt4dkQN6UHSme7puSq06VnUZmxRFOd3OIOmeMnfacTNPbOCcAs1XuOISLFy6M4
 zPPp4f0uWB3tM9fQ/hEoTSXmVHP5xeH0Uskn8GTulckgfwrdpDdQ4Qgi0nLcjR7UMaCOKd1vu
 lXw5hCigvZxZwkAKdlgqvOPMQWBdV9wnmYGbUkqwG+wQMgHRgwVVhpfunMIUW1ru/HpTXpsVk
 QkMYdcsWGCDobvE8YdUVj6TPqy7MSv0hU++H44X8OYxPwj0s8Dc/bpkYuH2nZNe3bKiv8YQnF
 V69yEUMW97cgMeAym8D4ioisC0vjS7ZuyF/eAY6LIjCrQ4iApPbHQ2qyWK5r7RM99Fi/JfjaT
 X7TAEtXYA4StzN6Rp+b00HSiUM1r0p0VGIkEAuob7MIFoTiVpq4W4GZhmSR04TvG1d0rGTrZ8
 0SIGARuUuF/CoOhmygTvcWQtizpX9uuvL5XYqHJDwRlfi0+zY10UZXlwGKHHLq4mN3hda47ra
 pwov+2AKgJvsbHIJot8+47OOymnlPwkBfk+H9u6ki0HHAS1nsouA+FVDGenH26OHt2/avG8cd
 qheLm2zGvYewB5i2hOczY2t1NIfu0jmuaTvlHAoroq6OA013WsyupXUpANb3HQWlupBhCz/WM
 puvvpKxXajjF98CJ2mQCzXLrsYy3EiaSxTj64zdW8m1b491ZuDfuHnjUL5i1/etcOmffQyhQU
 4fx6zeVNmk04DJcVVdiKNVWpGko=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/31 06:09, Boris Burkov wrote:
> On Wed, Aug 30, 2023 at 06:37:27PM +0800, Qu Wenruo wrote:
>> For function qgroup_update_refcnt(), we use @tmp list to iterate all th=
e
>> involved qgroups of a subvolume.
>>
>> It's a perfect match for qgroup_iterator facility, as that @tmp ulist
>> has a very limited lifespan (just inside the while() loop).
>>
>> By migrating to qgroup_iterator, we can get rid of the GFP_ATOMIC memor=
y
>> allocation and no more error handling needed.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/qgroup.c | 37 +++++++++++--------------------------
>>   1 file changed, 11 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 08f4fc622180..6fcf302744e2 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -2463,13 +2463,11 @@ int btrfs_qgroup_trace_subtree(struct btrfs_tra=
ns_handle *trans,
>>    * Walk all of the roots that points to the bytenr and adjust their r=
efcnts.
>>    */
>>   static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
>> -				struct ulist *roots, struct ulist *tmp,
>> -				struct ulist *qgroups, u64 seq, int update_old)
>> +				struct ulist *roots, struct ulist *qgroups,
>> +				u64 seq, int update_old)
>>   {
>>   	struct ulist_node *unode;
>>   	struct ulist_iterator uiter;
>> -	struct ulist_node *tmp_unode;
>> -	struct ulist_iterator tmp_uiter;
>>   	struct btrfs_qgroup *qg;
>>   	int ret =3D 0;
>>
>> @@ -2477,40 +2475,35 @@ static int qgroup_update_refcnt(struct btrfs_fs=
_info *fs_info,
>>   		return 0;
>>   	ULIST_ITER_INIT(&uiter);
>>   	while ((unode =3D ulist_next(roots, &uiter))) {
>> +		LIST_HEAD(tmp);
>> +
>>   		qg =3D find_qgroup_rb(fs_info, unode->val);
>>   		if (!qg)
>>   			continue;
>>
>> -		ulist_reinit(tmp);
>>   		ret =3D ulist_add(qgroups, qg->qgroupid, qgroup_to_aux(qg),
>>   				GFP_ATOMIC);
>>   		if (ret < 0)
>>   			return ret;
>> -		ret =3D ulist_add(tmp, qg->qgroupid, qgroup_to_aux(qg), GFP_ATOMIC);
>> -		if (ret < 0)
>> -			return ret;
>> -		ULIST_ITER_INIT(&tmp_uiter);
>> -		while ((tmp_unode =3D ulist_next(tmp, &tmp_uiter))) {
>> +		qgroup_iterator_add(&tmp, qg);
>> +		list_for_each_entry(qg, &tmp, iterator) {
>>   			struct btrfs_qgroup_list *glist;
>>
>> -			qg =3D unode_aux_to_qgroup(tmp_unode);
>>   			if (update_old)
>>   				btrfs_qgroup_update_old_refcnt(qg, seq, 1);
>>   			else
>>   				btrfs_qgroup_update_new_refcnt(qg, seq, 1);
>> +
>>   			list_for_each_entry(glist, &qg->groups, next_group) {
>>   				ret =3D ulist_add(qgroups, glist->group->qgroupid,
>>   						qgroup_to_aux(glist->group),
>>   						GFP_ATOMIC);
>
> Thinking out loud, could we use the same trick and put another global
> list on the qgroups to handle this one? Or some other "single global
> allocation up to #qgroups" trick.

I'm considering this as the last resort method.

Currently I tried to move this qgroups collecting code into one dedicate
function other than doing two jobs inside one function.

But that idea doesn't work as expected, I'm hoping to at least
understand why before adding a new list_head.

Thanks,
Qu

>
>>   				if (ret < 0)
>>   					return ret;
>> -				ret =3D ulist_add(tmp, glist->group->qgroupid,
>> -						qgroup_to_aux(glist->group),
>> -						GFP_ATOMIC);
>> -				if (ret < 0)
>> -					return ret;
>> +				qgroup_iterator_add(&tmp, glist->group);
>>   			}
>>   		}
>> +		qgroup_iterator_clean(&tmp);
>>   	}
>>   	return 0;
>>   }
>> @@ -2675,7 +2668,6 @@ int btrfs_qgroup_account_extent(struct btrfs_tran=
s_handle *trans, u64 bytenr,
>>   {
>>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>>   	struct ulist *qgroups =3D NULL;
>> -	struct ulist *tmp =3D NULL;
>>   	u64 seq;
>>   	u64 nr_new_roots =3D 0;
>>   	u64 nr_old_roots =3D 0;
>> @@ -2714,12 +2706,6 @@ int btrfs_qgroup_account_extent(struct btrfs_tra=
ns_handle *trans, u64 bytenr,
>>   		ret =3D -ENOMEM;
>>   		goto out_free;
>>   	}
>> -	tmp =3D ulist_alloc(GFP_NOFS);
>> -	if (!tmp) {
>> -		ret =3D -ENOMEM;
>> -		goto out_free;
>> -	}
>> -
>>   	mutex_lock(&fs_info->qgroup_rescan_lock);
>>   	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
>>   		if (fs_info->qgroup_rescan_progress.objectid <=3D bytenr) {
>> @@ -2734,13 +2720,13 @@ int btrfs_qgroup_account_extent(struct btrfs_tr=
ans_handle *trans, u64 bytenr,
>>   	seq =3D fs_info->qgroup_seq;
>>
>>   	/* Update old refcnts using old_roots */
>> -	ret =3D qgroup_update_refcnt(fs_info, old_roots, tmp, qgroups, seq,
>> +	ret =3D qgroup_update_refcnt(fs_info, old_roots, qgroups, seq,
>>   				   UPDATE_OLD);
>>   	if (ret < 0)
>>   		goto out;
>>
>>   	/* Update new refcnts using new_roots */
>> -	ret =3D qgroup_update_refcnt(fs_info, new_roots, tmp, qgroups, seq,
>> +	ret =3D qgroup_update_refcnt(fs_info, new_roots, qgroups, seq,
>>   				   UPDATE_NEW);
>>   	if (ret < 0)
>>   		goto out;
>> @@ -2755,7 +2741,6 @@ int btrfs_qgroup_account_extent(struct btrfs_tran=
s_handle *trans, u64 bytenr,
>>   out:
>>   	spin_unlock(&fs_info->qgroup_lock);
>>   out_free:
>> -	ulist_free(tmp);
>>   	ulist_free(qgroups);
>>   	ulist_free(old_roots);
>>   	ulist_free(new_roots);
>> --
>> 2.41.0
>>
