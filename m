Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8171B71300E
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 May 2023 00:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbjEZW25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 18:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbjEZW2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 18:28:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E985A4
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685140124; x=1685744924; i=quwenruo.btrfs@gmx.com;
 bh=2wv5Kq/dVMb5NMYWAluAJX/8oInf51Mx4ECm7WwzIPw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=etKPHyvV9RP2OCAvGuCf/4rYyUEFdyIG45F68oUMWB37ApTHwfmHKBBkO91YUi8MM/kKG9s
 BPtZAnnjjb6Iq904n7d+phuRxYfivWO9hwsIgj0EswoczaC0rHRVJ4Voc99maVjY+hVKMPWh1
 EZSw9pgCIL/LLm5+mA2DesWB1rRb2yeT0BhN0UnD5/h8vfy4HaVrHg5PhxcOpovJyHt73Fy7c
 H+Q67GsU7JMg7lNFsVqS5QRPGpt7z0f5Nnn1h//M8WQt9eXKJJetT2MeoesQounKL66z8Iuxj
 lFEOOVZjWd4d7/+olKojWwPWXKh1yoHt4+1RqO1GsT8aDTBid+xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mdeb5-1qbjh4446T-00ZkBL; Sat, 27
 May 2023 00:28:44 +0200
Message-ID: <a836a7f0-2105-c0e1-7a51-6fa5dec0935d@gmx.com>
Date:   Sat, 27 May 2023 06:28:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs: fix a crash in metadata repair path
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
 <ZHC3T+OMEJ7VIkwi@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZHC3T+OMEJ7VIkwi@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E6XfkaLOMZ1Z66LL/cl4oES7UtOMzRamnSCyDlG7BziuIULtmBI
 r5htyjX0kIsHauTh+vwCFdrLFkfKSOXMsIKRlm4JXFU+l/fykE/+F7iAtJlfIm6O5iS8i2G
 rcKcsEhpcXn1X/ut4ZeeuqIH2uwG4ySNRyYW9cTr+tNqH35l7k+29iZ4ONsfBr+ARWYpTKM
 zcxnBnmJPL/4ue+7Vt0eA==
UI-OutboundReport: notjunk:1;M01:P0:L5FSSoP0ZrQ=;cc9IGL+8k07NJ3Wo9RDyaJzlkCk
 CI7ahqYBFbTJmcGrpubsaK3qYdUCNncN32f9ow+7BkGlKiRnvB2VYxLFAJkFgu8qQJH28PMKx
 wqiP+02Achn3F+WLfGeftqBFgZBcr9oqOzMdTevNO6zWeFNey0xZcqQzoQD9/5qeiMNWUXbxG
 HE/YOD2MoCvlyTe2Xi575vm5NO2UWaqFh0UM4Uh2zIPWHEI37Ednen+guXm9IPfY4De0moeLp
 0jpMtdym+Ugk3XVHqWkLw8iDzTpvSCedQEZ7DjFtWnTfISeyRHaP8AtdQPLgXh5dXniCKwfQu
 hQqvuHaKhaBJCB4J3G/ckdGAAwl0/I555MDcBuzCk9zc+cFFITA91wgeJIYndRcojjAF1ccwQ
 ADJkRmr8w+bLR8eGmK1g6wUlohhmDutJa5/oKpMjJS+Ve94KF6JuZqbzHkLQYVR1FuWhjJwAD
 YLtyOQxGGu7rj7ASyi/Rmq3G7T0t3vMwZPXZNllCTNxM6aCIvHmT2aqZqapz5CF4iFYlzDF08
 oyVL08kIibzM/hX0hi8TJSa5M9UpAEW0z3VII9V2hG97uPprjwqq7ZzK9WYa8OGN61pYRhpQH
 tcpV+ua0f8h6ed6MCqw0Cu3v5ulhtv7k66fNDRDeLYBmswGL6XYESe9qkfEHOnSwerXdmb2Pt
 +/CHZytATIjllPQ5W1N00sD8X9s93kam0VWEyYauzpxRQPWyZKZBkicsbJ6a+c1/RW3tBcaNE
 caWoWb6NMheQDWQ5QZ7UmBZSkWqpf+5Y68Y8uj/dy6ej/jfILl7cR4hNFLARUlXAqgnBbwvH4
 Cb/4zHYjEBP6axN6b94oFiOzqi+MV+bRRQ3w8EoEQkIbGKVR9tpBpkApTPIPuFmelzWlxWew3
 o0jZ4O7+vWa1iYKyurTK7m5TIHYYps/kjPUdJ5xGiGuA/sTOCmoDrIDEWBqpnWbJyOWsAcifv
 sd18myMcMyZ331xKNxY9j2eej68=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/26 21:42, Christoph Hellwig wrote:
> On Fri, May 26, 2023 at 08:30:20PM +0800, Qu Wenruo wrote:
>>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>> -	u64 start =3D eb->start;
>>   	int i, num_pages =3D num_extent_pages(eb);
>>   	int ret =3D 0;
>>
>> @@ -185,12 +184,14 @@ static int btrfs_repair_eb_io_failure(const struc=
t extent_buffer *eb,
>>
>>   	for (i =3D 0; i < num_pages; i++) {
>>   		struct page *p =3D eb->pages[i];
>> +		u64 start =3D max_t(u64, eb->start, page_offset(p));
>> +		u64 end =3D min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SI=
ZE);
>> +		u32 len =3D end - start;
>>
>> -		ret =3D btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
>> -				start, p, start - page_offset(p), mirror_num);
>> +		ret =3D btrfs_repair_io_failure(fs_info, 0, start, len,
>> +				start, p, offset_in_page(start), mirror_num);
>>   		if (ret)
>>   			break;
>> -		start +=3D PAGE_SIZE;
>
> I actually just noticed this a week or so ago, but didn't have a
> reproducer.  My fix  does this a little differeny by adding a branch
> for nodesize < PAGE_SIZE similar to write_one_eb or
> read_extent_buffer_pages, which feels a bit simpler and easier to read
> to me:

Sometimes the extra calculation is going to damage the readability indeed.

But it's more like a preference, I'll leave David to do the final call.

Thanks,
Qu

>
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 48ac9fccca06ae..3d498d08e61b65 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -182,11 +182,19 @@ static int btrfs_repair_eb_io_failure(const struct=
 extent_buffer *eb,
>   	if (sb_rdonly(fs_info->sb))
>   		return -EROFS;
>
> +	if (fs_info->nodesize < PAGE_SIZE) {
> +		struct page *p =3D eb->pages[0];
> +
> +		return btrfs_repair_io_failure(fs_info, 0, start, eb->len,
> +					       start, p, start - page_offset(p),
> +					       mirror_num);
> +	}
> +
>   	for (i =3D 0; i < num_pages; i++) {
>   		struct page *p =3D eb->pages[i];
>
>   		ret =3D btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
> -				start, p, start - page_offset(p), mirror_num);
> +					      start, p, 0, mirror_num);
>   		if (ret)
>   			break;
>   		start +=3D PAGE_SIZE;
