Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888E877F1CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348721AbjHQIG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 04:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbjHQIGg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 04:06:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3918C2D73
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692259587; x=1692864387; i=quwenruo.btrfs@gmx.com;
 bh=GtTQWjuwvebqbHuakjll+1TnQrDCWGw7mhD/MpXBxjY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dY4djMksl9+bxsGHu/vbNmXtJsxlP3kohuGYXOnZx3gPvyI7XhtyajOBzK3MG5lyxQ2URtk
 UF5aBMJT+eT4dnhC2tADJ+5kc7oA677FAxLnR1bfe/CNPrhTaOXiWm4eZ7p/yK5pf+kWWWRjF
 2QYxljOGf7+WcUI9nastFtaiLC2aVua27UOASQBDxkV3yK4sdkHwXblc4zZJZlWcQVH5kYHTZ
 G1xx1Fp/Nw67umicAQnoL00JeD5JuxrHbrwQv6SyFJgQ7XaY+lvAKp2nE7EyzARme6XntdUCR
 sCTFD6bN2m8iz7YW6DumFq/s4/rddxLXNx9oYd+E4G6s9bt7B7IQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUnA-1pg67s2j8k-00rUAc; Thu, 17
 Aug 2023 10:06:27 +0200
Message-ID: <58134f59-671c-46ee-93b3-053d12a9d73f@gmx.com>
Date:   Thu, 17 Aug 2023 16:06:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: prevent metadata flush from being interrupted
 for del_balance_item()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <dfcb047887dbec9f252835fce458564f991fcd02.1692252334.git.wqu@suse.com>
 <ZN3RRO83qL6UDay2@debian0.Home>
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
In-Reply-To: <ZN3RRO83qL6UDay2@debian0.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IYveqhfta87QtX2TC+Y2rfwk0rUYAkKITHk9iuPX5GXHb2zkZsV
 hsjLeS+pahaMMU7N32pfk3V9cxr/yJB8fyXPwClgivYqtZqPWByeZNZVmfjGLBXbYfsGlMu
 nVJ//OnJsefy6FTVwKtuibT3OGUkaL6aTbbRxBxm5+LenEVV29SR2656xfAR5NVjse0fikD
 TQcuCtn9HhwOD7+QMW3cg==
UI-OutboundReport: notjunk:1;M01:P0:Cq1WbnBfjzw=;acOs9CaqAftD5b8ra1aLvaVgLYU
 RxR9OmggYNb6iqlwuN5EFG3bZVSM7AmNvM9hhvnUx790T2/zERKaJotsIzK6GfFtVMvwMIh6f
 I5STNmN5yC2kDQof67EN9vlRMFIp2+jQPMgDSWeuS9694Ou0uon31Rgv1E6Iq7KbUo8HjsMEr
 rEkC5cE/u8+BdYqcFXmAs+pktAwT27a3ZE/Ze3ejhBNm0XDBJxBJ/YV+mRaUUsIP3WPTrNFG5
 iBm6snnJuKfM1IOl+Vu8pM9SwILYAFRcNHD6LzZpWvRRO/IGspJ4unYkxrera4yhkLF6n3fLm
 hqMpCAg3Kfpx8MgeM9fbVpSlfbHtwRfCCHdUJbS3A6yac2fSXDKU3Yl5tYBBsgeIt1XnWVyhm
 N3dechnlW/1cluSGLl1M9lAFn055bkZLyRmwBD7Hwf9IO4pWuMyBwA1zttp7zkeAVljVaeS/e
 Zu+eXcgYix+SFU0SqTR3stOShEwcn7Fr0nxSBC3dtEqTk+cZou5vhVCv7eYsHUg/sCxsFbw/u
 9Mn6Q4vHAU3uE9oIcLNb4trPiFcPM5ZlpFrnNldE24jL7KwXanQofQ2inK0s3B8ug/GBoIYOA
 lh6rLVqAQJWXqB/aIgapNce5jSk/EduFOy59XXpBIXTNv2CB6eG1SWkQD72CjppLDMnHW7Sj1
 WmSfEi10Sc9kfuwcWuPOrtrXlNv3Z/ItIArv/Kip8+4chXok+J6NLxYeUguJc5JtO6ClUmeFB
 fBwM+80DTppyFtE4zjH6Bc7AvMhUv3hxRDjXY8yZJdfWwcDMqkiaTsdwJcN1JcpVCI8bV7SqU
 A8GTWigwERj7q0r+AbrsULfgrCg5AEFkSO9bGZ3qc04ZITFOd4HNzNYfTN/C/0qKEtZupqgrG
 V7jaOk1Vt/1AVZIzP+XitSLlJ1Xfq/H5qHE2Qk6voE0RUGSXLyv/6EnV8b0naQ9ZJ6vGVYzAV
 sO1Y+QpbMPVcPBIfp4I3J++8X7g=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/17 15:50, Filipe Manana wrote:
> On Thu, Aug 17, 2023 at 02:06:24PM +0800, Qu Wenruo wrote:
>> [BUG]
>>
>> There is an internal bug report that there are only 3 lines of btrfs
>> errors, then btrfs falls read-only:
>>
>>   [358958.022131] BTRFS info (device dm-9): balance: canceled
>>   [358958.022148] BTRFS: error (device dm-9) in __cancel_balance:4014: =
errno=3D-4 unknown
>>   [358958.022150] BTRFS info (device dm-9): forced readonly
>>
>> [CAUSE]
>> The error number -4 is -EINTR, and according to the code line (although
>> backported kernel, the code is still relevant upstream), it's the
>> btrfs_handle_fs_error() call inside reset_balance_state().
>>
>> This can happen when we try to start a transaction which requires
>> metadata flushing.
>>
>> This metadata flushing can be interrupted by signal, thus it can return
>> -EINTR.
>>
>> For our case, the -EINTR is deadly because we are unable to handle the
>> interrupted metadata flushing at this timing, and would immediately mar=
k
>> the fs read-only in the following call chain:
>>
>> reset_balance_state()
>> |- del_balance_item()
>> |  `- btrfs_start_transation_fallback_global_rsv()
>> |     `- start_transaction()
>> |	 `- btrfs_block_rsv_add()
>> |	    `- __reserve_bytes()
>> |	       `- handle_reserve_ticket()
>> |		  `- wait_reserve_ticket()
>> |		     `- prepare_to_wait_event()
>> |			This wait has TASK_KILLABLE, thus can be
>> |			interrupted.
>> |			Thus we return -EINTR.
>> |
>> |- IS_ERR(trans) triggered
>> |- btrfs_handle_fs_error()
>>     The fs is marked read-only.
>>
>> [FIX]
>> For this particular call site, we can not afford just erroring out with
>> -EINTR.
>>
>> Thus here we introduce a new flush type,
>> BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE, for this call site.
>>
>> This new flush type would wait for the ticket using TASK_UNINTERRUPTIBL=
E
>> instead, thus it won't be interrupted by signal.
>>
>> Since we're here, also enhance the error message a little to make it
>> more readable.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Instead retrying, introduce a new flush type
>>    The retrying can lead to dead loop as inside kernel space the signal
>>    won't be cleared until we reach user space.
>>    Thus we may retry forever.
>>
>>    Instead going TASK_UNINTERRUPTIBLE for this particular callsite woul=
d
>>    be a safer bet.
>> ---
>>   fs/btrfs/space-info.c  | 11 +++++++++--
>>   fs/btrfs/space-info.h  |  5 +++++
>>   fs/btrfs/transaction.c |  9 +++++++++
>>   fs/btrfs/transaction.h |  3 +++
>>   fs/btrfs/volumes.c     |  8 ++++++--
>>   5 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index d7e8cd4f140c..6fce57c6f2a1 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -1454,15 +1454,21 @@ static void priority_reclaim_data_space(struct =
btrfs_fs_info *fs_info,
>>
>>   static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
>>   				struct btrfs_space_info *space_info,
>> +				enum btrfs_reserve_flush_enum flush,
>>   				struct reserve_ticket *ticket)
>>
>>   {
>> +	int state;
>>   	DEFINE_WAIT(wait);
>>   	int ret =3D 0;
>>
>> +	if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE)
>> +		state =3D TASK_UNINTERRUPTIBLE;
>> +	else
>> +		state =3D TASK_KILLABLE;
>>   	spin_lock(&space_info->lock);
>>   	while (ticket->bytes > 0 && ticket->error =3D=3D 0) {
>> -		ret =3D prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
>> +		ret =3D prepare_to_wait_event(&ticket->wait, &wait, state);
>>   		if (ret) {
>>   			/*
>>   			 * Delete us from the list. After we unlock the space
>> @@ -1511,7 +1517,8 @@ static int handle_reserve_ticket(struct btrfs_fs_=
info *fs_info,
>>   	case BTRFS_RESERVE_FLUSH_DATA:
>>   	case BTRFS_RESERVE_FLUSH_ALL:
>>   	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
>> -		wait_reserve_ticket(fs_info, space_info, ticket);
>> +	case BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE:
>> +		wait_reserve_ticket(fs_info, space_info, flush, ticket);
>>   		break;
>>   	case BTRFS_RESERVE_FLUSH_LIMIT:
>>   		priority_reclaim_metadata_space(fs_info, space_info, ticket,
>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>> index 0bb9d14e60a8..e9d8243da0fc 100644
>> --- a/fs/btrfs/space-info.h
>> +++ b/fs/btrfs/space-info.h
>> @@ -50,6 +50,11 @@ enum btrfs_reserve_flush_enum {
>>   	 */
>>   	BTRFS_RESERVE_FLUSH_ALL_STEAL,
>>
>> +	/*
>> +	 * The same as BTRFS_RESERVE_FLUSH_ALL_STEAL, but won't be interrupre=
d.
>> +	 */
>> +	BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE,
>> +
>>   	/*
>>   	 * This is for btrfs_use_block_rsv only.  We have exhausted our bloc=
k
>>   	 * rsv and our global block rsv.  This can happen for things like
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index ab09542f2170..6a09e80b6875 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -785,6 +785,15 @@ struct btrfs_trans_handle *btrfs_start_transaction=
_fallback_global_rsv(
>>   				 BTRFS_RESERVE_FLUSH_ALL_STEAL, false);
>>   }
>>
>> +struct btrfs_trans_handle *btrfs_start_transaction_fallback_uninterrup=
tible(
>> +					struct btrfs_root *root,
>> +					unsigned int num_items)
>> +{
>> +	return start_transaction(root, num_items, TRANS_START,
>> +				 BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE,
>> +				 false);
>> +}
>> +
>>   struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *=
root)
>>   {
>>   	return start_transaction(root, 0, TRANS_JOIN, BTRFS_RESERVE_NO_FLUSH=
,
>> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
>> index 8e9fa23bd7fe..06f245e6c546 100644
>> --- a/fs/btrfs/transaction.h
>> +++ b/fs/btrfs/transaction.h
>> @@ -233,6 +233,9 @@ struct btrfs_trans_handle *btrfs_start_transaction(=
struct btrfs_root *root,
>>   struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rs=
v(
>>   					struct btrfs_root *root,
>>   					unsigned int num_items);
>> +struct btrfs_trans_handle *btrfs_start_transaction_fallback_uninterrup=
tible(
>> +					struct btrfs_root *root,
>> +					unsigned int num_items);
>>   struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *=
root);
>>   struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct b=
trfs_root *root);
>>   struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrf=
s_root *root);
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 189da583bb67..389e14fc2c3e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3507,7 +3507,11 @@ static int del_balance_item(struct btrfs_fs_info=
 *fs_info)
>>   	if (!path)
>>   		return -ENOMEM;
>>
>> -	trans =3D btrfs_start_transaction_fallback_global_rsv(root, 0);
>> +	/*
>> +	 * Here we don't want this transaction start to be interrupted, or we
>> +	 * will mark the fs read-only.
>> +	 */
>> +	trans =3D btrfs_start_transaction_fallback_uninterruptible(root, 0);
>
> Ouch, adding a new flush method, a new transaction start API, etc, just =
for this.
>
> So I replied to you on the thread for v1, but before I could reply you w=
ent this
> way anyway:
>
> https://lore.kernel.org/linux-btrfs/CAL3q7H5g1E8ZWqtAA6Ltb+_aWAqOm6iR57o=
jnGCyskZZrFDMuQ@mail.gmail.com/
>
> I'm not convinded the -EINTR comes from btrfs_start_transaction_fallback=
_global_rsv(),
> it should not since it's not doing any space reservation.  Correct me if=
 I missed something.

You're right, please discard this patch.

The problem I described is only possible for older kernels, not for the
upstream kernel after commit 3502a8c0dc1b ("btrfs: allow use of global
block reserve for balance item deletion").

I only need to backport that patch.

Thanks,
Qu
>
> Thanks.
>
>>   	if (IS_ERR(trans)) {
>>   		btrfs_free_path(path);
>>   		return PTR_ERR(trans);
>> @@ -3594,7 +3598,7 @@ static void reset_balance_state(struct btrfs_fs_i=
nfo *fs_info)
>>   	kfree(bctl);
>>   	ret =3D del_balance_item(fs_info);
>>   	if (ret)
>> -		btrfs_handle_fs_error(fs_info, ret, NULL);
>> +		btrfs_handle_fs_error(fs_info, ret, "failed to delete balance item")=
;
>>   }
>>
>>   /*
>> --
>> 2.41.0
>>
