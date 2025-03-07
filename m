Return-Path: <linux-btrfs+bounces-12103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30135A57398
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 22:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DF216D357
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925162580C3;
	Fri,  7 Mar 2025 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k0WwbBBZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439081519A3
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382859; cv=none; b=M5BXxB8c9hoFngTckRRsa3UzeqS4Z4r8c2ChejTSBy9sYXR+Uu/2nfPV8KlWt70fi43N6eXVHbd+/0o2OlsHZr1V8CW+NL09QWBYYK0Q6Fm8+uNSJZxcyTvQXD9exNTJ2oLVAkkuBgXyQI3fMqabb6YBpx8l+sEzhTWqAtUduSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382859; c=relaxed/simple;
	bh=gtLvTo1hAuc4zIidhwwojQUQ2+AaAOgYtg08xAvavXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtTMDZI/3MMt6Vvwr+Bc1aUioYWuE+Bh8gaOqlrmE/ujps3/uFNGP4rfrX+3uwRH9EEZO7SiuHT/v7mgPdJx7wHXqYqnMMwtfhbKtX9L7Tz4J+zNQNzDeHmjDUlx60NUFyiY7GKhO+y9+pgK6RetLmCLfJjh+p7ognlmCrM/NDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k0WwbBBZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741382855; x=1741987655; i=quwenruo.btrfs@gmx.com;
	bh=O2TWvktxMYGc03qHtNEYj/XiyTrjEtceC9FZxV36Mro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k0WwbBBZINFXeDpklgfBuXpVFwXg+xK65Z/rhXeXr5t2WW4biLYkJJoeB8B9MqN/
	 ojWK4RVYOEUZIT/3wmn8XLhkwpUP2RpHMc34MQs7TAjK0JDGpl84ZbfbT9iGCwP3z
	 c5/lhZBzF15m2QwjeoPapK/3+oW5JNRiNaZc9r2fChnL3WGQ9sjSRUOHswYvSzwzv
	 y73ntGJbwfN1uyARWP+BGkhanIopKj1snJpjxjNPpIQazeeOAuTr7rKQXIgK2Tb9w
	 t8eLgVXQqpjB52Gw3c4T37/HXGYreQwZENz/3ekAlsvQWdzd0iiBdAbWkso1rVQ5D
	 7inZBRZtbYMhi1MVHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9o21-1tvu1g1Ri9-008XXX; Fri, 07
 Mar 2025 22:27:35 +0100
Message-ID: <21fef21c-f843-4dde-bdbb-e8c3633222e1@gmx.com>
Date: Sat, 8 Mar 2025 07:57:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: add extra warning if delayed iput is added
 when it's not allowed
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1741321288.git.wqu@suse.com>
 <b74cc16979970a14aae45eba0c8ac792389ed473.1741321288.git.wqu@suse.com>
 <CAL3q7H4OA=CPBw9ft+3F8onjuHafaAqJRQx7gXpSjLQ88eBHBw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAL3q7H4OA=CPBw9ft+3F8onjuHafaAqJRQx7gXpSjLQ88eBHBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZXUDI49IHjQeYJZ0uTFSoxsa3uMK6yLHimC+pUEaLweqwNERtoY
 opnh9UJM1JMFGEDR6pxXgx3Q3HPsVnrIaJ/ZJ81ZZ4LL/PpYNZdqNNgd+ohQYEfcYW1yxpt
 Aqk8tc4lYS4Hc9Sx/sO//IbBwBR1UCsqtuXD1FLwawsnGClBMFsXdaf1Jbp6OVieN41OOub
 eqd6YbId5EixPUsTft7ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZOvXWNHr1y0=;anLRhJBnjGke6duBog4TrDhV2+/
 eckcq+BSlMmyYbV0c96ooXwOBvMl32LFrsM31s/mi7/sTkD2iaADE/TEIXw27JwHtKCOmlK0I
 3pkSlLH/nFNB6VK5sproGVQyA9g66HtHiYr6WIjL/KylBhZXqr+xAfviDd4az7DXvNWyRkunM
 o7EFHZZrwqdbB9U6XfAYl3KsMZ/XR0X+DXsw1NKBG73RNtlxDfdDfiK37lmsZe9ylgXLEgoNe
 e931/fYKo5GFRh87lYqnf6b44fIWuNIQLM8r/YgL2OgLBCoqyQXjNVw6IOG5NuTRTUHxQoMmk
 xhn4aKwqEZPQQkKTYAWr1zpnpNgDE/Z8pLjO66cuqpIMHYMqhldY6O0ngpTRb1C65IXTyW1X6
 A2x6GdnUFBGY0GeOYa0YN1rGAK4gchMP8TTUop1cRCWyuL0FFU6ZPGPKyUxT1wOVNufN8+rUq
 aQ6ETgkU/5IY3d2flRtYV35U7acHDSmPLOhHXufQJ5Awv30OCMW7bwQMmwNPoFO8/xrPDiwPN
 npPp15q7STYRhfIFGu9kvjzaLrmT6AB6mDNY97Lqf6tVC4I04NasAzcStec5FRxrbatMRGXjt
 xhjx7iloWGaFnf4x4kRpblq1s6Q2GCjI45DGrc9sxOuWzSMbgYJqgUE+j/hSlybFd9y4D7sIm
 Pbm6pGCgS2zH5ZcYwfIYDFzoT/5bEb8dOWL0/JECd8JB9j2KrivTloPO8JzN4rX1mIRVUs0ba
 SuFfHFqJ+SG7CqK69yZWcH2u75y6LXPJeqPJwHQCyC2hzaOhDTZYoKbRpb4E1+THB+9Muascb
 dUBb9KhtA1Q8c5RqttrqC7IL+OMwjF718YTkNr3dYOCMY0s1cLEMGkCRNM5hudhxlZe+D474v
 mdRsoSbVREyQ8e+pm8NI1/4ogJBh/IYZbsG8/c0C7wHaoTRbX5St8W4aa4kFq0rW0aOCINZNh
 fm0KRm2FS+P7DxjclKZdydcXmn6nawmItLwTmzmll63KWufHILE1WdnFZXbiLqpzm+dxEcb2v
 gtD6yb7kaF76czr1mVj9FAm7f9GcgXkc//m+45v28Nl8CRvQYLpXL0QjPTH+SAXFiRsolQXDB
 ehPW45vNOhbR3P7ZMB8p92L/2f5sStq6FZt5o3YwrhrQoD9jSYXugNElBn1hFNGoQ29MLEAsQ
 Ayp16shMdegGT56laQOIh6CLVYl/Ze8MIOoepGYzBWFPKi0EO2IVOWV3PxIRo4LS6uWLNIfMb
 oZAlCyZY1iEXwaq9l8AonS+Xag8lS8TFBQ/77fMnalZEMPv7bLDNxQqemhnraCWko1LK/Zw8U
 /j2Z+bLQNyABNfo5ry3cpwDiAtFth1Z0sHrWaSFCpoxeONfGsRQST0gEOWBWdHZpq1QH4fx1g
 0hCftGlU+X1Bo3hzkwiIACJLDcy7icqDn2w6SvbvGfb9HmBVmclHcQKYx2



=E5=9C=A8 2025/3/7 22:15, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Mar 7, 2025 at 4:27=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Since I have triggered the ASSERT() on the delayed iput too many times,
>> now is the time to add some extra debug warnings for delayed iput.
>>
>> After all btrfs_commit_super() calls, we should no longer allow any new
>> delayed iput being added.
>>
>> So introduce a new BTRFS_FS_STATE_NO_DELAYED_IPUT for debug builds, set
>> after above mentioned timing.
>> And all btrfs_add_delayed_iput() will check that flag and give a
>> WARN_ON_ONCE().
>>
>> I really hope this warning will never be triggered.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 3 +++
>>   fs/btrfs/fs.h      | 4 ++++
>>   fs/btrfs/inode.c   | 4 ++++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 320136a59db2..bb20c015b779 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4417,6 +4417,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>>                  if (ret)
>>                          btrfs_err(fs_info, "commit super ret %d", ret)=
;
>>          }
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +       set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
>> +#endif
>
> We'll want this earlier, right after we call
> btrfs_run_delayed_iputs(), so that we don't miss the case where for
> example we are forgetting to flush some queue and then the delayed
> iput is added after running iputs and before calling
> btfs_commit_super(), or right after calling btrfs_commit_super() and
> before setting the bit.

I guess this means the call of btrfs_run_delayed_iputs() inside
btrfs_commit_super() should also be removed in this case?

Thanks,
Qu

>
>>
>>          kthread_stop(fs_info->transaction_kthread);
>>          kthread_stop(fs_info->cleaner_kthread);
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index b8c2e59ffc43..ee298dd0f568 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -117,6 +117,10 @@ enum {
>>          /* Indicates there was an error cleaning up a log tree. */
>>          BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
>>
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +       /* No more delayed iput can be queued. */
>> +       BTRFS_FS_STATE_NO_DELAYED_IPUT,
>> +#endif
>>          BTRFS_FS_STATE_COUNT
>>   };
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 8ac4858b70e7..d2bf81c08f13 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -3435,6 +3435,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *=
inode)
>>          if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
>>                  return;
>>
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +       WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info-=
>fs_state));
>> +#endif
>> +
>
> I would get rid of the #ifdef CONFIG_BTRFS_DEBUG everywhere. It's very
> cheap code, negligible.
>
> Thanks.
>
>
>
>>          atomic_inc(&fs_info->nr_delayed_iputs);
>>          /*
>>           * Need to be irq safe here because we can be called from eith=
er an irq
>> --
>> 2.48.1
>>
>


