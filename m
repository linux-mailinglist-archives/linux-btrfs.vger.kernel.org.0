Return-Path: <linux-btrfs+bounces-12070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4AA55B4F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 01:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D03A1899558
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEBB27CCE8;
	Thu,  6 Mar 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OteGWjwF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC382080C3
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305586; cv=none; b=JxaMLok8tphvSoODdTk6BLdIHsS6RWV9A8jtk4uNnEmhXJ73kQczNWl6B0lBkfVL9Mfkve8UU1vMkq5OhIQO6ojkBSZ7UK+kW+ZijBzQ7GwPKbMxgHyCfJXNG5BUMpfxULz66gQPHuzk8U4X+SFEeANaxAN7moggPqWkrCFEMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305586; c=relaxed/simple;
	bh=tmlk8tR1h/NOOXzHYp2IQ+F13zBZ5t+8xqiUdor5KTU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MIeBK8ehqSV4Ddw3j7denqXy217I3RQwT6jkib1WH6d6+9PlLpBHHPVr7sI+75u3OSHzd433vGs7eqR4PXGsD7IrgZi/JXGQdXFujlC0J1l53FKoZ0VIy3IfBr/oWiOBwI+KiEyx6IlGscoDgldmEg7MuG7OmMZEPUL2DLfyPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OteGWjwF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741305581; x=1741910381; i=quwenruo.btrfs@gmx.com;
	bh=tmlk8tR1h/NOOXzHYp2IQ+F13zBZ5t+8xqiUdor5KTU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OteGWjwF7M3u0aP5besbpT3r9j+6mF3ykO/xoB44BFGdMhWlY1miGlXIBfaWU2Va
	 fVrDvICgaC+uMXSrx9mv8Wy2ooj1lwBtTK/OWQcw8bPhKMGMJ4clraA7O6Ur2eTOF
	 Cbqgw6lGpZr3idZC7QgeJHounwUpqilBzChEn661CBuylm6Ex43jlsh8TLYPV6G2o
	 za9NpTrcmwQYSPecRjSO6jDlOHIER3R/B6HxsR5N3RjhT8Fnxn+FtATGEbZicjYVn
	 1rddyYIJ0hrVxfZqg0BTiTzsbPSLclV3sVaQKIwKq6c4DnL7eoh/uyfQ0C2uQAubH
	 zxsk9XDMTdvQaJhzkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1tI6Ad3Hcd-00oNAs; Fri, 07
 Mar 2025 00:59:41 +0100
Message-ID: <8f7b34e5-159c-46b7-b895-d4d3ffb8ee09@gmx.com>
Date: Fri, 7 Mar 2025 10:29:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix non-empty delayed iputs list on unmount due to
 async workers
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b07f13dbfadfdb5884b21b97bbf1316c45d06a32.1741272910.git.fdmanana@suse.com>
 <70f71adc-e7f2-4645-bdcd-8f0235c26ad9@gmx.com>
Content-Language: en-US
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
In-Reply-To: <70f71adc-e7f2-4645-bdcd-8f0235c26ad9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2webiWRUTWDbc+ngbC/vi4Q1S1Yg3JEV28S8NCsteVtb4PlrgCZ
 fy9GS3AIToJ6MR4KiJ2d7zGhXwL1DcWONJ7Hg6C/ysytLfaYMfEAey4tmiAUDVtQbi4eOy0
 u/ydTcZac8qZXTSFF4HYVGiR7TXxXH77gj5K41+lpWy+G5UW8olXici9EhvNR3kkc32rGqX
 L1zjQnUwCLZssmHeLhMwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RrpSRVv2BHI=;P9KaUOCgtRz+Yb6ggRg5DEJHZPr
 fibubyIYEzyyVoN8WvE5TAdHfXch2C9iDcdU2YeVqB/lhwHTYBmLkOYQmPo1/E8PwSkSC1yxt
 186XE/s0rzPBz8W0OndG4EDdQcKVp/8xfVh8MJ/9cX86bKL6PfLvsasTvdx6UuAm0Qr3KrEgX
 NoQSgIKOzUC9E1yQBazir28h6DLWe5VLzyPBZEnjX9nEjsq0Xsku8UPdVuUSyLnvnGYWhPytA
 bBn59fhFn8X86VchrZSM7T3mSb5y+j9XM9CjedKK3NuT54h+f/ITRcpl2RT2JKMclkAU6Wzd0
 RqAT6WAP4nbsII+olklzAgiCDQi8JLasy0bgcUTPxcuQ2EiCGIjRlQJvMTJb6h7e7h+o20/Kf
 dW05mEWu7oJWNdixvXlkA0axVVYRShBndiuSt7Q2MIlUpgo2YW4fHMUvg2/zD2MDiawEArPVQ
 3/Ff9icT+SWXpqCMnfLBtrFWOxQMWIBL3eX5jM3qZfr/N+vLatsAbyNSYt9BmlleUhzngIPnl
 0bGg/WNwHnVolT1/TXDR7g5vvLJpe3sigyyup4DPjEptstIs1VeqUYqIPFJCRxoB9yEn1xt9c
 NfTsAyUls+E3u8JsmbskEpQDx6I9vgkBcfPAWmIQ6LP/nWTqMiPfvvWWT1WbsAEC9Sxh5E40L
 Mbu4E9e5Whxk55Hc5mqtf0e1UpTXEUHU9BO+KDqOLkBlSbyQNkUbpy83P6RZ5F6vtD5xeXsKG
 Wu6AnaeR/gr+epMlTmrIqQ364i6Uj7nshryViMEPDe9CU98+WpXqvdisAwWG9TK/8YmVPE02j
 7YAS6zc7zV6gJoHsCf+xFGnN3x7a8XF/WmUEIM6YBGhIJTxN2k+Bz1KO19JBloZO+593/qhri
 BFYv1t78J5d+m1/qzhlahpa5V3TDWpOfSmQm9HW5YacWb+sxM+nlCN/4kWTCYsC+MtmNs/Lmq
 SseJb2HrDja2Fl3JUb7kT1wqANZkBUqixhmQaW4h4k2RFNYZnQ0JyncdCyQsnOpCjsOTmFL2y
 hPdJb21DAQ38Mojl0m9cNpQ1t8ZrvSIoGdYllO7o2eKnxWxqhmo0VjTkGLl0jbkoqIzwSOGos
 C1+L/R/r+BhdaVPxTdIE06QrgRseUaSJ/x1R0OZCIBeIb2lL1plg8LsHPB4A+9GLukJt4FpZM
 ZtVKRImHPQ7sN+A6836zkICbFoq0QGWcHZZylI9HqG8pYFgv+ZapVGWIHjNSV4kXphIXjYmTJ
 Dr7dzR7jDRHyleGOCUVC1/79644kTxzbJbRRFLncMrSVfe0eaDpTxdFqHDUoH1ZvrwS7fl5sC
 OsBuork85vgiapCTRjKLbjXLYI0wC0JapfWOP8Pj7V4C8ASv5s7WQYe0w6QxDdAcF7um63pUb
 NlMydpgWlFZ9cvT/Md9MrYtOvxMQj43QN0cSpIc0+gvW2AbUcZpwYd72/A



=E5=9C=A8 2025/3/7 08:13, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2025/3/7 02:27, fdmanana@kernel.org =E5=86=99=E9=81=93:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> At close_ctree() after we have ran delayed iputs either explicitly
>> through
>> calling btrfs_run_delayed_iputs() or later during the call to
>> btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
>> delayed iputs list is empty.
>>
>> We have (another) race where this assertion might fail because we have
>> queued an async write into the fs_info->workers workqueue. Here's how i=
t
>> happens:
>>
>> 1) We are submitting a data bio for an inode that is not the data
>> =C2=A0=C2=A0=C2=A0 relocation inode, so we call btrfs_wq_submit_bio();
>>
>> 2) btrfs_wq_submit_bio() submits a work for the fs_info->workers queue
>> =C2=A0=C2=A0=C2=A0 that will run run_one_async_done();
>>
>> 3) We enter close_ctree(), flush several work queues except
>> =C2=A0=C2=A0=C2=A0 fs_info->workers, explicitly run delayed iputs with =
a call to
>> =C2=A0=C2=A0=C2=A0 btrfs_run_delayed_iputs() and then again shortly aft=
er by calling
>> =C2=A0=C2=A0=C2=A0 btrfs_commit_super() or btrfs_error_commit_super(), =
which also run
>> =C2=A0=C2=A0=C2=A0 delayed iputs;
>>
>> 4) run_one_async_done() is executed in the work queue, and because ther=
e
>> =C2=A0=C2=A0=C2=A0 was an IO error (bio->bi_status is not 0) it calls
>> btrfs_bio_end_io(),
>> =C2=A0=C2=A0=C2=A0 which drops the final reference on the associated or=
dered extent by
>> =C2=A0=C2=A0=C2=A0 calling btrfs_put_ordered_extent() - and that adds a=
 delayed iput for
>> =C2=A0=C2=A0=C2=A0 the inode;
>>
>> 5) At close_ctree() we find that after stopping the cleaner and
>> =C2=A0=C2=A0=C2=A0 transaction kthreads the delayed iputs list is not e=
mpty, failing the
>> =C2=A0=C2=A0=C2=A0 following assertion:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(list_empty(&fs_info->delaye=
d_iputs));
>>
>> Fix this by flushing the fs_info->workers workqueue before running
>> delayed
>> iputs at close_ctree().
>>
>> David reported this when running generic/648, which exercises IO error
>> paths by using the DM error table.
>>
>> Reported-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

But unfortunately, I still hit the same ASSERT() on generic/475.

It looks like I'm a little too lucky on this test case?

Thanks,
Qu
>
> Thanks,
> Qu
>> ---
>> =C2=A0 fs/btrfs/disk-io.c | 13 +++++++++++++
>> =C2=A0 1 file changed, 13 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index b0f125d8efa0..984145147716 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4340,6 +4340,19 @@ void __cold close_ctree(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_flush_workqueue(fs_info->delalloc_=
workers);
>>
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We can have ordered extents getting their l=
ast reference
>> dropped from
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the fs_info->workers queue because for asyn=
c writes for data
>> bios we
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * queue a work for that queue, at btrfs_wq_su=
bmit_bio(), that runs
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * run_one_async_done() which calls btrfs_bio_=
end_io() in case
>> the bio
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * has an error, and that later function can d=
o the final
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * btrfs_put_ordered_extent() on the ordered e=
xtent attached to
>> the bio,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * which adds a delayed iput for the inode. So=
 we must flush the
>> queue
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * so that we don't have delayed iputs after c=
ommitting the current
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * transaction below and stopping the cleaner =
and transaction
>> kthreads.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 btrfs_flush_workqueue(fs_info->workers);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When finishing a compressed writ=
e bio we schedule a work
>> queue item
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to finish an ordered extent -
>> btrfs_finish_compressed_write_work()
>
>


