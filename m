Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDE1F1389
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgFHHW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 03:22:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:43613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgFHHWz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 03:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591600965;
        bh=7VJDwygZOrIbZgthHyQupSLOE0eivY1QBelna6aCrAY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UgYvbtq/o0YLsIZ/Qr8Rp3pPW5pE9VoMQn9cW8PHWx9WvKVBGoNAbrvSnOatL+qtR
         KA3WVObf71fBfy9qyDzf+pnbr4ueeWcz+IYVxhxK58Rs1ul4AflYfznusVwQJS0FWf
         sf+QC+7JJ+Mpj29FhstLUU5szJG02k7twpQ3uAvw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1poA-1jg0GD0jou-002Hao; Mon, 08
 Jun 2020 09:22:45 +0200
Subject: Re: [PATCH 2/2] btrfs: qgroup: catch reserved space leakage at
 unmount time
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-3-wqu@suse.com>
 <b460820d-f326-8876-7f3b-b9842d245de3@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <d0815ea3-0ccb-dbd3-203f-5f47e08b1a8d@gmx.com>
Date:   Mon, 8 Jun 2020 15:22:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <b460820d-f326-8876-7f3b-b9842d245de3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:utw8/oSZLxZknLlJwfkq6m+/etuXyn15S8xTLcg/vekkRmGJzgd
 Fopfbsc1jL++vXjAWrQe37piUDIkYCxN32Wo5ku78FytpkiqosTnSgeO+bwj/w4RLDPqA/M
 OQ7EBGtBbPC0afzuMFiUoXUN8SGfJO8vKs+wR4QwYODVZzouFa8yf6eW6q/DdNDVi5E1l7z
 iQrwxC+3wUHg+GSutNctw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q3k4aoWVI3E=:MB4pSSsaW47lWbKrsr1eT0
 BQGKWv5LHygQZiJ69gGz2OXkoVQqMvG5vhYi1X1hxvstEUcWLdAY6oXa040csmjqLHPckU0uZ
 5k/AHdPnAlP6IxvQ+WrRTwEFajMC9kN2r9ov31z65hny6ZUsXxkjB6RJyLo0NYmgnZhFXQGc7
 mR2gp+ukGsd9CDFrKYolPaWluMhALWxHeiQ+RSSP+gCRy2zjMTvju+3y8h5jideRs7v2XVitt
 7Ainf5leFKF58RmbvQD3fOI0PFCyTECoNkx1jZ6onvAgZRQhPqj+CdjKadmgQ8dz31JYcP1NL
 WbLIa6FsNQW+fVCKfOoSl2iyIciwmPWlHBOKS7qiJN5zDVSAEGP2YlYQnf7Z2J+FxnuNaCvkn
 Aors6rl7PJp5QIj1kalLYo3+Q9P5wXYq9GRYxmPIPFSgD+AdfC4ZHA8zCTmihAURIY58eoWqT
 unmdeu5hFPHb9Gjb5GKlRhRWtJcQ7e7eTLGIdKlKC5VY1mxusvyZRlzQQXH8iTI6rvvRWLObL
 k63xw9gdA/XlCjtKHVDUgi8hzKb46t/muKDu8Iv78krqyT1CRkqfnFW1Qz6I/bMchbNcMLEYx
 KNhsFNmauul55d3zsysa5xlv7PZDtiwiSGxVG3fO3idUXNjEecxqf1V6z0ag1yMQiOtwBQgYg
 q5AFSuJ6DwLBwbD5KbO6OVFP5G1y0DbqVJmJHx13+TVdwTTm4Ov59YfFj4PAiyvMnLmdD6jbz
 ST6vPKHMxxCVPCHzOvHlL+lvtRcyci6+UczhvbWwqcmuM/XUUXuekGBbVkWj1GhdusAJ4frN6
 avTmnPQj514kdRaRn9EduPsStyx0mYxQNDudsKCUaoJRxUa5C6YrSzoEduSCZCicWe+UPREZ9
 KzVjhtRi9XPfSa45Ofk7OywQEQeIk7OltxIYhZKHfuYixAnOdeHW+/NVpxbAqnu8qXNVmJ2xG
 zgaIxU8KLdqya2nWnTBenmXnxqvB9iobGm2EuEihLE6vfeLLxyRdt4g09FmTTf6mWrzbJl9OV
 bZLo8Lsk4RN1M4z+C52FUVVufXtquzPvRWHRIRU6j5pjrIMZQUZdBVOgTWOwDz8CPvGXs2arX
 DIOET+zBPykOTyM6pGvav/aCtM5dBBfikIBRtrlO4EyMGmoKgU+QFwV1z+SR1QkwjESrQB/05
 ITgkTcqOpQtHH+ILBjjefKbjAjalyz1iNN3VN6FFRco/BTZbcL6AksSo+ggUe9NQPUqUT3+d4
 M88UxD1TdgCo7L2Y1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/8 =E4=B8=8B=E5=8D=882:58, Nikolay Borisov wrote:
>
>
> On 7.06.20 =D0=B3. 10:25 =D1=87., Qu Wenruo wrote:
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/disk-io.c |  6 ++++++
>>  fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/qgroup.h  |  2 +-
>>  3 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index f8ec2d8606fd..48d047e64461 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4058,6 +4058,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs=
_info)
>>  	ASSERT(list_empty(&fs_info->delayed_iputs));
>>  	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
>>
>> +	if (btrfs_qgroup_has_leak(fs_info)) {
>> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
>> +		     KERN_ERR "BTRFS: qgroup reserved space leaked\n");
>> +		btrfs_err(fs_info, "qgroup reserved space leaked\n");
> I don't think the message from the WARN() brings any value, it's simply
> duplicated by the btrfs_err. IMO it's more concise to do:
>
> WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> btrfs_err(qgroup reserved space leaked);
>
> without losing any information whatsoever.

Makes sense, also another cleanup item for existing similar cases.

>
>> +	}
>
> Is it safe calling this code here? workqueues are being destroyed after
> it in btrfs_stop_all_workers so it's possible that they have some
> lingering work which in turn might cause false positive in this check ?

The safety here is as safe as other calls in close_ctree(), we expect no
new trans started nor existing running trans (finish ordered io call),
and no dirty pages (invalidate/release page call)

So at this timing there should be nothing to modify qgroup and we're safe.
Or did I miss something for the close_ctree() context?

>> +
>>  	btrfs_free_qgroup_config(fs_info);
>>  	ASSERT(list_empty(&fs_info->delalloc_roots));
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 5bd4089ad0e1..3fccf2ffdcf1 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -505,6 +505,49 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info =
*fs_info)
>>  	return ret < 0 ? ret : 0;
>>  }
>>
>> +static u64 btrfs_qgroup_subvolid(u64 qgroupid)
>> +{
>> +	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
>> +}
>> +/*
>> + * Get called for close_ctree() when quota is still enabled.
>> + * This verifies we don't leak some reserved space.
>> + *
>> + * Return false if no reserved space is left.
>> + * Return true if some reserved space is leaked.
>> + */
>> +bool btrfs_qgroup_has_leak(struct btrfs_fs_info *fs_info)
>> +{
>> +	struct btrfs_qgroup *qgroup;
>
> nit:This variable is used only in the loop below just define it there to
> reduce its scope.

Sure.

Thanks,
Qu

>
>> +	struct rb_node *node;
>> +	bool ret =3D false;
>> +
>> +	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
>> +		return ret;
>> +	/*
>> +	 * Since we're unmounting, there is no race and no need to grab
>> +	 * qgroup lock.
>> +	 * And here we don't go post order to provide a more user friendly
>> +	 * sorted result.
>> +	 */
>> +	for (node =3D rb_first(&fs_info->qgroup_tree); node; node =3D rb_next=
(node)) {
>> +		int i;
>> +
>> +		qgroup =3D rb_entry(node, struct btrfs_qgroup, node);
>> +		for (i =3D 0; i < BTRFS_QGROUP_RSV_LAST; i++) {
>> +			if (qgroup->rsv.values[i]) {
>> +				ret =3D true;
>> +				btrfs_warn(fs_info,
>> +		"qgroup %llu/%llu has unreleased space, type=3D%d rsv=3D%llu",
>> +				   btrfs_qgroup_level(qgroup->qgroupid),
>> +				   btrfs_qgroup_subvolid(qgroup->qgroupid),
>> +				   i, qgroup->rsv.values[i]);
>> +			}
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>>  /*
>>   * This is called from close_ctree() or open_ctree() or btrfs_quota_di=
sable(),
>>   * first two are in single-threaded paths.And for the third one, we ha=
ve set
>> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
>> index 1bc654459469..e3e9f9df8320 100644
>> --- a/fs/btrfs/qgroup.h
>> +++ b/fs/btrfs/qgroup.h
>> @@ -415,5 +415,5 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_tr=
ans_handle *trans,
>>  int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *tr=
ans,
>>  		struct btrfs_root *root, struct extent_buffer *eb);
>>  void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *tra=
ns);
>> -
>> +bool btrfs_qgroup_has_leak(struct btrfs_fs_info *fs_info);
>>  #endif
>>
