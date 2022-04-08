Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C34F9FD3
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Apr 2022 00:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiDHXBu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDHXBt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 19:01:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75EF4ECCA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649458780;
        bh=5osz1LdFY1WGqAm3HeQ/rlS+GcH4EE/sCs/ruzqkd5Q=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=I7gJdgFVIc53hs8fKwbnbyPWUQ6eEEJAmXkdfa1dLMulswtQLH6FyE0dw+Orlfiv3
         mr/qZyg29b7s7nFP91FWuwB7zEjyBpef/O496g8XZxG//y/KRToEDyrOeDMh8tklkQ
         xJ7cuYC7tAXQIDQqYrP9hML/JNUTTe/mHd15a3Zo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4axq-1nebTJ3mcg-001hQi; Sat, 09
 Apr 2022 00:59:40 +0200
Message-ID: <3ecd3692-4974-8dcb-e678-7ff45fd3438a@gmx.com>
Date:   Sat, 9 Apr 2022 06:59:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 07/16] btrfs: make finish_parity_scrub() subpage
 compatible
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <d0a5f106303ee83daba01f65d6671b011791289a.1648807440.git.wqu@suse.com>
 <20220408170434.GX15609@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220408170434.GX15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X8Fitls9HH+UIMLVeCN5sGFBGLeHuf9zM7+mC33Sku+hZ+1eGyP
 O5rtosJrQzc50qM1ZFuuVbrxYXcH1HdOxYH3X9QJV5t21KgObz8NKgj/aSC0ClWg/zWjtTa
 eK10oFWVuLxETMeZ25SukSpW+2dxDKVu6SICCgoqCIldy09k/75/D0CV5cCBviKHG+GXuvZ
 m5ZKzMO7AFY8sFiPM2i6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dxmYw6h6rE=:YXIX6xrvZ/mGTYgPuL9Oth
 7zYKaOErSftWWmJQtSwXKAe7wlUm2RlflfMD59REJVxy7PiEx3Wa3LBcaS5lWzssrqlIlx9OQ
 trhMyNu1ydxWSTijGH5YciCImJKjsZ059MMRsI9bHn3texAUTA5MBWJoxqiBeVUGXqmwilbD9
 kMiHwv9Qs76iIBhU1vTF14Wfn0h06U9NNThNBje93pydALv3MySp0ocVNzS0lqnyl/o5A8k7i
 TMz8ZIZCwVgR6QKKoLBY7QVH34vdxkm2ymzcEeXtwoSItcA3pIgpFcefzBMzvb7E8kUQpY5t0
 rCOS632uxI3hQQby0DdXKFYYXgCALLekQZuFcqlH65CCq5DJapGxmcuYmh5TwWuMDboVJolxU
 jliwBDtJLbGVmM6ZOgxc2VJx9H5MenCpiR5QV7k8+fDqHnxVnuk5QhtI3Yy7X70crGoqWbVD2
 NciFLfWxeEpjqmHhV6jLOReSb829PCW5bGz8KBQY3vjxiK+Xgyk3E9RXwL8zbqpdMneGqZw+O
 QNstPbicFMgnCrnRfIhRP56r44Btdiql467EEDnv9nQJ+eCW+3/xp8U54Vqk98XyrfuymvfHi
 vKcQLkT7DaFstRSlVsSZ0VYf1e1F6xV0WOihIhQDRxMM2TfWBRgr4oM2NtCAMAnDYcWP8HCLy
 aGEUxWeLRt9FIAdrgs4ca8pS/jHWZVo+NpInJnYg0aIGbMy9bHchelQG8yYJ6a/wChhszJOyz
 2QLJBTvBA8sTA9UZ3Sh9ZEnNtEkIbBrwpjpziID0rRK4GVUMvYKvbhp8xGSymDK38i4h50mk2
 I1BGFd36oTSJwfx6KtObE/NGcQsQQpd5pGQcGVgQa+KAj1IENV3fQhWt0fVC2ZYQ1HUMha6kz
 xiET3rEwNv+nrIBX5NudBsO3fBac+AiSArKizsNQ/MxvznnZO+WInaZsnSBveCMkuCvZQV0nh
 8FsCom4RF+L2EvWO0wk3HW3LF/jdDKaZeS4NM1Wr9A5cfCgaVUYlVuqhBYXBZbJONAFZ8S/iv
 0EuXqudnzydqsAeJ8flGaZCopjw7MRzCcn+5Sz2g80C77ZLcmeisD+9/jXiWCqvABPHrANC3V
 WfoJalCOxSTvXU=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/9 01:04, David Sterba wrote:
> On Fri, Apr 01, 2022 at 07:23:22PM +0800, Qu Wenruo wrote:
>> The core is to convert direct page usage into sector_ptr usage, and
>> use memcpy() to replace copy_page().
>>
>> For pointers usage, we need to convert it to kmap_local_page() +
>> sector->pgoff.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/raid56.c | 56 +++++++++++++++++++++++++++-------------------=
-
>>   1 file changed, 32 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 07d0b26024dd..bd01e64ea4fc 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -2492,14 +2492,15 @@ static noinline void finish_parity_scrub(struct=
 btrfs_raid_bio *rbio,
>>   					 int need_check)
>>   {
>>   	struct btrfs_io_context *bioc =3D rbio->bioc;
>> +	const u32 sectorsize =3D bioc->fs_info->sectorsize;
>>   	void **pointers =3D rbio->finish_pointers;
>>   	unsigned long *pbitmap =3D rbio->finish_pbitmap;
>>   	int nr_data =3D rbio->nr_data;
>>   	int stripe;
>>   	int sectornr;
>>   	bool has_qstripe;
>> -	struct page *p_page =3D NULL;
>> -	struct page *q_page =3D NULL;
>> +	struct sector_ptr p_sector =3D {};
>> +	struct sector_ptr q_sector =3D {};
>
> This should be { 0 }

That's not what you said before.

You said that { 0 } conversion is not going to be merged and {} is fine.

Thanks,
Qu
