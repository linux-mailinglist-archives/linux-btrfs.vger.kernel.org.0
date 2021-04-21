Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F5366A0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhDULmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 07:42:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:33619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236593AbhDULmu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 07:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619005332;
        bh=CGYPsWRYgqYV4SWn9Cf2vERVh2ZuFHrp9Br52Qrrwng=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Z4KxYn6kiU+NO5fV0xi7w8iS/PGPexeIc8vbF6yRMYm8APqTDgBi6M+ydlSBgk5FH
         QoMSvNrKlntbCuIrzJCxyzHwuoI+b60EAZr22T2Tbk/KKdr7uYIfyHdOBiWYfS2EgB
         LCUjjiM0EKsO6bgGie/FQ24DqoIzJJc/bxa01HAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1lVJPm29ej-014Wdt; Wed, 21
 Apr 2021 13:42:12 +0200
To:     riteshh <riteshh@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
 <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
 <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
 <20210421070331.r4enns6ticwpan35@riteshh-domain>
 <20210421073020.fwu7a5t4ihl7gzao@riteshh-domain>
 <ca952f24-d0cd-fda7-c9c5-85eba3e7d04a@suse.com>
 <20210421111310.q2g2fhzhlcoaykff@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <639219d8-26cd-1b8d-ce80-0fffd547e61a@gmx.com>
Date:   Wed, 21 Apr 2021 19:42:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421111310.q2g2fhzhlcoaykff@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iuz1+0X3McbeYyrxhuqiV+wOZvNAG42zIXFLyObcIFenKrkgz37
 PgJcoS+MivI6PwOZg54odJaJS6o+FiL8hD9A8a1NxgiNf2m/4RzD99bK3h+Ja4rCr6AYltj
 wipe+RA+JesIHkE0cjwWOX9dcW9VQXyUWL7J0iMAbgeHhKm6JgxwuXcolvcjlDh93U8JZXu
 ocFuEkot8tk6CYzRjfTvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DHctmOAhyys=:WtSG2ZyK4fq/5BYU4CMiw4
 N2M9PxWHsnkDvC16r+bgxdYylWWpaXcgd0d721iwvwKtreAnzRuX/0f9cS1vo0JYU2sELDF49
 BxImdRmcPy3sSQJ9NoQz0GYQGBZFXzjvnFqMwHtF0Yfh246z8ROLUvg1Ams+IjMVgOi33BaVM
 CFJHYb8Osss4Hk4rgNh/4bKn9GETlC+NMDf8TIqG86n9kqM8mYamz33cIfmETBoiFFHaEmKCf
 tAVPldk3WskS6CUnmKmng1InnFV2WQ63Xpl0m7TvW/4k1Rpq6kQ9G51annw+U5yrTDnn84Z/u
 syuKLjsQfXGd7b4HdZhuK/8hpG1tqW7T8wHhpFUi5HmeSdIraY6eCxV4bJTMkWMWTJ30IZlkJ
 2/o5XPqrHsShaaNeXc3cC7Ozp+Yn6qfaV5X2Q8hXXv1TX8TPRLEsLsA1kJrmpFg04DcQJhui7
 SVILHHlpoa4rjKQucaM2/TUTlma01RN7gyfOmLQx2ov9ik5hzej9CMcVSDGz4UpK5uahv2dS4
 c3E29UCJJSGYByd4Gbc557Vi9UYrH/zhCIeVfZhKFeLP+1VTDB0ncT1sElJMbsh7GZbK3gSG4
 bQdBS1ii+m8u2nWNnX4chS4HVVMsCrHH/5Ub3irbh7xKYDwPhMuNM33eHJtCGBuNqtEbMr6R6
 0+WSUMvdQMLQ3SM5fhcgWsSkuM9IWMStO3OHgaGkoACTlO0MYITfpLGgmOOm6GGeAOGbf8VCH
 Ih7Cm09jf/qujvfqR12EvjL6RGgRSQlzKJhaEuxzBlknkAoHadBWDNwOEu1+/TOHtKWWElPO4
 Nte/6PpTNORJ8ukmW4m+W4SrGHMJf/jbZDku7Hc0lKdaeCpwfw21wv2TpKs9Q4q68OHesCH5/
 seiu3x/JwhVdl9zXnVmyADEAzX2Nspv2+A/uS7BiYKu1M1kPlfjYN1H7J82CU7ZcVmMgUXwyf
 gZhm0OhSKvU/Y76NuIIJL0YkxqTn47BTlHOrMCDRxNaMY9utTl0rKWuN+8v+3SkQcfgU+aPFi
 tvSr5wdwSFCHjyQH9wodEP85LohTwQvCqJJ3XvSpT+K87JzP6IEriD9RkdRy4HVLEQ+3bv4Vv
 NyJKRoQIrH6MdNrKJt2glv2GI8Y4OM9PV8CMbnotdksltoS6UqU6jE2I8Cc9EWu0fkAfr/G2h
 JbYWLXPmgr6vEH4T78o5l/IQxO64o3D9WXtvGg0rDsD9Srj3zD3RUtBi52E3pC0U2w1SKcItJ
 L8Myb+EMejWeBPZF0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/21 =E4=B8=8B=E5=8D=887:13, riteshh wrote:
> On 21/04/21 04:26PM, Qu Wenruo wrote:
>>
>>
>> On 2021/4/21 =E4=B8=8B=E5=8D=883:30, riteshh wrote:
>>> On 21/04/21 12:33PM, riteshh wrote:
>>>> On 21/04/19 09:24PM, Qu Wenruo wrote:
>>>>> [...]
>>>>>>>
>>>>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>>>>> index 45ec3f5ef839..49f78d643392 100644
>>>>>>> --- a/fs/btrfs/file.c
>>>>>>> +++ b/fs/btrfs/file.c
>>>>>>> @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct ino=
de
>>>>>>> *inode,
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unlock_page(page);
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EIO;
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping) {
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Since btrfs_readpage() will get the page unl=
ocked, we
>>>>>>> have
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a window where fadvice() can try to release =
the page.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here we check both inode mapping and PagePri=
vate() to
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * make sure the page is not released.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The priavte flag check is essential for subp=
age as we
>>>>>>> need
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to store extra bitmap using page->private.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping ||
>>>>>>> PagePrivate(page)) {
>>>>>>    =C2=A0^ Obviously it should be !PagePrivate(page).
>>>>>
>>>>> Hi Ritesh,
>>>>>
>>>>> Mind to have another try on generic/095?
>>>>>
>>>>> This time the branch is updated with the following commit at top:
>>>>>
>>>>> commit d700b16dced6f2e2b47e1ca5588a92216ce84dfb (HEAD -> subpage,
>>>>> github/subpage)
>>>>> Author: Qu Wenruo <wqu@suse.com>
>>>>> Date:   Mon Apr 19 13:41:31 2021 +0800
>>>>>
>>>>>       btrfs: fix a crash caused by race between prepare_pages() and
>>>>>       btrfs_releasepage()
>>>>>
>>>>> The fix uses the PagePrivate() check to avoid the problem, and passe=
s
>>>>> several generic/auto loops without any sign of crash.
>>>>>
>>>>> But considering I always have difficult in reproducing the bug with =
previous
>>>>> improper fix, your verification would be very helpful.
>>>>>
>>>>
>>>> Hi Qu,
>>>>
>>>> Thanks for the patch. I did try above patch but even with this I coul=
d still
>>>> reproduce the issue.
>>>>
>>>> 1. I think the original problem could be due to below logs.
>>>> 	[   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
>>>> 	<...>
>>>> 	[   83.634710] Page cache invalidation failure on direct I/O.  Possi=
ble data corruption due to collision with buffered I/O!
>>>>
>>>> Meaning, there might be a race here between DIO and buffered IO.
>>>> So from DIO path we call invalidate_inode_pages2_range(). Somehow thi=
s maybe
>>>> causing call of btrfs_releasepage().
>>>>
>>>> Now from code, invalidate_inode_pages2_range() can be called from bot=
h
>>>> __iomap_dio_rw() and from iomap_dio_complete(). So it is not clear as=
 to from
>>>> where this might be triggering this bug.
>>>
>>> I think I got one of the problem.
>>> 1. we use page->private pointer as btrfs_subpage struct which also hap=
pens to
>>>      hold spinlock within it.
>>>
>>>      Now in btrfs_subpage_clear_writeback()
>>>      -> we take this spinlock  spin_lock_irqsave(&subpage->lock, flags=
);
>>>      -> we call end_page_writeback(page);
>>>      		  -> this may end up waking up invalidate_inode_pages2_range()
>>> 		  which is waiting for writeback to complete.
>>> 			  -> this then may also call btrfs_releasepage() on the
>>> 			  same page and also free the subpage structure.
>>
>> This indeeds looks like a problem.
>>
>> This really means we need to have such a small race window below:
>> (btrfs_invalidatepage() doesn't seem to be possible to race considering
>>   how much work needed to be done in that function)
>>
>> 	Thread 1		|		Thread 2
>> --------------------------------+------------------------------------
>>   end_bio_extent_writepage()	| btrfs_releasepage()
>>   |- spin_lock_irqsave()		| |
>>   |- end_page_writeback()	| |
>>   |				| |- if (PageWriteback() ||...)
>>   |				| |- clear_page_extent_mapped()
>>   |- spin_unlock_irqrestore().
>>
>> It looks like my arm boards are not fast enough to trigger the race.
>>
>> Although it can be fixed by doing the same thing as dirty bit, by check=
ing
>> the bitmap first and then call end_page_writeback() with spinlock unloc=
ked.
>>
>> Would you please try the following fix? (based on the latest branch, wh=
ich
>> already has the previous fixes included).
>>
>> I'm also running the tests on all my arm boards to make sure it doesn't
>> cause extra problem, so far so good, but my board is far from fast, thu=
s not
>> yet 100% tested.
>>
>> Thanks,
>> Qu
>>
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index 696485ab68a2..c5abf9745c10 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const struct
>> btrfs_fs_info *fs_info,
>>   {
>>          struct btrfs_subpage *subpage =3D (struct btrfs_subpage
>> *)page->private;
>>          u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, le=
n);
>> +       bool finished =3D false;
>>          unsigned long flags;
>>
>>          spin_lock_irqsave(&subpage->lock, flags);
>>          subpage->writeback_bitmap &=3D ~tmp;
>>          if (subpage->writeback_bitmap =3D=3D 0)
>> -               end_page_writeback(page);
>> +               finished =3D true;
>>          spin_unlock_irqrestore(&subpage->lock, flags);
>> +       if (finished)
>> +               end_page_writeback(page);
>>   }
>>
>>   void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
>
> Thanks for this patch. I have re-tested generic/095 with 100 iterations =
and -g
> quick (with both of your patches). I don't see this issue anymore.
> So with the two patches (including above one) the race with
> btrfs_releasepage() is now fixed.
>
>
> For both of these patches, please feel free to add:
>
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks for the test.

I really feel a little envy for your fast Power system.
As my ARM board hasn't even finished one generic/auto run...

Thanks,
Qu

>
> -ritesh
>
