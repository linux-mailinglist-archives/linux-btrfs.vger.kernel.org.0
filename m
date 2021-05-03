Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA13723A6
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 01:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECXkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 19:40:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:39617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhECXkg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 19:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620085179;
        bh=U0yFUP000uwaJzhDmBiE7fWZL1e12L+R1/apQasJ6DE=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=XgwYjP0Oil9PlIdHCiHmRXBdaeRFTiRg1CTUlkrWVZLK1Deh6JQa75zXqw50APA/Z
         9tFR4QkFJzxB6f7RHlrk8vDzAPhSVPxK/hCZLknra41Cy054vl8hkzqBYy1lsWTAx4
         IFZ3xqYssRQ2bj9QlO7EoeZciiKuPGCfh+IXMQYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59C8-1leocp0EBY-001EDh; Tue, 04
 May 2021 01:39:39 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20210503020856.93333-1-wqu@suse.com>
 <20210503020856.93333-2-wqu@suse.com> <20210503170504.GN7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 1/4] btrfs: remove the dead branch in
 btrfs_io_needs_validation()
Message-ID: <a5f864f1-c62e-07d4-0e09-ff86251b1665@gmx.com>
Date:   Tue, 4 May 2021 07:39:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503170504.GN7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uqkytjhk/B7x+NUKddxW9lJxHOuWwJHI6NyC8VWDPQoGFUy7936
 jbTnHLAnZln0avq1FZLh9imKSGU9YN9UEyStqUKoVJ7iv+h5s/uyb8IRjWtBj7JDEpqqk6f
 9YmIbDt4qUUk1iUZ0gpuUnLe6+9X6Svoh+5Kwr4zopL0d5vPMQtCIIZN7dLjKdIYJq+z2QJ
 j7OAzahMIHa/DbPymBKEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRDX7XUKtXs=:5DHVb+UYe7T43MtQUaV/dB
 RQr9qrLLogmlVqQbW28q72OC5Y8MRKiyVszjS7ofP01hbyCb1INKgxOcKRseREOG9IviNC0Tc
 mFTnbiCy5MnG1hPTw91D/wCvIM4iNXD3xJZ/PAcUfGd56PHVqK3RBOLBA+Zb+FTWGCCBeLD39
 YwprwSCxxz07GZSH3IhW6Zx1NDSpwI+JkmO4ZW08nuefufNDtQl+gYkX6PW6kpx1+Ue/9BirE
 YOJDYuaKG43pj7cg75sqz+EyrzdQXMx41LIZTwdXi32SATvPV1JCCmwKQmBEay+JdPjU/oTuX
 pKTZVJmObV5isdyY1rypBiv03HLfwmpxsVRhRV/AQGVJb/DSNIx42xZh0eLEMqB2NNnapDVJW
 2aQ7EzLcw221WdO0Gr7Vm3oNEIKDovC2bLeBaXvgI9p+YydWH2CJIhfa35gXjqWq/TAoI9W77
 G2g6oGRbvk83NSPNwh0CYevXopNRG1IHET3o/yACucapPhTUW0W83+HYGHZFLY3//TVO8z5qi
 mv9wUBe/gA1Oy4jMqUAlALP9QjQ5Epg9T6xepbOyzxQ4CTmRePbX1uJjMtqz9awImHAzdgaW8
 E8Wz5uZbn9UPv5p8pkr8lxt5YSOLEKIfxrrTSCISGlM2sfUhprqY7RBALzZ8R2F3Rlap7ybwm
 3Q2ky0XU2X4m6u32GJz2QUKnqjFAhg1FMKOIhDAfDWbaDmdYGR9MKKkwK9pCtdKFdKezzyPw4
 AfvrDSW9ddB/sJMI9pb8b0YPavti7cdpefwS8SSrYNuwAuY+u37OSwZVMJestpAnzcDW2hNgu
 soNSi1T0USaNn4frzoChMIcIh1zvlXHwgdEcUkxL+o7R9RGMPv0YEK30baFjknVQmN6TOOpU6
 p/cy6rRqRYo4b/76UDIzjuqipHCm6bsJ0dwRYSTXRv7bMd4pnvP8bvAqC99YM3B8U66039XaK
 Xud0OnVdFB3RSS54zYQkn19FHsGqzC8M6HHnGc2hrpMRqjbH93C1MaeN+ppnUuOyQTaEohVsI
 aOLUrdZCt2zvnNZlju/lR7R1L+1vXr4iwIg0Gsqbn4J9Jl/4CS3tWe/+gcC4qaQRwMmLgp18u
 5741vtirjusqL410CQf3FV9cJPgJjzy7+q87bmJr8zB0FYEv8LDjqPAmoTk6WGlU1sG5WFm9T
 1dd5FEukZmKmeb7YGouisVXYjtt3G6rgagV4WvrdHNCoo11+XQnxwgjdBVS4ItJKk+ZFbGrxJ
 Pzwo1cKLu9TLwzywj
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/4 =E4=B8=8A=E5=8D=881:05, David Sterba wrote:
> On Mon, May 03, 2021 at 10:08:53AM +0800, Qu Wenruo wrote:
>> In function btrfs_io_needs_validation() we are ensured to get a
>> non-cloned bio.
>> The only caller, end_bio_extent_readpage(), already has an ASSERT() to
>> make sure we only get non-cloned bios.
>>
>> Thus the (bio_flagged(bio, BIO_CLONED)) branch will never get executed.
>>
>> Remove the dead branch and updated the comment.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 29 +++++++----------------------
>>   1 file changed, 7 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 14ab11381d49..0787fae5f7f1 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2644,8 +2644,10 @@ static bool btrfs_check_repairable(struct inode =
*inode, bool needs_validation,
>>
>>   static bool btrfs_io_needs_validation(struct inode *inode, struct bio=
 *bio)
>>   {
>> +	struct bio_vec *bvec;
>>   	u64 len =3D 0;
>>   	const u32 blocksize =3D inode->i_sb->s_blocksize;
>> +	int i;
>>
>>   	/*
>>   	 * If bi_status is BLK_STS_OK, then this was a checksum error, not a=
n
>> @@ -2669,30 +2671,13 @@ static bool btrfs_io_needs_validation(struct in=
ode *inode, struct bio *bio)
>>   	if (blocksize < PAGE_SIZE)
>>   		return false;
>>   	/*
>> -	 * We need to validate each sector individually if the failed I/O was
>> -	 * for multiple sectors.
>> -	 *
>> -	 * There are a few possible bios that can end up here:
>> -	 * 1. A buffered read bio, which is not cloned.
>> -	 * 2. A direct I/O read bio, which is cloned.
>
> Ok, so the cloned bio was expected only due to direct io but now it's
> done via iomap so it makes sense to simplify it.

I didn't dig into the history too deeply, but I don't think it's just
the iomap refactor.

As the ASSERT() in end_bio_extent_readpage() was added in c09abff87f90
("btrfs: cloned bios must not be iterated by bio_for_each_segment_all"),
which is from 2017, way before the iomap dio change.

So the dead code is there for over 4 years at least.


BTW, since you're mentioning iomap dio, the patchset is inspired by the
commit 77d5d6893106 ("btrfs: unify buffered and direct I/O read
repair"), kudos to Omar, which not only unify the code path, but also
considered subpage from the very beginning.

Thanks,
Qu

>
>> -	 * 3. A (buffered or direct) repair bio, which is not cloned.
>> -	 *
>> -	 * For cloned bios (case 2), we can get the size from
>> -	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can ge=
t
>> -	 * it from the bvecs.
>> +	 * We're ensured we won't get cloned bio in end_bio_extent_readpage()=
,
>> +	 * thus we can get the length from the bvecs.
>>   	 */
>> -	if (bio_flagged(bio, BIO_CLONED)) {
>> -		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
>> +	bio_for_each_bvec_all(bvec, bio, i) {
>> +		len +=3D bvec->bv_len;
>> +		if (len > blocksize)
>>   			return true;
>> -	} else {
>> -		struct bio_vec *bvec;
>> -		int i;
>> -
>> -		bio_for_each_bvec_all(bvec, bio, i) {
>> -			len +=3D bvec->bv_len;
>> -			if (len > blocksize)
>> -				return true;
>> -		}
>>   	}
>>   	return false;
>>   }
>> --
>> 2.31.1
