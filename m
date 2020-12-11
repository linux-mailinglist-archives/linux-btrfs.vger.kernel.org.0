Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5952D7434
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 11:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393481AbgLKKuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 05:50:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:60063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392591AbgLKKtv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 05:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607683693;
        bh=4YnO9d0xD2ybk9bXgnw7jIoeThOyW71wt2jqMxq9pjA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iS0WKHaWj4OxGPfmUQBlhPKwZjSw8AsYTmvQWuheK3Cj4ykxNo31dX8CHOL81cYcV
         VLOmY5gaYQB61ICr1mB5s5/RWqp1p4nig7YUEl4C9su3R0F6y1VQP7u/700JuS7TKZ
         TpAU+yjlVHObgheJmw9QpEVaQZFpmz80H9rCEWcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNpH-1kQSkz2e8j-00ljQy; Fri, 11
 Dec 2020 11:48:13 +0100
Subject: Re: [PATCH v2 09/18] btrfs: subpage: introduce helper for subpage
 uptodate status
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-10-wqu@suse.com>
 <40aaa304-cf64-806f-e2d0-8bb02b32abdf@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4ae159e0-25fd-285d-7ec5-5554862c85f1@gmx.com>
Date:   Fri, 11 Dec 2020 18:48:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <40aaa304-cf64-806f-e2d0-8bb02b32abdf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNXKzg6o0GW2+QEDGo59vH41qnxEsV2Lo4Tr1c+TXFnNlHinC/a
 AWEV3ViYJ5V8+kRHySPIT870YwUrpOFUmXaHJ2sI4Vm1UjDvz5OzzfajdmG915KnYF44rUu
 wUvAxUIiUqtwquLSDa75SbAgan0V4WM6oWDzycw2dNVw6y21OQriDFYuyJmSQ1IB6CZXTWc
 5BXjg4ISDFE/vgjZyTnvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IGthTSgdTWg=:HP7B2pnf5ydtiMtJacosQR
 wPhO5yx3b6/GNeA1qf+24woSoNAtCBQMCald1nCUsHEhlajtP1m8PQD5EUVSw46tCjNAFE+OU
 d3SXvPpbrUXyyLYZ5edncJqkc0HqVk1rkyQz7DgKzPjDSiRsVx7tRwH34/H/Dp7tpd9grzV3P
 2bwspew4KreqOEX1yJa89zhshgz+cShAdY7H50UcElPFsUYaHKfsZAxxdJp6fJtfE2zF8RlrP
 zE/4cfgaqiw+M6jbtzfZw0mx2MIUPVAFSuULplXFfKq/hbkRIKrqcqYFwPg7MIsyQs77TZJYV
 OpWbo01Umfvh+L1Mk+U0FjO6KadXGbng8UkY1u+OtAmtKma+yzagpf9XOEqaSvElh3gjGlhEL
 SS+JN140RuK1JY2yonyRL/Bv8LDqfgzMgGYG/cZy7kRLwW6htL2XRAwPcKhwXzbaBtwkaoCsG
 b3hyCM5WS3h7xRgZU6tKpKA/9/aWA8Xcb9DvmD/CTITQJzkI9WfM3MV0aCDck9oc4IBvr6Zrq
 IIPNMhDlpI8AnfaeTsEzZ3MRfDzUZcfFdrZD6S8gUxG524bonzyR2Icl+LZ76Gw0gayY+ZO35
 gX/dVM/MsEeLDQnQQoHRlJQQzKJqXUf+vJEnTlSNoXJJgXbKgU++5U+00WbZ+TZ4QUQTdArcy
 gPpTp+zO3FQox/LJ2kizV5r1R9wwQAGjGTNPQiGxFeQnoLLmbjcP4cdSKisLi1eVUje7lbz82
 TY2igfBa8LddQlM6eXitLWJduR6cshxMZD+vZ3FCR+1EDPUPd2hTNDeri/rWrGXXmIqK4ycpe
 GWQwSwJMvjBaCyvJyN0bAReSjIiqOjcm/hbDGRsCAPHcLHJf/+GEDH8ZuSId8LAjK952JiYAT
 ZOCvZi0pkbFzqdMolcCw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/11 =E4=B8=8B=E5=8D=886:10, Nikolay Borisov wrote:
>
>
> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>> This patch introduce the following functions to handle btrfs subpage
>> uptodate status:
>> - btrfs_subpage_set_uptodate()
>> - btrfs_subpage_clear_uptodate()
>> - btrfs_subpage_test_uptodate()
>>   Those helpers can only be called when the range is ensured to be
>>   inside the page.
>>
>> - btrfs_page_set_uptodate()
>> - btrfs_page_clear_uptodate()
>> - btrfs_page_test_uptodate()
>>   Those helpers can handle both regular sector size and subpage without
>>   problem.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/subpage.h | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>
>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>> index 87b4e028ae18..b3cf9171ec98 100644
>> --- a/fs/btrfs/subpage.h
>> +++ b/fs/btrfs/subpage.h
>> @@ -23,6 +23,7 @@
>>  struct btrfs_subpage {
>>  	/* Common members for both data and metadata pages */
>>  	spinlock_t lock;
>> +	u16 uptodate_bitmap;
>>  	union {
>>  		/* Structures only used by metadata */
>>  		struct {
>> @@ -35,6 +36,17 @@ struct btrfs_subpage {
>>  int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *p=
age);
>>  void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *=
page);
>>
>> +static inline void btrfs_subpage_clamp_range(struct page *page,
>> +					     u64 *start, u32 *len)
>> +{
>> +	u64 orig_start =3D *start;
>> +	u32 orig_len =3D *len;
>> +
>> +	*start =3D max_t(u64, page_offset(page), orig_start);
>> +	*len =3D min_t(u64, page_offset(page) + PAGE_SIZE,
>> +		     orig_start + orig_len) - *start;
>> +}
>
> This handles EB's which span pages, right? If so - a comment is in order
> since there is no design document specifying whether eb can or cannot
> span multiple pages.

Didn't I have already stated that in the subpage eb accessors patch?

No subpage eb can across page bounday.

>
>> +
>>  /*
>>   * Convert the [start, start + len) range into a u16 bitmap
>>   *
>> @@ -96,4 +108,90 @@ static inline bool btrfs_subpage_clear_and_test_tre=
e_block(
>>  	return last;
>>  }
>>
>> +static inline void btrfs_subpage_set_uptodate(struct btrfs_fs_info *fs=
_info,
>> +			struct page *page, u64 start, u32 len)
>> +{
>> +	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->priva=
te;
>> +	u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&subpage->lock, flags);
>> +	subpage->uptodate_bitmap |=3D tmp;
>> +	if (subpage->uptodate_bitmap =3D=3D (u16)-1)
>
> just use U16_MAX instead of (u16)-1.
>
>> +		SetPageUptodate(page);
>> +	spin_unlock_irqrestore(&subpage->lock, flags);
>> +}
>> +
>> +static inline void btrfs_subpage_clear_uptodate(struct btrfs_fs_info *=
fs_info,
>> +			struct page *page, u64 start, u32 len)
>> +{
>> +	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->priva=
te;
>> +	u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&subpage->lock, flags);
>> +	subpage->tree_block_bitmap &=3D ~tmp;
>
> I  guess you meant to clear uptodate_bitmap and not tree_block_bitmap ?'

Oh my...

Thanks for catching this,
Qu
>
>> +	ClearPageUptodate(page);
>> +	spin_unlock_irqrestore(&subpage->lock, flags);
>> +}
>> +
>
> <snip>
>
>> +DECLARE_BTRFS_SUBPAGE_TEST_OP(uptodate);
>> +
>> +/*
>> + * Note that, in selftest, especially extent-io-tests, we can have emp=
ty
>> + * fs_info passed in.
>> + * Thanfully in selftest, we only test sectorsize =3D=3D PAGE_SIZE cas=
es so far
>
> nit:s/Thankfully/Thankfully
>
>> + * thus we can fall back to regular sectorsize branch.
>> + */
>
> <snip>
>
>>
