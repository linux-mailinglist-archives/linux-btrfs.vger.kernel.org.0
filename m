Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B583EE80D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhHQILX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 04:11:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:40919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234684AbhHQILW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 04:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629187846;
        bh=Zu7WcWDxQE2tSX6HHDDQC0TpiMotmCfXmPqxTt4FUTo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fmUTlzIPFIMyTfFphb+VlCfxcm+9sR/1DmT16+m33M3KDkRgLZ0SzEqbfdMPbqMcr
         M3VKIUOJMBFN4hdGX1bobPYEe4VOl4tCYQ1QHcLWQyMFMLEfnPxYN1FAtPxhS9Iz5T
         pg3KeNt8Fcxeucv4J3sw4LGkdT9BrrMd9A7StNnI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFbW0-1mIcga0bNO-00H4Fg; Tue, 17
 Aug 2021 10:10:46 +0200
Subject: Re: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816235540.9475-1-wqu@suse.com>
 <8babcc1b-2456-8632-7b56-f9867d333a0d@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ac42cd2a-82dd-1987-4e18-e9d27e127172@gmx.com>
Date:   Tue, 17 Aug 2021 16:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8babcc1b-2456-8632-7b56-f9867d333a0d@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:915xZR9UEnq0FDrIimYGOnWDhJTmbQrWBj9Z/paRDlA0EqytOj+
 7xv/O8+01CCsHhqc3dFcYQPO5FjNWWgu1wxB3mfxwSYCbnoJ9gUP3vznKT1mL/rViDUoMks
 /TwGlDl32Qm0pfM8FNb6FsaotuysTPqwSJ9BdYUVfPj9dg0/dlm2Z8se3jEZPAf2+l41xU6
 amGMI2O1/jIcRITVsgWRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oSm5mVqCzxs=:g15uXd/k2jLjCsD5thBHxO
 9ANzHLdYg0bwkcP4PSi5vkQ4s0S1Pwo0imPwA11AkuMFlBl/QDRRjXVSRA1ir9+YxBpsvatbJ
 XsNBNyYBoaDQEvDgaASzLWRrSbsWMzanedniWd43YgbpU1GbljECf5wrFCBtnp6JYs/00cJTt
 cG3Hyrlk7gDcHhrniT7dwnmh3hvkwrOyzJC8zAlHbQNwSYQLedJ9a5bt24SQaNfwn46Bxp8AC
 gKGiCVbDsQrmLJVu20Jowne4RWdOPI/9xWeS6i0lcdSCk7Bme/iBDK98fD6yo/V8Cp2YfAaPb
 7VWJBVShp9efw6zNtz46zY9WcdHcCfd3DVobFa79AfKp6MuNST2f9vroMBeTh50MkAzmX0m8l
 hKTJd2ZxmHWNyfZwHjw8ezQlwzd0B3Zz9q9gEuQiVDoh+ZCFmhzEtdMKLVBlOMsHYh1yIpxqM
 CUiSptWIf80UGrw0SSUtOEhcqoIXDH7WnTmbHKTI/SKDLbB3be65o84gvmcfmdV4ZcLnUheIQ
 2N8Ab/YQndREPV7WB0CAWD/l5yX78SqY2HKbxVBkRi47uEu7pnLUuCWl2SFq7hwCS7BnDOO1e
 j87LhLURWu5opPVbGWInw0Ho3yShebZMy6h7v5KOXUSSFVKikWcuDFs4HMmlbgSUcEiWNYeq6
 4brD1quZLW46Ub4euTcEKsYeWqYj0nTdnWbI8d8sm0NWUhArzq0TmsO69Cb0AptwGGcQOzc9g
 UxRhRhxMPp5fFKBJDBS4mweci6gTGVlUcIMT79fsOQ9dKdyztDrsfe1bv8hBVS0LnP0fEJ+H0
 GfPzZjVzKYtsohcqHUcVIjMwT7DYSKAEYEkEFm2zhrsuDNQ22YV+5CDB3uJwU9mG2ZXjXkqGj
 LshBbtf7c+BLd+xOeGmpYS5Eo/cDu1JeoErAEcPj8X1hZdou3+ZIMkR0FeiMSfVDmVN3RnFGT
 O5LCTN4ISrBpqY0ACdk3c1brQ6HgH0JD9EXUib2NvW8z53I0923bUybxMyNx6j9Trizun4VVF
 NYEvfqKb/ChNLL4iYYOWbA+PuSgG+dNBySxN8MsdHxlnZq9yBtY4vtCMa0ed7nGhjhSg0uMf/
 AlO2R5TCrKJGEL+Oc/n4pOqQq+n2sqjyegt+tV4SyG/71GVOwm+J9OtHQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/17 =E4=B8=8B=E5=8D=883:55, Nikolay Borisov wrote:
>
>
> On 17.08.21 =D0=B3. 2:55, Qu Wenruo wrote:
>> There is a BUG_ON() in btrfs_csum_one_bio() to catch code logic error.
>>
>> It has indeed caught several bugs during subpage development.
>>
>> But the BUG_ON() itself will bring down the whole system which is
>> sometimes overkilled.
>>
>> Replace it with a WARN() and exit gracefully, so that it won't crash th=
e
>> whole system while we can still catch the code logic error.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Re-send as an independent patch
>> - Add WARN() to catch the code logic error
>> ---
>>   fs/btrfs/file-item.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index 2673c6ba7a4e..7f58d80a480f 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -665,7 +665,18 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode=
 *inode, struct bio *bio,
>>
>>   		if (!ordered) {
>>   			ordered =3D btrfs_lookup_ordered_extent(inode, offset);
>> -			BUG_ON(!ordered); /* Logic error */
>> +			/*
>> +			 * The bio range is not covered by any ordered extent,
>> +			 * must be a code logic error.
>> +			 */
>> +			if (unlikely(!ordered)) {
>> +				WARN(1, KERN_WARNING
>> +		"no ordered extent for root %llu ino %llu offset %llu\n",
>> +				     inode->root->root_key.objectid,
>> +				     btrfs_ino(inode), offset);
>> +				kvfree(sums);
>> +				return BLK_STS_IOERR;
>> +			}
>
> nit: How about :
>
> if (WARN_ON(!ordered)  {

I still remember that if (WARN_ON()) usage is not recommended by David.

Is that still the case?

> btrfs_err(foo)
> }
>
> That way you get the unlikely(!ordered) 'for free' and the code is
> somewhat cleaner IMO.
>
> While at it I also have to say the structure of the inner loop is rather
> iffy, because it's really if/else with an implicit 'else'. How about
> converting it to https://paste.ubuntu.com/p/kyWsRrkzWq/

I have no obvious preference between the existing one and the new one.

But since you mentioned it, I would prefer a third way, exactly the code
of the existing if () branch into a function, like
switch_ordered_extent(), and add a comment before the if () line.

To me, that would look easier to read.

Thanks,
Qu
>
>>   		}
>>
>>   		nr_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info,
>>
